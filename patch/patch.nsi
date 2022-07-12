!define TYPE "Patch"
!define VERSION "1.0.1"
!define SERVER "https://client.vae-soli.fr"

SetCompressor /SOLID lzma
RequestExecutionLevel admin ; required

Name "Vae Soli ${TYPE}"
Icon "lineage2.ico"
OutFile "Patch.exe"
InstallDir "$PROGRAMFILES32\Lineage II"
XPStyle on
BrandingText "${TYPE} v${VERSION}"
LicenseData "about.txt"
ShowInstDetails hide

Page license
Page directory
Page components
Page instfiles

Function .onVerifyInstDir
  IfFileExists $INSTDIR\system\l2.ini +2 0
  Abort
FunctionEnd

Function .onInstSuccess
  WriteINIStr $INSTDIR\launcher.ini Client ${TYPE} ${VERSION}
  SetFileAttributes $INSTDIR\launcher.ini HIDDEN
FunctionEnd

Section "Lineage II Patch"
  SectionIn RO

  SetOutPath $INSTDIR
  File Launcher.exe
  Delete lineage2.ico
  Delete LineageII.exe
  Delete Lineage2.new
  Delete patchw32.dll

  SetOutPath $INSTDIR\maps
  File maps\SkyLevel.unr ; replace hideous clouds

  SetOutPath $INSTDIR\system
  File /a /r "system\" ; patched system
  Delete Obscene-e.dat ; chat filter

  CreateShortCut "$DESKTOP\Vae Soli.lnk" "$INSTDIR\Launcher.exe" "" "$INSTDIR\Launcher.exe" 0
SectionEnd

Section "Download and install last Update"
  DetailPrint "Downloading last Update"
  inetc::get "${SERVER}/Update.exe" "$EXEDIR\Update.exe" /END
  Pop $0
  StrCmp $0 "OK" +2 0
  Abort "Le téléchargement a échoué"
  ExecWait "$EXEDIR\Update.exe"
SectionEnd
