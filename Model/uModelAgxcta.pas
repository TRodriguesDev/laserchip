unit uModelAgxcta;

interface

uses
  FireDAC.Comp.Client, SysUtils, uControllerConn, uEnumerador, uDAOAgxcta;

Type
  TModelAgxcta = class
    private
      FConn: TFDConnection;
    public
      property Conn             : TFDConnection read FConn write FConn;

      function selecionaagxcta: TFDQuery;
      function selLstaAgencias: TFDQuery;
    published
  end;


implementation

{ TModelAgxcta }

function TModelAgxcta.selecionaagxcta: TFDQuery;
var
  daoAgxcta : TDAOAgxcta;
begin
  daoAgxcta := TDAOAgxcta.Create;
  Try
    result := daoAgxcta.selecionaagxcta;
  Finally
    Freeandnil(daoAgxcta);
  End;
end;

function TModelAgxcta.selLstaAgencias: TFDQuery;
var
  daoAgxcta : TDAOAgxcta;
begin
  daoAgxcta := TDAOAgxcta.Create;
  Try
    result := daoAgxcta.selLstaAgencias;
  Finally
    Freeandnil(daoAgxcta);
  End;
end;


end.
