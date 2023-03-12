object FrmImportWSDelta: TFrmImportWSDelta
  Left = 0
  Top = 0
  Caption = 'Importa'#231#227'o SAP'
  ClientHeight = 338
  ClientWidth = 704
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    704
    338)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 84
    Width = 17
    Height = 13
    Caption = 'Log'
  end
  object Memo1: TMemo
    Left = 8
    Top = 103
    Width = 688
    Height = 176
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'Memo1')
    TabOrder = 0
  end
  object Button1: TButton
    Left = 439
    Top = 39
    Width = 75
    Height = 25
    Caption = 'Materiais'
    TabOrder = 1
    Visible = False
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 439
    Top = 79
    Width = 75
    Height = 25
    Caption = 'OP'
    TabOrder = 2
    Visible = False
    OnClick = Button2Click
  end
  object cxDateEdit1: TcxDateEdit
    Left = 89
    Top = 41
    TabOrder = 3
    Visible = False
    Width = 121
  end
  object Button3: TButton
    Left = 432
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Thread'
    TabOrder = 4
    Visible = False
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 520
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Button3'
    TabOrder = 5
    Visible = False
  end
  object Button5: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Materiais'
    TabOrder = 6
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 8
    Top = 39
    Width = 75
    Height = 25
    Caption = 'Lotes'
    TabOrder = 7
    OnClick = Button6Click
  end
  object UniConnection1: TUniConnection
    ProviderName = 'SQL Server'
    Database = 'ACCEPT'
    Username = 'accept'
    Password = 'accept00'
    Server = '192.168.133.231\SQLEXPRESS'
    LoginPrompt = False
    Left = 568
    Top = 232
  end
  object SQLServerUniProvider1: TSQLServerUniProvider
    Left = 568
    Top = 144
  end
end
