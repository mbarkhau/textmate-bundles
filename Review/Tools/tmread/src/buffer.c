#include "buffer.h"
#include "die.h"
#include "debug.h"
#include "stringutil.h"
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <stdio.h>
#include <sys/syscall.h>
#include <unistd.h>

#ifndef ALLOC_SIZE
#define ALLOC_SIZE 128
#endif

#ifndef READ_BLOCK_SIZE
#define READ_BLOCK_SIZE 1024
#endif

/**
 * 
 */
buffer_t* create_buffer() {
    buffer_t* res = malloc(sizeof(buffer_t));
    if (res == NULL)  die("create_buffer() malloc failed");
    res->data = NULL;
    res->size = 0;
    res->capacity = 0;
    return res;
}

/**
 * 
 */
buffer_t* create_buffer_with(char* bytes, size_t len) {
    buffer_t* b = create_buffer();
    b->data = bytes;
    b->size = len;
    b->capacity = len;
    return b;
}

buffer_t* create_buffer_from_cfstr(CFStringRef cfstr) {
    buffer_t* b = create_buffer();
	CFIndex cfstr_length = CFStringGetLength(cfstr);
	CFIndex storage_max_length = CFStringGetMaximumSizeForEncoding(cfstr_length, kCFStringEncodingUTF8);
	b->data = malloc(storage_max_length);

    CFRange copy_range; 
    copy_range.location = 0;
	copy_range.length = cfstr_length;
    
    CFIndex copy_count;
 
    CFStringGetBytes(cfstr, copy_range, kCFStringEncodingUTF8, 0, false, (UInt8 *)b->data, storage_max_length, &copy_count);
	b->size = copy_count;
	b->capacity = storage_max_length;
    return b;
}

/**
 * Exhaustively reads the output of the already opened tm_dialog process.
 *
 * @param tm_dialog The stdout of a tm_dialog process (must be open for reading)
 * @return The read output (must be free'd by caller)
 */
buffer_t * create_buffer_from_file_descriptor(int fd) {
 
    char intermediary_buffer[READ_BLOCK_SIZE];
    buffer_t *buffer = create_buffer();
     
    ssize_t bytes_read;
    do {

        bytes_read = syscall(SYS_read, fd, intermediary_buffer, sizeof(intermediary_buffer));
        D("create_buffer_from_file_descriptor(): got %zd bytes from fd\n", bytes_read);
        if (bytes_read > 0) {
            add_to_buffer(buffer, intermediary_buffer, bytes_read);
        } else if (bytes_read < 0) {
			D("read on tm_dialog output produced '%s'", strerror(errno));
		}

    } while(bytes_read != 0);

    return buffer;
}

/**
 * 
 */
buffer_t* create_buffer_of_dictionary_as_xml(CFDictionaryRef dictionary) {
 
    CFStringRef error;
    CFWriteStreamRef stream = CFWriteStreamCreateWithAllocatedBuffers(kCFAllocatorDefault, kCFAllocatorDefault);
    if (stream == NULL) die("failed to allocate write stream to write dictionary representation to");
    if (!CFWriteStreamOpen(stream)) die("failed to open write stream to write dictionary representation to");
 
    CFPropertyListWriteToStream(dictionary, stream, kCFPropertyListXMLFormat_v1_0, &error);
 
    if (error) {
        die("Writing dictionary to stream failed: %s", cfstr_2_cstr(error));
    }
 
    CFDataRef data = CFWriteStreamCopyProperty(stream, kCFStreamPropertyDataWritten);
    if (data == NULL) die("failed to extract data from dictionary write stream");
 
    CFIndex data_length = CFDataGetLength(data);
    char *bytes = malloc(data_length);
    if (bytes == NULL) die("failed to allocate buffer for dictionary representation");
    
    CFDataGetBytes(data, CFRangeMake(0, data_length), (UInt8 *)bytes);
    buffer_t* buffer = create_buffer_with(bytes, data_length);
 
    D("create_buffer_of_tm_dialog_input(): ");
    DB(buffer);
    D("\n");
     
    return buffer;
}

/**
 * 
 */
char* create_cstr_from_buffer(buffer_t* buffer) {
    char *cstr = malloc(buffer->size + 1);
    memcpy(cstr, buffer->data, buffer->size);
    cstr[buffer->size] = '\0';
    return cstr;
}

/**
 * 
 */
void add_to_buffer(buffer_t* buffer, char* bytes, size_t len) {
    if (buffer->capacity < buffer->size + len) {
        D("Resizing buffer (need to add %d) from %d to ", (int)len, (int)buffer->capacity); 
        buffer->capacity = ceil((buffer->size + len) / ALLOC_SIZE + 1) * ALLOC_SIZE;
        D("%d bytes\n", (int)buffer->capacity);
        buffer->data = realloc(buffer->data, buffer->capacity);
        if (buffer->data == NULL) die("reallocation of buffer failed");
    }
    memcpy(buffer->data + buffer->size, bytes, len);
    buffer->size += len;
}

size_t consume_from_head_of_buffer(buffer_t* buffer, char* dest, size_t dest_size) {
	D("consuming %d from buffer of size %d\n", (int)dest_size, (int)buffer->size);
	if (buffer->size == 0 || dest_size == 0) return 0;
	
	size_t consumption_size = (buffer->size < dest_size) ? buffer->size : dest_size;
	D("consumption_size = %d\n", (int)consumption_size);
	strncpy(dest, buffer->data, consumption_size);
	
	size_t new_data_size = buffer->size - consumption_size;
	D("new_data_size = %d\n", (int)new_data_size);
	char* new_data = malloc(new_data_size);
	strncpy(new_data, buffer->data + consumption_size, new_data_size);
	
	free(buffer->data);
	buffer->data = new_data;
	buffer->size = new_data_size;
	buffer->capacity = new_data_size;
	return consumption_size;
}

/**
 * 
 */
void destroy_buffer(buffer_t* buffer) {
   if (buffer->data != NULL) free(buffer->data);
   free(buffer);
}