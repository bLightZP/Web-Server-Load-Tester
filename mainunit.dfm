object MainForm: TMainForm
  Left = 440
  Top = 328
  Width = 616
  Height = 148
  Caption = 'MainForm'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object LabelThreads: TLabel
    Left = 96
    Top = 32
    Width = 78
    Height = 13
    Caption = 'Active Threads :'
  end
  object LabelCounter: TLabel
    Left = 178
    Top = 32
    Width = 6
    Height = 13
    Alignment = taCenter
    Caption = '0'
  end
  object ThreadsLabel: TLabel
    Left = 16
    Top = 14
    Width = 71
    Height = 13
    Caption = 'Threads to use'
  end
  object Label1: TLabel
    Left = 16
    Top = 60
    Width = 22
    Height = 13
    Caption = 'URL'
  end
  object GoButton: TButton
    Left = 508
    Top = 26
    Width = 75
    Height = 69
    Caption = 'Create Threads'
    TabOrder = 0
    WordWrap = True
    OnClick = GoButtonClick
  end
  object ThreadsEdit: TEdit
    Left = 14
    Top = 28
    Width = 75
    Height = 21
    TabOrder = 1
    Text = '10'
  end
  object URLEdit: TEdit
    Left = 14
    Top = 74
    Width = 483
    Height = 21
    TabOrder = 2
    Text = 
      'http://localhost:8081/v/clubhouse/gallery?code=GLR.000B3FD9.0000' +
      '836E.00D3.1050'
  end
end
