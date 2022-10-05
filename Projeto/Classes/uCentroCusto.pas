unit uCentroCusto;

interface
  uses
    uiCentroCusto, uExcecoes, SysUtils;

  type TCentroCusto = class(TInterfacedObject, ICentroCusto)
    private
      FValor : Real;
      FCodigo : string;

      function Valor(value : real) : ICentroCusto; overload;
      procedure ValidarCodigo(codigo : string);
    public
      constructor Create;
      class function Criar : ICentroCusto;

      function Codigo(value : string) : ICentroCusto; overload;
      function Codigo : string; overload;
      function Valor : real; overload;
  end;

implementation

{ TCentroCusto }

function TCentroCusto.Codigo: string;
begin
  Result := FCodigo;
end;

function TCentroCusto.Codigo(value: string): ICentroCusto;
begin
  Result := Self;
  try
    ValidarCodigo(value);
    FCodigo := value;
  except
    raise;
  end;
end;

constructor TCentroCusto.Create;
begin

end;

class function TCentroCusto.Criar: ICentroCusto;
begin
  Result := Self.Create;
end;

procedure TCentroCusto.ValidarCodigo(codigo: string);
var
  codigoPai,
  codigoFilho : Integer;
begin
  if Length(codigo) <> 7 then
    raise ECentroCustoException.Create('O código do centro de custo deve conter 7 dígitos');

  codigoPai   := StrToInt(Copy(codigo, 0, 2));
  codigoFilho := StrToInt(Copy(codigo, 2, 4));

  if not (codigoPai in [1..99]) then
    raise ECentroCustoException.Create('O código do centro de custo pai aceita somente valores de 01 até 99');

  if (codigoFilho < 1) or (codigoFilho > 9999) then
    raise ECentroCustoException.Create('O código do centro de custo filho aceita somente valores de 0001 ate 9999');
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

end.
