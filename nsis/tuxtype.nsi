# vim: noai et ts=4 tw=0
# with a few tiny modifications by Phil Harper(philh@theopencd.org)
# modified for tuxmath by Yves Combe (yves@ycombe.net)
# modified for tuxtype by David Bruce (davidstuartbruce@gmail.com)

!define PKG_VERSION "1.8.3"
!define PKG_PREFIX  "tuxtype"

!define APP_PREFIX  "TuxType"
!define APP_EXE     "${APP_PREFIX}.exe"
!define APP_NAME    "Tux Typing"

OutFile     "${PKG_PREFIX}-${PKG_VERSION}-win32-installer.exe"
Name        "${APP_NAME}"
Caption     ""
CRCCheck    on
WindowIcon  off
BGGradient  off

# Default to not silent
SilentInstall   normal
SilentUnInstall normal

# Various default text options
MiscButtonText
InstallButtonText
FileErrorText

# Default installation dir and registry key of install directory
InstallDir  "$PROGRAMFILES\${APP_PREFIX}"
InstallDirRegKey HKLM SOFTWARE\${APP_PREFIX} "Install_Dir"

# Licence text
LicenseText "Please read the terms of the General Public License before installing ${APP_NAME}"
LicenseData "mingw32\doc\COPYING"

# Directory browsing
# DirShow           show
ComponentText       "This will install ${APP_NAME} on your computer. Select which optional things you want installed."
DirText             "Choose a directory to install ${APP_NAME} in to:"
AllowRootDirInstall false

# Install page stuff
InstProgressFlags   smooth
AutoCloseWindow     true

Section
  SetOutPath $INSTDIR
  File "mingw32\${APP_EXE}"
#  File "mingw32\*.dll"
  SetOutPath $INSTDIR\data
  File /r "mingw32\data\*.*"
  SetOutPath $INSTDIR\doc
  File /r "mingw32\doc\*.*"
  SetOutPath $INSTDIR\fonts
  File /r "mingw32\fonts\*.*"
  SetOutPath $INSTDIR\locale
  File /r "mingw32\locale\*.*"


  WriteRegStr HKLM SOFTWARE\${APP_PREFIX} "Install_Dir" "$INSTDIR"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_PREFIX}" "DisplayName" "${APP_NAME} (remove only)"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_PREFIX}" "UninstallString" '"$INSTDIR\uninstall.exe"'
  WriteUninstaller "uninstall.exe"
SectionEnd


Section "Start Menu Shortcuts"
  SetShellVarContext all
  SetOutPath $INSTDIR
  CreateDirectory "$SMPROGRAMS\${APP_NAME}"
  CreateShortCut  "$SMPROGRAMS\${APP_NAME}\${APP_NAME} (Full Screen).lnk" "$INSTDIR\${APP_EXE}" "-f" "$INSTDIR\data\images\icons\tuxtype.ico" 0 "" "" "Start Tux Typing in Fullscreen mode"
  CreateShortCut  "$SMPROGRAMS\${APP_NAME}\${APP_NAME} (Windowed).lnk" "$INSTDIR\${APP_EXE}" "-w" "$INSTDIR\data\images\icons\tuxtype.ico" 0 "" "" "Start Tux Typing in a Window"
  CreateShortCut  "$SMPROGRAMS\${APP_NAME}\Uninstall.lnk" "$INSTDIR\uninstall.exe" "" "$INSTDIR\uninstall.exe" 0 "" "" "Remove Tux Typing"
SectionEnd


Section "Desktop Shortcut"
  SetShellVarContext all
  SetOutPath $INSTDIR
  CreateShortCut "$DESKTOP\${APP_NAME}.lnk" "$INSTDIR\${APP_EXE}" "" "$INSTDIR\data\images\icons\tuxtype.ico" 0  "" "" "Run Tux Typing"
SectionEnd

;Function .onInstSuccess
;  BringToFront
;  MessageBox MB_YESNO|MB_ICONQUESTION \
;             "${APP_NAME} was installed. Would you like to run ${APP_NAME} now ?" \
;             IDNO NoExec
;    Exec '$INSTDIR\${APP_EXE}'
;  NoExec:
;FunctionEnd

; uninstall stuff

UninstallText "This will uninstall ${APP_NAME}. Hit 'Uninstall' to continue."

; special uninstall section.
Section "Uninstall"
  SetShellVarContext all
  ; remove registry keys
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_PREFIX}"
  DeleteRegKey HKLM SOFTWARE\${APP_PREFIX}

  RMDir  /r "$INSTDIR\data"
  RMDir  /r "$INSTDIR\doc"
  Delete    "$INSTDIR\*.*"

  Delete "$DESKTOP\${APP_NAME}.lnk"
  Delete "$SMPROGRAMS\${APP_NAME}\*.*"
  RMDir  "$SMPROGRAMS\${APP_NAME}"
SectionEnd


