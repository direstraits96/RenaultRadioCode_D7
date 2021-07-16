{
Original Pyhton Code From: https://github.com/patgo25/RenaultRadioCodes
Delphi 7 Convertion by direstraits96
16-07-2021
}
unit RenaultRadioCalculator;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, XPMan;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    XPManifest1: TXPManifest;
    procedure Button1Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

Function CalculateRenaultCode(Precode:String):String;
var
  A,B,C,D:integer;
  Code:Single;
begin
  if (Length(Precode)>=4) and (Precode[1] in ['A'..'Z','a'..'z']) and (Precode[2] in ['0'..'9']) and (Precode[3] in ['0'..'9']) and (Precode[4] in ['0'..'9']) then
  begin
    Precode:=UpperCase(Precode); //UpperCase All the String
    A:= Ord(Precode[1])*5;
    B:= Ord(Precode[2]) + A*2 -698;
    C:= Ord(Precode[4]) + Ord(Precode[3])*5*2 +b -528;
    D:= ((C Shl 3)-C) Mod 100; //Shift the integer value of C to right by 3 and get the remainder from dividing by 100
    Code:= Int(D/10) + (D Mod 10) *5*2+ ((259 Mod B) Mod 100)*5*5*4;
    //This code Adds zeros(0) before the code depending on the result size
    if(Length(FloatToStr(Code))=4) then
    Result:=FloatToStr(Code);
    if(Length(FloatToStr(Code))=3) then
    Result:='0'+FloatToStr(Code);
    if(Length(FloatToStr(Code))=2) then
    Result:='00'+FloatToStr(Code);
    if(Length(FloatToStr(Code))=1) then
    Result:='000'+FloatToStr(Code);
    end
    else
      Result:='Invalid Precode';
    exit;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
Label1.Caption:=CalculateRenaultCode(Edit1.Text);
end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
Key := UpCase(Key); //Convert To Uppercase
if Key = #13 then //If key is Enter (Return)
  begin
    Key := #0; //No Sound
    Button1.Click; //Emulate Click to Calculate Code
  end;
end;

end.
