object srv_delta: Tsrv_delta
  OldCreateOrder = False
  OnDestroy = ServiceDestroy
  DisplayName = 'Delta Accept SAP'
  OnExecute = ServiceExecute
  OnShutdown = ServiceShutdown
  OnStart = ServiceStart
  OnStop = ServiceStop
  Height = 150
  Width = 215
end
