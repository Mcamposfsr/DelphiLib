unit UMappingClass;

interface

type
//MAPEAMENTO DE TABELA
[Tabela('EMPRESAS')]
 TEmpresa = class
  private
    FID: Integer;
    FCNPJ: String;
    FNome: String;

    procedure SetID(const AID: Integer);
    procedure SetCNPJ(const ACNPJ: String);
    procedure SetFNome(const ANome:String);


  public
    Constructor Create;
    Destructor Destroy;

  published
    [Campo('ID'),'PK']
    property ID: Integer read FID write SetID;

    [Campo('EMP_CNPJ')]
    property CNPJ: String read FCNPJ write SetCNPJ;

    [Campo('EMP_NOME')]
    property Nome: String  read FNome write SetFNome;

end;

implementation

  //CONSTRUCTOR MAPEAMENTO
  constructor TEmpresa.Create;
  begin

  end;

  //DESTRUCTOR MAPEAMENTO
  Destructor TEmpresa.Destroy;
  begin
    inherited
  end;

  //SET ID
  procedure TEmpresa.SetID(const AID: Integer);
  begin
    Self.FID := AID;
  end;

  //SET CNPJ
  procedure TEmpresa.SetCNPJ(const ACNPJ: String);
  begin
    Self.FCNPJ := ACNPJ;
  end;

  //SET NOME
  procedure TEmpresa.SetFNome(const ANome:String);
  begin
    Self.FNome := ANome;
  end;

end.
