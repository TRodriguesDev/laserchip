object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 525
  ClientWidth = 634
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  inline FrmCads1: TFrmCads
    Left = 0
    Top = 0
    Width = 634
    Height = 525
    Align = alClient
    TabOrder = 0
    ExplicitLeft = -16
    ExplicitTop = -39
    inherited pnlBotoes: TPanel
      Left = 498
      Height = 525
    end
    inherited pnlCentro: TPanel
      Width = 498
      Height = 525
      inherited pctPrincipal: TPageControl
        Width = 498
        Height = 525
        inherited tabFiltrar: TTabSheet
          ExplicitWidth = 490
          ExplicitHeight = 497
          inherited pnlFiltro: TPanel
            Width = 490
          end
          inherited pnlResumo: TPanel
            Top = 456
            Width = 490
          end
        end
      end
    end
  end
end
