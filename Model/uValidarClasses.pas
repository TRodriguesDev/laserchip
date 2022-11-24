unit uValidarClasses;

interface

uses Vcl.Dialogs, System.Variants, System.Rtti, System.SysUtils, System.TypInfo;

Type
  TValidador = class(TCustomAttribute)
    private
      FDescricao: String;
    public
      constructor Create(const Descricao: string);
      property Descricao: string read FDescricao;

      class function Validar(Objeto: TObject) : WideString;
  end;


implementation

{ TValidador }

constructor TValidador.Create(const Descricao: string);
begin
  FDescricao := Descricao;
end;

class function TValidador.Validar(Objeto: TObject): WideString;
var
  Contexto    : TRttiContext;
  Tipo        : TRttiType;
  Propriedade : TRttiProperty;
  Atributo    : TCustomAttribute;
  msgAlerta   : WideString;
  Valor       : variant;
begin
  Contexto := TRttiContext.Create;

  Tipo := Contexto.GetType(Objeto.ClassInfo);

  MsgAlerta := '';

  for Propriedade in Tipo.GetProperties do
  begin
    for Atributo in Propriedade.GetAttributes do
    begin
      if Atributo is TValidador then
      begin
        Valor := Propriedade.GetValue(Objeto).AsVariant;
        if not (VarToStr(Valor) <> EmptyStr) and (VartoStr(Valor) <> '0') then
        begin
          if MsgAlerta = '' then
            MsgAlerta  := 'Valor não preenchido:' + #13#10;

          MsgAlerta  := MsgAlerta + (Atributo as TValidador).Descricao + #13#10;
        end;
      end;
    end;

  end;

  result := msgAlerta;

end;

end.
