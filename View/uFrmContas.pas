unit uFrmContas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uControllerConta, uControllerAgxcta;

type
  TFrmContas = class(TForm)
    pnlBotoes: TPanel;
    btnFiltrar: TSpeedButton;
    btnTodos: TSpeedButton;
    btnIncluir: TSpeedButton;
    btnAlterar: TSpeedButton;
    btnExcluir: TSpeedButton;
    btnConsultar: TSpeedButton;
    btnSair: TSpeedButton;
    Panel1: TPanel;
    pnlResumo: TPanel;
    DSMemTabContas: TDataSource;
    MemTabContas: TFDMemTable;
    MemTabContasIDAgencia: TIntegerField;
    MemTabContasdac_agencia: TIntegerField;
    MemTabContasdatacad_agencia: TDateTimeField;
    DBGrid1: TDBGrid;
    MemTabContasAgencia_Conta: TIntegerField;
    MemTabContasNum_Conta: TIntegerField;
    MemTabContasDac_Conta: TStringField;
    MemTabContasCart_Conta: TStringField;
    MemTabContasObs_Conta: TStringField;
    Panel5: TPanel;
    lblTotContas: TLabel;
    label1: TLabel;
    DSMemTabLstAgencia: TDataSource;
    MemTabLstAgencia: TFDMemTable;
    MemTabLstAgenciaIDAgencia: TIntegerField;
    MemTabLstAgenciaAgencia: TStringField;
    procedure FormShow(Sender: TObject);
    procedure MemTabContasAfterOpen(DataSet: TDataSet);
    procedure btnFiltrarClick(Sender: TObject);
    procedure btnTodosClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure memtabcontroller(MemTab : TFDMemTable; ControllerConta : TControllerConta);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmContas: TFrmContas;

implementation

{$R *.dfm}

uses  uEnumerador, uFrmManuContas;

procedure TFrmContas.memtabcontroller(MemTab : TFDMemTable; ControllerConta : TControllerConta);
begin
 ControllerConta.ModelConta.IDConta       := MemTab.fieldbyname('IDConta').asinteger;
 ControllerConta.ModelConta.Num_Conta     := MemTab.fieldbyname('Num_Conta').asinteger;
 ControllerConta.ModelConta.Dac_Conta     := MemTab.fieldbyname('Dac_Conta').Asstring;
 ControllerConta.ModelConta.Cart_Conta    := MemTab.fieldbyname('Cart_Conta').Asstring;
 ControllerConta.ModelConta.Obs_Conta     := MemTab.fieldbyname('Obs_Conta').Asstring;
 ControllerConta.ModelConta.DataCad_Conta := MemTab.fieldbyname('DataCad_Conta').AsDateTime;
end;


procedure TFrmContas.btnAlterarClick(Sender: TObject);
Var
  ControllerConta : TControllerConta;
begin
  //Alterar
  ControllerConta := TControllerConta.Create;
  Try
    //um pouco diferente da tela Agencia
    memtabcontroller(MemTabContas,ControllerConta);

    FrmManuContas         := TFrmManuContas.create(self);
    FrmManuContas.Caption := '[ALTERAR] Formulário de Manutenção - Funções Básicas';
    FrmManuContas.tag     := 2;
    FrmManuContas.carregadados(ControllerConta);

    FrmManuContas.showmodal;
  Finally
    FreeAndNil(ControllerConta);
    FrmManuContas.free;
  End;
end;

procedure TFrmContas.btnConsultarClick(Sender: TObject);
Var
  ControllerConta : TControllerConta;
begin
  //Alterar
  ControllerConta := TControllerConta.Create;
  Try
    memtabcontroller(MemTabContas,ControllerConta);

    FrmManuContas           := TFrmManuContas.create(self);
    FrmManuContas.Caption   := '[CONSULTA] Formulário de Manutenção - Funções Básicas';
    FrmManuContas.Tag       := 3;
    FrmManuContas.carregadados(ControllerConta);

    FrmManuContas.showmodal;
  finally
    FreeAndNil(ControllerConta);
    FrmManuContas.free;
  End;
end;

procedure TFrmContas.btnExcluirClick(Sender: TObject);
var
  ControllerConta   : TControllerConta;
begin
  //Excluir da Lista
  ControllerConta := TControllerConta.Create;
  Try
    ControllerConta.ModelConta.Enumtp     := tpExcluir;
    ControllerConta.Modelconta.IDConta    := MemTabContas.fieldbyname('IDConta').AsInteger;

    If ControllerConta.ModelConta.Persistir then
      messagebox(Application.Handle,'Operação realizada com sucesso!','EXCLUSÃO',mb_ok+MB_SYSTEMMODAL+MB_ICONINFORMATION)
    else
      messagebox(Application.Handle,'Operação cancelada!','EXCLUSÃO',mb_ok+MB_SYSTEMMODAL+MB_ICONWARNING);
    btnTodos.Click;
  Finally
    Freeandnil(ControllerConta);
  End;
end;

procedure TFrmContas.btnFiltrarClick(Sender: TObject);
Var
  ControllerConta   : TControllerConta;
  qryConta          : TFDQuery;
begin
  FrmManuContas         := TFrmManuContas.create(self);
  With FrmManuContas do
  begin
    Caption := '[FILTRAR] Formulário de Manutenção - Funções Básicas';
    tag     := 0;
    showmodal;

    if FrmManuContas.ModalResult = mrok then
    begin
      ControllerConta := TControllerConta.Create;
      qryConta        := TFDQuery.Create(FrmContas);
      Try
        ControllerConta.ModelConta.IDConta       := strtoint(edtCod.Text);
        ControllerConta.ModelConta.Num_Conta     := strtoint(edtNumero.text);
        ControllerConta.ModelConta.Dac_Conta     := edtDig.Text;
        ControllerConta.ModelConta.Cart_Conta    := edtCart.Text;
        ControllerConta.ModelConta.Obs_Conta     := mmObs.Text;
        ControllerConta.ModelConta.DataCad_Conta := dtData.DateTime;

        qryConta := ControllerConta.selecionar(ControllerConta.ModelConta);
        try
          qryConta.FetchAll;
          MemTabContas.Close;
          MemTabContas.Data := qryConta.Data;
        finally
          qryConta.Close;
          FreeAndNil(qryConta);
        end;
      Finally
        FreeAndNil(ControllerConta);
        FreeAndNil(qryConta);
      End;
    end;
    free;
  end;
end;

procedure TFrmContas.btnIncluirClick(Sender: TObject);
begin
  FrmManuContas         := TFrmManuContas.create(self);
  FrmManuContas.Caption := '[INCLUIR] Formulário de Manutenção - Funções Básicas';
  FrmManuContas.tag     := 1;
  FrmManuContas.showmodal;
  FrmManuContas.free;
end;

procedure TFrmContas.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmContas.btnTodosClick(Sender: TObject);
Var
  ControllerConta   : TControllerConta;
  qryConta          : TFDQuery;
begin
  ControllerConta := TControllerConta.Create;
  qryConta        := TFDQuery.Create(FrmContas);
  Try
    qryConta := ControllerConta.selecionar(nil);
    try
      qryConta.FetchAll;
      MemTabContas.Close;
      MemTabContas.Data := qryConta.Data;
      lblTotContas.Caption := inttostr(MemTabContas.RecordCount);
    finally
      qryConta.Close;
      FreeAndNil(qryConta);
    end;
  Finally
    FreeAndNil(ControllerConta);
    FreeAndNil(qryConta);
  End;
end;

procedure TFrmContas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := cafree;
end;

procedure TFrmContas.FormShow(Sender: TObject);
Var
  ControllerLstAgencias : TControllerAgxcta;
  qryLstAgencias        : TFDQuery;
begin
  ControllerLstAgencias := TControllerAgxcta.Create;
  qryLstAgencias        := TFDQuery.Create(FrmManuContas);


  btnAlterar.Enabled  := False;
  btnExcluir.Enabled  := False;
  btnConsultar.Enabled:= False;

  Try
    qryLstAgencias := ControllerLstAgencias.selLstaAgencias;
    try
      qryLstAgencias.FetchAll;
      MemTabLstAgencia.Close;
      MemTabLstAgencia.Data := qryLstAgencias.Data;

      btnFiltrar.Enabled  := qryLstAgencias.RecordCount > 0;
      btnTodos.Enabled    := qryLstAgencias.RecordCount > 0;
      btnConsultar.Enabled:= qryLstAgencias.RecordCount > 0;

      if qryLstAgencias.RecordCount > 0 then
      else begin
        messagebox(Application.Handle,'Não encontrei agência, por favor, cadastre a agência!','ATENÇÃO',mb_ok+MB_SYSTEMMODAL+MB_ICONINFORMATION)

      end;

    finally
      qryLstAgencias.Close;
      FreeAndNil(qryLstAgencias);
    end;
  Finally
    FreeAndNil(ControllerConta);
    FreeAndNil(qryLstAgencias);
  End;
end;


procedure TFrmContas.MemTabContasAfterOpen(DataSet: TDataSet);
begin
  btnAlterar.Enabled  := MemTabContas.RecordCount > 0;
  btnExcluir.Enabled  := MemTabContas.RecordCount > 0;
  btnConsultar.Enabled:= MemTabContas.RecordCount > 0;
end;


end.
