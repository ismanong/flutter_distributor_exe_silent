# 修改替换
Remove-Item -Path ".dart_tool" -Recurse;dart pub global activate --source path .

# 静默安装
yoka_pack_2.1.6.exe /silent

# 修改原因
postinstall skipifsilent
普通安装（有界面） 显示运行程序复选框
静默安装时         跳过不执行

postinstall	             
普通安装（有界面） 显示运行程序复选框
静默安装时         自动运行程序

//不显示选择语言
ShowLanguageDialog=no

[Code]
// 禁止路径空格
function NextButtonClick(CurPageID: Integer): Boolean;
var
  InstallPath: string;
begin
  // 检查当前页面是否为选择目录页面
  if CurPageID = wpSelectDir then
  begin
    // 获取用户选择的安装路径
    InstallPath := WizardDirValue;

    // 检测路径中是否包含空格
    if Pos(' ', InstallPath) > 0 then
    begin
      // 提示用户路径中不能包含空格
      MsgBox('安装路径不能包含空格，请选择一个不包含空格的目录。', mbError, MB_OK);
      Result := False; // 阻止继续下一步
      Exit;
    end;
  end;

  // 如果没有问题，允许继续
  Result := True;
end;