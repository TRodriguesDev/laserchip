unit uDAOAgencia;

interface

uses
  uModelAgencia, FireDAC.Comp.Client, SysUtils, uControllerConn, vcl.Dialogs;

Type
  TDAOAgencia = class
    private
    protected
    public
      function selecionar (ModelAgencia : TModelAgencia) : TFDQuery;

      function incluir    (ModelAgencia : TModelAgencia) : Boolean;
      function excluir    (ModelAgencia : TModelAgencia) : Boolean;
      function alterar    (ModelAgencia : TModelAgencia) : Boolean;
  end;


implementation



{ TDAOAgencia }
function TDAOAgencia.alterar(ModelAgencia: TModelAgencia): Boolean;
var
  qryAgencia : TFDQuery;
begin
  qryAgencia := TControllerConn.getInstance().daoConn.novaQuery;
  Try
    try
      qryAgencia.ExecSQL('UPDATE agencias SET Dac_Agencia = :Dac_Agencia, Nome_Agencia = :Nome_Agencia WHERE IDAgencia = :IDAgencia',[ModelAgencia.Dac_Agencia, ModelAgencia.Nome_Agencia, ModelAgencia.IDAgencia]);
      result := True;
    except
      result := False;
    end;
  Finally
    qryAgencia.DisposeOf;
  End;
end;

function TDAOAgencia.excluir(ModelAgencia: TModelAgencia): Boolean;
var
  qryAgencia : TFDQuery;
begin
  qryAgencia := TControllerConn.getInstance().daoConn.novaQuery;
  Try
    try
      qryAgencia.ExecSQL('DELETE FROM agencias WHERE IDAgencia = :IDAgencia',[ModelAgencia.IDAgencia]);
      result := True;
    except
      result := False;
    end;
  Finally
    qryAgencia.DisposeOf;
  End;
end;

function TDAOAgencia.incluir(ModelAgencia: TModelAgencia): Boolean;
var
  qryAgencia : TFDQuery;
begin
  qryAgencia := TControllerConn.getInstance().daoConn.novaQuery;
  Try
    try
      qryAgencia.ExecSQL('INSERT INTO agencias (IDAgencia, Dac_Agencia, Nome_Agencia, DataCad_Agencia) VALUES (:IDAgencia, :Dac_Agencia, :Nome_Agencia, :DataCad_Agencia)',[ModelAgencia.IDAgencia, ModelAgencia.Dac_Agencia, ModelAgencia.Nome_Agencia, ModelAgencia.DataCad_Agencia]);                    result := True;
    except
      result := False;
    end;
  Finally
    qryAgencia.DisposeOf;
  End;
end;

function TDAOAgencia.selecionar(ModelAgencia : TModelAgencia): TFDQuery;
var
  qryAgencia  : TFDQuery;
  vSql        : String;
begin
  vSql := '';
  qryAgencia := TControllerConn.getInstance().daoConn.novaQuery;
  if ModelAgencia <> nil then
  Begin
    qryAgencia.SQL.Add('SELECT * FROM agencias ');
    if ModelAgencia.IDAgencia > 0 then
    Begin
      if vsql = '' then vSql := ' WHERE ' else vsql := ' AND ';
      qryAgencia.SQL.Add(vsql + 'IDAGENCIA = ' + inttostr(ModelAgencia.IDAgencia));
    end;

    if Trim(ModelAgencia.Dac_Agencia) <> '' then
    Begin
      if vsql = '' then vSql := ' WHERE ' else vsql := ' AND ';
      qryAgencia.SQL.Add(vsql + 'DAC_AGENCIA = ' + QuotedStr(ModelAgencia.Dac_Agencia));
    end;

    if Trim(ModelAgencia.Nome_Agencia) <> '' then
    Begin
      if vsql = '' then vSql := ' WHERE ' else vsql := ' AND ';
      qryAgencia.SQL.Add(vsql + 'NOME_AGENCIA LIKE ' + QuotedStr('%'+ModelAgencia.Nome_Agencia+'%'));
    end;

    if ModelAgencia.DataCad_Agencia > 0 then
    Begin
      if vsql = '' then vSql := ' WHERE ' else vsql := ' AND ';
      qryAgencia.SQL.Add(vsql + 'CAST(DATACAD_AGENCIA AS DATE) = :DATA');
      qryAgencia.ParamByName('DATA').AsDate := ModelAgencia.DataCad_Agencia;
      //quotedstr(formatdatetime('mm/dd/yyyy',ModelAgencia.DataCad_Agencia))
    end;

    qryAgencia.open;
  end
  else
    qryAgencia.Open('SELECT * FROM agencias');

  Result := qryAgencia;
end;


end.
