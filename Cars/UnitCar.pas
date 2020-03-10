{$O-} //��������� �����������, ����� �� ������ �������
unit UnitCar;
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, UnitBaseClass;

//�������� ����������� �������� ����������
type TDirection = (Horisontal,Vertical);
  //����� "����������"
type TCar = class(TBaseClass)
 public
  Target : TPoint; //����� ����������
  Color: TColor;
  Dir:TDirection; //������� ����������� ��������
  constructor Create(Color:TColor; Target:TPoint; Current:TPoint);
  procedure Paint(Canvas:TCanvas); override;
  function Move():boolean;override;
end;

//����������
var Started,Finished,Moves,Idle:integer;

implementation
uses UnitLucipher;
{ TCar }
const Colors : array [0..4] of TColor = (clGreen,clYellow, clBlue, clRed, clGray);

procedure TCar.Paint(Canvas: TCanvas);
var
  Left,Right,Top,Bottom:integer;
begin
   //�������� ������ ����������� ������� �����
   Left := column * CellSize;
   Right := Left + CellSize;
   Top := row * CellSize;
   Bottom := Top + CellSize;
   Canvas.Pen.Color := clBlack;
   Canvas.Pen.Width := 1;

   //Canvas.Brush.Color := Color;
   if TownLength[row,column] > 4 then
     Canvas.Brush.Color := Colors[4]
   else
     Canvas.Brush.Color := Colors[(TownLength[row,column]+4) mod 5];

   Canvas.Rectangle(Left+2,Top+2,Right-2,Bottom-2);
   //� ���������� ����������� ��������
   if Dir = Horisontal then
    begin
      Canvas.MoveTo(Left,Top+CellSize div 2);
      Canvas.LineTo(Right,Top+CellSize div 2);
    end
   else
    begin
      Canvas.MoveTo(Left+CellSize div 2,Top);
      Canvas.LineTo(Left+CellSize div 2,Bottom);
    end;
   //���������� "����"
   Canvas.Pen.Color := Canvas.Brush.Color;
   Canvas.Ellipse(Target.X * CellSize -2,Target.Y * CellSize -2, Target.X * CellSize +2,Target.Y * CellSize + +2);

   if TownLength[row,column] >= 5 then
     Canvas.TextOut(Left+4,Top+4,IntToStr(TownLength[row,column]));

end;

constructor TCar.Create(Color: TColor; Target, Current: TPoint);
begin
    self.Color := Color;
    self.Target := Target;
    row := Current.Y;
    column := Current.X;
    //SetLength(Town[row,column],Length(Town[row,column])+1); //����� ��� ����
    Inc(TownLength[row,column]);
    Town[row,column][TownLength[row,column]] := self; //������ � ������
    if row mod 2 = 1
      then Dir := Horisontal
      else Dir := Vertical;
end;


//�������������� ������� Sign
function Sign(x:integer):integer;
begin
  if x>0 then Result := 1
  else if x<0 then Result := -1
       else Result := 0;
end;

procedure Error; begin end;

function TCar.Move;
var Direction:boolean; //����������� ��������
    L:TLucipher; //������������ ��������
    rL,cL:integer; //���������� ���������
    rD,cD:integer; //������� ����� Target � ������� ����������
    Green:boolean; //��������� �� ��������
    oldrow,oldColumn:integer;
    k:integer;
begin
  Result := true;
  if Moved then exit;

 //������ ��������� ���������� ������:
 //���� ���� ����������, �� ���������.
 if (abs(row - Target.Y)<2) and (abs(column - Target.X)<2) then begin
      Result := false;
      exit;
  end;

  oldRow := row;
  oldColumn := column;

  Result := true;
 //���� ��� ��������, � ����������� �������� ���������� ��������,
 //������ (�� ��������� ��������), �� ������ � �� ������
 //���� ������ - �� ����� �����, ���� ��� ����� ��� ���������� ����,
 //��� ��������� ������� ��� ������, ���� �� ������� ���������� ���� ��� ����������
  rL := row; cL := column;
 case Dir of
   Horisontal:
    if Target.X < column
     then dec(cL)
     else inc(cL);
   Vertical:
    if Target.Y < row
     then dec(rL)
     else inc(rL);
 end;


 if (cl<1) or (cl>TownSize) or (rl<1) or (rl>TownSize)
  then Green := true //������� �� �������������� �����������
  else
  begin
    if Town[rL,cL][1]<>nil then
     begin
      Green := TLucipher(Town[rL,cL][1]).Direction;
      if Dir=Vertical
         then Green := not Green;
     end
      else
      begin
       Error;
       Green := true; //����� ��� ���������
      end;
  end;

  //����������
  if Green
   then inc(Moves)
   else inc(Idle);


  if not Green then exit; //�������� ���������

  Direction := abs(Target.Y - row) > abs(Target.X - column);
  //���������� ����������� �� ����
  if Direction
  then //����� ��������� �� ���������
  begin
      if Dir=Horisontal
       then //���� �� ����� �������� �� �����������
          begin
                column := column  + Sign(Target.X - column);
                row := row +  Sign(Target.Y - row);
          end
       else //���� �� ����� �������� �� ���������
          begin
               row := row + 2 * Sign(Target.Y - row);
          end
  end
  else //����� ��������� �� �����������
  begin
      if (Dir=Horisontal)
        then //���� �� ����� �������� �� �����������
          begin
             column := column  + 2*Sign(Target.X - column);
          end
        else //���� �� ����� �������� �� ���������
          begin
                column := column  + Sign(Target.X - column);
                row := row +  Sign(Target.Y - row);
          end
  end;

      if row mod 2 = 1
        then Dir := Horisontal
        else Dir := Vertical;

   //����������� ���� � ����� ����� ������
   //SetLength(Town[row,column],Length(Town[row,column])+1);
   if TownLength[row,column] < ArraySize then
     inc(TownLength[row,column]);
   //Town[row,column][High(Town[row,column])] := self;
   Town[row,column][TownLength[row,column]] := self;
   for k := 1 to TownLength[Oldrow,Oldcolumn] - 1 do
    Town[OldRow,OldColumn][k] := Town[OldRow,OldColumn][k+1];
   k := TownLength[Oldrow,Oldcolumn];
   Town[OldRow,OldColumn][k] := nil; //�� ������ ������
   //SetLength(Town[OldRow,OldColumn],Length(Town[OldRow,OldColumn])-1);
   if TownLength[Oldrow,Oldcolumn]>0 then
     dec(TownLength[Oldrow,Oldcolumn]);
   Moved := true;
end;

initialization
//����������
Started:=0;
Finished:=0;
Moves:=0;
Idle:=0;


end.
