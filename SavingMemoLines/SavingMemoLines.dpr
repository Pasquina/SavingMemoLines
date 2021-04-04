program SavingMemoLines;

uses
  Vcl.Forms,
  fmSavingMemoLines in 'fmSavingMemoLines.pas' {fSavingMemoLines};

{$R *.res}

begin

  {$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown := True;
  {$ENDIF DEBUG}

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfSavingMemoLines, fSavingMemoLines);
  Application.Run;
end.
