unit URepository;

interface

uses
//DELPHI USES
System.Sysutils,Firedac.comp.Client,System.Generics.Collections,

//LIBS
SimpleInterface,SimpleDAO,SimpleAttributes,SimpleQueryFiredac,

//CRETED USES
UDM,UMappingClass;

//INTERFACE DE ABSTRAÇÃO
type IRepository = interface
  ['{94936A0C-CC00-4219-A168-2F14B478BC72}']
end;


//CLASSE PARA HERANÇA
type TRepository = class(TInterfacedObject,IRepository)
  private
    // CONEXÃO DM
    FConnection: ISimpleQuery;
    FDAO: ISimpleDAO<TEmpresa>;

  public

    constructor Create(ADM:IDM);
    destructor Destroy; Override;

    //CRUD GENÉRICO
    procedure Insert;
    procedure Update;
    procedure Delete(AId:String);
    function FindAll:TObjectList<TEmpresa>;
    function Find(AId:Integer):TEmpresa;
end;




implementation

  //CONSTRUCTOR
  constructor TRepository.Create(ADM:IDM);
  begin
    inherited Create;

    //ENCAPSULAR/ ABSTRAIR CONEXÃO
    FConnection := TSimpleQueryFiredac.New(ADM.GetConnection);
    FDAO := TSimpleDAO<TEmpresa>.New(FConnection);
  end;

  // DESTRUCTOR
  destructor TRepository.Destroy;
  begin
    inherited;
  end;

  // ############ CRUD ############ CRUD ############ CRUD ############ CRUD ############ CRUD ############ CRUD ############ CRUD ############ CRUD


  procedure TRepository.Insert;
  var LEmpresa: TEmpresa;
  begin
    //CRIAÇÃO E CONFIGURAÇÃO MAPPER
    LEmpresa := TEmpresa.Create;
    try
      LEmpresa.CNPJ := '360';
      LEmpresa.Nome := 'Matheus';

      FDAO.Insert(LEmpresa);

    finally
      LEmpresa.Free;
    end;
  end;

  procedure TRepository.Update;
  var LEmpresa: TEmpresa;
  begin
    //CRIAÇÃO E CONFIGURAÇÃO MAPPER
    LEmpresa := TEmpresa.Create;
    try
      LEmpresa.ID := 1;
      LEmpresa.CNPJ := '361';
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

  function TRepository.FindAll:TObjectList<TEmpresa>;
  var LList: TObjectList<TEmpresa>;
  begin
     LList := TObjectList<TEmpresa>.Create;
     FDAO.Find(LList);

     //CALLER LIBERA OBJETO
     Result := LList;
  end;

  function TRepository.Find(AId:Integer): TEmpresa;
  var LEmpresa: TEmpresa;
  begin
    LEmpresa := FDAO.Find(AId);
    Result := LEmpresa;
  end;

end.
