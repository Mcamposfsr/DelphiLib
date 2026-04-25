unit UAppTester;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  //TESTES
  UDM,URepository
  ;

type
  TFormTester = class(TForm)
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  FormTester: TFormTester;

implementation

{$R *.dfm}


  procedure TFormTester.FormShow(Sender: TObject);
  var LDM: IDM;
  begin
    LDM := TDMClientes.Create;
    LDM.ConectarBD(
    'SYSDBA',
    'masterkey',
    'localhost',
    '3050',
    'C:\Users\Matheus\Desktop\TIConsultoria\CadizSyncSped\Database\360_J_M_FRIOS_07_11_2025_09_47_v1.40.FDB');

    TRepository.Create(LDM);

    ShowMessage(BoolToStr(LDM.GetConnection.Connected));
  end;

end.
