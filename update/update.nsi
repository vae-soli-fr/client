!define TYPE "Update"
!define VERSION "1.3.0"
!define PETNAME "Daring Drake"

SetCompressor /SOLID lzma
RequestExecutionLevel user

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

Function .onInstSuccess
  MessageBox MB_YESNO|MB_ICONQUESTION "Would you like to read the changelog online?" IDYES 0 IDNO +2
  ExecShell "open" "https://github.com/vae-soli-fr/client/blob/master/update/CHANGELOG.md"
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

Section "Execution Grounds from Classic"
  SetOutPath $INSTDIR\animations
  File animations\EG_A.ukx
  SetOutPath $INSTDIR\maps
  File maps\21_22.unr
  SetOutPath $INSTDIR\sounds
  File sounds\EG_SND.uax
  SetOutPath $INSTDIR\staticmeshes
  File staticmeshes\EG_S4.usx
  SetOutPath $INSTDIR\textures
  File textures\EG_T4.utx
SectionEnd

Section "Version"
  SetOutPath $INSTDIR\l2text
  File l2text\help.htm ; don't forget !
SectionEnd
