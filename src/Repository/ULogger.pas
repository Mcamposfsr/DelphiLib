unit ULogger;

interface

uses System.SysUtils, System.Classes, System.IOUtils,SimpleInterface,
SimpleDAO,SimpleAttributes,SimpleQueryFiredac,SimpleLogger,Data.DB,Vcl.Dialogs;

type
  TFileLogger = class(TInterfacedObject, iSimpleQueryLogger)
  public
    procedure Log(const aSQL: string; aParams: TParams; aDurationMs: Int64);
  end;


implementation

procedure TFileLogger.Log(const aSQL: string; aParams: TParams; aDurationMs: Int64);
var
  Linha: string;
begin
  ShowMessage('Executou');
  Linha := System.SysUtils.Format(
    '[%s] SQL: %s | Params: %s | %d ms',
    [
      FormatDateTime('yyyy-mm-dd hh:nn:ss', Now),
      aSQL,
      '',
      aDurationMs
    ]
  );

  TFile.WriteAllText('C:\Users\Matheus\Desktop\TIConsultoria\TESTE.TXT',Linha);
end;


end.
