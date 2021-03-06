{$O-}
unit UnitMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, UnitBaseClass, UnitCar, UnitLucipher, StdCtrls;

type
  TForm1 = class(TForm)
    PaintBox1: TPaintBox;
    CheckBox: TCheckBox;
    Timer1: TTimer;
    CheckBoxFar: TCheckBox;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    LabelFinished: TLabel;
    LabelIdle: TLabel;
    LabelMove: TLabel;
    LabelCurrent: TLabel;
    LabelStarted: TLabel;
    ComboBoxN: TComboBox;
    Label11: TLabel;
    Label12: TLabel;
    ComboBox1: TComboBox;
    Timer2: TTimer;
    procedure PaintBox1Paint(Sender: TObject);
    procedure CheckBoxClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

var Single:boolean = false;
var Rate:integer = 0;
var StartRate:integer = 1;

{$R *.dfm}

procedure TForm1.CheckBoxClick(Sender: TObject);
begin
  timer1.Enabled := CheckBox.Checked;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  StartRate := ComboBox1.ItemIndex+1;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 DoubleBuffered := true;
end;

var InPaint:boolean = false;

procedure Error(); begin

end;

procedure TForm1.PaintBox1Paint(Sender: TObject);
var r,c:integer;
begin
  if InPaint then exit;
  InPaint := true;

  CellSize := PaintBox1.Width;
  if PaintBox1.Height < CellSize then CellSize := PaintBox1.Height;
  dec(CellSize,20);
  CellSize := CellSize div TownSize;
  for r := 1 to TownSize do
   for c := 1 to TownSize do
    if TownLength[r,c]>0 then
     if assigned(Town[r,c][1]) then
        Town[r,c][1].Paint(PaintBox1.Canvas)
     else
        Error();

  Application.ProcessMessages; //���� ������ ��������
  InPaint := false;
end;

procedure Remove(row,col:integer);
var k:integer;
    N:integer;
    T:TBaseClass;
begin
   N := TownLength[row,col];
   if N=0 then exit;
   T := Town[row,col][1];
   for k := 1 to N-1 do
     Town[row,col][k] := Town[row,col][k+1];
   Town[row,col][N] := nil;
   //SetLength(Town[row,col],N-1);
   if TownLength[row,col]>0 then
     dec(TownLength[row,col]);
   T.Free;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var C:TCar;
const Colors : array [0..4] of TColor = (clGreen,clYellow, clBlue, clRed, clGray);
var
 Target,Current:TPoint;
 col,row:integer;
 k:integer;
begin
 if InPaint then exit; //����� ����������, ��� ���������

 //�� ������ ��� �������
 //���� ������� "������ ���� ������" �� ���������� ������ ���� ������
 //���� ��� - �� �� ������ ���� �����

 dec(Rate);
 if Rate <=0 then begin
   Rate := StartRate;
   Single := ComboBoxN.ItemIndex = 0;
 end;

 if not Single then
 for k:=0 to ComboBoxN.ItemIndex-1 do
 begin
 //�������� ���� (��� ���������) ��������� �����������
  //��������� ����
  repeat
    Target.X := random(TownSize)+1;
    Target.Y := random(TownSize)+1;
  //���� �� ����� ����� ���� ������
  until
   (Target.X mod 2 = 0) and (Target.Y mod 2 = 1)
    or
   (Target.X mod 2 = 1) and (Target.Y mod 2 = 0)
  ;
  //��������� ��������� ���������
  repeat
    Current.X := random(TownSize)+1;
    Current.Y := random(TownSize)+1;
  until
   (Current.X mod 2 = 0) and (Current.Y mod 2 = 1)
    or
   (Current.X mod 2 = 1) and (Current.Y mod 2 = 0)
  ;
  if CheckBoxFar.Checked then begin
  //������� ���, ����� ����� �������� �����. ���� - ����������� ������
     while Current.X > 2 do dec(Current.X,2);
     while Current.Y > 2 do dec(Current.Y,2);
     while Target.X < TownSize - 2 do inc(Target.X,2);
     while Target.Y < TownSize - 2 do inc(Target.Y,2);
  end;

    //���������������� � ������ ��������������
    C := TCar.Create(Colors[random(Length(Colors))],Target,Current);
    Single := true;
    inc(Started);
 end;

  for row := 1 to TownSize do //��� ���� ���������
    for col := 1 to TownSize do
     if TownLength[row,col]>0 then //���� ���� ��� ���
       if Town[row,col][1] <> nil then
        Town[row,col][1].Moved := false;

 //��������� ��� ��� ������� �� "���������" ������
  for row := 1 to TownSize do //��� ���� ���������
    for col := 1 to TownSize do
     if TownLength[row,col]>0 then //���� ���� ��� ���
       if Town[row,col][1] <> nil then
        if not Town[row,col][1].Move //�� ������� ���
        then
          begin
            Remove(row,col); //���� �� ������� - �� ����� � ��������
            inc(Finished);
            Single := false;
          end;

 //������� �����������
 PaintBox1.Repaint;
end;


procedure TForm1.Timer2Timer(Sender: TObject);
begin
 //�������� ����������
 LabelStarted.Caption := '������� '+IntToStr(Started);
 LabelFinished.Caption := '�������� '+IntToStr(Finished);
 LabelCurrent.Caption := '� ������ '+IntToStr(Started - Finished);
 if Moves+Idle > 0 then
 begin
   LabelMove.Caption := '�������� '+IntToStr(Moves)+' ('+FloatToStrF(100.0*Moves/(Moves+Idle),ffFixed,10,1)+'%)';
   LabelIdle.Caption := '�������� '+IntToStr(Idle)+' ('+FloatToStrF(100.0*Idle/(Moves+Idle),ffFixed,10,1)+'%)';
 end;
end;

end.
