unit UInterfaceGestaoPlugin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  uni,
  Rtti,
  Usysaccept,
  UInterfaces,
  UFrmwait,
  UPermissoesxml,
  System.TypInfo,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFerramenta_BO = class(TInterfacedObject, IAccept_Backoffice)
  private
    bd: tuniconnection;
  protected
  published
  public
    FrmPlugin: TFORM;

    function CriaPlugin(bd_recebida: tuniconnection; comandos_xml: string;
      utilizador: TInfoUtilizador; pai: TWinControl; imagem: tbitmap;
      out classe_registada: string; out msg_alerta: string): boolean;

    procedure InicializaPlugin(comandos_xml: string);
    procedure ActualizaUtilizador(utilizador_ligado: TInfoUtilizador);
    procedure FechaPlugin;
    function DevolveInfoPlugin(out descricao, hint, codigo, grupo,
      versao: string; out single_instance: boolean;
      out bmp16, bmp32: tbitmap): boolean;

  end;

  TPluginAcceptV2 = class(TInterfacedObject, IAccept_PluginV2)
  private
    bd: tuniconnection;
  protected
    frmbase: TFORM;

  published
  public
    permissoes_plugin_perfil: string;

    function CriaPlugin(bd_recebida: tuniconnection; codigo_janela: string;
      comandos_xml: string; utilizador: TInfoUtilizador;
      permissoes_plugin: String; pai: TWinControl; imagem: tbitmap;
      out classe_registada: string; out msg_alerta: string): boolean;
    procedure InicializaPlugin(classe: string; comandos_xml: string);
    procedure ActualizaUtilizador(classe: string;
      utilizador_ligado: TInfoUtilizador; permissoes_plugin: String);
    procedure FechaPlugin(classe: string);

    // grupo - tipo menu, nome do menu; navbar, nome da subclasse
    function DevolveInfoPlugin(codigo_janela: string;
      out tipo: eTipoJanelaPlugin; out descricao, hint, codigo, grupo,
      versao: string; out single_instance: boolean;
      out bmp16, bmp32: tbitmap): boolean;

    // lista separada por ;
    function DevolveListaJanelas: string;
    function DevolveTemplatePermissoes(codigo_janela: STRING): string;

  end;

function LANCA_PLUGIN(id: tguid): IAccept_Backoffice;
function LANCA_PLUGINV2(id: tguid): IAccept_PluginV2;

function DevolvePermissao(user: TInfoUtilizador; permissoes_plugin: string;
  permissao_a_validar: string; out valor_permissao: String): boolean;

implementation

USES UFrmJanela2, UFrmJanela1;

function LANCA_PLUGIN(id: tguid): IAccept_Backoffice;
begin
  result := TFerramenta_BO.create;
end;

function LANCA_PLUGINV2(id: tguid): IAccept_PluginV2;
begin
  result := TPluginAcceptV2.create;
end;

EXPORTS LANCA_PLUGIN;
EXPORTS LANCA_PLUGINV2;

{ TFerramenta_BO }

procedure TFerramenta_BO.ActualizaUtilizador(utilizador_ligado
  : TInfoUtilizador);
begin

end;

function TFerramenta_BO.CriaPlugin(bd_recebida: tuniconnection;
  comandos_xml: string; utilizador: TInfoUtilizador; pai: TWinControl;
  imagem: tbitmap; out classe_registada: string;
  out msg_alerta: string): boolean;
begin

  try
    Application.CreateForm(TFrmTemplateBO_Child, self.FrmPlugin);
    self.bd := bd_recebida;

    if pai <> nil then
    begin
      FrmPlugin.FormStyle := fsNormal;
      FrmPlugin.BorderStyle := bsnone;
      FrmPlugin.Parent := pai;
      FrmPlugin.BorderIcons := [];
    end
    else
    begin
      FrmPlugin.FormStyle := fsMDIChild;
    end;
    FrmPlugin.icon := Usysaccept.bmp2ico(imagem);
    TFrmTemplateBO_Child(FrmPlugin).utilizador_recebido := utilizador;
    TFrmTemplateBO_Child(FrmPlugin).activajanela(self.bd);
    FrmPlugin.Show;

  except
    on e: exception do
      msg_alerta := e.message;
  end;

  classe_registada := self.FrmPlugin.ClassName;
  result := true;
end;

function TFerramenta_BO.DevolveInfoPlugin(out descricao, hint, codigo, grupo,
  versao: string; out single_instance: boolean;
  out bmp16, bmp32: tbitmap): boolean;
begin
  descricao := 'Template';
  codigo := 'CODIGO_TEMPLATE';
  hint := 'Plugin Template';
  grupo := 'Template';
  versao := 'V0';
  if bmp16 = nil then
    bmp16 := tbitmap.create;
  if bmp32 = nil then
    bmp32 := tbitmap.create;
  single_instance := true;
  bmp16.LoadFromResourceName(HInstance, 'ICON_16');
  bmp32.LoadFromResourceName(HInstance, 'ICON_32');
  // bmp := NIL;
end;

procedure TFerramenta_BO.FechaPlugin;
begin

end;

procedure TFerramenta_BO.InicializaPlugin(comandos_xml: string);
begin

end;

{ TPluginAcceptV2 }

procedure TPluginAcceptV2.ActualizaUtilizador(classe: string;
  utilizador_ligado: TInfoUtilizador; permissoes_plugin: String);
var
  PERMISSAO: string;
  P: TRttiProperty;
begin
  self.permissoes_plugin_perfil := permissoes_plugin;

  // se não tem permissão de acesso, fecha janela

  if frmbase = nil then
  BEGIN
    EXIT;
  END;
  P := TRttiContext.create.GetType(frmbase.ClassInfo)
    .GetProperty('Permissoes_activas');
  P.SetValue(frmbase, permissoes_plugin);
  if DevolvePermissao(utilizador_ligado, permissoes_plugin_perfil,
    'C_PER_ACESSO', PERMISSAO) = false then
  begin
    if self.frmbase <> nil then
    begin
      self.frmbase.close;
      self.frmbase := nil;
    end;
  end;

end;

function TPluginAcceptV2.CriaPlugin(bd_recebida: tuniconnection;
  codigo_janela: string; comandos_xml: string; utilizador: TInfoUtilizador;
  permissoes_plugin: String; pai: TWinControl; imagem: tbitmap;
  out classe_registada: string; out msg_alerta: string): boolean;
var
  PERMISSAO: string;
  P: TRttiProperty;

begin
  self.permissoes_plugin_perfil := permissoes_plugin;

  if DevolvePermissao(utilizador_ligado, permissoes_plugin_perfil,
    'C_PER_ACESSO', PERMISSAO) = false
  //
  // if DevolveValorPermissao(self.permissoes_plugin, 'c_PER_ACESSO', att) <> '1'
  then
  begin
    MostraMensagem('Sem permissão para realizar essa acção', e_msg_alerta);
    EXIT;
  end;

  // fAtivo := (res = '1') or fPermissoesIlimitadas;
  if codigo_janela = '1' then
  begin
    try
      Application.CreateForm(TFrmTemplateBO_Child, FrmTemplateBO_Child);
      self.bd := bd_recebida;

      if pai <> nil then
      begin
        FrmTemplateBO_Child.FormStyle := fsNormal;
        FrmTemplateBO_Child.BorderStyle := bsnone;
        FrmTemplateBO_Child.Parent := pai;
        FrmTemplateBO_Child.BorderIcons := [];
      end
      else
      begin
        FrmTemplateBO_Child.FormStyle := fsMDIChild;
      end;
      FrmTemplateBO_Child.icon := Usysaccept.bmp2ico(imagem);
      FrmTemplateBO_Child.utilizador_recebido := utilizador;
      // IMPORTANTE
      self.frmbase := FrmTemplateBO_Child;
      P := TRttiContext.create.GetType(frmbase.ClassInfo)
        .GetProperty('Permissoes_activas');
      P.SetValue(frmbase, permissoes_plugin);
      // *****************************

      FrmTemplateBO_Child.activajanela(self.bd);
      FrmTemplateBO_Child.Show;

    except
      on e: exception do
        msg_alerta := e.message;
    end;

    classe_registada := FrmTemplateBO_Child.ClassName;
    result := true;
  end
  else if codigo_janela = '2' then
  begin
    try
      Application.CreateForm(TFrmTemplate2PluginV2, FrmTemplate2PluginV2);
      self.bd := bd_recebida;

      if pai <> nil then
      begin
        FrmTemplate2PluginV2.FormStyle := fsNormal;
        FrmTemplate2PluginV2.BorderStyle := bsnone;
        FrmTemplate2PluginV2.Parent := pai;
        FrmTemplate2PluginV2.BorderIcons := [];
      end
      else
      begin
        FrmTemplate2PluginV2.FormStyle := fsMDIChild;
      end;
      FrmTemplate2PluginV2.icon := Usysaccept.bmp2ico(imagem);
      FrmTemplate2PluginV2.utilizador_recebido := utilizador;
      // IMPORTANTE
      self.frmbase := FrmTemplate2PluginV2;
      P := TRttiContext.create.GetType(frmbase.ClassInfo)
        .GetProperty('Permissoes_activas');
      P.SetValue(frmbase, permissoes_plugin);
      // *****************************

      FrmTemplate2PluginV2.activajanela(self.bd);
      FrmTemplate2PluginV2.Show;

    except
      on e: exception do
        msg_alerta := e.message;
    end;
    /// IMPORTANTE
    classe_registada := FrmTemplate2PluginV2.ClassName;
    result := true;
  end
  else
  begin
    MostraMensagem('Plugin inválido (' + codigo_janela + ') - ' +
      classe_registada, e_msg_alerta);
  end;
end;

function TPluginAcceptV2.DevolveInfoPlugin(codigo_janela: string;
  out tipo: eTipoJanelaPlugin; out descricao, hint, codigo, grupo,
  versao: string; out single_instance: boolean;
  out bmp16, bmp32: tbitmap): boolean;
begin
  descricao := 'Template' + codigo_janela;
  codigo := 'CODIGO_TEMPLATE' + codigo_janela;
  hint := 'Plugin Template' + codigo_janela;
  grupo := 'Menu Plugins' + codigo_janela;
  versao := 'V0';
  if bmp16 = nil then
    bmp16 := tbitmap.create;
  if bmp32 = nil then
    bmp32 := tbitmap.create;
  single_instance := true;
  if codigo_janela = '1' then
    tipo := eTipoJanelaPlugin.e_plugin_menu
  else
    tipo := eTipoJanelaPlugin.e_plugin_barra_lateral;

  single_instance := true;

  bmp16.LoadFromResourceName(HInstance, 'ICON_16');
  bmp32.LoadFromResourceName(HInstance, 'ICON_32');
end;

// devolve codigo das janelas
function TPluginAcceptV2.DevolveListaJanelas: string;
begin
  //funcionaldiade 1 - codigo 1
  //funcionaldiade 2 - codigo 2
  result := '1;2';
end;

function TPluginAcceptV2.DevolveTemplatePermissoes(codigo_janela
  : STRING): string;
var
  lista: tstringlist;
begin
  lista := tstringlist.create;
  try
    // lista.add(' <?xml version="1.0" encoding="UTF-8"?> ');
    lista.add(' <PERMISSOES_PLUGIN> ');
    lista.add('    <PLUGIN_ACCEPT>');
    lista.add('    <EDITORES> ');
    lista.add('       <SN TIPO="CHECKBOX"> ');
    lista.add('          <VALORES>             ');
    lista.add('             <VALOR_TRUE>1</VALOR_TRUE> ');
    lista.add('             <VALOR_FALSE>0</VALOR_FALSE>   ');
    lista.add('          </VALORES> ');
    lista.add('       </SN> ');
    lista.add('    </EDITORES> ');
    lista.add('    <PERMISSOES> ');
    lista.add('       <SECCAO1 DESC="Registos" TIPO="GRELHA"> ');
    lista.add('          <Acesso> ');
    lista.add(
      ' <C_PER_ACESSO DESC="Aceder aos registos" EDITOR="SN">0</C_PER_ACESSO> ');
    lista.add(
      ' <C_PER_BOTAO1 DESC="Carregar Botão1" EDITOR="SN">0</C_PER_BOTAO1> ');
    lista.add('          </Acesso> ');
    lista.add('       </SECCAO1> ');
    lista.add('    </PERMISSOES> ');
    lista.add('    </PLUGIN_ACCEPT>');

    lista.add(' </PERMISSOES_PLUGIN> ');
    result := lista.text;
  finally
    lista.free;
  end;
end;

procedure TPluginAcceptV2.FechaPlugin(classe: string);
begin

end;

procedure TPluginAcceptV2.InicializaPlugin(classe, comandos_xml: string);
begin

end;

// devolve true se pode avancar; sempre true para admin ou quando é 1
// valor_permissao
function DevolvePermissao(user: TInfoUtilizador; permissoes_plugin: string;
  permissao_a_validar: string; out valor_permissao: String): boolean;
var
  res: boolean;
  att: string;
begin
  res := false;
  if user.is_admin then
    res := true;
  valor_permissao := DevolveValorPermissao(permissoes_plugin,
    permissao_a_validar, '');
  if user.is_admin = false then
  begin
    if trim(valor_permissao) = '1' then
      res := true;
  end;

  result := res;

end;

end.
