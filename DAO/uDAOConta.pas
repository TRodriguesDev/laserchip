unit uDAOConta;

interface

uses
  FireDAC.Comp.Client, SysUtils, uControllerConn, uModelConta;

Type
  TDAOConta = class
    private
    protected
    public
      function selecionar(ModelConta : TModelConta) : TFDQuery;
      //function selLstaAgencias  : TFDQuery;

      function incluir (ModelConta : TModelConta) : Boolean;
      function excluir (ModelConta : TModelConta) : Boolean;
      function alterar (ModelConta : TModelConta) : Boolean;
  end;


implementation
{ TDAOConta }


function TDAOConta.alterar(ModelConta: TModelConta): Boolean;
var
  qryConta : TFDQuery;
begin
  qryConta := TControllerConn.getInstance().daoConn.novaQuery;
  Try
    try
      qryConta.ExecSQL('UPDATE Contas SET Agencia_Conta = :Agencia_Conta, Num_Conta = :Num_Conta, Dac_Conta = :Dac_Conta, Cart_Conta = :Cart_Conta, Obs_Conta = :Obs_Conta WHERE IDCONTA = :IDCONTA',[ModelConta.Agencia_Conta, ModelConta.Num_Conta, ModelConta.Dac_Conta, ModelConta.Cart_Conta, ModelConta.Obs_Conta, ModelConta.IDConta]);
      result := True;
    except
      result := False;
    end;
  Finally
    qryConta.DisposeOf;
  End;
end;

function TDAOConta.excluir(ModelConta: TModelConta): Boolean;
var
  qryConta : TFDQuery;
begin
  qryConta := TControllerConn.getInstance().daoConn.novaQuery;
  Try
    try
      qryConta.ExecSQL('DELETE FROM Contas WHERE IDConta = :IDConta',[ModelConta.IDConta]);
      result := True;
    except
      result := False;
    end;
  Finally
    qryConta.DisposeOf;
  End;
end;

function TDAOConta.incluir(ModelConta: TModelConta): Boolean;
var
  qryConta : TFDQuery;
begin
  qryConta := TControllerConn.getInstance().daoConn.novaQuery;
  Try
    try
      qryConta.ExecSQL('INSERT INTO Contas (Agencia_Conta, Num_Conta, Dac_Conta, Cart_Conta, Obs_Conta, DataCad_Conta) VALUES (:Agencia_Conta, :Num_Conta, :Dac_Conta, :Cart_Conta, :Obs_Conta, :DataCad_Conta)',[ModelConta.Agencia_Conta, ModelConta.Num_Conta, ModelConta.Dac_Conta, ModelConta.Cart_Conta, ModelConta.Obs_Conta, ModelConta.DataCad_Conta]);
      result := True;
    except
      result := False;
    end;
  Finally
    qryConta.DisposeOf;
  End;
end;

function TDAOConta.selecionar(ModelConta : TModelConta): TFDQuery;
var
  qryConta : TFDQuery;
  vSql     : String;
begin
  vSql := '';
  qryConta := TControllerConn.getInstance().daoConn.novaQuery;
  if ModelConta <> Nil then
  Begin
    qryConta.SQL.Add('SELECT c.*, A.DAC_AGENCIA FROM Contas c INNER JOIN Agencias A ON C.AGENCIA_CONTA = A.IDAGENCIA ');

    if ModelConta.IDConta > 0 then
    Begin
      if vsql = '' then vSql := ' WHERE ' else vsql := ' AND ';
      qryConta.SQL.Add(vsql + 'IDCONTA = ' + inttostr(ModelConta.IDConta));
    end;

    if ModelConta.Agencia_Conta > 0 then
    Begin
      if vsql = '' then vSql := ' WHERE ' else vsql := ' AND ';
      qryConta.SQL.Add(vsql + 'AGENCIA_CONTA = ' + inttostr(ModelConta.Agencia_Conta));
    end;

    if ModelConta.Num_Conta > 0 then
    Begin
      if vsql = '' then vSql := ' WHERE ' else vsql := ' AND ';
      qryConta.SQL.Add(vsql + 'NUM_CONTA = ' + inttostr(ModelConta.Num_Conta));
    end;

    if Trim(ModelConta.dac_Conta) <> '' then
    Begin
      if vsql = '' then vSql := ' WHERE ' else vsql := ' AND ';
      qryConta.SQL.Add(vsql + 'DAC_CONTA = ' + quotedstr(ModelConta.Dac_Conta));
    end;

    if Trim(ModelConta.Cart_Conta) <> '' then
    Begin
      if vsql = '' then vSql := ' WHERE ' else vsql := ' AND ';
      qryConta.SQL.Add(vsql + 'CART_CONTA = ' + quotedstr(ModelConta.CART_Conta));
    end;

    if Trim(ModelConta.Obs_Conta) <> '' then
    Begin
      if vsql = '' then vSql := ' WHERE ' else vsql := ' AND ';
      qryConta.SQL.Add(vsql + 'OBS_CONTA = ' + quotedstr(ModelConta.Obs_Conta));
    end;

    if ModelConta.DataCad_Conta > 0 then
    Begin
      if vsql = '' then vSql := ' WHERE ' else vsql := ' AND ';
      qryConta.SQL.Add(vsql + 'CAST(DATACAD_AGENCIA AS DATE) = :DATA');
      qryConta.ParamByName('DATA').AsDate := ModelConta.DataCad_Conta;
    end;

    qryConta.Open;
  end
  else
    qryConta.Open('SELECT c.*, A.DAC_AGENCIA FROM Contas c INNER JOIN Agencias A ON C.AGENCIA_CONTA = A.IDAGENCIA ');
  Result := qryConta;
end;


end.
