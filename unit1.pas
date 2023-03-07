unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ulazautoupdate;

type

  { TForm1 }

  TForm1 = class(TForm)
    LazAutoUpdate1: TLazAutoUpdate;
    Memo1: TMemo;
    procedure FormActivate(Sender: TObject);
    procedure LazAutoUpdate1DebugEvent(Sender: TObject; lauMethodName,
      lauMessage: string);
    procedure Memo1Change(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

procedure LogiFile(s: string);
var
   f : Textfile;
begin
  ForceDirectories(extractfilepath(paramstr(0)));
  AssignFile(f, extractfilepath(paramstr(0))+'log.txt');
  try
    if FileExists(extractfilepath(paramstr(0))+'log.txt') = False then
      Rewrite(f)
    else
    begin
      Append(f);
    end;
    Writeln(f,'['+FormatDateTime('dd/mm/yy hh:nn',Now())+']:'+ s);
  finally
    CloseFile(f);
  end;
end;

{ TForm1 }

procedure TForm1.LazAutoUpdate1DebugEvent(Sender: TObject; lauMethodName,
  lauMessage: string);
begin
  LogiFile('('+lauMethodName+') - ' + lauMessage);
  Memo1.Lines.Add('('+lauMethodName+') - ' + lauMessage);
end;

procedure TForm1.Memo1Change(Sender: TObject);
begin

end;

procedure TForm1.FormActivate(Sender: TObject);
begin
  LogiFile('activate');
end;

end.

