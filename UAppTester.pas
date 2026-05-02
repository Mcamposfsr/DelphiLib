unit UAppTester;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,FireDAC.UI.Intf,FireDAC.VCLUI.Wait,FireDAC.Stan.Async,System.Generics.Collections,
  //TESTES
  UDM,UMappingClass,

  //SIMPLE ORM
  SimpleInterface,SimpleDAO,SimpleAttributes,SimpleQueryFiredac,SimpleLogger,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls
  ;

  type
  TMeuLogger = class(TInterfacedObject, ISimpleQueryLogger)
  public
    procedure Log(const aSQL: string; aParams: TParams; aDurationMs: Int64);
  end;

type
  TFormTester = class(TForm)
    TDBGrid: TDBGrid;
    DataSourceSimple: TDataSource;
    TButtonFind: TButton;
    TButtonInsert: TButton;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure TButtonFindClick(Sender: TObject);
    procedure TButtonInsertClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    FConn: ISimpleQuery;
    FDAO: ISimpleDAO<TCLiente>;
    FDM: IDM;
  public

  end;

var
  FormTester: TFormTester;

implementation

{$R *.dfm}

  //procedure teste

  //BUSCAR VALORES NO BANCO AUTOMÁTICAMENTE
procedure TFormTester.FormCreate(Sender: TObject);
  var
  Lista: TObjectList<TCLiente>;
  LBancoPath: String;

  begin
    Lista := TObjectList<TCLiente>.Create;
    LBancoPath := ExtractFilePath(paramStr(0)) + '/../../DataBase/TESTEFB.FDB';

    FDM := TDMClientes.Create;
    FDM.ConectarBD('SYSDBA','masterkey','localhost','3050',LBancoPath);

    FConn := TSimpleQueryFireDac.New(FDM.GetConnection);
    FDAO := TSimpleDAO<TCLiente>.New(FConn);
    FDAO.DataSource(Self.DataSourceSimple);
    FDAO.Logger(TMeuLogger.Create);

//    FDAO.Find;
  end;

  //LOGGAR SQL
  procedure TMeuLogger.Log(const aSQL: string; aParams: TParams; aDurationMs: Int64);
  begin
    ShowMessage(aSQL + sLineBreak);
  end;

  //BUSCAR VIA ID Nº 1
  procedure TFormTester.TButtonFindClick(Sender: TObject);
  var
    LCliente: TCLiente;
  begin

    LCLiente := FDAO.Find(1);

    if Assigned(LCliente) then
    begin
      try
        ShowMessage(LCliente.Nome);
      finally
        LCliente.Free;
      end;
    end
    else
      ShowMessage('Cliente não encontrado!');
  end;


  // SELECT *
  procedure TFormTester.Button1Click(Sender: TObject);
  begin
    FDAO.Find;
  end;


  //INSERT
  procedure TFormTester.TButtonInsertClick(Sender: TObject);
  var LCliente: TCliente;
  begin
    LCliente := nil;
    try
      LCliente := TCliente.Create;
      LCliente.Nome := 'Teste';
      LCliente.CPF := '123.123.123-12';

      FDAO.Insert(LCliente);
    finally
      FDAO.Find;
      LCliente.Free;
    end;
  end;

end.
