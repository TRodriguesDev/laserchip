unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ComCtrls, Vcl.Menus,
  Vcl.ToolWin, Vcl.StdCtrls, FireDAC.Phys.ADSDef, FireDAC.Stan.Intf,
  FireDAC.Phys, FireDAC.Phys.ADS, Data.DB, FireDAC.Phys.MySQLDef,
  FireDAC.Phys.MySQL, frxClass, frxDBSet, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;


type
  TFrmPrincipal = class(TForm)
    StatusBar1: TStatusBar;
    tbMenus: TToolBar;
    tbAtalhos: TToolBar;
    MMenu: TMainMenu;
    Cadastro1: TMenuItem;
    Agencias1: TMenuItem;
    Contas1: TMenuItem;
    N1: TMenuItem;
    Sair1: TMenuItem;
    ToolButton2: TToolButton;
    ToolButton5: TToolButton;
    ToolButton1: TToolButton;
    btnRelatorio: TSpeedButton;
    btnAgencias: TSpeedButton;
    btnContas: TSpeedButton;
    Relatrios1: TMenuItem;
    Contas2: TMenuItem;
    frxRelLstContas: TfrxReport;
    frxDBLstContas: TfrxDBDataset;
    procedure btnAgenciasClick(Sender: TObject);
    procedure btnContasClick(Sender: TObject);
    procedure Agencias1Click(Sender: TObject);
    procedure Contas1Click(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnRelatorioClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

uses UFrmAgencias, UFrmContas, uControllerConn, uControllerAgxcta;

{$R *.dfm}

procedure TFrmPrincipal.Agencias1Click(Sender: TObject);
begin
  FrmAgencias := TFrmAgencias.create(self);
  FrmAgencias.showmodal;
  FrmAgencias.free;
end;

procedure TFrmPrincipal.btnAgenciasClick(Sender: TObject);
begin
  Agencias1.Click;
end;

procedure TFrmPrincipal.btnContasClick(Sender: TObject);
begin
  Contas1.Click;
end;

procedure TFrmPrincipal.btnRelatorioClick(Sender: TObject);
Var
  ControllerAgxcta   : TControllerAgxcta;
  qryRelAgxcta       : TFDQuery;
begin
  ControllerAgxcta := TControllerAgxcta.Create;
  qryRelAgxcta     := TFDQuery.Create(FrmPrincipal);
  Try
    qryRelAgxcta := ControllerAgxcta.selecionaagxcta;
    try
      qryRelAgxcta.FetchAll;

      if qryRelAgxcta.recordcount > 0 then
      Begin
        //frxDBLstContas.Close;
        frxDBLstContas.DataSet := qryRelAgxcta;

        frxRelLstContas.LoadFromFile(ExtractFilePath(Application.ExeName) + 'relatorios\Rel_AgenciasxContas.fr3');
        frxRelLstContas.PrepareReport;
        frxRelLstContas.ShowPreparedReport;
      end
      else
        messagebox(application.Handle,'Não existe dados para imprimir', 'RELATÓRIO', mb_ok+MB_SYSTEMMODAL);
    finally
      qryRelAgxcta.Close;
      FreeAndNil(qryRelAgxcta);
    end;
  Finally
    FreeAndNil(ControllerAgxcta);
    FreeAndNil(qryRelAgxcta);
  End;


end;

procedure TFrmPrincipal.Contas1Click(Sender: TObject);
begin
  FrmContas := TFrmContas.create(self);
  FrmContas.showmodal;
  FrmContas.free;
end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
begin
  Try
    TControllerConn.getInstance().daoConn.getConexao.Connected := True;

    If TControllerConn.getInstance().daoConn.getConexao.Connected then
    else begin
      messagebox(application.Handle,'Impossivel Conectar ao Banco', 'Erro Banco', mb_ok+MB_SYSTEMMODAL);
      Application.Terminate;
    end;

  except on e:exception do
    begin
      messagebox(application.Handle,'Erro Banco',Pchar('Impossivel Conectar ao Banco' + e.message),mb_ok+MB_SYSTEMMODAL);
      Application.Terminate;

    end;

  End;
end;

procedure TFrmPrincipal.Sair1Click(Sender: TObject);
begin
  Application.Terminate;
end;

end.
