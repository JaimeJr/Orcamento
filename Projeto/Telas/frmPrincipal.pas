unit frmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ExtCtrls, Vcl.StdCtrls, uiCentroCusto, uCentroCusto, Vcl.Mask, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Datasnap.DBClient, uExcecoes,
  System.Generics.Collections;

type
  TfrmCentroCusto = class(TForm)
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
    btnAdicionar: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FCentrosCusto: TList<ICentroCustoSubject>;

    procedure TratarExcecao(Sender: TObject; E: Exception);
    procedure AdicionarCentroCusto(codigo: string; valor: Real);
    procedure PreencherDataSet(cdsResumo, cdsPai, cdsFilho: TClientDataSet);
    procedure PreencherResumo(cdsResumo: TClientDataSet);
    procedure PreencherPai(cdsPai: TClientDataSet);
    procedure PreencherFilho(cdsFilho: TClientDataSet);
  public
    { Public declarations }
  end;

var
  frmCentroCusto: TfrmCentroCusto;

implementation

{$R *.dfm}

{ TfrmCentroCusto }

procedure TfrmCentroCusto.AdicionarCentroCusto(codigo: string; valor: Real);
var
  centroCustoObserver: ICentroCustoObserver;
  centroCusto: ICentroCustoSubject;
begin
  try
    TCentroCusto.ValidarCodigo(codigo);

    centroCustoObserver := ICentroCustoObserver(TCentroCustoObserver.
                             Criar.
                               Codigo(codigo).
                               valor(valor));

    centroCusto := TCentroCustoSubject.Create;
    centroCusto.AddObserver(centroCustoObserver);
    centroCusto.Codigo(codigo);
    centroCusto.Valor(valor);

    if not FCentrosCusto.Contains(centroCusto) then
      FCentrosCusto.Add(centroCusto);
  except
    raise;
  end;
end;

procedure TfrmCentroCusto.btnAdicionarClick(Sender: TObject);
begin
  AdicionarCentroCusto(edtCentroCusto.Text, StrToFloat(edtValor.Text));
  PreencherDataSet(cdsCentroCustoResumo, cdsCentroCustoPai, cdsCentroCustoFilho);
end;

procedure TfrmCentroCusto.FormCreate(Sender: TObject);
begin
  Application.OnException := TratarExcecao;
  FCentrosCusto := TList<ICentroCustoSubject>.Create;
end;

procedure TfrmCentroCusto.FormShow(Sender: TObject);
begin
  edtCentroCusto.Text := '010001';
  edtValor.Text := '1';
  btnAdicionarClick(Sender);
end;

procedure TfrmCentroCusto.PreencherDataSet(cdsResumo, cdsPai, cdsFilho: TClientDataSet);
begin
  PreencherResumo(cdsResumo);
  PreencherPai(cdsPai);
  PreencherFilho(cdsFilho);
end;

procedure TfrmCentroCusto.PreencherFilho(cdsFilho: TClientDataSet);
begin

end;

procedure TfrmCentroCusto.PreencherPai(cdsPai: TClientDataSet);
begin

end;

procedure TfrmCentroCusto.PreencherResumo(cdsResumo: TClientDataSet);
var
  centroCusto: ICentroCustoSubject;
begin
  if not cdsCentroCustoResumo.Active then
    cdsCentroCustoResumo.CreateDataSet;

  cdsCentroCustoResumo.EmptyDataSet;

  for centroCusto in FCentrosCusto do
  begin
    cdsCentroCustoResumo.Append;
    cdsCentroCustoResumoCODIGO.AsString := centroCusto.Codigo;
    cdsCentroCustoResumoVALOR.AsFloat := centroCusto.Valor;
    cdsCentroCustoResumo.Post;
  end;

  cdsCentroCustoResumo.Open;
end;

procedure TfrmCentroCusto.TratarExcecao(Sender: TObject; E: Exception);
begin
  if not (E is ECentroCustoException) then
  begin
    Application.MessageBox(PChar(E.Message), 'Ocorreu uma exceção sem tratamento', MB_OK + MB_ICONSTOP);
    Exit;
  end;

  if E is ECodigoInvalidoException then
  begin
    Application.MessageBox(PChar(E.Message), 'Ocorreu uma exeção na inclusão da centro de custo', MB_OK + MB_ICONSTOP);
    edtCentroCusto.SetFocus;
    Exit;
  end;

  Application.MessageBox(PChar(E.Message),
    'Ocorreu uma exeção relacionada ao centro de custo.', MB_OK + MB_ICONSTOP);
end;

end.

