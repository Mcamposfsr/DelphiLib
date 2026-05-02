program AppTester;

uses
  Vcl.Forms,
  UAppTester in 'UAppTester.pas' {FormTester},
  UDM in 'src\DM\UDM.pas',
  UMappingClass in 'src\Repository\Mapping\UMappingClass.pas',
  UGenericUtils in 'src\Utils\UGenericUtils.pas',
  ULogger in 'src\Repository\ULogger.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormTester, FormTester);
  Application.Run;
end.
