unit URepository;

interface

uses
//DELPHI USES
System.Sysutils,Firedac.comp.Client,

//CRETED USES
UDM
;

//INTERFACE DE ABSTRAÇÃO
type IRepository = interface
  ['{94936A0C-CC00-4219-A168-2F14B478BC72}']
end;

//CLASSE PARA HERANÇA
type TRepository = class(TInterfacedObject,IRepository)
  private
    // CONEXÃO DM
    FConnection: TFDConnection;
  public
    function Teste: TFDQuery;

  constructor Create(ADM:IDM);
end;

[TABELA('EMPRESAS')]
type TEmpresa = class
  private
    FCNPJ: String;
    FNome: String;

  published

    [CAMPO('EMP_CNPJ')]
    property CNPJ: String read FCNPJ write FCNPJ;

    [CAMPO('EMP_NOME')]
    property Nome: String  read FNome write FNome;

end;


implementation

  //CONSTRUCTOR
  constructor TRepository.Create(ADM:IDM);
  begin
    inherited Create;
    FConnection := ADM.GetConnection;
  end;

  //BUSCAR DADOS
  function TRepository.Teste:TFDQuery;
  var LSQL: String;
  begin
  result := nil;
//
//    FQueryBusca.Close;
//    LSQL:= 'SELECT * FROM EMPRESAS WHERE EMP_CNPJ <> :CNPJ_NULO';
//    FQueryBusca.Params.Clear;
//    FQueryBusca.SQL.Text:= LSQL;
//    FQueryBusca.ParamByName('CNPJ_NULO').Value := '0.000.000/0000-00';
//
//    try
//      FQueryBusca.Open;
//
//      result := FQueryBusca;
//    except
//      on E: Exception do
//      begin
//        Raise;
//      end;
//    end;
  end;

end.
