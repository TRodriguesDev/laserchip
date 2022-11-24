unit uDAOAgxcta;

interface

uses
  FireDAC.Comp.Client, SysUtils, uControllerConn;

Type
  TDAOAgxcta = class
    private
    protected
    public
      function selecionaagxcta: TFDQuery;
      function selLstaAgencias  : TFDQuery;
  end;

implementation

{ TDAOAgxcta }

function TDAOAgxcta.selecionaagxcta: TFDQuery;
var
  qryAgxcta : TFDQuery;
Begin
  qryAgxcta := TControllerConn.getInstance().daoConn.novaQuery;
  //MSSQL
  //qryAgencia.Open('SELECT IDAgencia, (CAST(IDAgencia AS VARCHAR(10))+''-''+ DAC_AGENCIA) as AGENCIA FROM agencias  order by 1');
  qryAgxcta.Open('select * from vw_agencias_contas');

  Result := qryAgxcta;
end;

function TDAOAgxcta.selLstaAgencias: TFDQuery;
var
  qryLstAgencias : TFDQuery;
Begin
  qryLstAgencias := TControllerConn.getInstance().daoConn.novaQuery;
  //MSSQL
  //qryAgencia.Open('SELECT IDAgencia, (CAST(IDAgencia AS VARCHAR(10))+''-''+ DAC_AGENCIA) as AGENCIA FROM agencias  order by 1');
  qryLstAgencias.Open('SELECT IDAgencia, CONCAT(CAST(IDAgencia AS CHAR(10)) ,''-'', DAC_AGENCIA) as AGENCIA FROM agencias order by 1');

  Result := qryLstAgencias;
end;

end.
