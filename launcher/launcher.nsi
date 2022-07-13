!define TYPE "Launcher"
!define VERSION "1.0.0"
!define SERVER "https://client.vae-soli.fr"
!define SF_SELECTED 1

SetCompressor /SOLID lzma
RequestExecutionLevel admin ; required

Name "Vae Soli ${TYPE}"
Icon "lineage2.ico"
OutFile "..\Patch\Launcher.exe"
XPStyle on
BrandingText "${TYPE} v${VERSION}"
ShowInstDetails nevershow
AutoCloseWindow true

SubCaption 3 " : mise à jour"
Caption "Vae Soli"

Var latest
Var running

Page custom check
Page instfiles

Function .onInit
  SetOutPath $TEMP\vaesoli
  File splash.bmp
  ;advsplash::show Delay FadeIn FadeOut KeyColor (ex:0xFF00FF or -1) FileName
  advsplash::show 1750 600 400 0x3B3B3B $TEMP\vaesoli\splash
FunctionEnd

Function .OnGUIInit
  inetc::get "${SERVER}/latest.ini" "$TEMP\vaesoli\latest.ini" /END
  Pop $0
  StrCmp $0 "OK" +2 0
  MessageBox MB_OK|MB_ICONINFORMATION|MB_TOPMOST "Impossible de récupérer la dernière version"
FunctionEnd

Function .OnGUIEnd
  WriteINIStr $EXEDIR\version.ini Client ${TYPE} ${VERSION}
  RMDir /r $TEMP\vaesoli
FunctionEnd

Section /o "update" update
  DetailPrint "Downloading last Update"
  inetc::get "${SERVER}/Update.exe" "$TEMP\vaesoli\Update.exe" /END
  Pop $0
  StrCmp $0 "OK" +2 0
  Abort "Le téléchargement a échoué"
  Exec "$TEMP\vaesoli\Update.exe"
SectionEnd

Section /o "run" run
  HideWindow
  SetOutPath $EXEDIR\system
  Exec l2.exe
SectionEnd

Function "check"
  HideWindow
  IfFileExists $TEMP\vaesoli\latest.ini 0 pass ; when download fail
  ReadINIStr $latest $TEMP\vaesoli\latest.ini Client Update
  ReadINIStr $running $EXEDIR\version.ini Client Update
  StrCmp $latest $running pass 0
  MessageBox MB_YESNO|MB_ICONQUESTION|MB_TOPMOST "Un nouvel Update v$latest est disponible :$\r$\nsouhaitez-vous le télécharger ?" IDYES 0 IDNO pass
  SectionSetFlags ${update} ${SF_SELECTED}
  Goto skip
  pass:
  SectionSetFlags ${run} ${SF_SELECTED}
  skip:
FunctionEnd
