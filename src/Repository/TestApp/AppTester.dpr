program AppTester;

uses
  Vcl.Forms,
  UAppTester in 'UAppTester.pas' {Form1},
  URepository in '..\URepository.pas',
  UDM in '..\..\DM\UDM.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
