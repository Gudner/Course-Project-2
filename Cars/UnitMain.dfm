object Form1: TForm1
  Left = 0
  Top = 0
  Caption = #1058#1088#1072#1085#1089#1087#1086#1088#1090' '#1080' '#1089#1074#1077#1090#1086#1092#1086#1088#1099
  ClientHeight = 485
  ClientWidth = 611
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    611
    485)
  PixelsPerInch = 96
  TextHeight = 13
  object PaintBox1: TPaintBox
    Left = 8
    Top = 35
    Width = 463
    Height = 446
    Anchors = [akLeft, akTop, akRight, akBottom]
    OnPaint = PaintBox1Paint
  end
  object Label1: TLabel
    Left = 478
    Top = 31
    Width = 68
    Height = 13
    Anchors = [akTop, akRight]
    Caption = #1054#1076#1085#1072' '#1084#1072#1096#1080#1085#1072
    Color = clGreen
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object Label2: TLabel
    Left = 478
    Top = 50
    Width = 63
    Height = 13
    Anchors = [akTop, akRight]
    Caption = #1044#1074#1077' '#1084#1072#1096#1080#1085#1099
    Color = clYellow
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clYellow
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    ExplicitLeft = 580
  end
  object Label3: TLabel
    Left = 477
    Top = 69
    Width = 61
    Height = 13
    Anchors = [akTop, akRight]
    Caption = #1058#1088#1080' '#1084#1072#1096#1080#1085#1099
    Color = clBlue
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object Label4: TLabel
    Left = 477
    Top = 88
    Width = 82
    Height = 13
    Anchors = [akTop, akRight]
    Caption = #1063#1077#1090#1099#1088#1077' '#1084#1072#1096#1080#1085#1099
    Color = clRed
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    ExplicitLeft = 579
  end
  object Label5: TLabel
    Left = 477
    Top = 107
    Width = 75
    Height = 13
    Anchors = [akTop, akRight]
    Caption = #1055#1103#1090#1100' '#1080' '#1073#1086#1083#1100#1096#1077
    Color = clGray
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    ExplicitLeft = 579
  end
  object LabelFinished: TLabel
    Left = 478
    Top = 166
    Width = 74
    Height = 13
    Anchors = [akTop, akRight]
    Caption = #1042#1089#1077#1075#1086' '#1076#1086#1077#1093#1072#1083#1086
    ExplicitLeft = 580
  end
  object LabelIdle: TLabel
    Left = 477
    Top = 204
    Width = 74
    Height = 13
    Anchors = [akTop, akRight]
    Caption = #1042#1088#1077#1084#1103' '#1087#1088#1086#1089#1090#1086#1103
    ExplicitLeft = 579
  end
  object LabelMove: TLabel
    Left = 477
    Top = 223
    Width = 84
    Height = 13
    Anchors = [akTop, akRight]
    Caption = #1042#1088#1077#1084#1103' '#1076#1074#1080#1078#1077#1085#1080#1103
    ExplicitLeft = 579
  end
  object LabelCurrent: TLabel
    Left = 477
    Top = 185
    Width = 84
    Height = 13
    Anchors = [akTop, akRight]
    Caption = #1057#1077#1081#1095#1072#1089' '#1074' '#1075#1086#1088#1086#1076#1077
    ExplicitLeft = 579
  end
  object LabelStarted: TLabel
    Left = 477
    Top = 147
    Width = 75
    Height = 13
    Anchors = [akTop, akRight]
    Caption = #1042#1089#1077#1075#1086' '#1074#1099#1077#1093#1072#1083#1086
    ExplicitLeft = 579
  end
  object Label11: TLabel
    Left = 260
    Top = 8
    Width = 55
    Height = 13
    Caption = #1057#1086#1079#1076#1072#1074#1072#1090#1100
  end
  object Label12: TLabel
    Left = 420
    Top = 8
    Width = 42
    Height = 13
    Caption = #1050#1072#1078#1076#1099#1077
  end
  object CheckBox: TCheckBox
    Left = 8
    Top = 8
    Width = 65
    Height = 17
    Caption = #1055#1059#1057#1050'!'
    TabOrder = 0
    OnClick = CheckBoxClick
  end
  object CheckBoxFar: TCheckBox
    Left = 157
    Top = 8
    Width = 97
    Height = 17
    Caption = #1062#1077#1083#1100' '#1076#1072#1083#1077#1082#1086
    TabOrder = 1
  end
  object Button1: TButton
    Left = 76
    Top = 4
    Width = 75
    Height = 25
    Caption = #1054#1076#1080#1085' '#1096#1072#1075
    TabOrder = 2
    OnClick = Timer1Timer
  end
  object ComboBoxN: TComboBox
    Left = 325
    Top = 4
    Width = 89
    Height = 21
    Style = csDropDownList
    ItemIndex = 1
    TabOrder = 3
    Text = #1055#1086' '#1086#1076#1085#1086#1081
    Items.Strings = (
      #1053#1077' '#1085#1072#1076#1086
      #1055#1086' '#1086#1076#1085#1086#1081
      #1055#1086' '#1076#1074#1077
      #1055#1086' '#1090#1088#1080
      #1055#1086' '#1095#1077#1090#1099#1088#1077
      #1055#1086' '#1087#1103#1090#1100)
  end
  object ComboBox1: TComboBox
    Left = 487
    Top = 4
    Width = 89
    Height = 21
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 4
    Text = #1054#1076#1080#1085' '#1096#1072#1075
    OnChange = ComboBox1Change
    Items.Strings = (
      #1054#1076#1080#1085' '#1096#1072#1075
      #1044#1074#1072' '#1096#1072#1075#1072
      #1058#1088#1080' '#1096#1072#1075#1072
      #1063#1077#1090#1099#1088#1077' '#1096#1072#1075#1072
      #1055#1103#1090#1100' '#1096#1072#1075#1086#1074)
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 500
    OnTimer = Timer1Timer
    Left = 168
    Top = 96
  end
  object Timer2: TTimer
    OnTimer = Timer2Timer
    Left = 168
    Top = 176
  end
end
