!define TYPE "Update"
!define VERSION "1.2.0"
!define PETNAME "Cheeky Caracal"

SetCompressor /SOLID lzma

Name "Vae Soli ${TYPE}"
Icon "lineage2.ico"
OutFile "Update.exe"
InstallDir "$PROGRAMFILES32\Lineage II"
XPStyle on
BrandingText "${TYPE} v${VERSION} $\"${PETNAME}$\""
LicenseData "about.txt"
ShowInstDetails hide

Page license
Page directory
Page instfiles

Function .onVerifyInstDir
  IfFileExists $INSTDIR\system\l2.ini +2 0
  Abort
FunctionEnd

Section "Grand Crusade Lobby"
  SetOutPath $INSTDIR\maps
  File maps\Lobby01.unr
  SetOutPath $INSTDIR\staticmeshes
  File staticmeshes\Clasi_S2.usx
  SetOutPath $INSTDIR\system
  File system\logongrp.dat
  SetOutPath $INSTDIR\textures
  File textures\Clasi_T2.utx
SectionEnd

Section "Giran Renew"
  SetOutPath $INSTDIR\maps
  File maps\22_22.unr
  SetOutPath $INSTDIR\staticmeshes
  File staticmeshes\GrandCrusadeGiranDam.usx
  File staticmeshes\GrandCrusadeTent.usx
  SetOutPath $INSTDIR\textures
  File textures\New_Speaking_V_T.utx
SectionEnd

Section "Gludin Port"
  SetOutPath $INSTDIR\maps
  File maps\17_22.unr
SectionEnd

Section "Version"
  SetOutPath $INSTDIR\l2text
  File l2text\help.htm ; don't forget !
SectionEnd
