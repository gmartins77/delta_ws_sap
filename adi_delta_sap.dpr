program adi_delta_sap;

uses
  Vcl.SvcMgr,
  srv_delta_sap in 'srv_delta_sap.pas' {srv_delta: TService},
  UThreads_WS in 'UThreads_WS.pas',
  z_ws_ac_mat1 in 'z_ws_ac_mat1.pas',
  z_ws_ac_mat11 in 'z_ws_ac_mat11.pas',
  z_ws_cent_pal1 in 'z_ws_cent_pal1.pas',
  USysLogs_local in 'USysLogs_local.pas';

{$R *.RES}

begin
  // Windows 2003 Server requires StartServiceCtrlDispatcher to be
  // called before CoRegisterClassObject, which can be called indirectly
  // by Application.Initialize. TServiceApplication.DelayInitialize allows
  // Application.Initialize to be called from TService.Main (after
  // StartServiceCtrlDispatcher has been called).
  //
  // Delayed initialization of the Application object may affect
  // events which then occur prior to initialization, such as
  // TService.OnCreate. It is only recommended if the ServiceApplication
  // registers a class object with OLE and is intended for use with
  // Windows 2003 Server.
  //
  // Application.DelayInitialize := True;
  //
  if not Application.DelayInitialize or Application.Installing then
    Application.Initialize;
  Application.CreateForm(Tsrv_delta, srv_delta);
  Application.Run;
end.
