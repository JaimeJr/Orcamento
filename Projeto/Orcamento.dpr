program Orcamento;

uses
  Vcl.Forms,
  frmPrincipal in 'Telas\frmPrincipal.pas' {Form1},
  uCentroCusto in 'Classes\uCentroCusto.pas',
  uiCentroCusto in 'Interfaces\uiCentroCusto.pas',
  uExcecoes in 'Excecoes\uExcecoes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
