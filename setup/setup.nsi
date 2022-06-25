!define NAME "Vae Soli Retail"
!define VERSION "1.0.0"

Name "${NAME}"
Icon "lineage2.ico"
OutFile "Setup.exe"
InstallDir "$PROGRAMFILES32\Lineage II"
XPStyle on
BrandingText "${NAME} v${VERSION}"
LicenseData "about.txt"
ShowInstDetails nevershow

Page license
Page directory
Page instfiles

Function .onInit
  IfFileExists $EXEDIR\data.001 0 +3
  IfFileExists $EXEDIR\data.002 0 +2
  IfFileExists $EXEDIR\data.003 +3 0
  MessageBox MB_OK|MB_ICONSTOP "Une ou plusieurs archives sont manquantes."
  Abort "Installation impossible"
FunctionEnd

Section "Lineage II High Five"
  SetOutPath $INSTDIR
  Nsis7z::ExtractWithDetails "$EXEDIR\data.001" "Installing package %s..."
SectionEnd
