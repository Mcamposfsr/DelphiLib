unit UMappingClass;

interface

uses SimpleAttributes,Vcl.Dialogs;

type
//MAPEAMENTO DE TABELA
[Tabela('CLIENTES')]
 TCLiente = class
  private
    FID: Integer;
    FNome: String;
    FCPF: String;

    procedure SetID(const AID: Integer);
    procedure SetCPF(const ACPF: String);
    procedure SetNome(const ANome:String);

  public
    Constructor Create;
    Destructor Destroy; Override;

  published
    [Campo('ID_CLIENTE'),Pk,AutoInc]
    property ID: Integer read FID write SetID;

    [Campo('NOME_CLIENTE')]
    property Nome: String  read FNome write SetNome;

    [Campo('CPF_CLIENTE')]
    property CPF: String read FCPF write SetCPF;

end;

implementation

  //CONSTRUCTOR MAPEAMENTO
  constructor TCLiente.Create;
  begin
    inherited;
  end;

  //DESTRUCTOR MAPEAMENTO
  Destructor TCLiente.Destroy;
  begin
    inherited;
  end;

  //SET ID
  procedure TCLiente.SetID(const AID: Integer);
  begin
    Self.FID := AID;
  end;

  //SET CPF
  procedure TCLiente.SetCPF(const ACPF: String);
  begin
    Self.FCPF := ACPF;
//    ShowMessage(ACPF);
  end;

  //SET NOME
  procedure TCLiente.SetNome(const ANome:String);
  begin

    Self.FNome := ANome;
//    ShowMessage(Self.Nome);
  end;

end.
