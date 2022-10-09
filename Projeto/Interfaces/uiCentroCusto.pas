unit uiCentroCusto;

interface
  uses
    System.Generics.Collections;

  type ICentroCusto = interface
    ['{3CABB29B-2148-4B72-8F8A-D123FBD002F5}']
    function Codigo(value : string) : ICentroCusto; overload;
    function Codigo : string; overload;

    function Valor(value : Real) : ICentroCusto; overload;
    function Valor : Real; overload;
  end;

  type ICentroCustoObserver = interface(ICentroCusto)
    ['{07EB6696-3738-4D54-8E5C-D6E535C48E5D}']
    procedure AtualizarObserver(novoValor : Real);
  end;

  type ICentroCustoPai = interface(ICentroCustoObserver)
    ['{FDD005DE-ECCF-4855-ACCE-463898A227EE}']
  end;

  type ICentroCustoFilho = interface(ICentroCustoObserver)
    ['{0DC6AA81-E477-46CA-8EF9-0EC1E2571AB3}']
  end;

  type ICentroCustoSubject = interface(ICentroCusto)
    ['{430A4209-FCEE-442E-810F-7543AA967E63}']
    function Observers : TList<ICentroCustoObserver>; overload;
    function Observers(observers : TList<ICentroCustoObserver>) : ICentroCustoSubject; overload;
    function AddObserver(centroCusto : ICentroCustoObserver) : ICentroCustoSubject;
    function Contains(centroCusto : ICentroCusto) : Boolean;
    procedure AtualizarObservers(valor : Real);
    function ValorTotal : Real;
  end;

  type IValidacoesCentroCusto = interface
    ['{4C511A77-D845-413D-8B8F-4FD81A573C3F}']
  end;

implementation

end.
