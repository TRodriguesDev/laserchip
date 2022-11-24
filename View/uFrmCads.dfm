object FrmCads: TFrmCads
  Left = 0
  Top = 0
  Width = 650
  Height = 540
  TabOrder = 0
  object pnlBotoes: TPanel
    Left = 514
    Top = 0
    Width = 136
    Height = 540
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 0
    object btnFiltrar: TSpeedButton
      Left = 6
      Top = 31
      Width = 120
      Height = 34
      Caption = '&Filtrar'
      OnClick = btnFiltrarClick
    end
    object btnTodos: TSpeedButton
      Left = 6
      Top = 71
      Width = 120
      Height = 34
      Caption = '&Todos'
      OnClick = btnTodosClick
    end
    object btnIncluir: TSpeedButton
      Left = 6
      Top = 111
      Width = 120
      Height = 34
      Caption = '&Incluir'
      OnClick = btnIncluirClick
    end
    object btnAlterar: TSpeedButton
      Left = 6
      Top = 151
      Width = 120
      Height = 34
      Caption = '&Alterar'
      OnClick = btnAlterarClick
    end
    object btnExcluir: TSpeedButton
      Left = 6
      Top = 191
      Width = 120
      Height = 34
      Caption = '&Excluir'
    end
    object btnConsultar: TSpeedButton
      Left = 6
      Top = 231
      Width = 120
      Height = 34
      Caption = '&Consultar'
      OnClick = btnConsultarClick
    end
    object btnSair: TSpeedButton
      Left = 6
      Top = 497
      Width = 120
      Height = 34
      Caption = '&Sair'
    end
  end
  object pnlCentro: TPanel
    Left = 0
    Top = 0
    Width = 514
    Height = 540
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnlCentro'
    TabOrder = 1
    object PageControl: TPageControl
      Left = 0
      Top = 0
      Width = 514
      Height = 540
      ActivePage = tabFiltrar
      Align = alClient
      TabOrder = 0
      object tabFiltrar: TTabSheet
        Caption = 'tabFiltrar'
        object pnlFiltro: TPanel
          Left = 0
          Top = 0
          Width = 506
          Height = 49
          Align = alTop
          TabOrder = 0
          object Label1: TLabel
            Left = 8
            Top = 1
            Width = 38
            Height = 13
            Caption = 'Agencia'
          end
          object Label2: TLabel
            Left = 93
            Top = 1
            Width = 27
            Height = 13
            Caption = 'Nome'
          end
          object Label3: TLabel
            Left = 309
            Top = 1
            Width = 29
            Height = 13
            Caption = 'Conta'
          end
          object btnFiltra: TSpeedButton
            Left = 472
            Top = 20
            Width = 23
            Height = 22
          end
          object edtFAgencia: TEdit
            Left = 8
            Top = 20
            Width = 80
            Height = 21
            NumbersOnly = True
            TabOrder = 0
            Text = 'edtFAgencia'
          end
          object edtFNome: TEdit
            Left = 93
            Top = 20
            Width = 210
            Height = 21
            TabOrder = 1
            Text = 'Edit1'
          end
          object edtFConta: TEdit
            Left = 309
            Top = 20
            Width = 107
            Height = 21
            NumbersOnly = True
            TabOrder = 2
            Text = 'Edit1'
          end
        end
        object pnlResumo: TPanel
          Left = 0
          Top = 471
          Width = 506
          Height = 41
          Align = alBottom
          BevelOuter = bvNone
          Caption = 'pnlResumo'
          TabOrder = 1
        end
        object DBGrid1: TDBGrid
          Left = 0
          Top = 49
          Width = 506
          Height = 422
          Align = alClient
          TabOrder = 2
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
        end
      end
      object tabCad: TTabSheet
        Caption = 'tabCad'
        ImageIndex = 2
      end
    end
  end
end
