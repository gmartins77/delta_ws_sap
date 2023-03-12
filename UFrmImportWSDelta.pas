unit UFrmImportWSDelta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  dateutils,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls,
  dxCore, cxDateUtils, dxSkinsCore, dxSkinDevExpressStyle, dxSkinSilver,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, UniProvider,
  SQLServerUniProvider, Data.DB, DBAccess, Uni, UBD_Aux, UThreads_WS;

type
  TFrmImportWSDelta = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    cxDateEdit1: TcxDateEdit;
    UniConnection1: TUniConnection;
    SQLServerUniProvider1: TSQLServerUniProvider;
    Button3: TButton;
    Button4: TButton;
    Label1: TLabel;
    Button5: TButton;
    Button6: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    { Private declarations }
    Fpermissoes_activas: string;
  published
    property Permissoes_activas: string read Fpermissoes_activas
      write Fpermissoes_activas;
  public
    { Public declarations }
  end;

var
  FrmImportWSDelta: TFrmImportWSDelta;

implementation

{$R *.dfm}
{$R 'resources.res' 'resources.rc'}

uses z_ws_ac_mat1, z_ws_cent_pal1;

procedure TFrmImportWSDelta.Button1Click(Sender: TObject);
var
  ws: z_ws_ac_mat;
  res2: TABLE_OF_ZACCEPTMATERIAL;
  a: integer;
  // erro: z_ws_ac_mat1.BAPIRETURN;
begin
  ws := z_ws_ac_mat1.Getz_ws_ac_mat(false);
  try
    Memo1.lines.Add('bora');
    ws.z_ws_ac_mat(res2);
    Memo1.lines.Clear;
    for a := 0 to Length(res2) - 1 do
    begin
      Memo1.lines.Add(res2[a].MATNR + ' ' + res2[a].MAKTX);
      GravaMat_Sap(UniConnection1, res2[a], Memo1);
    end;

  except
    on e: exception do
    begin
      Memo1.lines.Add(e.Message);
    end;

  end;
end;

procedure TFrmImportWSDelta.Button2Click(Sender: TObject);
var
  ws: Z_WS_CENT_PAL;
  res: TABLE_OF_ZDOLMAORDEMPROD;
  a: integer;
  ano, mes, dia: string;
  Data: TDate;
begin
  Data := cxDateEdit1.date;
  ano := IntToStr(YearOf(cxDateEdit1.date));
  mes := IntToStr(MonthOf(cxDateEdit1.date));
  dia := IntToStr(DayOfTheMonth(cxDateEdit1.date));

  if Length(mes) = 1 then
    mes := '0' + mes;
  if Length(dia) = 1 then
    dia := '0' + dia;

  ws := GetZ_WS_CENT_PAL(false);
  try
    ws.Z_WS_CENT_PAL(ano + '-' + mes + '-' + dia, '', '', res);
    Memo1.lines.Clear;
    for a := 0 to Length(res) - 1 do
    begin
      Memo1.lines.Add(res[a].AUFNR + ' ' + res[a].CHARG);
      GravaOP_Sap(UniConnection1, Data, res[a], Memo1);
    end;

  except
    on e: exception do
    begin
      Memo1.lines.Add(e.Message);
    end;

  end;
end;

procedure TFrmImportWSDelta.Button3Click(Sender: TObject);
var
  th: TThread_Geral;
begin
  th := TThread_Geral.Create('', Memo1, 1);

end;

procedure TFrmImportWSDelta.Button5Click(Sender: TObject);
begin
  TThread_WS_PA.Create('', Memo1);
end;

procedure TFrmImportWSDelta.Button6Click(Sender: TObject);
begin
  TThread_WS_ORDENS.Create('', cxDateEdit1.date, Memo1);

end;

procedure TFrmImportWSDelta.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := cafree;
  FrmImportWSDelta := nil;
end;

procedure TFrmImportWSDelta.FormCreate(Sender: TObject);
begin
  cxDateEdit1.date := NOW;
end;

end.
