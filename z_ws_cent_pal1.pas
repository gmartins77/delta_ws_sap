// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : z_ws_cent_pal.WSDL
// >Import : z_ws_cent_pal.WSDL>0
// Encoding : utf-8
// Codegen  : [wfForceSOAP12+]
// Version  : 1.0
// (05/12/2016 22:08:07 - - $Rev: 52705 $)
// ************************************************************************ //

unit z_ws_cent_pal1;

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
  // !:decimal         - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:time            - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]

  BAPIRETURN = class; { "urn:sap-com:document:sap:rfc:functions"[GblCplx] }
  ZDOLMAORDEMPROD = class; { "urn:sap-com:document:sap:rfc:functions"[GblCplx] }

  TABLE_OF_ZDOLMAORDEMPROD = array of ZDOLMAORDEMPROD;
  { "urn:sap-com:document:sap:rfc:functions"[GblCplx] }
  char50 = type string; { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }
  char220 = type string; { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }
  char5 = type string; { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }
  numeric6 = type string; { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }
  char20 = type string; { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }

  time = class(TXSTime)
  end; { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }

  char18 = type string; { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }
  date10 = type string; { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }
  char12 = type string; { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }
  lang = type string; { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }
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

  quantum13_3 = class(TXSDecimal)
  end; { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }

  char10 = type string; { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }
  char8 = type string; { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }

  // ************************************************************************ //
  // XML       : ZDOLMAORDEMPROD, global, <complexType>
  // Namespace : urn:sap-com:document:sap:rfc:functions
  // ************************************************************************ //
  ZDOLMAORDEMPROD = class(TRemotable)
  private
    FAUFNR: char12;
    FAEDAT: date10;
    FAEZEIT: time;
    FPLNBEZ: char18;
    FEAN11: char18;
    FSPRAS: lang;
    FCHARG: char10;
    FARBPL: char8;
    FGAMNG: quantum13_3;
  public
    destructor Destroy; override;
  published
    property AUFNR: char12 Index(IS_UNQL)read FAUFNR write FAUFNR;
    property AEDAT: date10 Index(IS_UNQL)read FAEDAT write FAEDAT;
    property AEZEIT: time Index(IS_UNQL)read FAEZEIT write FAEZEIT;
    property PLNBEZ: char18 Index(IS_UNQL)read FPLNBEZ write FPLNBEZ;
    property EAN11: char18 Index(IS_UNQL)read FEAN11 write FEAN11;
    property SPRAS: lang Index(IS_UNQL)read FSPRAS write FSPRAS;
    property CHARG: char10 Index(IS_UNQL)read FCHARG write FCHARG;
    property ARBPL: char8 Index(IS_UNQL)read FARBPL write FARBPL;
    property GAMNG: quantum13_3 Index(IS_UNQL)read FGAMNG write FGAMNG;
  end;

  // ************************************************************************ //
  // Namespace : urn:sap-com:document:sap:rfc:functions
  // soapAction: urn:sap-com:document:sap:rfc:functions:Z_WS_CENT_PAL:Z_WS_CENT_PALRequest
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // use       : literal
  // binding   : Z_WS_CENT_PAL_BIND_soap12
  // service   : Z_WS_CENT_PAL_SERV
  // port      : Z_WS_CENT_PAL_BIND_soap12
  // URL       : http://SRVNEWSAP-2.delta.local:8001/sap/bc/srt/rfc/sap/z_ws_cent_pal/002/z_ws_cent_pal_serv/z_ws_cent_pal_bind
  // ************************************************************************ //
  Z_WS_CENT_PAL = interface(IInvokable)
    ['{95C70656-EB87-AEAA-C648-0C6C2A7B9728}']
    function Z_WS_CENT_PAL(const I_AEDAT: date10; const I_AUFNR: char12;
      const I_ERDAT: date10; var ZITEMPROD: TABLE_OF_ZDOLMAORDEMPROD)
      : BAPIRETURN; stdcall;
  end;

function GetZ_WS_CENT_PAL(UseWSDL: Boolean = System.False; Addr: string = '';
  HTTPRIO: THTTPRIO = nil): Z_WS_CENT_PAL;

implementation

uses SysUtils;

function GetZ_WS_CENT_PAL(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO)
  : Z_WS_CENT_PAL;
// const
// defWSDL = 'z_ws_cent_pal.WSDL';
// defURL = 'http://SRVNEWSAP-2.delta.local:8001/sap/bc/srt/rfc/sap/z_ws_cent_pal/002/z_ws_cent_pal_serv/z_ws_cent_pal_bind';
// defSvc = 'Z_WS_CENT_PAL_SERV';
// defPrt = 'Z_WS_CENT_PAL_BIND_soap12';
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
  defWSDL := DevolveInformacaoFicheiroini(FICHEIRO, 'WEB_SERVICE_PAL', 'WSDL');
  defURL := DevolveInformacaoFicheiroini(FICHEIRO, 'WEB_SERVICE_PAL', 'URL');
  if TRIM(defURL) = '' then
    defURL := 'http://SRVNEWSAP-2.delta.local:8001/sap/bc/srt/rfc/sap/z_ws_cent_pal/002/z_ws_cent_pal_serv/z_ws_cent_pal_bind';
  defSvc := DevolveInformacaoFicheiroini(FICHEIRO, 'WEB_SERVICE_PAL',
    'SERVICE');
  if TRIM(defSvc) = '' then
    defSvc := 'Z_WS_CENT_PAL_SERV';
  defPrt := DevolveInformacaoFicheiroini(FICHEIRO, 'WEB_SERVICE_PAL', 'PORT');
  if TRIM(defPrt) = '' then
    defPrt := 'Z_WS_CENT_PAL_BIND_soap12';
  USERNAME := DevolveInformacaoFicheiroini(FICHEIRO, 'WEB_SERVICE_PAL',
    'USERNAME');
  PASSWORD := DevolveInformacaoFicheiroini(FICHEIRO, 'WEB_SERVICE_PAL',
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
    Result := (RIO as Z_WS_CENT_PAL);
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

destructor ZDOLMAORDEMPROD.Destroy;
begin
  SysUtils.FreeAndNil(FAEZEIT);
  SysUtils.FreeAndNil(FGAMNG);
  inherited Destroy;
end;

initialization

{ Z_WS_CENT_PAL }
InvRegistry.RegisterInterface(TypeInfo(Z_WS_CENT_PAL),
  'urn:sap-com:document:sap:rfc:functions', 'utf-8');
InvRegistry.RegisterDefaultSOAPAction(TypeInfo(Z_WS_CENT_PAL),
  'urn:sap-com:document:sap:rfc:functions:Z_WS_CENT_PAL:Z_WS_CENT_PALRequest');
InvRegistry.RegisterInvokeOptions(TypeInfo(Z_WS_CENT_PAL), ioDocument);
InvRegistry.RegisterInvokeOptions(TypeInfo(Z_WS_CENT_PAL), ioSOAP12);
{ Z_WS_CENT_PAL.Z_WS_CENT_PAL }
InvRegistry.RegisterMethodInfo(TypeInfo(Z_WS_CENT_PAL), 'Z_WS_CENT_PAL', '',
  '[ReturnName="RETURN"]', IS_UNQL);
InvRegistry.RegisterParamInfo(TypeInfo(Z_WS_CENT_PAL), 'Z_WS_CENT_PAL',
  'I_AEDAT', '', '', IS_UNQL);
InvRegistry.RegisterParamInfo(TypeInfo(Z_WS_CENT_PAL), 'Z_WS_CENT_PAL',
  'I_AUFNR', '', '', IS_UNQL);
InvRegistry.RegisterParamInfo(TypeInfo(Z_WS_CENT_PAL), 'Z_WS_CENT_PAL',
  'I_ERDAT', '', '', IS_UNQL);
InvRegistry.RegisterParamInfo(TypeInfo(Z_WS_CENT_PAL), 'Z_WS_CENT_PAL',
  'ZITEMPROD', '', '[ArrayItemName="item"]', IS_UNQL);
InvRegistry.RegisterParamInfo(TypeInfo(Z_WS_CENT_PAL), 'Z_WS_CENT_PAL',
  'RETURN', '', '', IS_UNQL);
RemClassRegistry.RegisterXSInfo(TypeInfo(TABLE_OF_ZDOLMAORDEMPROD),
  'urn:sap-com:document:sap:rfc:functions', 'TABLE_OF_ZDOLMAORDEMPROD');
RemClassRegistry.RegisterXSInfo(TypeInfo(char50),
  'urn:sap-com:document:sap:rfc:functions', 'char50');
RemClassRegistry.RegisterXSInfo(TypeInfo(char220),
  'urn:sap-com:document:sap:rfc:functions', 'char220');
RemClassRegistry.RegisterXSInfo(TypeInfo(char5),
  'urn:sap-com:document:sap:rfc:functions', 'char5');
RemClassRegistry.RegisterXSInfo(TypeInfo(numeric6),
  'urn:sap-com:document:sap:rfc:functions', 'numeric6');
RemClassRegistry.RegisterXSInfo(TypeInfo(char20),
  'urn:sap-com:document:sap:rfc:functions', 'char20');
RemClassRegistry.RegisterXSInfo(TypeInfo(time),
  'urn:sap-com:document:sap:rfc:functions', 'time');
RemClassRegistry.RegisterXSInfo(TypeInfo(char18),
  'urn:sap-com:document:sap:rfc:functions', 'char18');
RemClassRegistry.RegisterXSInfo(TypeInfo(date10),
  'urn:sap-com:document:sap:rfc:functions', 'date10');
RemClassRegistry.RegisterXSInfo(TypeInfo(char12),
  'urn:sap-com:document:sap:rfc:functions', 'char12');
RemClassRegistry.RegisterXSInfo(TypeInfo(lang),
  'urn:sap-com:document:sap:rfc:functions', 'lang');
RemClassRegistry.RegisterXSInfo(TypeInfo(char1),
  'urn:sap-com:document:sap:rfc:functions', 'char1');
RemClassRegistry.RegisterXSClass(BAPIRETURN,
  'urn:sap-com:document:sap:rfc:functions', 'BAPIRETURN');
RemClassRegistry.RegisterExternalPropName(TypeInfo(BAPIRETURN), 'TYPE_',
  '[ExtName="TYPE"]');
RemClassRegistry.RegisterExternalPropName(TypeInfo(BAPIRETURN), 'MESSAGE_',
  '[ExtName="MESSAGE"]');
RemClassRegistry.RegisterXSInfo(TypeInfo(quantum13_3),
  'urn:sap-com:document:sap:rfc:functions', 'quantum13_3', 'quantum13.3');
RemClassRegistry.RegisterXSInfo(TypeInfo(char10),
  'urn:sap-com:document:sap:rfc:functions', 'char10');
RemClassRegistry.RegisterXSInfo(TypeInfo(char8),
  'urn:sap-com:document:sap:rfc:functions', 'char8');
RemClassRegistry.RegisterXSClass(ZDOLMAORDEMPROD,
  'urn:sap-com:document:sap:rfc:functions', 'ZDOLMAORDEMPROD');

end.
