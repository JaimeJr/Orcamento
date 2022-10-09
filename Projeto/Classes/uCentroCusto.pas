unit uCentroCusto;

interface

uses
  uiCentroCusto, uExcecoes, SysUtils, System.Generics.Collections;

type
  TCentroCusto = class(TInterfacedObject, ICentroCusto)
  protected
    FCodigo: string;
    FValor: Real;
  public
    class function Criar: ICentroCusto;

    constructor Create;
    function Valor: real; overload;
    function Valor(value: real): ICentroCusto; overload; virtual;

    function Codigo: string; overload;
    function Codigo(value: string): ICentroCusto; overload; virtual;
  end;

  TCentroCustoSubject = class(TCentroCusto, ICentroCustoSubject)
  private
    FObservers: TList<ICentroCustoObserver>;
    procedure AtualizarObservers(valor : Real);
  public
    function Observers: TList<ICentroCustoObserver>; overload;
    function Observers(observers: TList<ICentroCustoObserver>): ICentroCustoSubject; overload;
    function Contains(centroCusto: ICentroCusto): Boolean;
    function Valor(value: Real): ICentroCusto; override;
    function ValorTotal : Real;
    class function Criar: ICentroCustoSubject;
    constructor Create;

    function AddObserver(centroCusto: ICentroCustoObserver): ICentroCustoSubject;
  end;

  TCentroCustoObserver = class(TCentroCusto, ICentroCustoObserver)
  public
    constructor Create;
    class function Criar: ICentroCustoObserver;
    procedure AtualizarObserver(novoValor: Real);
  end;

  TValidacoes = class(TInterfacedObject, IValidacoesCentroCusto)
    class function RetornarCodigoPai(codigo: string): string;
    class function RetonarCodigoFilho(codigo: string): string;
    class procedure ValidarCodigo(codigo: string);
    class function ContemCentroCusto(centrosCusto: TList<ICentroCustoObserver>; novoCentroCusto: ICentroCusto): Boolean; overload;
    class function ContemCentroCusto(centrosCusto: TList<ICentroCustoSubject>; novoCentroCusto: ICentroCusto): Boolean; overload;

    class function PosicaoCentroCusto(centrosCusto: TList<ICentroCustoObserver>; novoCentroCusto: ICentroCusto): Integer; overload;
    class function PosicaoCentroCusto(centrosCusto: TList<ICentroCustoSubject>; novoCentroCusto: ICentroCusto): Integer; overload;
  end;

implementation

{ TCentroCusto }

function TCentroCusto.Codigo(value: string): ICentroCusto;
begin
  Result := Self;
  FCodigo := value;
end;

function TCentroCusto.Codigo: string;
begin
  Result := FCodigo;
end;

constructor TCentroCusto.Create;
begin
  inherited;
end;

class function TCentroCusto.Criar: ICentroCusto;
begin
  Result := Self.Create;
end;

function TCentroCusto.Valor(value: real): ICentroCusto;
begin
  Result := Self;
  FValor := FValor + value;
end;

function TCentroCusto.Valor: real;
begin
  Result := FValor;
end;

{ TCentroCustoSubject }

function TCentroCustoSubject.AddObserver(centroCusto: ICentroCustoObserver): ICentroCustoSubject;
var
  centroCustoPai, centroCustoFilho, centroCustoResumo: ICentroCustoObserver;

  procedure PreencherObservers;
  var
    novoCodigo: string;
  begin
    novoCodigo := TValidacoes.RetornarCodigoPai(centroCusto.Codigo);
    centroCustoPai := TCentroCustoObserver(TCentroCustoObserver.
                        Criar.
                          Codigo(novoCodigo).
                          Valor(0));

    novoCodigo := TValidacoes.RetonarCodigoFilho(centroCusto.Codigo);
    centroCustoFilho := TCentroCustoObserver(TCentroCustoObserver.
                          Criar.
                            Codigo(novoCodigo).
                            Valor(0));

    novoCodigo := centroCusto.Codigo;
    centroCustoResumo := TCentroCustoObserver(TCentroCustoObserver.
                           Criar.
                             Codigo(novoCodigo).
                             Valor(0));
  end;

begin
  Result := Self;
  PreencherObservers;

  if not TValidacoes.ContemCentroCusto(FObservers, centroCustoPai) then
    FObservers.Add(centroCustoPai);

  if not TValidacoes.ContemCentroCusto(FObservers, centroCustoFilho) then
    FObservers.Add(centroCustoFilho);

  if not TValidacoes.ContemCentroCusto(FObservers, centroCustoResumo) then
    FObservers.Add(centroCustoResumo);
end;

procedure TCentroCustoSubject.AtualizarObservers(valor : Real);
var
  observer: ICentroCustoObserver;
  codigo: string;
begin
  for observer in FObservers do
  begin
    codigo := FCodigo;

    case Length(observer.Codigo) of
      2: codigo := TValidacoes.RetornarCodigoPai(FCodigo);
      4: codigo := TValidacoes.RetonarCodigoFilho(FCodigo);
    end;

    if observer.Codigo = codigo then
      observer.AtualizarObserver(valor);
  end;
end;

function TCentroCustoSubject.Contains(centroCusto: ICentroCusto): Boolean;
begin
  Result := FObservers.Contains(ICentroCustoObserver(centroCusto));
end;

constructor TCentroCustoSubject.Create;
begin
  inherited;
  FObservers := TList<ICentroCustoObserver>.Create;
end;

class function TCentroCustoSubject.Criar: ICentroCustoSubject;
begin
  Result := Self.Create;
end;

function TCentroCustoSubject.Observers(observers: TList<ICentroCustoObserver>): ICentroCustoSubject;
begin
  Result := Self;
  FObservers := observers;
end;

function TCentroCustoSubject.observers: TList<ICentroCustoObserver>;
begin
  Result := FObservers;
end;

function TCentroCustoSubject.Valor(value: Real): ICentroCusto;
begin
  inherited;
  AtualizarObservers(value);
end;

function TCentroCustoSubject.ValorTotal: Real;
var
  total : Real;
  centroCusto : ICentroCustoObserver;
begin
  total := 0;
  for centroCusto in FObservers do
    if Length(centroCusto.Codigo) = 6 then
      total := total + centroCusto.Valor;

  Result := total;
end;

{ TCentroCustoObserver }

procedure TCentroCustoObserver.AtualizarObserver(novoValor: Real);
begin
  FValor := FValor + novoValor;
end;

constructor TCentroCustoObserver.Create;
begin
  inherited;
end;

class function TCentroCustoObserver.Criar: ICentroCustoObserver;
begin
  Result := Self.Create;
end;

{ TValidacoesCentroCusto }

class function TValidacoes.ContemCentroCusto(centrosCusto: TList<ICentroCustoObserver>; novoCentroCusto: ICentroCusto): Boolean;
var
  centroCusto: ICentroCusto;
begin
  Result := False;

  if centrosCusto.Count = 0 then
    Exit;

  for centroCusto in centrosCusto do
  begin
    Result := centroCusto.Codigo = novoCentroCusto.Codigo;

    if Result then
      Break;
  end;
end;

class function TValidacoes.ContemCentroCusto(centrosCusto: TList<ICentroCustoSubject>; novoCentroCusto: ICentroCusto): Boolean;
var
  centroCusto: ICentroCusto;
begin
  Result := False;
  if not Assigned(centrosCusto) then
    Exit;

  if centrosCusto.Count = 0 then
    Exit;

  for centroCusto in centrosCusto do
  begin
    Result := centroCusto.Codigo = novoCentroCusto.Codigo;

    if Result then
      Break;
  end;
end;

class function TValidacoes.PosicaoCentroCusto(centrosCusto: TList<ICentroCustoObserver>; novoCentroCusto: ICentroCusto): Integer;
var
  posicaoCentroCusto : integer;
  centroCusto: ICentroCustoObserver;
begin
  posicaoCentroCusto := 0;
  Result := posicaoCentroCusto;

  if not ContemCentroCusto(centrosCusto, novoCentroCusto) then
    Exit;

  for centroCusto in centrosCusto do
  begin
    if centroCusto.Codigo = novoCentroCusto.Codigo then
      Break;

    Inc(posicaoCentroCusto);
  end;

  Result := posicaoCentroCusto;
end;

class function TValidacoes.PosicaoCentroCusto(centrosCusto: TList<ICentroCustoSubject>; novoCentroCusto: ICentroCusto): Integer;
var
  posicaoCentroCusto : integer;
  centroCusto: ICentroCustoSubject;
begin
  posicaoCentroCusto := 0;
  Result := posicaoCentroCusto;

  if not ContemCentroCusto(centrosCusto, novoCentroCusto) then
    Exit;

  for centroCusto in centrosCusto do
  begin
    if centroCusto.Codigo = novoCentroCusto.Codigo then
      Break;

    Inc(posicaoCentroCusto);
  end;

  Result := posicaoCentroCusto;
end;

class function TValidacoes.RetonarCodigoFilho(codigo: string): string;
begin
  Result := Copy(codigo, 3, 4);
end;

class function TValidacoes.RetornarCodigoPai(codigo: string): string;
begin
  Result := Copy(codigo, 0, 2);
end;

class procedure TValidacoes.ValidarCodigo(codigo: string);
var
  codigoPai, codigoFilho: Integer;
begin
  if Length(codigo) <> 6 then
    raise ECodigoInvalidoException.Create('O código do centro de custo deve conter 6 dígitos');

  codigoPai := StrToInt(TValidacoes.RetornarCodigoPai(codigo));

  if not (codigoPai in [1..99]) then
    raise ECodigoInvalidoException.Create('O código do centro de custo pai aceita somente valores de 01 até 99');

  codigoFilho := StrToInt(TValidacoes.RetonarCodigoFilho(codigo));

  if (codigoFilho < 1) or (codigoFilho > 9999) then
    raise ECodigoInvalidoException.Create('O código do centro de custo filho aceita somente valores de 0001 ate 9999');
end;

end.

