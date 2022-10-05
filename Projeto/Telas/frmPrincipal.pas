unit frmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Mask, Data.DB, Vcl.Grids, Vcl.DBGrids, Datasnap.DBClient;

type
  TForm1 = class(TForm)
    pnlFundo: TPanel;
    pnlCabecalho: TPanel;
    pnlGrids: TPanel;
    pnlCentroCustoResumo: TPanel;
    pnlCentroCustoFilho: TPanel;
    pnlCentroCustoPai: TPanel;
    edtCentroCusto: TEdit;
    edtValor: TEdit;
    lblCentroCusto: TLabel;
    Label2: TLabel;
    btnConfirmar: TButton;
    grdCentroCustoPai: TDBGrid;
    grdCentroCustoFilho: TDBGrid;
    grdCentroCustoResumo: TDBGrid;
    dsCentroCustoPai: TDataSource;
    dsCentroCustoFilho: TDataSource;
    dsCentroCustoResumo: TDataSource;
    cdsCentroCustoPai: TClientDataSet;
    cdsCentroCustoFilho: TClientDataSet;
    cdsCentroCustoResumo: TClientDataSet;
    cdsCentroCustoFilhoCODIGO: TIntegerField;
    cdsCentroCustoFilhoVALOR: TFloatField;
    cdsCentroCustoPaiCODIGO: TIntegerField;
    cdsCentroCustoPaiVALOR: TFloatField;
    cdsCentroCustoResumoCODIGO: TIntegerField;
    cdsCentroCustoResumoVALOR: TFloatField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

end.
