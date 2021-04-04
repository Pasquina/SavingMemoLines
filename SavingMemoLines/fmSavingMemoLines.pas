unit fmSavingMemoLines;

{ MIT License

  Copyright (c) 2021 Milan Vydareny

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in all
  copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE. }

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList, System.IOUtils,
  Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnMan, Vcl.StdCtrls, Vcl.ButtonGroup,
  Vcl.ComCtrls;

type
  TfSavingMemoLines = class(TForm)
    ActionManager1: TActionManager;
    aSaveLines: TAction;
    aSaveStringList: TAction;
    bgMain: TButtonGroup;
    mMain: TMemo;
    aLoadLogFile: TAction;
    sbMain: TStatusBar;
    aDeleteLogFile: TAction;
    procedure aSaveLinesExecute(Sender: TObject);
    procedure aSaveStringListExecute(Sender: TObject);
    procedure aLoadLogFileExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure aDeleteLogFileExecute(Sender: TObject);
  private
    { Private declarations }
    FLogFileName: TFilename;
    FStringListWork: TStringList;
    procedure SetLogFileName(const Value: TFilename);
    procedure SetStringListWork(const Value: TStringList);
    property LogFileName: TFilename read FLogFileName write SetLogFileName;
    property StringListWork: TStringList read FStringListWork write SetStringListWork;
  public
    { Public declarations }
  end;

var
  fSavingMemoLines: TfSavingMemoLines;

implementation

{$R *.dfm}
{ Delete log file function is a convenience. }

procedure TfSavingMemoLines.aDeleteLogFileExecute(Sender: TObject);
begin
  DeleteFile(LogFileName);                                 // delete the current log file if it exists
end;

{ Load the log file back into the memo. This loads the entire log file, not just
  the most recent lines. }

procedure TfSavingMemoLines.aLoadLogFileExecute(Sender: TObject);
var
  LFileStream: TFileStream;                                // to read the lines
begin
  if not FileExists(LogFileName) then                      // test for log already present
    begin
      ShowMessage('There is no current logfile.');         // cannot load if not there
      Exit;
    end;

  LFileStream := TFileStream.Create(LogFileName, fmOpenRead); // prepare to read
  try
    mMain.Lines.LoadFromStream(LFileStream, TEncoding.UTF8); // load the file to the lines
  finally
    LFileStream.Free;                                      // return resources
  end;
end;

{ Saving from TMemo.Lines does not honor the TrailingLineBreak option of
  TStrings. }

procedure TfSavingMemoLines.aSaveLinesExecute(Sender: TObject);
var
  LMode: Word;                                             // in case we need to create the file
  LFileStream: TFileStream;                                // handle the writing
begin
  if not FileExists(LogFileName) then                      // test for file exists
    LMode := fmCreate                                      // not present need to create
  else
    LMode := fmOpenReadWrite;                              // present need to append
  LFileStream := TFileStream.Create(LogFileName, LMode or fmShareDenyWrite); // open log file
  try
    LFileStream.Seek(0, soFromEnd);                        // make sure at the end of the existing file
    mMain.Lines.SaveToStream(LFileStream, TEncoding.UTF8); // add the lines to the end
  finally
    LFileStream.Free;                                      // return resources
  end;
end;

{ This procedure is identical to writing the memo lines in the aSaveLinesExecute procdeure
  with one exception: The line are place in a StringList using an Assign method.
  This causes the Text property of TStringlist to honor the TrailingLineBreak option. }

procedure TfSavingMemoLines.aSaveStringListExecute(Sender: TObject);
var
  LMode: Word;                                             // in case we need to create the file
  LFileStream: TFileStream;                                // handle the writing
begin
  if not FileExists(LogFileName) then                      // test for file exists
    LMode := fmCreate                                      // not present need to create
  else
    LMode := fmOpenReadWrite;                              // present need to append

  { This is the workaround. By assigning the TMemoLines to a StringList we can write
    the lines with an object that honors the TrailingLineBreak option. }

  StringListWork.Assign(mMain.Lines);                      // assign lines to a real StringList

  LFileStream := TFileStream.Create(LogFileName, LMode or fmShareDenyWrite); // prepare to write
  try
    LFileStream.Seek(0, soFromEnd);                        // make sure at the end of the existing file
    StringListWork.SaveToStream(LFileStream, TEncoding.UTF8); // add tdhe lines to the end
  finally
    LFileStream.Free;                                      // return resources
  end;
end;

{ Some initial housekeeping. }

procedure TfSavingMemoLines.FormCreate(Sender: TObject);
begin
  { Note that the log file will be placed in the directory from which the program is executed.
    Normally, this will be a directory in the project and writing will be no problem. If
    your setup is different, you may have to modify this line of code. The full path and
    directory name used is displayed in the program status bar to help you find the file. }

  LogFileName := TPath.Combine(TPath.GetLibraryPath, 'Messages.log'); // determine log file name
  sbMain.SimpleText := LogFileName; // display the full path and name in the status bar
  StringListWork := TStringList.Create; // create the work stringlist
end;

procedure TfSavingMemoLines.FormDestroy(Sender: TObject);
begin
  StringListWork.Free; // free the stringlist
end;

procedure TfSavingMemoLines.SetLogFileName(const Value: TFilename);
begin
  FLogFileName := Value;
end;

procedure TfSavingMemoLines.SetStringListWork(const Value: TStringList);
begin
  FStringListWork := Value;
end;

end.
