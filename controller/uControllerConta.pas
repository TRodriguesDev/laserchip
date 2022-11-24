unit uControllerConta;

interface

uses FireDAC.Comp.Client, SysUtils, uModelConta;

Type
  TControllerConta = class
  private
    FModelConta: TModelConta;

    public
      property ModelConta : TModelConta read FModelConta write FModelConta;

      function persistir: Boolean;
      function selecionar(ModelConta : TModelConta): TFDQuery;

      constructor Create;
      destructor destroy; override;
  end;

implementation

{ TControllerConta }

constructor TControllerConta.Create;
begin
  FModelConta := TModelConta.create;
  inherited Create;
end;

destructor TControllerConta.destroy;
begin
  Freeandnil(FModelConta);
  inherited;
end;

function TControllerConta.persistir: Boolean;
begin
  result := FModelConta.persistir;
end;

function TControllerConta.selecionar(ModelConta : TModelConta): TFDQuery;
begin
  result := FModelConta.selecionar(ModelConta);
end;


end.

