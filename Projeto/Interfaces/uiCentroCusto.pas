unit uiCentroCusto;

interface
  uses
    System.Generics.Collections;

  type ICentroCusto = interface
  ['{3CABB29B-2148-4B72-8F8A-D123FBD002F5}']
    function Valor(value : real) : ICentroCusto; overload;
    function Valor : real; overload;

    function Codigo(value : string) : ICentroCusto; overload;
    function Codigo : string; overload;

    procedure ValidarCodigo(codigo : string);
  end;

  type ICentroCustoPai = interface(ICentroCusto)
  ['{FDD005DE-ECCF-4855-ACCE-463898A227EE}']
    procedure AtualizarValores(centroCusto : ICentroCusto);
  end;

  type ICentroCustoFilho = interface (ICentroCusto)
  ['{0DC6AA81-E477-46CA-8EF9-0EC1E2571AB3}']
    function CentroCustoPai(centroCusto : ICentroCustoPai) : ICentroCustoFilho; overload;
    function CentroCustoPai : ICentroCustoPai; overload;

    procedure AtualizarPai;
  end;



implementation

end.
