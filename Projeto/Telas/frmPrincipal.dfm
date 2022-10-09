object frmCentroCusto: TfrmCentroCusto
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Centro de Custo'
  ClientHeight = 483
  ClientWidth = 619
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlFundo: TPanel
    Left = 0
    Top = 0
    Width = 619
    Height = 483
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object pnlCabecalho: TPanel
      Left = 0
      Top = 0
      Width = 619
      Height = 49
      Align = alTop
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object lblCentroCusto: TLabel
        Left = 6
        Top = 11
        Width = 84
        Height = 13
        Caption = 'Centro de Custo'
      end
      object Label2: TLabel
        Left = 133
        Top = 11
        Width = 26
        Height = 13
        Caption = 'Valor'
      end
      object edtCentroCusto: TEdit
        Left = 6
        Top = 25
        Width = 121
        Height = 21
        MaxLength = 6
        NumbersOnly = True
        TabOrder = 0
      end
      object edtValor: TEdit
        Left = 133
        Top = 25
        Width = 90
        Height = 21
        NumbersOnly = True
        TabOrder = 1
      end
      object btnConfirmar: TButton
        Left = 317
        Top = 25
        Width = 75
        Height = 21
        Caption = 'Confirmar'
        TabOrder = 3
        OnClick = btnConfirmarClick
      end
      object btnAdicionar: TButton
        Left = 229
        Top = 25
        Width = 75
        Height = 21
        Caption = 'Adicionar'
        TabOrder = 2
        OnClick = btnAdicionarClick
      end
    end
    object pnlGrids: TPanel
      Left = 0
      Top = 49
      Width = 619
      Height = 434
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object pnlCentroCustoResumo: TPanel
        AlignWithMargins = True
        Left = 6
        Top = 176
        Width = 607
        Height = 252
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alBottom
        TabOrder = 2
        object grdCentroCustoResumo: TDBGrid
          Left = 1
          Top = 1
          Width = 605
          Height = 250
          Align = alClient
          BorderStyle = bsNone
          DataSource = dsCentroCustoResumo
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'CODIGO'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'VALOR'
              Visible = True
            end>
        end
      end
      object pnlCentroCustoFilho: TPanel
        AlignWithMargins = True
        Left = 316
        Top = 6
        Width = 297
        Height = 158
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        TabOrder = 1
        ExplicitHeight = 326
        object grdCentroCustoFilho: TDBGrid
          Left = 1
          Top = 1
          Width = 295
          Height = 156
          Align = alClient
          BorderStyle = bsNone
          DataSource = dsCentroCustoFilho
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'CODIGO'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'VALOR'
              Visible = True
            end>
        end
      end
      object pnlCentroCustoPai: TPanel
        AlignWithMargins = True
        Left = 6
        Top = 6
        Width = 298
        Height = 158
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alLeft
        TabOrder = 0
        ExplicitHeight = 326
        object grdCentroCustoPai: TDBGrid
          Left = 1
          Top = 1
          Width = 296
          Height = 156
          Align = alClient
          BorderStyle = bsNone
          DataSource = dsCentroCustoPai
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'CODIGO'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'VALOR'
              Visible = True
            end>
        end
      end
    end
  end
  object dsCentroCustoPai: TDataSource
    DataSet = cdsCentroCustoPai
    Left = 128
    Top = 184
  end
  object dsCentroCustoFilho: TDataSource
    DataSet = cdsCentroCustoFilho
    Left = 528
    Top = 168
  end
  object dsCentroCustoResumo: TDataSource
    DataSet = cdsCentroCustoResumo
    Left = 272
    Top = 424
  end
  object cdsCentroCustoPai: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 128
    Top = 144
    object cdsCentroCustoPaiCODIGO: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODIGO'
      Size = 2
    end
    object cdsCentroCustoPaiVALOR: TFloatField
      DisplayLabel = 'Valor'
      FieldName = 'VALOR'
    end
  end
  object cdsCentroCustoFilho: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 528
    Top = 136
    object cdsCentroCustoFilhoCODIGO: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODIGO'
      Size = 4
    end
    object cdsCentroCustoFilhoVALOR: TFloatField
      DisplayLabel = 'Valor'
      FieldName = 'VALOR'
    end
  end
  object cdsCentroCustoResumo: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 272
    Top = 392
    object cdsCentroCustoResumoCODIGO: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODIGO'
      Size = 6
    end
    object cdsCentroCustoResumoVALOR: TFloatField
      DisplayLabel = 'Valor'
      FieldName = 'VALOR'
    end
  end
end
