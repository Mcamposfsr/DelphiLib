unit UGenericUtils;

interface

uses
//USES DELPHI
System.SysUtils, Vcl.Dialogs, System.IOUtils, System.Zip,System.Math,

//USES API WINDOWS
Winapi.ShellAPI, Winapi.Windows;

// ############# TIPOS AUXÍLIARES ############# TIPOS AUXÍLIARES ############# TIPOS AUXÍLIARES ############# TIPOS AUXÍLIARES
type
  TVersion = record
    Major, Minor, Release, Build: Integer;
  end;

// ################# CLASSE UTILS ################# CLASSE UTILS ################# CLASSE UTILS ################# CLASSE UTILS

Type TGenericUtils = class
  Public

  //RETORNAR CNPJ APENAS C/ NÚMEROS
  class function NormalizerCNPJ(ACnpj:string):String;
  //EXECUTAR APLICAÇÃO
  class procedure ExecuteApplication(APath:String);
  //COMPACTAR ARQUIVOS
  class procedure CompactarArquivo(const ADiretorioFinal, ADiretorioArquivo: string);
  //DELETAR ARQUIVOS
  class procedure ArchiveDeleter(ACaminhoArquivo:String);
  //BUSCAR VERSÃO DO APLICATIVO
  class function GetAppVersion: string;
  //COMPARAR VERSÕES - 0.0.0.0
  class function CompareVersion(const AVersionA, AVersionB: string): Integer;

  private
  // FUNÇÕES AUXÍLIARES

  // ***** CompareVersion *****
  class function ElementAtOrDefault(const Arr: TArray<string>; Index: Integer): string;
  class function ParseVersion(const AVersion: string): TVersion;

end;

implementation

  // ################## AÇÕES PRINCIPAIS ################## AÇÕES PRINCIPAIS ################## AÇÕES PRINCIPAIS ################## AÇÕES PRINCIPAIS ################## AÇÕES PRINCIPAIS

  //RETORNAR CNPJ APENAS C/ NÚMEROS
  class function TGenericUtils.NormalizerCNPJ(ACnpj:string):String;
  Var I:Integer;
  begin
    Result:= '';
    for I := 1 to Length(ACnpj) do
    begin
      if ACnpj[I] in ['0'..'9'] then
      begin
        Result:= Result + ACnpj[I];
      end;
    end;
  end;

  //EXECUTAR APLICAÇÃO
  class procedure TGenericUtils.ExecuteApplication(APath: String);
  begin
    ShellExecute(
      0,
      'open',
      PChar(APath),
      PChar('/SILENT /NORESTART'),
      nil,
      SW_SHOW
    );
  end;

  //COMPACTAR ARQUIVOS
  class procedure TGenericUtils.CompactarArquivo(const ADiretorioFinal, ADiretorioArquivo: string);
  var
  LZip: TZipFile;
  LDirDestino:String;
  begin
    // GARANTIR QUE DIRETÓRIO DE COMPACTAÇÃO EXISTE
    LDirDestino:= ExtractFilePath(ADiretorioFinal);

    if not TDirectory.Exists(LDirDestino) then
      TDirectory.CreateDirectory(LDirDestino);
    LZip := nil;
    try
      try
        LZip:= TZipFile.Create;
        LZip.Open(ADiretorioFinal, zmWrite);
        LZip.Add(ADiretorioArquivo,ExtractFileName(ADiretorioArquivo),zcDeflate);
      finally
        if assigned(LZip) then
          LZip.Close;
      end;
    finally
      LZip.Free;
    end;
  end;

  //DELETAR ARQUIVOS
  class procedure TGenericUtils.ArchiveDeleter(ACaminhoArquivo:String);
  begin
    if not System.SysUtils.DeleteFile(ACaminhoArquivo) then
      Raise Exception.Create(
      'Ocorreu um erro ao tentar apagar: ' +
       ExtractFileName(ACaminhoArquivo) +
        sLineBreak +  'Arquivo aberto ou diretório informado errado');
  end;

  //BUSCAR VERSÃO DO APLICATIVO
  class function TGenericUtils.GetAppVersion: string;
  var
    Size, Handle: DWORD;
    Buffer: Pointer;
    FileInfo: PVSFixedFileInfo;
    Len: UINT;
  begin
    Result := '';
    Size := GetFileVersionInfoSize(PChar(ParamStr(0)), Handle);

    if Size > 0 then
    begin
      GetMem(Buffer, Size);
      try
        if GetFileVersionInfo(PChar(ParamStr(0)), Handle, Size, Buffer) then
        begin
          if VerQueryValue(Buffer, '\', Pointer(FileInfo), Len) then
          begin
            Result := Format('%d.%d.%d.%d', [
              HiWord(FileInfo.dwFileVersionMS),
              LoWord(FileInfo.dwFileVersionMS),
              HiWord(FileInfo.dwFileVersionLS),
              LoWord(FileInfo.dwFileVersionLS)
            ]);
          end;
        end;
      finally
        FreeMem(Buffer);
      end;
    end;
  end;

  //COMPARADOR  - USO: CompareVersion(X,Y) > 0 ->
  // TRUE: X > Y
  // FALSE: X <= Y
  class function TGenericUtils.CompareVersion(const AVersionA, AVersionB: string): Integer;
  var
    V1, V2: TVersion;
  begin
    V1 := Self.ParseVersion(AVersionA);
    V2 := Self.ParseVersion(AVersionB);

    if V1.Major <> V2.Major then
      Exit(Sign(V1.Major - V2.Major));

    if V1.Minor <> V2.Minor then
      Exit(Sign(V1.Minor - V2.Minor));

    if V1.Release <> V2.Release then
      Exit(Sign(V1.Release - V2.Release));

    if V1.Build <> V2.Build then
      Exit(Sign(V1.Build - V2.Build));

    Result := 0;
  end;

  // ######## FUNÇÕES AUXÍLIARES ######## FUNÇÕES AUXÍLIARES ######## FUNÇÕES AUXÍLIARES ######## FUNÇÕES AUXÍLIARES ######## FUNÇÕES AUXÍLIARES ######## FUNÇÕES AUXÍLIARES

  class function TGenericUtils.ElementAtOrDefault(const Arr: TArray<string>; Index: Integer): string;
  begin
    if Index < Length(Arr) then
      Result := Arr[Index]
    else
      Result := '';
  end;

  class function TGenericUtils.ParseVersion(const AVersion: string): TVersion;
  var
    Parts: TArray<string>;
  begin
    Parts := AVersion.Split(['.']);

    Result.Major   := StrToIntDef(ElementAtOrDefault(Parts,0), 0);
    Result.Minor   := StrToIntDef(ElementAtOrDefault(Parts,1), 0);
    Result.Release := StrToIntDef(ElementAtOrDefault(Parts,2), 0);
    Result.Build   := StrToIntDef(ElementAtOrDefault(Parts,3), 0);
  end;
end.
