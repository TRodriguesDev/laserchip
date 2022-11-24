unit uFrmManuAgencias;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Buttons, Vcl.DBCtrls,
  Vcl.StdCtrls, Vcl.ComCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, uControllerAgencia,
  Vcl.NumberBox;

type
  TFrmManuAgencias = class(TForm)
    pnlBotoes: TPanel;
    pnlDados: TPanel;
    pnlGrid: TPanel;
    btnSair: TSpeedButton;
    btnOk: TSpeedButton;
    btnRestaurar: TSpeedButton;
    navAgencia: TDBNavigator;
    dtData: TDateTimePicker;
    lblDataCad: TLabel;
    DBGrid1: TDBGrid;
    edtNome: TLabeledEdit;
    edtDig: TLabeledEdit;
    edtAgencia: TNumberBox;
    Label1: TLabel;
    Shape1: TShape;
    procedure btnRestaurarClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure limparCampos;
    procedure carregadados(ControllerAgencia : TControllerAgencia);
    procedure FormCreate(Sender: TObject);
    procedure navAgenciaClick(Sender: TObject; Button: TNavigateBtn);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  {Tag = 0 : Filtrar, 1 : Incluir, 2 : Alterar, 3 : Consultar}
  FrmManuAgencias       : TFrmManuAgencias;
  ControllerAgencia     : TControllerAgencia;
  ControllerAgenciaAux  : TControllerAgencia;

implementation

{$R *.dfm}

uses   uEnumerador, uFrmAgencias;

procedure TFrmManuAgencias.limparCampos;
begin
  dtData.DateTime := now;
  edtAgencia.Value:= 0;
  edtDig.Text     := '';
  edtNome.Text    := '';
end;


procedure TFrmManuAgencias.navAgenciaClick(Sender: TObject;
  Button: TNavigateBtn);
Var
  ControllerAgencia : TControllerAgencia;
begin
  ControllerAgencia := TControllerAgencia.Create;
  Try
    ControllerAgencia.ModelAgencia.DataCad_Agencia  := FrmAgencias.MemTabAgencia.fieldbyname('DataCad_Agencia').AsDateTime;
    ControllerAgencia.ModelAgencia.IDAgencia        := FrmAgencias.MemTabAgencia.fieldbyname('IDAgencia').AsInteger;
    ControllerAgencia.ModelAgencia.Dac_Agencia      := FrmAgencias.MemTabAgencia.fieldbyname('Dac_Agencia').AsString;
    ControllerAgencia.ModelAgencia.Nome_Agencia     := FrmAgencias.MemTabAgencia.fieldbyname('Nome_Agencia').AsString;

    FrmManuAgencias.carregadados(ControllerAgencia);
  Finally
    FreeAndNil(ControllerAgencia);
  End;
end;

procedure TFrmManuAgencias.btnOkClick(Sender: TObject);
begin

  if FrmManuAgencias.tag in [1,2] then
  begin
    //Grava os dados
    Try
      if FrmManuAgencias.tag = 1 then
        ControllerAgencia.ModelAgencia.Enumtp           := tpIncluir
      else if FrmManuAgencias.tag = 2 then
        ControllerAgencia.ModelAgencia.Enumtp           := tpAlterar;

      ControllerAgencia.ModelAgencia.IDAgencia          := strtoint(vartostr(edtagencia.Value));
      ControllerAgencia.ModelAgencia.Dac_Agencia        := edtDig.text;
      ControllerAgencia.ModelAgencia.Nome_Agencia       := edtNome.text;
      ControllerAgencia.ModelAgencia.DataCad_Agencia    := Now;



      If ControllerAgencia.ModelAgencia.persistir then
        messagebox(Application.Handle,'Operação realizada com sucesso!','INCLUIR / ALTERAR',mb_ok+MB_SYSTEMMODAL+MB_ICONINFORMATION)
      else
        messagebox(Application.Handle,'Operação cancelada!','INCLUIR / ALTERAR',mb_ok+MB_SYSTEMMODAL+MB_ICONWARNING);



    Finally
      Freeandnil(ControllerAgencia);
      btnSair.Click;
    End;
  end
  else if FrmManuAgencias.tag = 0 then
  begin

    ModalResult := mrok;

  end
  else
    btnSair.Click;
end;

procedure TFrmManuAgencias.btnRestaurarClick(Sender: TObject);
begin
  carregadados(ControllerAgenciaAux);
end;

procedure TFrmManuAgencias.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmManuAgencias.carregadados(ControllerAgencia: TControllerAgencia);
begin
  dtData.DateTime   := ControllerAgencia.ModelAgencia.DataCad_Agencia;
  edtAgencia.Text   := inttostr(ControllerAgencia.ModelAgencia.IDAgencia);
  edtDig.Text       := ControllerAgencia.ModelAgencia.Dac_Agencia;
  edtNome.Text      := ControllerAgencia.ModelAgencia.Nome_Agencia;
  ControllerAgenciaAux := ControllerAgencia;
end;

procedure TFrmManuAgencias.FormCreate(Sender: TObject);
begin
  ControllerAgencia     := TControllerAgencia.create;
  ControllerAgenciaAux  := TControllerAgencia.create;
end;

procedure TFrmManuAgencias.FormShow(Sender: TObject);
begin
  if tag in [0,1] then limparCampos;

  dtData.Enabled       := Tag = 0;
  btnRestaurar.Visible := Tag = 2;
  navAgencia.Visible   := Tag = 3;
end;


end.
