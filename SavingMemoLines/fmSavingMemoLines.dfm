object fSavingMemoLines: TfSavingMemoLines
  Left = 0
  Top = 0
  Caption = 'Saving TMemoLines'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object bgMain: TButtonGroup
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 142
    Height = 274
    Align = alLeft
    ButtonOptions = [gboFullSize, gboShowCaptions]
    Items = <
      item
        Action = aSaveLines
      end
      item
        Action = aSaveStringList
      end
      item
        Action = aLoadLogFile
      end
      item
        Action = aDeleteLogFile
      end>
    TabOrder = 0
    ExplicitHeight = 293
  end
  object mMain: TMemo
    AlignWithMargins = True
    Left = 151
    Top = 3
    Width = 481
    Height = 274
    Align = alClient
    ScrollBars = ssBoth
    TabOrder = 1
    ExplicitHeight = 293
  end
  object sbMain: TStatusBar
    Left = 0
    Top = 280
    Width = 635
    Height = 19
    Panels = <>
    SimplePanel = True
    ExplicitLeft = 144
    ExplicitTop = 296
    ExplicitWidth = 0
  end
  object ActionManager1: TActionManager
    Left = 16
    Top = 224
    StyleName = 'Platform Default'
    object aSaveLines: TAction
      Caption = 'Save From Memo'
      OnExecute = aSaveLinesExecute
    end
    object aSaveStringList: TAction
      Caption = 'Save From StringList'
      OnExecute = aSaveStringListExecute
    end
    object aLoadLogFile: TAction
      Caption = 'Display Current Log File'
      OnExecute = aLoadLogFileExecute
    end
    object aDeleteLogFile: TAction
      Caption = 'Delete Log File'
      OnExecute = aDeleteLogFileExecute
    end
  end
end
