unit uModelConta;

interface

uses
  FireDAC.Comp.Client, SysUtils, uControllerConn, uEnumerador, uValidarClasses;

Type
  TModelConta = class
    private
      FConn           : TFDConnection;
      FIDConta        : Integer;
      FAgencia_Conta  : Integer;
      FNum_Conta      : Integer;
      FDac_Conta      : String;
      FCart_Conta     : String;
      FObs_Conta      : String;
      FDataCad_Conta  : TDateTime;
      FEnumtp         : TEnumerador;
      FmsgAlerta      : wideString;
    public

      property Conn             : TFDConnection read FConn write FConn;

      [TValidador('ID Conta')]
      property IDConta        : Integer read FIDConta write FIDConta;

      [TValidador('Agência')]
      property Agencia_Conta        : Integer read FAgencia_Conta write FAgencia_Conta;

      [TValidador('Número da Conta')]
      property Num_Conta        : Integer read FNum_Conta write FNum_Conta;

      [TValidador('Dígito da Conta')]
      property Dac_Conta      : String read FDac_Conta write FDac_Conta;

      //[TValidador('Carteira')]
      property Cart_Conta     : String read FCart_Conta write FCart_Conta;

      //[TValidador('Observações')]
      property Obs_Conta     : String read FObs_Conta write FObs_Conta;

      [TValidador('Data de Cadastro')]
      property DataCad_Conta  : TDateTime read FDataCad_Conta write FDataCad_Conta;

      property Enumtp           : TEnumerador read FEnumtp write FEnumtp;
      property msgAlerta        : WideString read FmsgAlerta write FmsgAlerta;

      function persistir: Boolean;
      function selecionar(ModelConta : TModelConta): TFDQuery;



   published

  end;

  implementation


{ TModelConta }
uses uDAOConta;


function TModelConta.persistir: Boolean;
var
  daoConta : TDAOConta;
begin
  result := False;
  self.msgAlerta  := '';

  if self.Enumtp <> tpExcluir then
    self.msgAlerta := TValidador.Validar(Self);

  if self.MsgAlerta = '' then
  begin
    daoConta := TDAOConta.Create;
    try
      case FEnumtp of
        tpIncluir:
          result := daoConta.incluir(Self);
        tpExcluir:
          result := daoConta.excluir(self);
        tpAlterar:
          result := daoConta.alterar(self);
      end;
    finally
      Freeandnil(daoConta);
    end;
  end;
  //else
    //showmessage(self.MsgAlerta);
end;

function TModelConta.selecionar(ModelConta : TModelConta): TFDQuery;
var
  daoConta : TDAOConta;
begin
  daoConta := TDAOConta.Create;
  Try
    result := daoConta.selecionar(ModelConta);
  Finally
    Freeandnil(daoConta);
  End;
end;

end.
