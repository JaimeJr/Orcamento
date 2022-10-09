unit uExcecoes;

interface
  uses SysUtils;

  type
    ECentroCustoException = class(Exception);
    EValorEmBrancoException = class(ECentroCustoException);
    ECodigoInvalidoException = class(ECentroCustoException);
    ESemCentroCustoException = class(ECentroCustoException);

implementation

end.
