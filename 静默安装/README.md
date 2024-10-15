# 创建
dart create -t console data_backup

# 全局运行
data_backup
data_backup serve
...

# 本地运行
dart run
dart run data_backup serve

# 添加到全局包的访问 （每次修改源码后，都需要从新添加，用于升级包。）
# ！！！注意清理缓存 位于项目.dart_tool目录 
# 包含 添加包时生成的配置package_config.json 和 执行命令生成的快照.snapshot
dart pub global activate --source path .
# 清理并添加
Remove-Item -Path ".dart_tool" -Recurse;dart pub global activate --source path .

1. 执行访问（配置为从命令行运行，yaml的executables属性。）
data_backup

2. 执行访问 （未配置为从命令行运行）
dart pub global run data_backup

# 查看全局的包的列表
dart pub global list

# 停用全局包的访问
dart pub global deactivate data_backup

# 编译生产（将 Dart 代码 AOT 编译为优化的本机代码）
dart compile exe bin/data_backup.dart

===============================================================================

1.快捷图标更新 默认选中 更新 修复 checkablealone 默认选中  https://newsn.net/say/innosetup-desktop-shortcut.html 

Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: {% if CREATE_DESKTOP_ICON != true %}unchecked{% else %}checkedonce{% endif %}
改为（可能作者拼写错误）
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: {% if CREATE_DESKTOP_ICON != true %}unchecked{% else %}checkablealone{% endif %}



2.添加静默代码：

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