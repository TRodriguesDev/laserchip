unit uControllerConn;

interface

uses SysUtils, uDAOConn;

Type

  TControllerConn = class
    private
      FConn: TDAOConn;

      constructor Create;
      destructor Destroy; Override;
    public
      property daoConn : TDAOConn read FConn write FConn;

      class function getInstance : TControllerConn;

  end;

implementation




var
  instanciaBD : TControllerConn;

{ TControllerConn }

constructor TControllerConn.Create;
begin
  inherited Create;
  FConn := TDAOConn.create;
end;

destructor TControllerConn.Destroy;
begin

  inherited;
  FreeAndNil(FConn);
end;

class function TControllerConn.getInstance: TControllerConn;
begin
  if instanciaBD = nil then
    instanciaBD := TControllerConn.Create;

  Result := instanciaBD;
end;

initialization
  instanciaBD := nil

finalization
  if instanciaBD <> nil then
    instanciaBD.Free;

end.
