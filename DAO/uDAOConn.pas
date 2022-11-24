unit uDAOConn;

interface

uses FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDac.DApt, Sysutils, FireDAC.Phys.MySQLDef, FireDAC.Phys.MySQL;

Type
  TDAOConn = class
    private
      FConn : TFDConnection;
    public
      function getConexao : TFDConnection;
      function novaQuery  : TFDQuery;

      constructor Create;
      destructor Destroy; Override;

  end;

implementation

{ TDAOConn }

constructor TDAOConn.Create;
begin
  inherited Create;

  FConn := TFDConnection.Create(nil);
  FConn.Params.DriverID := 'MSSQL';
  //FConn.Params.DriverID := 'MYSQL';
  FConn.Params.Database := 'cadastros';
  FConn.Params.UserName := 'sa';
  FConn.Params.Password := 'password';
  //FConn.Params.UserName := 'root';
  //FConn.Params.Password := 'Rod104t@v';
  //FConn.Params.Add('Address=localhost');
  FConn.Params.Add('Address=DESKTOP-BL330UG\SQLEXPRESS');
  FConn.LoginPrompt := False;
end;

destructor TDAOConn.Destroy;
begin
  inherited;
  FreeAndNil(FConn);

end;

function TDAOConn.getConexao: TFDConnection;
begin
  result := FConn;
end;

function TDAOConn.novaQuery: TFDQuery;
Var
  Query : TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  Query.Connection := FConn;
  Result := Query;
end;

end.
