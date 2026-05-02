unit URepository;

interface

uses
//DELPHI USES
System.Sysutils,Firedac.comp.Client,System.Generics.Collections,Vcl.Dialogs,FireDAC.VCLUI.Wait,FireDAC.Stan.Async,

//LIBS
SimpleInterface,SimpleDAO,SimpleAttributes,SimpleQueryFiredac,SimpleLogger,

//CREATED USES
UDM,UMappingClass,ULogger;

//INTERFACE DE ABSTRAÇÃO
type IRepository = interface
  ['{94936A0C-CC00-4219-A168-2F14B478BC72}']
end;


//CLASSE PARA HERANÇA
type TRepository = class(TInterfacedObject,IRepository)
  private
    // CONEXÃO DM
    FConnection: ISimpleQuery;
    FDAO: ISimpleDAO<TCLiente>;
    FConn: TFDConnection;
    Flogger: iSimpleQueryLogger;
  public

    constructor Create(ADM:IDM);
    destructor Destroy; Override;

    //CRUD GENÉRICO
    procedure Insert;
    procedure Update;
    procedure Delete(AId:String);
    function FindAll:TObjectList<TCLiente>;
    function Find(AId:Integer):TCLiente;
end;

implementation

  //CONSTRUCTOR
  constructor TRepository.Create(ADM:IDM);
  begin
    inherited Create;
    Flogger := TFileLogger.Create;
    //ENCAPSULAR/ ABSTRAIR CONEXÃO
    FConn := ADM.GetConnection;
    FConnection := TSimpleQueryFiredac.New(ADM.GetConnection);
    FDAO := TSimpleDAO<TCLiente>.New(FConnection);
    FDAO.Logger(Flogger);
  end;

  // DESTRUCTOR
  destructor TRepository.Destroy;
  begin
    inherited;
  end;

  // ############ CRUD ############ CRUD ############ CRUD ############ CRUD ############ CRUD ############ CRUD ############ CRUD ############ CRUD


  procedure TRepository.Insert;
  var LEmpresa: TCLiente;
  begin
    //CRIAÇÃO E CONFIGURAÇÃO MAPPER
    LEmpresa := TCLiente.Create;
    try
      LEmpresa.CPF := '360';
      LEmpresa.Nome := 'Matheus';

      FDAO.Insert(LEmpresa);

    finally
      LEmpresa.Free;
    end;
  end;

  procedure TRepository.Update;
  var LEmpresa: TCLiente;
  begin
    //CRIAÇÃO E CONFIGURAÇÃO MAPPER
    LEmpresa := TCLiente.Create;
    try
      LEmpresa.ID := 1;
      LEmpresa.CPF := '361';
      LEmpresa.Nome := 'Matheus Campos';
      FDAO.Update(LEmpresa);

    finally
      LEmpresa.Free;
    end;
  end;

  procedure TRepository.Delete(AId:String);
  begin
    FDAO.Delete('ID',AId);
  end;

  function TRepository.FindAll:TObjectList<TCLiente>;
  var LList: TObjectList<TCLiente>;
  begin
     LList := TObjectList<TCLiente>.Create;
     FDAO.Find(LList);

     //CALLER LIBERA OBJETO
     Result := LList;
  end;

  function TRepository.Find(AId:Integer): TCLiente;
  var LEmpresa: TCLiente;
  begin
    LEmpresa := FDAO.Find(AId);
    ShowMessage(LEmpresa.Nome);
    Result := LEmpresa;
  end;

//  function TRepository.Find(AId:Integer): TCLiente;
//  var Q: TFDQuery;
//begin
//  Q := TFDQuery.Create(nil);
//  try
//    Q.Connection := FConn;
//
//    Q.SQL.Text := 'SELECT * FROM CLIENTES WHERE ID_CLIENTE = :ID';
//    Q.ParamByName('ID').AsInteger := 1;
//
//    Q.Open;
//
//    ShowMessage(Q.FieldByName('NOME_CLIENTE').AsString);
//  finally
//    Q.Free;
//  end;
//end;

end.
