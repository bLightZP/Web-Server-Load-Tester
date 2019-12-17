object MainForm: TMainForm
  Left = 440
  Top = 328
  Width = 472
  Height = 268
  Caption = 'MainForm'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object LabelThreads: TLabel
    Left = 110
    Top = 30
    Width = 78
    Height = 13
    Caption = 'Active Threads :'
  end
  object LabelCounter: TLabel
    Left = 110
    Top = 46
    Width = 78
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = '0'
  end
  object GoButton: TButton
    Left = 28
    Top = 30
    Width = 75
    Height = 59
    Caption = 'GO'
    TabOrder = 0
    OnClick = GoButtonClick
  end
end
