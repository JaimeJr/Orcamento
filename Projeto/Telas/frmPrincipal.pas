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
    btnAdicionar: TButton;
    cdsCentroCustoPaiCODIGO: TStringField;
    cdsCentroCustoPaiVALOR: TFloatField;
    cdsCentroCustoResumoCODIGO: TStringField;
    cdsCentroCustoResumoVALOR: TFloatField;
    cdsCentroCustoFilhoCODIGO: TStringField;
    cdsCentroCustoFilhoVALOR: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConfirmarClick(Sender: TObject);
  private
    { Private declarations }
    FCentroCusto: ICentroCustoSubject;
    FValidacoesCentroCusto: TValidacoes;

    procedure TratarExcecao(Sender: TObject; E: Exception);
    procedure AdicionarCentroCusto(codigo: string; valor: Real);
    procedure PreencherDataSet(cdsResumo, cdsPai, cdsFilho: TClientDataSet);
    procedure PreencherResumo(cdsResumo: TClientDataSet);
    procedure PreencherPai(cdsPai: TClientDataSet);
    procedure PreencherFilho(cdsFilho: TClientDataSet);
    procedure MostrarValorTotal;
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
  centroCusto: ICentroCustoObserver;
  novoCentroCusto: Boolean;

  procedure AtualizarCentroCusto;
  var
    valorAtual: Real;
  begin
    valorAtual := FCentroCusto.Observers.Items[TValidacoes.PosicaoCentroCusto(FCentroCusto.Observers, centroCusto)].valor;

    FCentroCusto.Observers.Items[TValidacoes.PosicaoCentroCusto(FCentroCusto.Observers, centroCusto)].valor(valorAtual + valor);
  end;

begin
  try
    FValidacoesCentroCusto.ValidarCodigo(codigo);

    if not Assigned(FCentroCusto) then
      FCentroCusto := TCentroCustoSubject.Create;

    FCentroCusto.Codigo(codigo);

    centroCustoObserver := ICentroCustoObserver(TCentroCustoObserver.Criar.Codigo(codigo).valor(valor));

    novoCentroCusto := not (TValidacoes.ContemCentroCusto(FCentroCusto.Observers, centroCustoObserver));

    if novoCentroCusto then
    begin
      centroCusto := TCentroCustoObserver.Create;
      centroCusto.Codigo(codigo);
    end
    else
      centroCusto := FCentroCusto.Observers.Items[TValidacoes.PosicaoCentroCusto(FCentroCusto.Observers, centroCustoObserver)];

    if novoCentroCusto then
      FCentroCusto.AddObserver(centroCusto);

    FCentroCusto.Valor(valor);
  except
    raise;
  end;
end;

procedure TfrmCentroCusto.btnAdicionarClick(Sender: TObject);
begin
  if edtValor.Text = '' then
    raise EValorEmBrancoException.Create('O valor informado esta em branco');

  AdicionarCentroCusto(edtCentroCusto.Text, StrToFloat(edtValor.Text));
  PreencherDataSet(cdsCentroCustoResumo, cdsCentroCustoPai, cdsCentroCustoFilho);
end;

procedure TfrmCentroCusto.btnConfirmarClick(Sender: TObject);
begin
  MostrarValorTotal;
end;

procedure TfrmCentroCusto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FValidacoesCentroCusto.DisposeOf;
end;

procedure TfrmCentroCusto.FormCreate(Sender: TObject);
begin
  Application.OnException := TratarExcecao;
  FValidacoesCentroCusto := TValidacoes.Create;
end;

procedure TfrmCentroCusto.MostrarValorTotal;
var
  valorTotal: string;
begin
  if cdsCentroCustoResumo.IsEmpty then
    raise ESemCentroCustoException.Create('Não há centro de custo informado');

  valorTotal := FloatToStr(FCentroCusto.ValorTotal);

  Application.MessageBox(PChar('Valor total dos centros de custo: R$' + valorTotal), PChar('Valor Total'), MB_OK + MB_ICONINFORMATION);
end;

procedure TfrmCentroCusto.PreencherDataSet(cdsResumo, cdsPai, cdsFilho: TClientDataSet);
begin
  PreencherResumo(cdsResumo);
  PreencherPai(cdsPai);
  PreencherFilho(cdsFilho);
end;

procedure TfrmCentroCusto.PreencherFilho(cdsFilho: TClientDataSet);
var
  centroCustoObserver: ICentroCustoObserver;
begin
  if not cdsCentroCustoFilho.Active then
    cdsCentroCustoFilho.CreateDataSet;

  cdsCentroCustoFilho.EmptyDataSet;

  for centroCustoObserver in FCentroCusto.Observers do
  begin
    if Length(centroCustoObserver.Codigo) <> 4 then
      Continue;

    cdsCentroCustoFilho.Append;
    cdsCentroCustoFilhoCODIGO.AsString := centroCustoObserver.Codigo;
    cdsCentroCustoFilhoVALOR.AsFloat := centroCustoObserver.Valor;
    cdsCentroCustoFilho.Post;
  end;

  cdsCentroCustoFilho.Open;
end;

procedure TfrmCentroCusto.PreencherPai(cdsPai: TClientDataSet);
var
  centroCustoObserver: ICentroCustoObserver;
begin
  if not cdsCentroCustoPai.Active then
    cdsCentroCustoPai.CreateDataSet;

  cdsCentroCustoPai.EmptyDataSet;

  for centroCustoObserver in FCentroCusto.Observers do
  begin
    if Length(centroCustoObserver.Codigo) <> 2 then
      Continue;

    cdsCentroCustoPai.Append;
    cdsCentroCustoPaiCODIGO.AsString := centroCustoObserver.Codigo;
    cdsCentroCustoPaiVALOR.AsFloat := centroCustoObserver.Valor;
    cdsCentroCustoPai.Post;
  end;

  cdsCentroCustoPai.Open;
end;

procedure TfrmCentroCusto.PreencherResumo(cdsResumo: TClientDataSet);
var
  centroCustoObserver: ICentroCustoObserver;
begin
  if not cdsCentroCustoResumo.Active then
    cdsCentroCustoResumo.CreateDataSet;

  cdsCentroCustoResumo.EmptyDataSet;

  for centroCustoObserver in FCentroCusto.Observers do
  begin
    if Length(centroCustoObserver.Codigo) <> 6 then
      Continue;

    cdsCentroCustoResumo.Append;
    cdsCentroCustoResumoCODIGO.AsString := centroCustoObserver.Codigo;
    cdsCentroCustoResumoVALOR.AsFloat := centroCustoObserver.Valor;
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

  if E is EValorEmBrancoException then
  begin
    Application.MessageBox(PChar(E.Message), 'Ocorreu uma exeção no preenchimento do valor do centro de custo', MB_OK + MB_ICONSTOP);
    edtValor.SetFocus;
    Exit;
  end;

  Application.MessageBox(PChar(E.Message), 'Ocorreu uma exeção relacionada ao centro de custo.', MB_OK + MB_ICONSTOP);
end;

end.

