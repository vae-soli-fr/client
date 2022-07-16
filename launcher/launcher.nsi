!define TYPE "Launcher"
!define VERSION "1.1.0"
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

MiscButtonText "Retour" "Jouer" "Quitter" "Fermer"
InstallButtonText "Jouer"
SubCaption 3 " : mise à jour"
Caption "Vae Soli"
WindowIcon off
SetFont "Tahoma" 13
AutoCloseWindow true

Var latestPatch
Var runningPatch
Var latestUpdate
Var runningUpdate

Page custom web
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

Section /o "patch" patch
  DetailPrint "Downloading last Patch"
  inetc::get "${SERVER}/Patch.exe" "$TEMP\vaesoli\Patch.exe" /END
  Pop $0
  StrCmp $0 "OK" +2 0
  Abort "Le téléchargement a échoué"
  Exec '"$TEMP\vaesoli\Patch.exe" /D=$EXEDIR'
SectionEnd

Section /o "update" update
  DetailPrint "Downloading last Update"
  inetc::get "${SERVER}/Update.exe" "$TEMP\vaesoli\Update.exe" /END
  Pop $0
  StrCmp $0 "OK" +2 0
  Abort "Le téléchargement a échoué"
  ExecWait '"$TEMP\vaesoli\Update.exe" /D=$EXEDIR'
SectionEnd

Section /o "run" run
  HideWindow
  SetOutPath $EXEDIR\system
  Exec l2.exe
SectionEnd

Function "web"
  nsWeb::IsInet 1
  StrCmp $1 1 0 +2
  nsWeb::ShowWebInPage "${SERVER}/news"
FunctionEnd

Function "check"
  HideWindow
  IfFileExists $TEMP\vaesoli\latest.ini 0 pass ; when download fail

  ; select patch
  ReadINIStr $latestPatch $TEMP\vaesoli\latest.ini Client Patch
  ReadINIStr $runningPatch $EXEDIR\version.ini Client Patch
  StrCmp $latestPatch $runningPatch next 0
  MessageBox MB_YESNO|MB_ICONQUESTION|MB_TOPMOST "Un nouveau Patch v$latestPatch est disponible :$\r$\nsouhaitez-vous le télécharger ?" IDYES 0 IDNO next
  SectionSetFlags ${patch} ${SF_SELECTED}
  Goto skip

  ; select update
  next:
  ReadINIStr $latestUpdate $TEMP\vaesoli\latest.ini Client Update
  ReadINIStr $runningUpdate $EXEDIR\version.ini Client Update
  StrCmp $latestUpdate $runningUpdate pass 0
  MessageBox MB_YESNO|MB_ICONQUESTION|MB_TOPMOST "Un nouvel Update v$latestUpdate est disponible :$\r$\nsouhaitez-vous le télécharger ?" IDYES 0 IDNO pass
  SectionSetFlags ${update} ${SF_SELECTED}

  ; select L2
  pass:
  SectionSetFlags ${run} ${SF_SELECTED}
  skip:
FunctionEnd
