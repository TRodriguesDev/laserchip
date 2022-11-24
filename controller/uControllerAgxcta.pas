unit uControllerAgxcta;

interface

uses FireDAC.Comp.Client, SysUtils, uModelAgxcta;

Type
  TControllerAgxcta = class
  private
    FModelAgxcta: TModelAgxcta;

    public
      property ModelAgxcta : TModelAgxcta read FModelAgxcta write FModelAgxcta;

      function selecionaagxcta: TFDQuery;
      function selLstaAgencias: TFDQuery;


      constructor Create;
      destructor destroy; override;
  end;

implementation

{ TControllerAgxcta }

constructor TControllerAgxcta.Create;
begin
  FModelAgxcta := TModelAgxcta.create;
  inherited;
end;

destructor TControllerAgxcta.destroy;
begin
  FreeAndNil(FModelAgxcta);
  inherited;
end;

function TControllerAgxcta.selecionaagxcta: TFDQuery;
begin
  result := FModelAgxcta.selecionaagxcta;
end;

function TControllerAgxcta.selLstaAgencias: TFDQuery;
begin
  result := FModelAgxcta.selLstaAgencias;
end;

end.
