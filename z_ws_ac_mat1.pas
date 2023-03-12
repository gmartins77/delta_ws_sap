// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : C:\Users\gmart\Dropbox (SINMETRO)\Projectos_ACCEPT\Delta\WS\z_ws_ac_mat.WSDL
// >Import : C:\Users\gmart\Dropbox (SINMETRO)\Projectos_ACCEPT\Delta\WS\z_ws_ac_mat.WSDL>0
// Encoding : utf-8
// Codegen  : [wfForceSOAP12+]
// Version  : 1.0
// (11-01-2017 16:48:36 - - $Rev: 52705 $)
// ************************************************************************ //

unit z_ws_ac_mat1;

interface

uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns, UAux_Integracao;

const
  IS_OPTN = $0001;
  IS_UNBD = $0002;
  IS_UNQL = $0008;
  IS_REF = $0080;

type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Embarcadero types; however, they could also
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]

  ZACCEPTMATERIAL = class; { "urn:sap-com:document:sap:rfc:functions"[GblCplx] }
  BAPIRETURN = class; { "urn:sap-com:document:sap:rfc:functions"[GblCplx] }

  char50 = type string; { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }
  char20 = type string; { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }
  numeric6 = type string; { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }
  TABLE_OF_ZACCEPTMATERIAL = array of ZACCEPTMATERIAL;
  { "urn:sap-com:document:sap:rfc:functions"[GblCplx] }
  char40 = type string; { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }
  char18 = type string; { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }

  // ************************************************************************ //
  // XML       : ZACCEPTMATERIAL, global, <complexType>
  // Namespace : urn:sap-com:document:sap:rfc:functions
  // ************************************************************************ //
  ZACCEPTMATERIAL = class(TRemotable)
  private
    FMATNR: char18;
    FMAKTX: char40;
  published
    property MATNR: char18 Index(IS_UNQL)read FMATNR write FMATNR;
    property MAKTX: char40 Index(IS_UNQL)read FMAKTX write FMAKTX;
  end;

  char220 = type string; { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }
  char5 = type string; { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }
  char1 = type string; { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }

  // ************************************************************************ //
  // XML       : BAPIRETURN, global, <complexType>
  // Namespace : urn:sap-com:document:sap:rfc:functions
  // ************************************************************************ //
  BAPIRETURN = class(TRemotable)
  private
    FTYPE_: char1;
    FCODE: char5;
    FMESSAGE_: char220;
    FLOG_NO: char20;
    FLOG_MSG_NO: numeric6;
    FMESSAGE_V1: char50;
    FMESSAGE_V2: char50;
    FMESSAGE_V3: char50;
    FMESSAGE_V4: char50;
  published
    property TYPE_: char1 Index(IS_UNQL)read FTYPE_ write FTYPE_;
    property CODE: char5 Index(IS_UNQL)read FCODE write FCODE;
    property MESSAGE_: char220 Index(IS_UNQL)read FMESSAGE_ write FMESSAGE_;
    property LOG_NO: char20 Index(IS_UNQL)read FLOG_NO write FLOG_NO;
    property LOG_MSG_NO: numeric6 Index(IS_UNQL)read FLOG_MSG_NO
      write FLOG_MSG_NO;
    property MESSAGE_V1: char50 Index(IS_UNQL)read FMESSAGE_V1
      write FMESSAGE_V1;
    property MESSAGE_V2: char50 Index(IS_UNQL)read FMESSAGE_V2
      write FMESSAGE_V2;
    property MESSAGE_V3: char50 Index(IS_UNQL)read FMESSAGE_V3
      write FMESSAGE_V3;
    property MESSAGE_V4: char50 Index(IS_UNQL)read FMESSAGE_V4
      write FMESSAGE_V4;
  end;

  // ************************************************************************ //
  // Namespace : urn:sap-com:document:sap:rfc:functions
  // soapAction: urn:sap-com:document:sap:rfc:functions:z_ws_ac_mat:Z_WS_AC_MATRequest
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // use       : literal
  // binding   : z_ws_ac_mat_bind_soap12
  // service   : z_ws_ac_mat_serv
  // port      : z_ws_ac_mat_bind_soap12
  // URL       : http://SRVNEWSAP-2.delta.local:8001/sap/bc/srt/rfc/sap/z_ws_ac_mat/002/z_ws_ac_mat_serv/z_ws_ac_mat_bind
  // ************************************************************************ //
  z_ws_ac_mat = interface(IInvokable)
    ['{CF1C7B19-5734-1581-D7B7-84D6B9B481D3}']
    function z_ws_ac_mat(var ZITEMMATE: TABLE_OF_ZACCEPTMATERIAL)
      : BAPIRETURN; stdcall;
  end;

function Getz_ws_ac_mat(UseWSDL: Boolean = System.False; Addr: string = '';
  HTTPRIO: THTTPRIO = nil): z_ws_ac_mat;

implementation

uses SysUtils;

function Getz_ws_ac_mat(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO)
  : z_ws_ac_mat;
// const
// defWSDL = 'C:\Users\gmart\Dropbox (SINMETRO)\Projectos_ACCEPT\Delta\WS\z_ws_ac_mat.WSDL';
// defURL = 'http://SRVNEWSAP-2.delta.local:8001/sap/bc/srt/rfc/sap/z_ws_ac_mat/002/z_ws_ac_mat_serv/z_ws_ac_mat_bind';
// defSvc = 'z_ws_ac_mat_serv';
// defPrt = 'z_ws_ac_mat_bind_soap12';
var
  defWSDL: string;
  defURL: string;
  defSvc: string;
  defPrt: string;
  RIO: THTTPRIO;
  FICHEIRO: sTRING;
  USERNAME, PASSWORD: STRING;
begin
  Result := nil;

  FICHEIRO := ExtractFilePath(ParamStr(0)) + 'CONF_WS.INI';
  defWSDL := DevolveInformacaoFicheiroini(FICHEIRO, 'WEB_SERVICE_MAT', 'WSDL');

  if TRIM(defWSDL) = '' then
    defWSDL :=
      'C:\Users\gmart\Dropbox (SINMETRO)\Projectos_ACCEPT\Delta\WS\z_ws_ac_mat.WSDL';
  // defWSDL = 'C:\Users\gmart\Dropbox (SINMETRO)\Projectos_ACCEPT\Delta\WS\z_ws_ac_mat.WSDL';
  defURL := DevolveInformacaoFicheiroini(FICHEIRO, 'WEB_SERVICE_MAT', 'URL');
  if TRIM(defURL) = '' then
    defURL := 'http://SRVNEWSAP-2.delta.local:8001/sap/bc/srt/rfc/sap/z_ws_ac_mat/002/z_ws_ac_mat_serv/z_ws_ac_mat_bind';
  defSvc := DevolveInformacaoFicheiroini(FICHEIRO, 'WEB_SERVICE_MAT',
    'SERVICE');
  if TRIM(defSvc) = '' then
    defSvc := 'z_ws_ac_mat_serv';
  defPrt := DevolveInformacaoFicheiroini(FICHEIRO, 'WEB_SERVICE_MAT', 'PORT');
  if TRIM(defPrt) = '' then
    defPrt := 'z_ws_ac_mat_bind_soap12';
  USERNAME := DevolveInformacaoFicheiroini(FICHEIRO, 'WEB_SERVICE_MAT',
    'USERNAME');
  PASSWORD := DevolveInformacaoFicheiroini(FICHEIRO, 'WEB_SERVICE_MAT',
    'PASSWORD');

  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as z_ws_ac_mat);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end
    else
      RIO.URL := Addr;
    RIO.HTTPWebNode.USERNAME := USERNAME; // 'ACCEPT';
    RIO.HTTPWebNode.PASSWORD := PASSWORD; // 'delacc';

  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;

initialization

{ z_ws_ac_mat }
InvRegistry.RegisterInterface(TypeInfo(z_ws_ac_mat),
  'urn:sap-com:document:sap:rfc:functions', 'utf-8');
InvRegistry.RegisterDefaultSOAPAction(TypeInfo(z_ws_ac_mat),
  'urn:sap-com:document:sap:rfc:functions:z_ws_ac_mat:Z_WS_AC_MATRequest');
InvRegistry.RegisterInvokeOptions(TypeInfo(z_ws_ac_mat), ioDocument);
InvRegistry.RegisterInvokeOptions(TypeInfo(z_ws_ac_mat), ioSOAP12);
{ z_ws_ac_mat.Z_WS_AC_MAT }
InvRegistry.RegisterMethodInfo(TypeInfo(z_ws_ac_mat), 'Z_WS_AC_MAT', '',
  '[ReturnName="RETURN"]', IS_UNQL);
InvRegistry.RegisterParamInfo(TypeInfo(z_ws_ac_mat), 'Z_WS_AC_MAT', 'ZITEMMATE',
  '', '[ArrayItemName="item"]', IS_UNQL);
InvRegistry.RegisterParamInfo(TypeInfo(z_ws_ac_mat), 'Z_WS_AC_MAT', 'RETURN',
  '', '', IS_UNQL);
RemClassRegistry.RegisterXSInfo(TypeInfo(char50),
  'urn:sap-com:document:sap:rfc:functions', 'char50');
RemClassRegistry.RegisterXSInfo(TypeInfo(char20),
  'urn:sap-com:document:sap:rfc:functions', 'char20');
RemClassRegistry.RegisterXSInfo(TypeInfo(numeric6),
  'urn:sap-com:document:sap:rfc:functions', 'numeric6');
RemClassRegistry.RegisterXSInfo(TypeInfo(TABLE_OF_ZACCEPTMATERIAL),
  'urn:sap-com:document:sap:rfc:functions', 'TABLE_OF_ZACCEPTMATERIAL');
RemClassRegistry.RegisterXSInfo(TypeInfo(char40),
  'urn:sap-com:document:sap:rfc:functions', 'char40');
RemClassRegistry.RegisterXSInfo(TypeInfo(char18),
  'urn:sap-com:document:sap:rfc:functions', 'char18');
RemClassRegistry.RegisterXSClass(ZACCEPTMATERIAL,
  'urn:sap-com:document:sap:rfc:functions', 'ZACCEPTMATERIAL');
RemClassRegistry.RegisterXSInfo(TypeInfo(char220),
  'urn:sap-com:document:sap:rfc:functions', 'char220');
RemClassRegistry.RegisterXSInfo(TypeInfo(char5),
  'urn:sap-com:document:sap:rfc:functions', 'char5');
RemClassRegistry.RegisterXSInfo(TypeInfo(char1),
  'urn:sap-com:document:sap:rfc:functions', 'char1');
RemClassRegistry.RegisterXSClass(BAPIRETURN,
  'urn:sap-com:document:sap:rfc:functions', 'BAPIRETURN');
RemClassRegistry.RegisterExternalPropName(TypeInfo(BAPIRETURN), 'TYPE_',
  '[ExtName="TYPE"]');
RemClassRegistry.RegisterExternalPropName(TypeInfo(BAPIRETURN), 'MESSAGE_',
  '[ExtName="MESSAGE"]');

end.
