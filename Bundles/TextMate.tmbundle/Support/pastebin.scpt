FasdUAS 1.101.10   ��   ��    k             l      �� ��   93 paste.applescript
 * 
 * Created by Jacob Rus on 2006-05-26.
 * 
 * This script sets up a list of options, allows TextMate to paste the
 * selected text to a pastebin, sets up a list of possible actions to
 * perform with the link, depending on what applications are available,
 * and carries those actions out.  Some options include:
 * 
 *   - Copy the URL to the clipboard
 *   - Send the URL to Quicksilver
 *   - Open the URL in the default browser
 *   - Paste the URL to an open IRC channel in Colloquy
 *   - Paste the URL to an open chat in Adium
 *   
 * Note that for these last two, if multiple channels or chats are open with
 * the same name, this Applescript will not attempt to distinguish between
 * them, and will paste to the first available channel or chat which matches
 * the user's choice.
 * 
        	  l     ������  ��   	  
  
 l     ������  ��        l     �� ��    !  ==========================         l     �� ��    !  = SET UP LIST OF OPTIONS =         l     �� ��    !  ==========================         l     ������  ��        l     �� ��      initialize the list         l     ��  r         J     ����    o      ���� 0 the_list  ��         l     ������  ��      ! " ! l     �� #��   # N H get a list of open applications, so that we can decide which actions to    "  $ % $ l     �� &��   &   present as options    %  ' ( ' l    )�� ) O     * + * r   	  , - , n   	  . / . 1    ��
�� 
pnam / 2  	 ��
�� 
pcap - o      ���� 0 openapps openApps + m     0 0�null     ߀��  �System Events.app�|?��^���ذ���p��۠�^����    �[b�> APPLsesevs   alis    �  Ladybird                   ���BH+    �System Events.app                                                k��d�        ����  	                CoreServices    ���"      �c��      �  �  �  6Ladybird:System:Library:CoreServices:System Events.app  $  S y s t e m   E v e n t s . a p p    L a d y b i r d  -System/Library/CoreServices/System Events.app   / ��  ��   (  1 2 1 l     ������  ��   2  3 4 3 l     �� 5��   5 : 4 get open IRC channels from Colloquy, if it is open;    4  6 7 6 l     �� 8��   8 !  preface the actions with -    7  9 : 9 l   ^ ;�� ; Z    ^ < =���� < E     > ? > o    ���� 0 openapps openApps ? m     @ @  Colloquy    = k    Z A A  B C B O   * D E D r    ) F G F l 	  ' H�� H l   ' I�� I b    ' J K J n    ! L M L 1    !��
�� 
pnam M 2   ��
�� 
dchM K n   ! & N O N 1   $ &��
�� 
pnam O 2  ! $��
�� 
crmM��  ��   G o      ���� 0 colloquy_channels   E m     P P�null     ߀��  *Colloquy.app0$�"�|?��^����0������ �^���Ր    �[b�( APPLcocoRC   alis    H  Ladybird                   ���BH+    *Colloquy.app                                                    R���{\        ����  	                Applications    ���"      ��_<      *  "Ladybird:Applications:Colloquy.app    C o l l o q u y . a p p    L a d y b i r d  Applications/Colloquy.app   / ��   C  Q R Q Z   + ; S T���� S >  + / U V U o   + ,���� 0 colloquy_channels   V J   , .����   T r   2 7 W X W b   2 5 Y Z Y o   2 3���� 0 the_list   Z m   3 4 [ [  Paste to Colloquy IRC:    X o      ���� 0 the_list  ��  ��   R  \�� \ X   < Z ]�� ^ ] r   L U _ ` _ b   L S a b a o   L M���� 0 the_list   b J   M R c c  d�� d b   M P e f e m   M N g g 	 	-     f o   N O���� 0 each_channel  ��   ` o      ���� 0 the_list  �� 0 each_channel   ^ o   ? @���� 0 colloquy_channels  ��  ��  ��  ��   :  h i h l     ������  ��   i  j k j l     �� l��   l 0 * get open chats from Adium, if it is open;    k  m n m l     �� o��   o !  preface the actions with >    n  p q p l  _ � r�� r Z   _ � s t���� s E   _ b u v u o   _ `���� 0 openapps openApps v m   ` a w w  Adium    t k   e � x x  y z y O  e y { | { r   k x } ~ } l  k t ��  n   k t � � � 1   p t��
�� 
AchN � 2  k p��
�� 
Acht��   ~ o      ���� 0 adium_chats   | m   e h � ��null     ߀��  *	Adium.app���0$�"�|?��^����0������ �^���Ր    �[b�� APPLAdAdIM   alis    <  Ladybird                   ���BH+    *	Adium.app                                                       F���`��        ����  	                Applications    ���"      �`m�      *  Ladybird:Applications:Adium.app    	 A d i u m . a p p    L a d y b i r d  Applications/Adium.app  / ��   z  � � � Z   z � � ����� � >  z � � � � o   z }���� 0 adium_chats   � J   } ����   � r   � � � � � b   � � � � � o   � ����� 0 the_list   � m   � � � �  Paste to Adium chat:    � o      ���� 0 the_list  ��  ��   �  ��� � X   � � ��� � � r   � � � � � b   � � � � � o   � ����� 0 the_list   � J   � � � �  ��� � b   � � � � � m   � � � � 	 	>     � o   � ����� 0 	each_chat  ��   � o      ���� 0 the_list  �� 0 	each_chat   � o   � ����� 0 adium_chats  ��  ��  ��  ��   q  � � � l     ������  ��   �  � � � l     �� ���   � 2 , get all accounts from iChat, if it is open;    �  � � � l  � ��� � Z   � � ����� � E   � � � � � o   � ����� 0 openapps openApps � m   � � � �  iChat    � k   � � �  � � � O  � � � � � r   � � � � � 6 � � � � � n   � � � � � 1   � ���
�� 
pnam � 2  � ���
�� 
pres � >  � � � � � 1   � ���
�� 
stat � m   � ���
�� pstaoffl � o      ���� 0 ichat_accounts   � m   � � � ��null     ߀��  *	iChat.app���0(�"�|?��^����0������ �^���Ր    �[b�p APPLfefez!   alis    <  Ladybird                   ���BH+    *	iChat.app                                                       A�d<        ����  	                Applications    ���"      �d,      *  Ladybird:Applications:iChat.app    	 i C h a t . a p p    L a d y b i r d  Applications/iChat.app  / ��   �  � � � Z   � � � ����� � >  � � � � � o   � ����� 0 ichat_accounts   � J   � �����   � r   � � � � � b   � � � � � o   � ����� 0 the_list   � m   � � � �  Paste to iChat:    � o      ���� 0 the_list  ��  ��   �  ��� � X   � ��� � � r   � � � b   � � � o  ���� 0 the_list   � J   � �  ��� � b   � � � m   � �   	    � o  ���� 0 	each_chat  ��   � o      ���� 0 the_list  �� 0 	each_chat   � o   � ����� 0 ichat_accounts  ��  ��  ��  ��   �  � � � l     ������  ��   �  � � � l     �� ���   �   add singular actions    �  � � � l # ��� � r  # � � � b  ! � � � o  ���� 0 the_list   � m    � �  Open in browser    � o      ���� 0 the_list  ��   �  � � � l $+ ��� � r  $+ � � � b  $) � � � o  $%���� 0 the_list   � m  %( � �  Copy link to clipboard    � o      ���� 0 the_list  ��   �  � � � l ,? ��� � Z  ,? � ����� � E  ,1 � � � o  ,-���� 0 openapps openApps � m  -0 � �  Quicksilver    � r  4; � � � b  49 � � � o  45���� 0 the_list   � m  58 � �  Send to Quicksilver    � o      ���� 0 the_list  ��  ��  ��   �  � � � l     ������  ��   �  � � � l @I ��� � r  @I � � � I  @E��������  0 defaultchoices defaultChoices��  ��   � o      ���� 0 default_items  ��   �  � � � l Jx ��� � O  Jx � � � r  Pw � � � I Ps�� � �
�� .gtqpchltns    @   @ ns   � l 
PQ ��� � o  PQ���� 0 the_list  ��   � �� � 
�� 
okbt � l 	TW� m  TW  Paste   �    �~
�~ 
prmp l 	Z]�} m  Z]  Pick actions for paste:   �}   �|
�| 
appr l 	`c	�{	 m  `c

 ! Paste Selection to Pastebin   �{   �z
�z 
inSL o  fi�y�y 0 default_items   �x�w
�x 
mlsl m  lm�v
�v boovtrue�w   � o      �u�u 0 the_choices   � m  JM�null     ߀�� �vTextMate.app�$�"�|?��^���ذ���p��۠�^����    �[b�B APPLTxTxMt   alis    �  Ladybird                   ���BH+   �vTextMate.app                                                    RW����Q        ����  	                Deployment (ppc)    ���"      ���1     �v Q c�  k�  5Ladybird:Users:duff:Oak:Deployment (ppc):TextMate.app     T e x t M a t e . a p p    L a d y b i r d  ,Users/duff/Oak/Deployment (ppc)/TextMate.app  /    ��  ��   �  l     �t�s�t  �s    l     �r�q�r  �q    l     �p�p   %  ==============================     l     �o�o   %  = PASTE TEXT TO THE PASTEBIN =     l     �n�n   %  ==============================     l     �m�l�m  �l    l y� �k  r  y�!"! m  y|##      " o      �j�j 0 the_url  �k   $%$ l ��&�i& Z  ��'(�h�g' > ��)*) o  ���f�f 0 the_choices  * m  ���e
�e boovfals( k  ��++ ,-, I  ���d.�c�d 0 savechoices saveChoices. /�b/ o  ���a�a 0 the_choices  �b  �c  - 0�`0 r  ��121 I ���_3�^
�_ .sysoexecTEXT���     TEXT3 l 	��4�]4 m  ��55��mkfifo /tmp/cd_tm_pipe
		"$TM_SUPPORT_PATH/bin/CocoaDialog.app/Contents/MacOS/CocoaDialog" progressbar --indeterminate \
		  --title "Paste to Pasting Server�" \
		  --text "Contacting Server �pastie.caboo.se��" < /tmp/cd_tm_pipe &
		exec 4<>/tmp/cd_tm_pipe
		echo -n . >&4
		TM_HTML=$("${TM_RUBY:-ruby}" -rjcode -Ku -r"$TM_BUNDLE_SUPPORT/lib/doctohtml.rb" -e 'print document_to_html(STDIN.read)')
		echo -n "$TM_SELECTED_TEXT"|curl http://pastie.caboo.se/pastes/create \
			-s -L -o /dev/null -w "%{url_effective}" \
			-H "Expect:" \
			-F "paste[body]=<-" \
			-F "paste[textmate_html]=&zwj;$TM_HTML"
		exec 4>&-
		wait
		rm -f /tmp/cd_tm_pipe   �]  �^  2 o      �\�\ 0 the_url  �`  �h  �g  �i  % 676 l     �[�Z�[  �Z  7 898 l     �Y:�Y  : $  =============================   9 ;<; l     �X=�X  = $  = PERFORM REQUESTED OPTIONS =   < >?> l     �W@�W  @ $  =============================   ? ABA l     �V�U�V  �U  B CDC l ��E�TE Z  ��FG�S�RF > ��HIH o  ���Q�Q 0 the_url  I m  ��JJ      G I  ���PK�O�P 0 actonurl actOnURLK LML o  ���N�N 0 the_url  M N�MN o  ���L�L 0 the_choices  �M  �O  �S  �R  �T  D OPO l     �K�J�K  �J  P QRQ l     �I�H�I  �H  R STS i     UVU I      �GW�F�G 0 actonurl actOnURLW XYX o      �E�E 0 the_url  Y Z�DZ o      �C�C 0 the_choices  �D  �F  V X     [�B\[ k   ]] ^_^ r    `a` c    bcb o    �A�A 0 each_choice  c m    �@
�@ 
TEXTa o      �?�? 0 each_choice  _ ded l   �>�=�>  �=  e fgf l   �<h�<  h "  send the URL to Quicksilver   g i�;i Z   jkl�:j l   m�9m =   non o    �8�8 0 each_choice  o m    pp  Send to Quicksilver   �9  k k    .qq rsr O    ,tut k     +vv wxw I    %�7�6�5
�7 .miscactvnull��� ��� null�6  �5  x y�4y r   & +z{z o   & '�3�3 0 the_url  { 1   ' *�2
�2 
sele�4  u m    ||�null     ߀��  *Quicksilver.app"�|?��^���Ѱ���p��Ԡ�^����    �[b�  APPLdadaed   alis    T  Ladybird                   ���BH+    *Quicksilver.app                                                 K	-����        ����  	                Applications    ���"      ����      *  %Ladybird:Applications:Quicksilver.app      Q u i c k s i l v e r . a p p    L a d y b i r d  Applications/Quicksilver.app  / ��  s }~} l  - -�1�0�1  �0  ~ �/ l  - -�.��.  � $  send the URL to the clipboard   �/  l ��� =  1 4��� o   1 2�-�- 0 each_choice  � m   2 3��  Copy link to clipboard   � ��� k   7 >�� ��� I  7 <�,��+
�, .JonspClpnull���     ****� o   7 8�*�* 0 the_url  �+  � ��� l  = =�)�(�)  �(  � ��'� l  = =�&��&  � * $ open the URL in the default browser   �'  � ��� =  A D��� o   A B�%�% 0 each_choice  � m   B C��  Open in browser   � ��� k   G N�� ��� I  G L�$��#
�$ .GURLGURLnull��� ��� TEXT� o   G H�"�" 0 the_url  �#  � ��� l  M M�!� �!  �   � ��� l  M M���  � * $ paste the URL to the requested chat   �  � ��� I   Q X���� 0 
startswith  � ��� o   R S�� 0 each_choice  � ��� m   S T�� 	 	>    �  �  � ��� k   [ ��� ��� r   [ d��� I   [ b���� 0 striplength  � ��� o   \ ]�� 0 each_choice  � ��� m   ] ^�� �  �  � o      �� 0 each_choice  � ��� O  e ���� l 	 i ���� O  i ���� l 	 � ���� I  � ����
� .AdIMsndMnull���    cobj�  � ���
� 
TO  � l  � ���� b   � ���� m   � ���  pasted    � o   � ��� 0 the_url  �  �  �  � n   i ~��� 4   { ~��
� 
cobj� m   | }�
�
 � l  i {��	� 6  i {��� 2  i n�
� 
Acht� =  q z��� 1   r v�
� 
AchN� o   w y�� 0 each_choice  �	  �  � m   e f �� ��� l  � ����  �  � ��� l  � ����  � * $ paste the URL to the requested chat   �  � ��� I   � ���� � 0 
startswith  � ��� o   � ����� 0 each_choice  � ���� m   � ���   	   ��  �   � ��� k   � ��� ��� r   � ���� I   � �������� 0 striplength  � ��� o   � ����� 0 each_choice  � ���� m   � ����� ��  ��  � o      ���� 0 each_choice  � ��� O  � ���� l 	 � ����� I  � �����
�� .ichtsendnull���    obj � l  � ����� b   � ���� m   � ���  pasted    � o   � ����� 0 the_url  ��  � �����
�� 
TO  � l  � ����� 4   � ����
�� 
pres� o   � ����� 0 each_choice  ��  ��  ��  � m   � � �� ��� l  � �������  ��  � ���� l  � ������  � 6 0 paste the URL to the requested IRC channel/chat   ��  � ��� I   � �������� 0 
startswith  � ��� o   � ����� 0 each_choice  � ���� m   � ��� 	 	-    ��  ��  � ���� k   ��� ��� r   � ���� I   � �������� 0 striplength  � ��� o   � ����� 0 each_choice  � ���� m   � ����� ��  ��  � o      ���� 0 each_choice  �  ��  O   � k   �  r   �  n   � �	 1   � ���
�� 
trgA	 n   � �

 4   � ���
�� 
cobj m   � �����  l  � ��� 6  � � 2  � ���
�� 
chvC =  � � 1   � ���
�� 
pnam o   � ����� 0 each_choice  ��   o      ���� 0 the_channel   �� I ��
�� .ccoRsCmXnull���     TEXT l �� b   m    pasted     o  ���� 0 the_url  ��   ��
�� 
sCm1 o  	
���� 0 the_channel   ����
�� 
sCm3 m  ��
�� savoyes ��  ��   m   � � P��  ��  �:  �;  �B 0 each_choice  \ o    ���� 0 the_choices  T  l     ������  ��    l     ������  ��    !  l     ��"��  "   load default choices   ! #$# i    %&% I      ��������  0 defaultchoices defaultChoices��  ��  & k     8'' ()( Q     5*+,* k    (-- ./. r    010 b    232 l   4��4 I   ��56
�� .earsffdralis        afdr5 m    ��
�� afdmpref6 ��78
�� 
from7 m    ��
�� fldmfldu8 ��9��
�� 
rtyp9 m    ��
�� 
ctxt��  ��  3 m    :: 7 1com.macromates.textmate.paste_to_server.as_record   1 o      ���� 0 
prefs_file  / ;<; r    =>= I   ��?��
�� .rdwropenshor       file? o    ���� 0 
prefs_file  ��  > o      ���� 0 f  < @A@ r    "BCB I    ��DE
�� .rdwrread****        ****D o    ���� 0 f  E ��F��
�� 
as  F m    ��
�� 
list��  C o      ���� 0 the_list  A G��G I  # (��H��
�� .rdwrclosnull���     ****H o   # $���� 0 f  ��  ��  + R      ������
�� .ascrerr ****      � ****��  ��  , r   0 5IJI J   0 3KK L��L m   0 1MM  	- #textmate   ��  J o      ���� 0 the_list  ) NON l  6 6������  ��  O P��P L   6 8QQ o   6 7���� 0 the_list  ��  $ RSR l     ������  ��  S TUT l     ������  ��  U VWV l     ��X��  X   save choices   W YZY i    [\[ I      ��]���� 0 savechoices saveChoices] ^��^ o      ���� 0 the_list  ��  ��  \ k     %__ `a` r     bcb b     ded l    	f��f I    	��gh
�� .earsffdralis        afdrg m     ��
�� afdmprefh ��ij
�� 
fromi m    ��
�� fldmflduj ��k��
�� 
rtypk m    ��
�� 
ctxt��  ��  e m   	 
ll 7 1com.macromates.textmate.paste_to_server.as_record   c o      ���� 0 
prefs_file  a mnm r    opo I   ��qr
�� .rdwropenshor       fileq o    ���� 0 
prefs_file  r ��s��
�� 
perms m    ��
�� boovtrue��  p o      ���� 0 f  n tut I   ��vw
�� .rdwrwritnull���     ****v o    ���� 0 the_list  w ��x��
�� 
refnx o    ���� 0 f  ��  u y��y I    %��z��
�� .rdwrclosnull���     ****z o     !���� 0 f  ��  ��  Z {|{ l     ������  ��  | }~} l     ������  ��  ~ � l     ���  � L F test if 'longstring' starts with 'startstring'.  If not, return false   � ��� i    ��� I      �~��}�~ 0 
startswith  � ��� o      �|�| 0 
longstring  � ��{� o      �z�z 0 startstring  �{  �}  � k     8�� ��� Z     ���y�x� ?     ��� n     ��� 1    �w
�w 
leng� o     �v�v 0 startstring  � n    ��� 1    �u
�u 
leng� o    �t�t 0 
longstring  � L   
 �� m   
 �s
�s boovfals�y  �x  � ��� Y    5��r���q� Z    0���p�o� >   '��� l   "��n� n    "��� 4    "�m�
�m 
cha � o     !�l�l 0 i  � o    �k�k 0 startstring  �n  � l  " &��j� n   " &��� 4   # &�i�
�i 
cha � o   $ %�h�h 0 i  � o   " #�g�g 0 
longstring  �j  � L   * ,�� m   * +�f
�f boovfals�p  �o  �r 0 i  � m    �e�e � n    ��� 1    �d
�d 
leng� o    �c�c 0 startstring  �q  � ��b� L   6 8�� m   6 7�a
�a boovtrue�b  � ��� l     �`�_�`  �_  � ��� l     �^�]�^  �]  � ��� l     �\��\  � O I strip the first 'num' characters from 'longstring', returning the result   � ��� i    ��� I      �[��Z�[ 0 striplength  � ��� o      �Y�Y 0 
longstring  � ��X� o      �W�W 0 num  �X  �Z  � L     �� c     ��� l    ��V� n     ��� 7  �U��
�U 
cha � l   	��T� [    	��� o    �S�S 0 num  � m    �R�R �T  � l  
 ��Q� n   
 ��� 1    �P
�P 
leng� o   
 �O�O 0 
longstring  �Q  � o     �N�N 0 
longstring  �V  � m    �M
�M 
TEXT� ��L� l     �K�J�K  �J  �L       �I����������������H�G�F�E�D�C�B�A�@�?�I  � �>�=�<�;�:�9�8�7�6�5�4�3�2�1�0�/�.�-�,�+�*�)�(�'�> 0 actonurl actOnURL�=  0 defaultchoices defaultChoices�< 0 savechoices saveChoices�; 0 
startswith  �: 0 striplength  
�9 .aevtoappnull  �   � ****�8 0 the_list  �7 0 openapps openApps�6 0 colloquy_channels  �5 0 adium_chats  �4 0 ichat_accounts  �3 0 default_items  �2 0 the_choices  �1 0 the_url  �0  �/  �.  �-  �,  �+  �*  �)  �(  �'  � �&V�%�$���#�& 0 actonurl actOnURL�% �"��" �  �!� �! 0 the_url  �  0 the_choices  �$  � ����� 0 the_url  � 0 the_choices  � 0 each_choice  � 0 the_channel  � &����p|��������� �������� ����� P��
�	�����
� 
kocl
� 
cobj
� .corecnte****       ****
� 
TEXT
� .miscactvnull��� ��� null
� 
sele
� .JonspClpnull���     ****
� .GURLGURLnull��� ��� TEXT� 0 
startswith  � 0 striplength  
� 
Acht�  
� 
AchN
� 
TO  
� .AdIMsndMnull���    cobj
� 
pres
� .ichtsendnull���    obj 
� 
chvC
�
 
pnam
�	 
trgA
� 
sCm1
� 
sCm3
� savoyes � 
� .ccoRsCmXnull���     TEXT�#!�[��l kh ��&E�O��  � *j O�*�,FUOPY ��  �j 	OPY ܢ�  �j OPY �*��l+  <*�ml+ E�O� (*a -a [a ,\Z�81�k/ *a a �%l UUOPY �*�a l+  **�ll+ E�Oa  a �%a *a �/l UOPY T*�a l+  G*�ml+ E�Oa  3*a -a [a ,\Z�81�k/a ,E�Oa  �%a !�a "a #a $ %UY h[OY��� �&����� �  0 defaultchoices defaultChoices�  �  � �������� 0 
prefs_file  �� 0 f  �� 0 the_list  � ��������������:��������������M
�� afdmpref
�� 
from
�� fldmfldu
�� 
rtyp
�� 
ctxt�� 
�� .earsffdralis        afdr
�� .rdwropenshor       file
�� 
as  
�� 
list
�� .rdwrread****        ****
�� .rdwrclosnull���     ****��  ��  �  9 *������ �%E�O�j E�O���l E�O�j W X  �kvE�O�� ��\���������� 0 savechoices saveChoices�� ����� �  ���� 0 the_list  ��  � �������� 0 the_list  �� 0 
prefs_file  �� 0 f  � ��������������l����������
�� afdmpref
�� 
from
�� fldmfldu
�� 
rtyp
�� 
ctxt�� 
�� .earsffdralis        afdr
�� 
perm
�� .rdwropenshor       file
�� 
refn
�� .rdwrwritnull���     ****
�� .rdwrclosnull���     ****�� &������ �%E�O��el 	E�O��l O�j � ������������� 0 
startswith  �� ����� �  ������ 0 
longstring  �� 0 startstring  ��  � �������� 0 
longstring  �� 0 startstring  �� 0 i  � ����
�� 
leng
�� 
cha �� 9��,��, fY hO #k��,Ekh ��/��/ fY h[OY��Oe� ������������� 0 striplength  �� ����� �  ������ 0 
longstring  �� 0 num  ��  � ������ 0 
longstring  �� 0 num  � ������
�� 
cha 
�� 
leng
�� 
TEXT�� �[�\[Z�k\Z��,2�&� �����������
�� .aevtoappnull  �   � ****� k    ���  ��  '��  9��  p��  ���  ���  ���  ���  ���  ��� �� $�� C����  ��  ��  � ������ 0 each_channel  �� 0 	each_chat  � 8�� 0������ @ P������ [������ g w ������� � � � ���������� � � � � � �����������
����������#����5��J���� 0 the_list  
�� 
pcap
�� 
pnam�� 0 openapps openApps
�� 
dchM
�� 
crmM�� 0 colloquy_channels  
�� 
kocl
�� 
cobj
�� .corecnte****       ****
�� 
Acht
�� 
AchN�� 0 adium_chats  
�� 
pres
�� 
stat
�� pstaoffl�� 0 ichat_accounts  ��  0 defaultchoices defaultChoices�� 0 default_items  
�� 
okbt
�� 
prmp
�� 
appr
�� 
inSL
�� 
mlsl�� 

�� .gtqpchltns    @   @ ns  �� 0 the_choices  �� 0 the_url  �� 0 savechoices saveChoices
�� .sysoexecTEXT���     TEXT�� 0 actonurl actOnURL���jvE�O� 	*�-�,E�UO�� G� *�-�,*�-�,%E�UO�jv 
��%E�Y hO �[��l kh  ��%kv%E�[OY��Y hO�� Qa  *a -a ,E` UO_ jv �a %E�Y hO !_ [��l kh �a �%kv%E�[OY��Y hO�a  ^a  *a -�,a [a ,\Za 91E` UO_ jv �a %E�Y hO !_ [��l kh �a �%kv%E�[OY��Y hO�a %E�O�a  %E�O�a ! �a "%E�Y hO*j+ #E` $Oa % )�a &a 'a (a )a *a +a ,_ $a -ea . /E` 0UOa 1E` 2O_ 0f *_ 0k+ 3Oa 4j 5E` 2Y hO_ 2a 6 *_ 2_ 0l+ 7Y h� ����� �   [���� ����  � � �� % 	- queuetue                  � ! 	- JEG2                  � % 	- nickserv                  � & 	- #textmate                  � &  	James Gray                  � %  	nicuramar                  � &  	James Gray                    (  	Blake Burris                   )  	drunkenbatman                   *  	eventualbuddha                   )  	Allan Odgaard                   /  	bbazzarrakk@mac.com                   )  	Allan Odgaard                  � ����     	
 !"#$%& �''  l o g i n w i n d o w �((  D o c k	 �))  S y s t e m U I S e r v e r
 �**  F i n d e r �++  S S H K e y c h a i n �,,  R e m i n d e r M a t e �--  i T u n e s H e l p e r �..  E y e T V   H e l p e r �//  Q u i c k s i l v e r �00  G e e k T o o l �11  i T u n e s �22  D a s h b o a r d C l i e n t �33  D a s h b o a r d C l i e n t �44  D a s h b o a r d C l i e n t �55  D a s h b o a r d C l i e n t �66  D a s h b o a r d C l i e n t �77   t e x t p a n d e r d a e m o n �88  S y s t e m   E v e n t s �99  M a i l �::  C o l l o q u y �;;   N e t N e w s W i r e   L i t e �<<  O m n i W e b �==  T e r m i n a l �>>  T e x t M a t e �??  D V D   P l a y e r  �@@  U n i v e r s a l A c c e s s! �AA  S c r i p t   E d i t o r" �BB 
 i C h a t# �CC  i C h a t A g e n t$ �DD  A d d r e s s   B o o k% �EE 
 A d i u m& �FF  o s a s c r i p t� ��G�� G  HIJKH �LL  q u e u e t u eI �MM  J E G 2J �NN  n i c k s e r vK �OO  # t e x t m a t e� ��P��  P   � ��Q�� 	Q 	 RSTUVWXYZR �[[  J a m e s   G r a yS �\\  n i c u r a m a rT �]]  J a m e s   G r a yU �^^  B l a k e   B u r r i sV �__  d r u n k e n b a t m a nW �``  e v e n t u a l b u d d h aX �aa  A l l a n   O d g a a r dY �bb & b b a z z a r r a k k @ m a c . c o mZ �cc  A l l a n   O d g a a r d� ��d�� d  ee %  	nicuramar                  � ��f�� f  gg %  	nicuramar                  � �hh 4 h t t p : / / p a s t i e . c a b o o . s e / 8 9 9�H  �G  �F  �E  �D  �C  �B  �A  �@  �?  ascr  ��ޭ