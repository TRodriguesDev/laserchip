unit uFrmCads;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, System.Actions, Vcl.ActnList, Vcl.StdCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids;

type
  TFrmCads = class(TFrame)
    pnlBotoes: TPanel;
    btnFiltrar: TSpeedButton;
    btnTodos: TSpeedButton;
    btnIncluir: TSpeedButton;
    btnAlterar: TSpeedButton;
    btnExcluir: TSpeedButton;
    btnConsultar: TSpeedButton;
    btnSair: TSpeedButton;
    pnlCentro: TPanel;
    PageControl: TPageControl;
    tabFiltrar: TTabSheet;
    pnlFiltro: TPanel;
    tabCad: TTabSheet;
    edtFAgencia: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    edtFNome: TEdit;
    edtFConta: TEdit;
    Label3: TLabel;
    btnFiltra: TSpeedButton;
    pnlResumo: TPanel;
    DBGrid1: TDBGrid;
    procedure btnFiltrarClick(Sender: TObject);
    procedure btnTodosClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TFrmCads.btnAlterarClick(Sender: TObject);
begin
  PageControl.TabIndex  := 1;
  tabCad.TabVisible     := True;
  tabFiltrar.TabVisible := False;
  tabCad.Caption        := 'Alterar Registro';
end;

procedure TFrmCads.btnConsultarClick(Sender: TObject);
begin
  PageControl.TabIndex  := 1;
  tabCad.TabVisible     := True;
  tabFiltrar.TabVisible := False;
  tabCad.Caption        := 'Detalhes do Registro';
end;

procedure TFrmCads.btnFiltrarClick(Sender: TObject);
begin
  PageControl.TabIndex  := 0;
  PageControl.Visible   := True;
  tabCad.TabVisible     := False;
  tabFiltrar.TabVisible := True;
  tabFiltrar.Caption    := 'Filtrar';
  pnlFiltro.Visible     := True;
end;

procedure TFrmCads.btnIncluirClick(Sender: TObject);
begin
  PageControl.TabIndex  := 1;
  tabCad.TabVisible     := True;
  tabFiltrar.TabVisible := False;
  tabCad.Caption        := 'Novo Registro';
end;

procedure TFrmCads.btnTodosClick(Sender: TObject);
begin
  PageControl.TabIndex  := 0;
  tabCad.TabVisible     := False;
  tabFiltrar.TabVisible := True;
  tabFiltrar.Caption    := 'Todos';
  pnlFiltro.Visible     := False;
end;

end.
