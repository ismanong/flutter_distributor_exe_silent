[Setup]
AppId=6c99909f-6cfb-41e9-91c9-aab695408f5b
AppVersion=0.0.1+15
AppName=xxx壁纸 测试
AppPublisher=xxx
AppPublisherURL=https://xxx.com
AppSupportURL=https://xxx.com
AppUpdatesURL=https://xxx.com
DefaultDirName=D:\Program Files (x86)\xxx
DisableProgramGroupPage=yes
OutputDir=.
OutputBaseFilename=xxx-OutsideChina-0.0.1.15-windows
Compression=lzma
SolidCompression=yes
SetupIconFile=D:\_work\desktop_tool\wallpaper\packages\main\windows\runner\resources\app_icon.ico
WizardStyle=modern
PrivilegesRequired=none
ArchitecturesAllowed=x64
ArchitecturesInstallIn64BitMode=x64

// 选择语言 no=隐藏
ShowLanguageDialog=no

// 磁盘跨区(磁盘跨越) yes=启用 否则超过2G会报 disk spanning must be enabled in order to create an installation larger than 2100000000byte
// DiskSpanning=yes

[Languages]

Name: "english"; MessagesFile: "compiler:Default.isl"




Name: "chinesesimplified"; MessagesFile: "compiler:Languages\ChineseSimplified.isl"



[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: checkedonce
Name: "launchAtStartup"; Description: "{cm:AutoStartProgram,微端壁纸 测试}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
[Files]
Source: "xxx-OutsideChina-0.0.1.15-windows_exe\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{autoprograms}\微端壁纸 测试"; Filename: "{app}\main.exe"
Name: "{autodesktop}\微端壁纸 测试"; Filename: "{app}\main.exe"; Tasks: desktopicon
Name: "{userstartup}\微端壁纸 测试"; Filename: "{app}\main.exe"; WorkingDir: "{app}"; Tasks: launchAtStartup
[Run]
Filename: "{app}\main.exe"; Description: "{cm:LaunchProgram,微端壁纸 测试}"; Flags:  nowait postinstall skipifsilent



[code]
//关键代码静默安装
procedure InitializeWizard();
begin
//不显示边框，这样就能达到不会闪两下了
WizardForm.BorderStyle:=bsNone;
end;


procedure CurPageChanged(CurPageID: Integer);
//var
//indexpageid3:Integer;
begin
    //因为安装过程界面隐藏不了，所以设置窗口宽高为0
    WizardForm.ClientWidth := ScaleX(0);
    WizardForm.ClientHeight := ScaleY(0);
    if CurPageID = wpWelcome then
    WizardForm.NextButton.OnClick(WizardForm);
    if CurPageID >= wpInstalling then
            WizardForm.Visible := False
        else
            WizardForm.Visible := True;
            // WizardForm.NextButton.OnClick(WizardForm);    
end;

function ShouldSkipPage(PageID: Integer): Boolean;
begin
    Result := True
end;

function IsCreateShortcut(): Boolean;
var
  j: Integer;
  isVerySilent: Boolean;
begin
  isVerySilent := True;
  for j := 1 to ParamCount do
    if CompareText(ParamStr(j), '--noicon=1') = 0 then
    begin
      isVerySilent := False;
      Break;
    end; 

  if isVerySilent then
    Log ('VerySilent')
  else
    Log ('not VerySilent');
  Result := isVerySilent;
end;

// 卸载删除所有文件
procedure CurUninstallStepChanged(CurUninstallStep:TUninstallStep);
begin
  if CurUninstallStep = usDone then
  begin
  DelTree(ExpandConstant('{app}'), True, True, True);
  end;
end;

// 研究下有没有更简单的方式 https://blog.csdn.net/allway2/article/details/122220277
