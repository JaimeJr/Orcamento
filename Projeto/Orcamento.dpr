program Orcamento;

uses
  Vcl.Forms,
  frmPrincipal in 'Telas\frmPrincipal.pas' {Form1},
  uiCentroCusto in 'Interfaces\uiCentroCusto.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
