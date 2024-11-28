object Form1: TForm1
  Left = 0
  Top = 0
  ActiveControl = EdCant
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Creaci'#243'n archivo de texto'
  ClientHeight = 876
  ClientWidth = 1118
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -21
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesktopCenter
  OnClose = FormClose
  PixelsPerInch = 168
  TextHeight = 30
  object Gauge1: TGauge
    Left = 10
    Top = 829
    Width = 1088
    Height = 32
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Progress = 0
  end
  object Label1: TLabel
    Left = 10
    Top = 112
    Width = 393
    Height = 38
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Crear usando el metodo normal'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -28
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 686
    Top = 114
    Width = 395
    Height = 38
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Crear usando hilos de ejecuci'#243'n'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -28
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    StyleName = 'Windows'
  end
  object EdCant: TLabeledEdit
    Left = 294
    Top = 28
    Width = 169
    Height = 44
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    EditLabel.Width = 263
    EditLabel.Height = 44
    EditLabel.Margins.Left = 5
    EditLabel.Margins.Top = 5
    EditLabel.Margins.Right = 5
    EditLabel.Margins.Bottom = 5
    EditLabel.Caption = 'Cantidad de Registros :'
    EditLabel.Font.Charset = DEFAULT_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -26
    EditLabel.Font.Name = 'Segoe UI'
    EditLabel.Font.Style = []
    EditLabel.ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -26
    Font.Name = 'Segoe UI'
    Font.Style = []
    LabelPosition = lpLeft
    NumbersOnly = True
    ParentFont = False
    TabOrder = 0
    Text = '25000'
  end
  object Memo1: TMemo
    Left = 10
    Top = 216
    Width = 1088
    Height = 603
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object Button1: TButton
    Left = 10
    Top = 160
    Width = 130
    Height = 46
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Generar'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 686
    Top = 162
    Width = 130
    Height = 44
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Generar'
    TabOrder = 3
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 967
    Top = 162
    Width = 131
    Height = 44
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Cancelar'
    TabOrder = 4
    OnClick = Button3Click
  end
end
