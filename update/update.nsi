!define TYPE "Update"
!define VERSION "1.5.0"
!define PETNAME "Feisty Fish"

SetCompressor /SOLID lzma
RequestExecutionLevel admin ; required

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
  WriteINIStr $INSTDIR\version.ini Client ${TYPE} ${VERSION}
  SetFileAttributes $INSTDIR\version.ini HIDDEN
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

Section "Cerulys"
  SetOutPath $INSTDIR\maps
  File maps\24_22.unr
SectionEnd

Section "Gludio from Classic"
  SetOutPath $INSTDIR\maps
  File maps\19_21.unr
  SetOutPath $INSTDIR\staticmeshes
  File staticmeshes\gl_cv_s.usx
  File staticmeshes\Gludio_Rewindmill_S.usx
  File staticmeshes\gludio_tree_S.usx
  SetOutPath $INSTDIR\textures
  File textures\gl_cv_t.utx
  File textures\gludio_rewindmill_t.utx
  File textures\gludio_tree_t.utx
  File textures\L2DecoLayer.utx
  File textures\magmell_orbis_t.utx
  File textures\t_19_21.utx
  File textures\t_gludio.utx
  File textures\t_oren.utx
  File textures\t_sland.utx
  File textures\T_texture.utx
SectionEnd

Section "Version"
  SetOutPath $INSTDIR\l2text
  File l2text\help.htm ; don't forget !
SectionEnd
