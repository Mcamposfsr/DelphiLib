object FormTester: TFormTester
  Left = 0
  Top = 0
  Caption = 'Tester'
  ClientHeight = 496
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object TDBGrid: TDBGrid
    Left = 24
    Top = 32
    Width = 569
    Height = 241
    DataSource = DataSourceSimple
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
  end
  object TButtonFind: TButton
    Left = 24
    Top = 367
    Width = 105
    Height = 41
    Caption = 'Busca ID 1'
    TabOrder = 1
    OnClick = TButtonFindClick
  end
  object TButtonInsert: TButton
    Left = 24
    Top = 430
    Width = 105
    Height = 41
    Caption = 'Inserir Dados Teste'
    TabOrder = 2
    OnClick = TButtonInsertClick
  end
  object Button1: TButton
    Left = 24
    Top = 304
    Width = 105
    Height = 41
    Caption = 'Buscar Dados'
    TabOrder = 3
    OnClick = Button1Click
  end
  object DataSourceSimple: TDataSource
    Left = 168
    Top = 312
  end
end
