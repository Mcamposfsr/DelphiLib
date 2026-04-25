program AppTester;

uses
  Vcl.Forms,
  UAppTester in 'UAppTester.pas' {FormTester},
  UDM in 'src\DM\UDM.pas',
  URepository in 'src\Repository\URepository.pas',
  UMappingClass in 'src\Repository\Mapping\UMappingClass.pas',
  UGenericUtils in 'src\Utils\UGenericUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormTester, FormTester);
  Application.Run;
end.
