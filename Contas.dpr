program Contas;

uses
  Vcl.Forms,
  uPrincipal in 'View\uPrincipal.pas' {FrmPrincipal},
  uFrmAgencias in 'View\uFrmAgencias.pas' {FrmAgencias},
  uFrmContas in 'View\uFrmContas.pas' {FrmContas},
  uFrmManuContas in 'View\uFrmManuContas.pas' {FrmManuContas},
  uFrmManuAgencias in 'View\uFrmManuAgencias.pas' {FrmManuAgencias},
  uModelAgencia in 'Model\uModelAgencia.pas',
  uDAOAgencia in 'DAO\uDAOAgencia.pas',
  uDAOConn in 'DAO\uDAOConn.pas',
  uControllerConn in 'controller\uControllerConn.pas',
  uControllerAgencia in 'controller\uControllerAgencia.pas',
  uEnumerador in 'Model\uEnumerador.pas',
  uValidarClasses in 'Model\uValidarClasses.pas',
  uDAOConta in 'DAO\uDAOConta.pas',
  uModelConta in 'Model\uModelConta.pas',
  uControllerConta in 'controller\uControllerConta.pas',
  uModelAgxcta in 'Model\uModelAgxcta.pas',
  uDAOAgxcta in 'DAO\uDAOAgxcta.pas',
  uControllerAgxcta in 'controller\uControllerAgxcta.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
