!define TYPE "Update"
!define VERSION "1.0.0"
!define PETNAME "Amazing Avocet"

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

Section "Version"
  SetOutPath $INSTDIR\l2text
  File l2text\help.htm ; don't forget !
SectionEnd
