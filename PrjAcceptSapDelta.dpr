program PrjAcceptSapDelta;

uses
  Vcl.Forms,
  UFrmImportWSDelta in 'UFrmImportWSDelta.pas' {FrmImportWSDelta},
  z_ws_cent_pal1 in 'z_ws_cent_pal1.pas',
  z_ws_ac_mat1 in 'z_ws_ac_mat1.pas',
  UBD_Aux in 'UBD_Aux.pas',
  UThreads_WS in 'UThreads_WS.pas',
  UAux_Integracao in 'UAux_Integracao.pas',
  USysLogs_local in 'USysLogs_local.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmImportWSDelta, FrmImportWSDelta);
  Application.Run;
end.
