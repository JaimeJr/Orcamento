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
    class procedure ValidarCodigo(codigo: string);

    constructor Create;
    function Valor: real; overload;
    function Valor(value: real): ICentroCusto; overload; virtual;

    function Codigo: string; overload;
    function Codigo(value: string): ICentroCusto; overload; virtual;
  end;

type
  TCentroCustoSubject = class(TCentroCusto, ICentroCustoSubject)
  private
    FObservers: TList<ICentroCustoObserver>;
    procedure AtualizarObservers;
  public
    function Observers: TList<ICentroCustoObserver>;
    function Contains(centroCusto : ICentroCusto) : Boolean;
    function Valor(value: Real): ICentroCusto; override;
//    function Codigo(value: string): ICentroCusto; override;
    class function Criar: ICentroCustoSubject;
    constructor Create;

    function AddObserver(centroCusto : ICentroCustoObserver) : ICentroCustoSubject;
  end;

type
  TCentroCustoObserver = class(TCentroCusto, ICentroCustoObserver)
  public
    constructor Create;
    class function Criar : ICentroCustoObserver;
    procedure AtualizarObserver(novoValor : Real);
  end;

type
  TCentroCustoPai = class(TCentroCustoObserver)
  end;

type
  TCentroCustoFilho = class(TCentroCustoObserver)
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

class procedure TCentroCusto.ValidarCodigo(codigo: string);
var
  codigoPai,
  codigoFilho : Integer;
begin
  if Length(codigo) <> 6 then
    raise ECodigoInvalidoException.Create('O código do centro de custo deve conter 6 dígitos');

  codigoPai := StrToInt(Copy(codigo, 0, 2));

  if not (codigoPai in [1..99]) then
    raise ECodigoInvalidoException.Create('O código do centro de custo pai aceita somente valores de 01 até 99');

  codigoFilho := StrToInt(Copy(codigo, 2, 4));

  if (codigoFilho < 1) or (codigoFilho >= 9999) then
    raise ECodigoInvalidoException.Create('O código do centro de custo filho aceita somente valores de 0001 ate 9999');
end;

function TCentroCusto.Valor(value: real): ICentroCusto;
begin
  Result := Self;
  FValor := value;
end;

function TCentroCusto.Valor: real;
begin
  Result := FValor;
end;

{ TCentroCustoSubject }

function TCentroCustoSubject.AddObserver(centroCusto : ICentroCustoObserver) : ICentroCustoSubject;
var
  centroCustoPai,
  centroCustoFilho : ICentroCustoObserver;

  procedure PreencherPaiFilho;
  var
    novoCodigo : string;
  begin
    novoCodigo := Copy(centroCusto.Codigo, 0, 2);
    centroCustoPai := TCentroCustoPai(TCentroCustoPai.
                        Criar.
                          Codigo(novoCodigo).
                          Valor(centroCusto.Valor));

    novoCodigo := Copy(centroCusto.Codigo, 2, 4);
    centroCustoFilho := TCentroCustoFilho(TCentroCustoFilho.
                        Criar.
                          Codigo(novoCodigo).
                          Valor(centroCusto.Valor));
  end;

  function Contem(novoCentroCusto : ICentroCusto) : Boolean;
  var
    centroCusto : ICentroCusto;
    i: Integer;
  begin
    Result := False;

    if FObservers.Count = 0 then
      Exit;

    for i := 0 to FObservers.Count - 1 do
    begin
      centroCusto := FObservers.Items[i];

      Result := centroCusto.Codigo = novoCentroCusto.Codigo;
      if Result then
        Break;
    end;
  end;

begin
  Result := Self;
  PreencherPaiFilho;

  if not Contem(centroCustoPai) then
    FObservers.Add(centroCustoPai);

  if not Contem(centroCustoFilho) then
    FObservers.Add(centroCustoFilho);
end;

procedure TCentroCustoSubject.AtualizarObservers;
var
  observer : ICentroCustoObserver;
  codigo : string;
begin
  for observer in FObservers do
  begin
    if Length(observer.Codigo) = 2 then
      codigo := Copy(Self.Codigo, 0, 2)
    else
      codigo := Copy(Self.Codigo, 2, 4);

    if observer.Codigo = codigo then
      observer.AtualizarObserver(Self.Valor);
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

function TCentroCustoSubject.Observers: TList<ICentroCustoObserver>;
begin
  Result := FObservers;
end;

function TCentroCustoSubject.Valor(value: Real): ICentroCusto;
begin
  inherited;
  AtualizarObservers;
end;

{ TCentroCustoObserver }

procedure TCentroCustoObserver.AtualizarObserver(novoValor: Real);
begin
  FValor := FValor + valor;
end;

constructor TCentroCustoObserver.Create;
begin
  inherited;
end;

class function TCentroCustoObserver.Criar: ICentroCustoObserver;
begin
  Result := Self.Create;
end;

end.

