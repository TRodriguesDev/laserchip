unit uFrmAgencias;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.Mask, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFrmAgencias = class(TForm)
    pnlBotoes: TPanel;
    btnFiltrar: TSpeedButton;
    btnTodos: TSpeedButton;
    btnIncluir: TSpeedButton;
    btnAlterar: TSpeedButton;
    btnExcluir: TSpeedButton;
    btnConsultar: TSpeedButton;
    btnSair: TSpeedButton;
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    pnlResumo: TPanel;
    MemTabAgencia: TFDMemTable;
    DSMemTabAgencia: TDataSource;
    MemTabAgenciaIDAgencia: TIntegerField;
    MemTabAgenciadac_agencia: TIntegerField;
    MemTabAgencianome_agencia: TStringField;
    MemTabAgenciadatacad_agencia: TDateTimeField;
    Panel5: TPanel;
    lblTotAgencias: TLabel;
    Label11: TLabel;
    Shape1: TShape;
    procedure FrmCads1btnSairClick(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnTodosClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure MemTabAgenciaAfterOpen(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmAgencias: TFrmAgencias;

implementation

{$R *.dfm}

uses uFrmManuAgencias, uControllerAgencia, uEnumerador;

procedure TFrmAgencias.btnAlterarClick(Sender: TObject);
Var
  ControllerAgencia : TControllerAgencia;
begin
  //Alterar
  ControllerAgencia := TControllerAgencia.Create;
  Try
    ControllerAgencia.ModelAgencia.DataCad_Agencia  := MemTabAgencia.fieldbyname('DataCad_Agencia').AsDateTime;
    ControllerAgencia.ModelAgencia.IDAgencia        := MemTabAgencia.fieldbyname('IDAgencia').AsInteger;
    ControllerAgencia.ModelAgencia.Dac_Agencia      := MemTabAgencia.fieldbyname('Dac_Agencia').AsString;
    ControllerAgencia.ModelAgencia.Nome_Agencia     := MemTabAgencia.fieldbyname('Nome_Agencia').AsString;

    FrmManuAgencias         := TFrmManuAgencias.create(self);
    FrmManuAgencias.Caption := '[ALTERAR] Formulário de Manutenção - Funções Básicas';
    FrmManuAgencias.tag     := 2;
    FrmManuAgencias.carregadados(ControllerAgencia);

    FrmManuAgencias.showmodal;
  Finally
    FreeAndNil(ControllerAgencia);
    FrmManuAgencias.free;
  End;


end;

procedure TFrmAgencias.btnConsultarClick(Sender: TObject);
Var
  ControllerAgencia : TControllerAgencia;
begin
  //Alterar
  ControllerAgencia := TControllerAgencia.Create;
  Try
    ControllerAgencia.ModelAgencia.DataCad_Agencia  := MemTabAgencia.fieldbyname('DataCad_Agencia').AsDateTime;
    ControllerAgencia.ModelAgencia.IDAgencia        := MemTabAgencia.fieldbyname('IDAgencia').AsInteger;
    ControllerAgencia.ModelAgencia.Dac_Agencia      := MemTabAgencia.fieldbyname('Dac_Agencia').AsString;
    ControllerAgencia.ModelAgencia.Nome_Agencia     := MemTabAgencia.fieldbyname('Nome_Agencia').AsString;

    FrmManuAgencias           := TFrmManuAgencias.create(self);
    FrmManuAgencias.Caption   := '[CONSULTA] Formulário de Manutenção - Funções Básicas';
    FrmManuAgencias.Tag       := 3;
    FrmManuAgencias.carregadados(ControllerAgencia);

    FrmManuAgencias.showmodal;
  finally
    FreeAndNil(ControllerAgencia);
    FrmManuAgencias.free;
  End;
end;

procedure TFrmAgencias.btnExcluirClick(Sender: TObject);
var
  ControllerAgencia   : TControllerAgencia;
begin
  //Excluir do banco de dados
  If messagebox(application.Handle,PChar('Tem certeza que deseja excluir a agência ' + MemTabAgencia.fieldbyname('Nome_agencia').asstring), 'EXLUIR AGÊNCIA', MB_YESNO+MB_SYSTEMMODAL+MB_ICONQUESTION) = mrno then
  else begin
    ControllerAgencia := TControllerAgencia.Create;
    Try
      ControllerAgencia.ModelAgencia.Enumtp     := tpExcluir;
      ControllerAgencia.ModelAgencia.IDAgencia  := MemTabAgencia.fieldbyname('IDAgencia').AsInteger;

      If ControllerAgencia.ModelAgencia.Persistir then
        messagebox(Application.Handle,'Operação realizada com sucesso!','EXCLUSÃO',mb_ok+MB_SYSTEMMODAL+MB_ICONINFORMATION)
      else
        messagebox(Application.Handle,'Operação cancelada!','EXCLUSÃO',mb_ok+MB_SYSTEMMODAL+MB_ICONWARNING);
      btnTodos.Click;
    Finally
      Freeandnil(ControllerAgencia);
      //btnSair.Click;
    End;
  end;
end;

procedure TFrmAgencias.btnFiltrarClick(Sender: TObject);
Var
  ControllerAgencia   : TControllerAgencia;
  qryAgencia          : TFDQuery;
begin
  FrmManuAgencias         := TFrmManuAgencias.create(self);
  With FrmManuAgencias do
  begin
    Caption := '[FILTRAR] Formulário de Manutenção - Funções Básicas';
    tag     := 0;
    showmodal;

    if FrmManuAgencias.ModalResult = mrok then
    begin
      ControllerAgencia := TControllerAgencia.Create;
      qryAgencia        := TFDQuery.Create(FrmAgencias);
      Try
        ControllerAgencia.ModelAgencia.DataCad_Agencia := dtData.DateTime;
        ControllerAgencia.ModelAgencia.IDAgencia       := strtoint(vartostr(edtagencia.Value));
        ControllerAgencia.ModelAgencia.Dac_Agencia     := edtDig.Text;
        ControllerAgencia.ModelAgencia.Nome_Agencia    := Trim(edtNome.Text);

        qryAgencia := ControllerAgencia.selecionar(ControllerAgencia.ModelAgencia);
        try
          qryAgencia.FetchAll;
          MemTabAgencia.Close;
          MemTabAgencia.Data := qryAgencia.Data;
          lblTotAgencias.Caption := inttostr(MemTabAgencia.RecordCount);
        finally
          qryAgencia.Close;
          FreeAndNil(qryAgencia);
        end;
      Finally
        FreeAndNil(ControllerAgencia);
        FreeAndNil(qryAgencia);
      End;
    end;
    free;
  end;
end;

procedure TFrmAgencias.btnIncluirClick(Sender: TObject);
begin
  FrmManuAgencias         := TFrmManuAgencias.create(self);
  FrmManuAgencias.Caption := '[INCLUIR] Formulário de Manutenção - Funções Básicas';
  FrmManuAgencias.tag     := 1;
  FrmManuAgencias.showmodal;
  FrmManuAgencias.free;
end;

procedure TFrmAgencias.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmAgencias.btnTodosClick(Sender: TObject);
Var
  ControllerAgencia   : TControllerAgencia;
  qryAgencia          : TFDQuery;
begin
  ControllerAgencia := TControllerAgencia.Create;
  qryAgencia        := TFDQuery.Create(FrmAgencias);
  Try
    qryAgencia := ControllerAgencia.selecionar(nil);
    try
      qryAgencia.FetchAll;
      MemTabAgencia.Close;
      MemTabAgencia.Data := qryAgencia.Data;
      lblTotAgencias.Caption := inttostr(MemTabAgencia.RecordCount);
    finally
      qryAgencia.Close;
      FreeAndNil(qryAgencia);
    end;
  Finally
    FreeAndNil(ControllerAgencia);
    FreeAndNil(qryAgencia);
  End;
end;

procedure TFrmAgencias.FormShow(Sender: TObject);
begin
  btnAlterar.Enabled      := False;
  btnExcluir.Enabled      := False;
  btnConsultar.Enabled    := False;
  lblTotAgencias.Caption  := '0';
end;

procedure TFrmAgencias.FrmCads1btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmAgencias.MemTabAgenciaAfterOpen(DataSet: TDataSet);
begin
  btnAlterar.Enabled  := MemTabAgencia.RecordCount > 0;
  btnExcluir.Enabled  := MemTabAgencia.RecordCount > 0;
  btnConsultar.Enabled:= MemTabAgencia.RecordCount > 0;
end;

end.
