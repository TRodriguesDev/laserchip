unit uControllerAgencia;

interface

uses uModelAgencia, SysUtils, FireDAC.Comp.Client;

Type
  TControllerAgencia = class
  private
    FModelAgencia: TModelAgencia;

    public
      property ModelAgencia : TModelAgencia read FModelAgencia write FModelAgencia;

      function persistir  : Boolean;
      function selecionar(ModelAgencia: TModelAgencia): TFDQuery;

      constructor Create;
      destructor destroy; override;
  end;

implementation

{ TControllerAgencia }

constructor TControllerAgencia.Create;
begin
  FModelAgencia := TModelAgencia.create;
  inherited Create;
end;

destructor TControllerAgencia.destroy;
begin
  Freeandnil(FModelAgencia);
  inherited;
end;

function TControllerAgencia.persistir: Boolean;
begin
  result := FModelAgencia.persistir;
end;

function TControllerAgencia.selecionar(ModelAgencia: TModelAgencia): TFDQuery;
begin
  result := FModelAgencia.selecionar(ModelAgencia);
end;


end.
