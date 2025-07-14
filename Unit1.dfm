object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 742
  ClientWidth = 831
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object Splitter1: TSplitter
    Left = 690
    Top = 0
    Width = 5
    Height = 742
    ExplicitLeft = 592
    ExplicitHeight = 620
  end
  object CategoryPanelGroup1: TCategoryPanelGroup
    Left = 0
    Top = 0
    Width = 690
    Height = 742
    VertScrollBar.Tracking = True
    HeaderFont.Charset = DEFAULT_CHARSET
    HeaderFont.Color = clWindowText
    HeaderFont.Height = -12
    HeaderFont.Name = 'Segoe UI'
    HeaderFont.Style = []
    TabOrder = 0
    ExplicitHeight = 741
    object CategoryPanel4: TCategoryPanel
      Top = 529
      Height = 308
      Caption = 'Command Panel'
      TabOrder = 0
      object Label4: TLabel
        Left = 11
        Top = 25
        Width = 79
        Height = 15
        Caption = 'Command line'
      end
      object ComandEdit: TEdit
        Left = 11
        Top = 47
        Width = 622
        Height = 23
        TabOrder = 0
      end
      object Button2: TButton
        Left = 11
        Top = 76
        Width = 158
        Height = 25
        Caption = 'Execute'
        TabOrder = 1
        OnClick = Button2Click
      end
      object StringGrid2: TStringGrid
        Left = 11
        Top = 107
        Width = 655
        Height = 133
        ColCount = 3
        FixedCols = 0
        TabOrder = 2
      end
    end
    object CategoryPanel3: TCategoryPanel
      Top = 396
      Height = 133
      Caption = 'Task Info'
      TabOrder = 1
      object StringGrid1: TStringGrid
        Left = 0
        Top = 0
        Width = 667
        Height = 107
        Align = alClient
        ColCount = 6
        FixedCols = 0
        RowCount = 20
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect, goFixedRowDefAlign]
        PopupMenu = PopupMenu1
        TabOrder = 0
      end
    end
    object CategoryPanel2: TCategoryPanel
      Top = 217
      Height = 179
      Caption = 'Find Files'
      TabOrder = 2
      object Label1: TLabel
        Left = 11
        Top = 27
        Width = 80
        Height = 15
        Caption = 'Selected Folder'
      end
      object Label2: TLabel
        Left = 11
        Top = 77
        Width = 49
        Height = 15
        Caption = 'File Mask'
      end
      object Label3: TLabel
        Left = 241
        Top = 77
        Width = 73
        Height = 15
        Caption = 'Text to Search'
      end
      object Button5: TButton
        Left = 11
        Top = 123
        Width = 209
        Height = 25
        Caption = 'Find Files Task'
        TabOrder = 0
        OnClick = Button5Click
      end
      object Recursive: TCheckBox
        Left = 436
        Top = 98
        Width = 81
        Height = 17
        Caption = 'Recursive'
        Checked = True
        State = cbChecked
        TabOrder = 1
      end
      object SearchTextEdit: TEdit
        Left = 241
        Top = 94
        Width = 189
        Height = 23
        TabOrder = 2
        Text = 'webbrowser'
      end
      object PaternEdit: TEdit
        Left = 11
        Top = 94
        Width = 209
        Height = 23
        TabOrder = 3
        Text = '*.*'
      end
      object PathEdit: TEdit
        Left = 10
        Top = 48
        Width = 345
        Height = 23
        Hint = 'Select Directory'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        Text = 'D:\MyDocuments\Python'
      end
      object Button7: TButton
        Left = 361
        Top = 47
        Width = 38
        Height = 24
        Caption = '....'
        TabOrder = 5
        OnClick = Button7Click
      end
    end
    object CategoryPanel1: TCategoryPanel
      Top = 0
      Height = 217
      Caption = 'Find Sequance in File'
      TabOrder = 3
      object Label5: TLabel
        Left = 275
        Top = 76
        Width = 137
        Height = 15
        Caption = 'Searc Patern as  HexString'
      end
      object Label6: TLabel
        Left = 242
        Top = 166
        Width = 188
        Height = 15
        Caption = 'Divide Paterns with | Character'
      end
      object Button3: TButton
        Left = 523
        Top = 48
        Width = 30
        Height = 21
        Caption = '...'
        TabOrder = 0
        OnClick = Button3Click
      end
      object Button1: TButton
        Left = 10
        Top = 161
        Width = 201
        Height = 25
        Caption = 'Start Search '
        TabOrder = 1
        OnClick = Button1Click
      end
      object LabeledEdit2: TLabeledEdit
        Left = 11
        Top = 93
        Width = 238
        Height = 23
        Hint = 'Divide Paterns with Symbol ||'
        EditLabel.Width = 152
        EditLabel.Height = 15
        EditLabel.Caption = 'Search Patterns as AnsiString'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        Text = 'ABCD|1234|QWER|sdf'
        OnKeyPress = LabeledEdit2KeyPress
      end
      object LabeledEdit1: TLabeledEdit
        Left = 10
        Top = 46
        Width = 507
        Height = 23
        EditLabel.Width = 70
        EditLabel.Height = 15
        EditLabel.Caption = 'File to Search'
        TabOrder = 3
        Text = ''
      end
      object Edit1: TEdit
        Left = 272
        Top = 93
        Width = 321
        Height = 23
        TabOrder = 4
        Text = 'AAAB1247B2|ABC2F3'
        OnKeyPress = Edit1KeyPress
      end
      object RadioGroup1: TRadioGroup
        Left = 11
        Top = 122
        Width = 518
        Height = 33
        Columns = 2
        ItemIndex = 1
        Items.Strings = (
          'AnsiString'
          'HexString')
        TabOrder = 5
      end
    end
  end
  object Panel1: TPanel
    Left = 695
    Top = 0
    Width = 136
    Height = 742
    Align = alClient
    Caption = 'Panel1'
    TabOrder = 1
    ExplicitWidth = 132
    ExplicitHeight = 741
    object Memo1: TMemo
      Left = 1
      Top = 26
      Width = 134
      Height = 715
      Align = alClient
      Lines.Strings = (
        '')
      TabOrder = 0
      ExplicitWidth = 130
      ExplicitHeight = 714
    end
    object Button6: TButton
      Left = 1
      Top = 1
      Width = 134
      Height = 25
      Align = alTop
      Caption = 'Clear LOG'
      TabOrder = 1
      OnClick = Button6Click
      ExplicitWidth = 130
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 664
    Top = 216
  end
  object PopupMenu1: TPopupMenu
    Left = 584
    Top = 152
    object Caption1: TMenuItem
      Caption = 'Cancel'
      OnClick = Caption1Click
    end
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 608
    Top = 200
  end
end
