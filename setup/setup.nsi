!define TYPE "Retail"
!define VERSION "1.0.1"
!define SERVER "https://client.vae-soli.fr"

SetCompressor /SOLID lzma
RequestExecutionLevel user

Name "Vae Soli ${TYPE}"
Icon "lineage2.ico"
OutFile "Setup.exe"
InstallDir "$PROGRAMFILES32\Lineage II"
XPStyle on
BrandingText "${TYPE} v${VERSION}"
LicenseData "about.txt"
ShowInstDetails nevershow

Page license
Page directory
Page components
Page instfiles

Function .onInit
  IfFileExists $EXEDIR\data.001 0 +3
  IfFileExists $EXEDIR\data.002 0 +2
  IfFileExists $EXEDIR\data.003 +3 0
  MessageBox MB_OK|MB_ICONSTOP "Une ou plusieurs archives sont manquantes."
  Abort "Installation impossible"
FunctionEnd

Section "Lineage II Retail client"
  SectionIn RO
  AddSize 11558609 ; kB

  SetOutPath $INSTDIR
  Nsis7z::ExtractWithDetails "$EXEDIR\data.001" "Installing Lineage II: Freya (High Five) %s..."
SectionEnd

Section "Download and install last Patch"
  DetailPrint "Downloading last Patch"
  inetc::get "${SERVER}/Patch.exe" "$EXEDIR\Patch.exe" /END
  Pop $0
  StrCmp $0 "OK" +2 0
  Abort "Le téléchargement a échoué"
  ExecWait "$EXEDIR\Patch.exe"
SectionEnd
