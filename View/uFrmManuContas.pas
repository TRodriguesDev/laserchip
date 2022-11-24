unit uFrmManuContas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Buttons, Vcl.DBCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.NumberBox, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uControllerConta;

type
  TFrmManuContas = class(TForm)
    pnlBotoes: TPanel;
    pnlDados: TPanel;
    pnlGrid: TPanel;
    btnSair: TSpeedButton;
    btnOk: TSpeedButton;
    btnRestaurar: TSpeedButton;
    navConta: TDBNavigator;
    DBGrid1: TDBGrid;
    lblDataCad: TLabel;
    dtData: TDateTimePicker;
    mmObs: TMemo;
    Label5: TLabel;
    edtDig: TLabeledEdit;
    edtCart: TLabeledEdit;
    lcbAgencia: TDBLookupComboBox;
    Label1: TLabel;
    edtNumero: TNumberBox;
    lblNumero: TLabel;
    edtCod: TNumberBox;
    Label2: TLabel;
    Shape1: TShape;
    procedure btnSairClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnRestaurarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure carregadados(ControllerConta : TControllerConta);

    procedure navContaClick(Sender: TObject; Button: TNavigateBtn);
  private
    { Private declarations }
    procedure limparCampos;

  public
    { Public declarations }
  end;

var
  FrmManuContas: TFrmManuContas;
  ControllerConta     : TControllerConta;
  ControllerContaAux  : TControllerConta;

implementation



{$R *.dfm}

uses uEnumerador, uFrmContas;

procedure TFrmManuContas.limparCampos;
begin
  edtCod.Value    := 0;
  dtData.DateTime := now; //Sempre a data atual
  edtNumero.Value := 0;
  edtDig.Text     := '';
  edtCart.Text    := '';
  mmObs.Text      := '';
end;


procedure TFrmManuContas.navContaClick(Sender: TObject; Button: TNavigateBtn);
Var
  ControllerConta : TControllerConta;
begin
  //Alterar
  ControllerConta := TControllerConta.Create;
  Try
    FrmContas.memtabcontroller(FrmContas.MemTabContas, ControllerConta);
    carregadados(ControllerConta);
  Finally
    FreeAndNil(ControllerConta);
  End;
end;

procedure TFrmManuContas.btnOkClick(Sender: TObject);
Begin
  if FrmManuContas.tag in [1,2] then
  begin
    //Grava os dados
    Try
      if FrmManuContas.tag = 1 then
        ControllerConta.ModelConta.Enumtp           := tpIncluir
      else if FrmManuContas.tag = 2 then
        ControllerConta.ModelConta.Enumtp           := tpAlterar;

      //ControllerConta.ModelConta.IDConta        : Autoincrement;
      ControllerConta.ModelConta.Agencia_Conta    :=  lcbAgencia.KeyValue;
      ControllerConta.ModelConta.Num_Conta        :=  strtoint(edtNumero.text);
      ControllerConta.ModelConta.Dac_Conta        :=  edtDig.Text;
      ControllerConta.ModelConta.Cart_Conta       :=  edtCart.Text;
      ControllerConta.ModelConta.Obs_Conta        :=  mmObs.Text;
      ControllerConta.ModelConta.DataCad_Conta    :=  dtData.DateTime;

      If ControllerConta.ModelConta.Persistir then
        messagebox(Application.Handle,'Operação realizada com sucesso!' ,'INCLUIR / ALTERAR',mb_ok+MB_SYSTEMMODAL+MB_ICONINFORMATION)
      else
        messagebox(Application.Handle,Pchar('Operação cancelada!' + #13 + ControllerConta.ModelConta.msgAlerta),'INCLUIR / ALTERAR',mb_ok+MB_SYSTEMMODAL+MB_ICONWARNING);
    Finally
      Freeandnil(ControllerConta);
      btnSair.Click;
    End;
  end
  else if FrmManuContas.tag = 0 then
  begin

    ModalResult := mrok;
    //btnSair.Click;
  end
  else
    btnSair.Click;
end;

procedure TFrmManuContas.btnRestaurarClick(Sender: TObject);
begin
  carregadados(ControllerContaAux);
end;

procedure TFrmManuContas.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmManuContas.carregadados(ControllerConta: TControllerConta);
begin
  edtCod.Value             :=     ControllerConta.ModelConta.IDConta;
  edtNumero.Value          :=     ControllerConta.ModelConta.Num_Conta;
  edtDig.Text              :=     ControllerConta.ModelConta.Dac_Conta;
  edtCart.Text             :=     ControllerConta.ModelConta.Cart_Conta;
  mmObs.Text               :=     ControllerConta.ModelConta.Obs_Conta;
  dtData.DateTime          :=     ControllerConta.ModelConta.DataCad_Conta;
end;

procedure TFrmManuContas.FormCreate(Sender: TObject);
begin
  ControllerConta     := TControllerConta.create;
  ControllerContaAux  := TControllerConta.create;
end;

procedure TFrmManuContas.FormShow(Sender: TObject);
begin
  if tag in [0,1] then limparCampos;

  //Habilita a data de cadastro apenas se a opcao for filtro
  dtData.Enabled        := Tag = 0;
  //Habilita o codigo da coonta apenas se a opcao for filtro
  edtCod.Enabled        := Tag = 0;

  //Restaurar visivel somente para anterar
  btnRestaurar.Visible  := Tag = 2;

  //Navegador visivel, apenas na consulta
  navConta.Visible      := Tag = 3;
end;


end.
