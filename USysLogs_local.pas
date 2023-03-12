unit USysLogs_local;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes,
  SHFolder,
  vcl.StdCtrls, Types, SyncObjs;

type
  // threads utilizam sistema de gestao por semaforos

  TGereLogs = class
  public
    directoria_base: String;
    cs_base: tcriticalsection;
    MEMO_base: tmemo;
    procedure FazLog(ficheiro: string; msg: string);
  end;

  TThread_Logfile = class(TThread)
  private
    fpasta_base: string;
    Fficheiro: string;
    Fmsg: string;
    FLock: tcriticalsection;
    fMEMO: tmemo;

    procedure EscreveLog;
    function LocalAppDataPath: string;
    function LocalAppDataPathACCEPT: string;
  protected
  public
    constructor Create(ficheiro: string; msg: string; pasta_base: String = '';
      cs: tcriticalsection = nil; MEMO_LOG: tmemo = NIL);
    destructor Destroy; override;
    procedure Execute; override;
  end;

  // thread para fazer log em ficheiro

  // thread para fazer log em BD
  // formato BD
  // datahora
  // tipo
  // descricao

  // exemplo de execucao
  // com cs_log_Especifico e log visual em memo
  // TThread_Logfile.Create('.\log.txt', msg,
  // cs_log_especifica, fmemo);
  // simples
  // TThread_Logfile.Create('.\log.txt', msg);

const
  c_ficheiro_log_base = 'service.log';

const
  c_ficheiro_ERROR_base = 'service_Error.log';

var
  GereLogs_local: TGereLogs;

var
  cs_thread_log_local: tcriticalsection;

var
  desliga_logs_Sistema: boolean;

implementation

{ TThread_Logfile }

constructor TThread_Logfile.Create(ficheiro, msg: string;
  pasta_base: String = ''; cs: tcriticalsection = nil; MEMO_LOG: tmemo = NIL);
begin

  fpasta_base := pasta_base;
  Fficheiro := ficheiro;
  if cs = nil then
    FLock := cs_thread_log_local
  else
    FLock := cs;
  Fmsg := msg;
  FreeOnTerminate := true;
  fMEMO := MEMO_LOG;
  inherited Create(False);
end;

destructor TThread_Logfile.Destroy;
begin

  inherited;
end;

procedure TThread_Logfile.EscreveLog;
var
  F: TextFile;
  S: STRING;
begin
  S := DATETIMETOSTR(NOW) + ' ' + Fmsg;

  // verifica se cria pasta

  if trim(fpasta_base) = '.\' then
    fpasta_base := ExtractFilePath(ParamStr(0))
  ELSE if trim(fpasta_base) = '' then
    fpasta_base := ExtractFilePath(ParamStr(0)) + 'logs\'
  else if trim(fpasta_base) = 'APPDATA' then
    fpasta_base := LocalAppDataPathACCEPT;

  if Copy(fpasta_base, length(fpasta_base) - 1, 1) <> '\' then
    fpasta_base := fpasta_base + '\';

  Fficheiro := fpasta_base + Fficheiro;
  try
    if not DirectoryExists(ExtractFilePath(Fficheiro)) then
      CreateDir(ExtractFilePath(Fficheiro));
  except

  end;

  TRY
    if desliga_logs_Sistema = False then

      IF fMEMO <> NIL THEN
        fMEMO.LINES.ADD(S);

    // Getting the filename for the logfile (In this case the Filename is 'application-exename.log'
    // Assigns Filename to variable F
    AssignFile(F, Fficheiro);
    // Rewrites the file F
    if FileExists(Fficheiro) = False then
      Rewrite(F);
    // Open file for appending
    Append(F);
    // Write text to Textfile F
    WriteLn(F, S);
    // finally close the file
    CloseFile(F);
  EXCEPT
  END;
end;

procedure TThread_Logfile.Execute;
begin
  FLock.Acquire;
  try
    // try
    EscreveLog;
  finally
    FLock.Release;
  end;

  // except
  // FLock.Release;
  // end;
end;

function TThread_Logfile.LocalAppDataPath: string;
const
  SHGFP_TYPE_CURRENT = 0;
var
  path: array [0 .. MaxChar] of char;
begin
  SHGetFolderPath(0, CSIDL_APPDATA, 0, SHGFP_TYPE_CURRENT, @path[0]);
  Result := StrPas(path);
end;

function TThread_Logfile.LocalAppDataPathACCEPT: string;
var
  dir: string;
  dir_accept: string;
begin
  // verifica se a subpasta accept existe
  dir := LocalAppDataPath;
  dir_accept := dir + '\logs_accept';
  try
    if DirectoryExists(dir_accept) = False then
      // senao existir, cria-a
      CreateDir(dir_accept);
  except
    dir_accept := '';
  end;
  Result := dir_accept;
end;

{ TGereLogs }

procedure TGereLogs.FazLog(ficheiro, msg: string);
begin
  TThread_Logfile.Create(ficheiro, msg, directoria_base, cs_base, MEMO_base);
end;

initialization

GereLogs_local := TGereLogs.Create;
cs_thread_log_local := tcriticalsection.Create;
desliga_logs_Sistema := False;

finalization

cs_thread_log_local.free;
GereLogs_local.free;

end.
