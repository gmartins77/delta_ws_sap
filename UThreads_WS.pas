unit UThreads_WS;

interface

uses uni, inifiles, Windows, Messages, SysUtils, Classes, syncobjs, Activex,
  dateutils,
  SQLServerUniProvider,
  Vcl.StdCtrls, UBD_Aux, UAux_Integracao, z_ws_ac_mat1,
  z_ws_cent_pal1, USysLogs_local;

type

  TThread_Geral = Class(TThread)
  private
    { Private declarations }
    fMINUTOS_SINCRONIZACAO_BASE: integer;
    ULTIMO_SINCRONISMO: tdatetime;
    fmemo_log: tmemo;
    fcentro: string;

    MINUTOS_SINCRONIZACAO_MAT: integer;
    MINUTOS_SINCRONIZACAO_OP: integer;
    ULTIMO_SINCRONISMO_MAT: tdatetime;
    ULTIMO_SINCRONISMO_OP: tdatetime;

  Public
    { Public declarations }

    Procedure Execute; Override;
    constructor Create(centro: STRING; memo_log: tmemo;
      MINUTOS_SINCRONIZACAO: integer);
    destructor Destroy; override;

    FUNCTION VerificaSeEnvia(I_data: tdatetime; I_MINUTOS: integer;
      I_ULTIMO_SINCRONISMO: tdatetime): boolean;
    { Published declarations }
  End;

  TThread_WS_ORDENS = Class(TThread)
  private
    { Private declarations }
    fcentro: string;
    fMINUTOS_SINCRONIZACAO: ttime;
    Fdias_offset: SMALLINT;
    fmemo_log: tmemo;

    fdata_importacao: tdatetime;

    BD: TUNICONNECTION;

    ULTIMO_ENVIO: tdatetime;

    server: string;
    bdados: string;
    login: String;
    pass: String;

    Procedure FazLog(msg: String; erro: boolean = false);
  Public
    { Public declarations }

    Procedure Execute; Override;
    constructor Create(centro: STRING; data: tdatetime; memo_log: tmemo);
    destructor Destroy; override;

    procedure ImportaOrdens(bd_recebida: TUNICONNECTION; memo: tmemo;
      centro: String); // Published
    { Published declarations }
  End;

  TThread_WS_PA = Class(TThread)
  private
    { Private declarations }
    fcentro: string;
    fMINUTOS_SINCRONIZACAO: ttime;
    Fdias_offset: SMALLINT;
    fmemo_log: tmemo;

    BD: TUNICONNECTION;

    ULTIMO_ENVIO: tdatetime;

    server: string;
    bdados: string;
    login: String;
    pass: String;

    Procedure FazLog(msg: String; erro: boolean = false);
  Public
    { Public declarations }

    Procedure Execute; Override;
    constructor Create(centro: STRING; memo_log: tmemo);
    destructor Destroy; override;

    procedure ImportaProdutoAcabado(bd_recebida: TUNICONNECTION; memo: tmemo;
      centro: String);
    { Published declarations }
  End;

implementation

{ TThread_WS_ORDENS }

constructor TThread_WS_ORDENS.Create(centro: STRING; data: tdatetime;
  memo_log: tmemo);
VAR

  ficheiro: string;
begin
  inherited Create(false);

  freeonterminate := true;
  fmemo_log := memo_log;

  fcentro := centro;

  fdata_importacao := data;

  ficheiro := ExtractFilePath(ParamStr(0)) + 'CONF_WS.INI';

  server := DevolveInformacaoFicheiroini(ficheiro, 'SISTEMA', 'SERVIDOR');
  bdados := DevolveInformacaoFicheiroini(ficheiro, 'SISTEMA', 'BD');
  login := DevolveInformacaoFicheiroini(ficheiro, 'SISTEMA', 'LOGIN');
  pass := DevolveInformacaoFicheiroini(ficheiro, 'SISTEMA', 'PASS');

  GereLogs_local.FazLog(c_ficheiro_log_base, 'Iniciando TThread_WS_ORDENS');
end;

destructor TThread_WS_ORDENS.Destroy;
begin

  GereLogs_local.FazLog(c_ficheiro_log_base, 'Fechando TThread_WS_ORDENS');
  inherited;
end;

procedure TThread_WS_ORDENS.Execute;
var
  data_importacao: TDate;
begin
  inherited;
  Coinitialize(nil);
  TRY
    BD := TUNICONNECTION.Create(nil);
    try
      BD.SpecificOptions.Add('SQL Server.Authentication=auServer');
      BD.ProviderName := 'SQL Server';
      BD.LoginPrompt := false;
      BD.server := server;
      BD.Database := bdados;
      BD.Username := login;
      BD.Password := pass;

      BD.OPEN;
      ImportaOrdens(BD, fmemo_log, fcentro);
    finally
      BD.free;
      CoUninitialize;
    end;
  EXCEPT
    ON E: EXCEPTION DO
    BEGIN
      GereLogs_local.FazLog(c_ficheiro_ERROR_base, 'TThread_WS_ORDENS ' +
        E.MESSAGE);
    END;
  END;
end;

procedure TThread_WS_ORDENS.FazLog(msg: String; erro: boolean);
begin

end;

procedure TThread_WS_ORDENS.ImportaOrdens(bd_recebida: TUNICONNECTION;
  memo: tmemo; centro: String);
var
  ws: Z_WS_CENT_PAL;
  res: TABLE_OF_ZDOLMAORDEMPROD;
  a: integer;
  ano, mes, dia: string;
  data: TDate;
  ts: tdatetime;
  msg: string;
begin
  try

    FazLogImportacao(bd_recebida, 'GetZ_WS_CENT_PAL', host_name,
      c_accao_log_inicio, fmemo_log);

    data := fdata_importacao;
    ano := IntToStr(YearOf(data));
    mes := IntToStr(MonthOf(data));
    dia := IntToStr(DayOfTheMonth(data));

    if Length(mes) = 1 then
      mes := '0' + mes;
    if Length(dia) = 1 then
      dia := '0' + dia;

    ws := GetZ_WS_CENT_PAL(false);

    ts := NOW;
    ws.Z_WS_CENT_PAL(ano + '-' + mes + '-' + dia, '', '', res);
    for a := 0 to Length(res) - 1 do
    begin
      if memo <> nil then
        memo.Lines.Add(res[a].PLNBEZ + ' ' + res[a].AUFNR + ' ' + res[a].CHARG);
      msg := GravaOP_Sap(bd_recebida, data, res[a], fmemo_log);
      if trim(msg) <> '' then
        if memo <> nil then
          memo.Lines.Add(msg);
    end;
    FazLogImportacao(bd_recebida, 'GetZ_WS_CENT_PAL', host_name,
      c_accao_log_fim, fmemo_log)
  except
    on E: EXCEPTION do
    begin
      FazLogImportacao(bd_recebida, 'GetZ_WS_CENT_PAL', host_name,
        c_accao_log_erro, fmemo_log, '', E.MESSAGE)

    end;

  end;
end;

{ TThread_WS_PA }

constructor TThread_WS_PA.Create(centro: STRING; memo_log: tmemo);
VAR

  ficheiro: string;
begin
  inherited Create(false);

  freeonterminate := true;
  fmemo_log := memo_log;

  fcentro := centro;

  ficheiro := ExtractFilePath(ParamStr(0)) + 'CONF_WS.INI';

  server := DevolveInformacaoFicheiroini(ficheiro, 'SISTEMA', 'SERVIDOR');
  bdados := DevolveInformacaoFicheiroini(ficheiro, 'SISTEMA', 'BD');
  login := DevolveInformacaoFicheiroini(ficheiro, 'SISTEMA', 'LOGIN');
  pass := DevolveInformacaoFicheiroini(ficheiro, 'SISTEMA', 'PASS');

end;

destructor TThread_WS_PA.Destroy;
begin

  inherited;
end;

procedure TThread_WS_PA.Execute;
var
  data_importacao: TDate;
begin
  inherited;
  TRY
    Coinitialize(nil);

    BD := TUNICONNECTION.Create(nil);
    try
      BD.SpecificOptions.Add('SQL Server.Authentication=auServer');
      BD.ProviderName := 'SQL Server';
      BD.LoginPrompt := false;
      BD.server := server;
      BD.Database := bdados;
      BD.Username := login;
      BD.Password := pass;
      BD.OPEN;
      ImportaProdutoAcabado(BD, fmemo_log, fcentro);
    finally
      BD.free;
      CoUninitialize;
    end;
  EXCEPT
    ON E: EXCEPTION DO
    BEGIN
      GereLogs_local.FazLog(c_ficheiro_ERROR_base,
        'TThread_WS_PA ' + E.MESSAGE);
    END;
  END;
end;

procedure TThread_WS_PA.FazLog(msg: String; erro: boolean);
begin

end;

procedure TThread_WS_PA.ImportaProdutoAcabado(bd_recebida: TUNICONNECTION;
  memo: tmemo; centro: String);
var
  ws: z_ws_ac_mat;
  res2: TABLE_OF_ZACCEPTMATERIAL;
  a: integer;
  ts: tdatetime;
  msg: string;
begin
  try
    // iws := GetWS_SAP(false);
    ws := z_ws_ac_mat1.Getz_ws_ac_mat(false);

    ws.z_ws_ac_mat(res2);
    ts := NOW;
    FazLogImportacao(bd_recebida, 'Getz_ws_ac_mat', host_name,
      c_accao_log_inicio, fmemo_log);

    for a := 0 to Length(res2) - 1 do
    begin
      if memo <> nil then
        memo.Lines.Add(res2[a].MATNR + ' ' + res2[a].MAKTX);
      msg := GravaMat_Sap(bd_recebida, res2[a], fmemo_log);
      if trim(msg) <> '' then
        if memo <> nil then
          memo.Lines.Add(msg);

    end;
    FazLogImportacao(bd_recebida, 'Getz_ws_ac_mat', host_name, c_accao_log_fim,
      fmemo_log);
  except
    on E: EXCEPTION do
    begin
      FazLogImportacao(bd_recebida, 'Getz_ws_ac_mat', host_name,
        c_accao_log_erro, fmemo_log, '', E.MESSAGE)

    end;

  end
end;

{ TThread_Geral }

constructor TThread_Geral.Create(centro: STRING; memo_log: tmemo;
  MINUTOS_SINCRONIZACAO: integer);
begin
  INHERITED Create(false);
  freeonterminate := true;
  fcentro := centro;
  fMINUTOS_SINCRONIZACAO_BASE := MINUTOS_SINCRONIZACAO;
  fmemo_log := memo_log;
end;

destructor TThread_Geral.Destroy;
begin

  inherited;
end;

procedure TThread_Geral.Execute;
VAR
  ficheiro: sTRING;
  S: STRING;
  ACTIVO_OP: boolean;
  ACTIVO_MAT: boolean;
begin

  inherited;
  TRY

    ficheiro := ExtractFilePath(ParamStr(0)) + 'CONF_WS.INI';
    S := DevolveInformacaoFicheiroini(ficheiro, 'WEB_SERVICE_PAL',
      'MINUTOS_SINCRONIZACAO');
    if trim(S) <> '' then
    BEGIN
      MINUTOS_SINCRONIZACAO_OP := STRTOINT(S);
    END
    ELSE
    BEGIN
      MINUTOS_SINCRONIZACAO_OP := fMINUTOS_SINCRONIZACAO_BASE;
    END;
    S := DevolveInformacaoFicheiroini(ficheiro, 'WEB_SERVICE_MAT',
      'MINUTOS_SINCRONIZACAO');
    if trim(S) <> '' then
    BEGIN
      MINUTOS_SINCRONIZACAO_MAT := STRTOINT(S);
    END
    ELSE
    BEGIN
      MINUTOS_SINCRONIZACAO_MAT := fMINUTOS_SINCRONIZACAO_BASE;
    END;

    ACTIVO_OP := DevolveInformacaoFicheiroini(ficheiro, 'WEB_SERVICE_PAL',
      'ACTIVO') = '1';
    ACTIVO_MAT := DevolveInformacaoFicheiroini(ficheiro, 'WEB_SERVICE_MAT',
      'ACTIVO') = '1';

    GereLogs_local.FazLog(c_ficheiro_log_base, 'Sincronização base');
    GereLogs_local.FazLog(c_ficheiro_log_base,
      'Minutos OP - ' + IntToStr(MINUTOS_SINCRONIZACAO_OP));
    GereLogs_local.FazLog(c_ficheiro_log_base,
      'Minutos MAT - ' + IntToStr(MINUTOS_SINCRONIZACAO_MAT));
    if ACTIVO_OP then
      GereLogs_local.FazLog(c_ficheiro_log_base, 'Sincronização OP ativa')
    else
      GereLogs_local.FazLog(c_ficheiro_log_base, 'Sincronização OP inativa');
    if ACTIVO_MAT then
      GereLogs_local.FazLog(c_ficheiro_log_base, 'Sincronização MAT ativa2')
    else
      GereLogs_local.FazLog(c_ficheiro_log_base, 'Sincronização MAT inativa');

    while NOT Terminated do
    BEGIN
      // OP
      if ACTIVO_OP then
      BEGIN
        if VerificaSeEnvia(NOW, MINUTOS_SINCRONIZACAO_OP, ULTIMO_SINCRONISMO_OP)
        then
        begin
          GereLogs_local.FazLog(c_ficheiro_log_base, 'Vou sincronizar OP');
          TThread_WS_ORDENS.Create(fcentro, NOW, fmemo_log);
          ULTIMO_SINCRONISMO_OP := NOW;
        end;
      END;
      // MAT
      if ACTIVO_MAT then
      BEGIN
        if VerificaSeEnvia(NOW, MINUTOS_SINCRONIZACAO_MAT,
          ULTIMO_SINCRONISMO_MAT) then
        begin
          TThread_WS_PA.Create(fcentro, fmemo_log);
          ULTIMO_SINCRONISMO_MAT := NOW;
        end;
      END;
      SLEEP(1000);
    END;

  EXCEPT
    on E: EXCEPTION do
    begin
      GereLogs_local.FazLog(c_ficheiro_ERROR_base, 'TThread_Geral.execute - ' +
        E.MESSAGE);
    end;

  END;
end;

function TThread_Geral.VerificaSeEnvia(I_data: tdatetime; I_MINUTOS: integer;
  I_ULTIMO_SINCRONISMO: tdatetime): boolean;
var
  res: boolean;
begin
  res := false;
  if I_ULTIMO_SINCRONISMO <= 0 then
    res := true
  else
  begin
    if MinutesBetween(I_ULTIMO_SINCRONISMO, I_data) >= I_MINUTOS then
    begin
      res := true;
    end;

  end;
  result := res;
end;

end.
