unit srv_delta_sap;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.SvcMgr, Vcl.Dialogs,
  USysLogs_local, UThreads_WS;

type
  Tsrv_delta = class(TService)
    procedure ServiceExecute(Sender: TService);
    procedure ServiceShutdown(Sender: TService);
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
    procedure ServiceDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  srv_delta: Tsrv_delta;

implementation

{$R *.DFM}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  srv_delta.Controller(CtrlCode);
end;

function Tsrv_delta.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure Tsrv_delta.ServiceDestroy(Sender: TObject);
begin
  GereLogs_local.free;
end;

procedure Tsrv_delta.ServiceExecute(Sender: TService);
var
  th: TThread_Geral;
begin
  GereLogs_local.FazLog(c_ficheiro_log_base, 'vou entrar execute');

  While NOT Terminated do
  Begin
    { Process Service Requests }
    ServiceThread.ProcessRequests(False);
    { Allow system some time }
    // doSaveLog('dormindo execute');
    Sleep(100);
  End;
end;

procedure Tsrv_delta.ServiceShutdown(Sender: TService);
begin
  GereLogs_local.FazLog(c_ficheiro_log_base, 'service shutdown');

end;

procedure Tsrv_delta.ServiceStart(Sender: TService; var Started: Boolean);
var
  th: TThread_Geral;
  centro: String;
  minutos_Sincronizacao: integer;
  s: string;
begin
  // obtem a lista de threads a enviar

  th := TThread_Geral.Create('1001', nil, 60);
end;

procedure Tsrv_delta.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  GereLogs_local.FazLog(c_ficheiro_log_base, 'service stop');

end;

end.
