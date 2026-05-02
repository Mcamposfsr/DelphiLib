unit UDM;

interface

uses Firedac.comp.Client,FireDAC.Stan.Def,FireDAC.Phys.FB,FireDAC.Phys.FBDef;

Type IDM = Interface
  ['{D5651A9B-D387-4DBE-940B-97560CA85781}']
  Function GetConnection:TFDConnection;
  procedure ConectarBD(AUserName,APassWord,AServer,APort,ADataBasePath:String);
  procedure DesconectarBd;
  procedure ConnectionTest(AUserName,APassWord,AServer,APort,ADataBasePath:String);
End;

type
  TDMClientes = class(TInterfacedObject,IDM)
  private
    FConnection: TFDConnection;

  public
    constructor Create;
    destructor Destroy; override;

    //ACESSO A CONEXÃO
    Function GetConnection:TFDConnection;

    // CONFIGURAR CONEXÃO
    procedure ConectarBD(AUserName,APassWord,AServer,APort,ADataBasePath:String);
    procedure DesconectarBd;

    procedure ConnectionTest(AUserName,APassWord,AServer,APort,ADataBasePath:String);
  end;

implementation

  //INSTANCIA DM
  constructor TDMClientes.Create;
  begin
      inherited Create;
      FConnection := TFDConnection.Create(nil);
  end;

  destructor TDMClientes.Destroy;
  begin
      if Assigned(Self.FConnection) then
    begin
      if Self.FConnection.Connected then
        Self.FConnection.Connected := False;
      FConnection.Free;
    end;

    inherited Destroy;
  end;

  // CONFIGURAR/INICIAR CONEXÃO
  procedure TDMClientes.ConectarBD(AUserName,APassWord,AServer,APort,ADataBasePath:String);
  begin
    if Self.FConnection.Connected then
    Self.FConnection.Connected := False;

    FConnection.Params.Clear;

    Self.FConnection.Params.DriverID := 'FB';
    Self.FConnection.Params.UserName := AUserName;
    Self.FConnection.Params.Password := APassWord;
    Self.FConnection.Params.Values['Server'] := AServer;
    Self.FConnection.Params.Values['Port'] := APort;
    Self.FConnection.Params.Database := ADataBasePath;
    Self.FConnection.LoginPrompt := False;

//    Self.FConnection.TxOptions.AutoCommit := False;
    Self.FConnection.Connected := True;
  end;

  // DESCONECTAR DO BANCO DE DADOS
  procedure TDMClientes.DesconectarBd;
  begin
    if FConnection.Connected then
    FConnection.Connected := False;
  end;

  // RETORNAR TFDCONNECTION
  Function TDMClientes.GetConnection:TFDConnection;
  begin
    Result := Self.FConnection;
  end;

  //TESTAR CONEXÃO
  procedure TDMClientes.ConnectionTest(AUserName,APassWord,AServer,APort,ADataBasePath:String);
  begin
    if FConnection.Connected then
    FConnection.Connected := False;
    Self.ConectarBD(AUserName,APassWord,AServer,APort,ADataBasePath);
    Self.FConnection.Connected := False;
  end;

end.
