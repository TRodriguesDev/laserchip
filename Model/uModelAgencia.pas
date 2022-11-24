unit uModelAgencia;

interface

uses
  FireDAC.Comp.Client, SysUtils, uControllerConn, uEnumerador, uValidarClasses, vcl.Dialogs;

Type
  TModelAgencia = class
    private
      FConn           : TFDConnection;
      FIDAgencia      : Integer;
      FDac_Agencia    : String;
      FNome_Agencia   : String;
      FDataCad_Agencia: TDateTime;
      FEnumtp         : TEnumerador;
      FmsgAlerta      : wideString;

    public

      property Conn             : TFDConnection read FConn write FConn;

      [TValidador('Código da Agência')]
      property IDAgencia        : Integer read FIDAgencia write FIDAgencia;

      [TValidador('Dígito da Agência')]
      property Dac_Agencia      : String read FDac_Agencia write FDac_Agencia;

      [TValidador('Nome da Agência')]
      property Nome_Agencia     : String read FNome_Agencia write FNome_Agencia;

      [TValidador('Data de Cadastro')]
      property DataCad_Agencia  : TDateTime read FDataCad_Agencia write FDataCad_Agencia;

      property Enumtp           : TEnumerador read FEnumtp write FEnumtp;
      property msgAlerta        : WideString read FmsgAlerta write FmsgAlerta;

      function persistir: Boolean;
      function selecionar(ModelAgencia : TModelAgencia): TFDQuery;

   published

  end;

  implementation

{ TModelAgencia }

uses uDAOAgencia;

function TModelAgencia.persistir: Boolean;
var
  daoAgencia : TDAOAgencia;
begin
  result          := False;
  self.msgAlerta  := '';

  if self.Enumtp <> tpExcluir then
    self.msgAlerta := TValidador.Validar(Self);

  if self.MsgAlerta = '' then
  begin
    daoAgencia := TDAOAgencia.Create;
    try
      case FEnumtp of
        tpIncluir:
          result := daoAgencia.incluir(Self);
        tpExcluir:
          result := daoAgencia.excluir(self);
        tpAlterar:
          result := daoAgencia.alterar(self);
      end;
    finally
      Freeandnil(daoAgencia);
    end;
  end
  else
    showmessage(self.MsgAlerta);
end;

function TModelAgencia.selecionar(ModelAgencia : TModelAgencia): TFDQuery;
var
  daoAgencia : TDAOAgencia;
begin
  daoAgencia := TDAOAgencia.Create;
  Try
    result := daoAgencia.selecionar(ModelAgencia);
  Finally
    Freeandnil(daoAgencia);
  End;
end;


end.
