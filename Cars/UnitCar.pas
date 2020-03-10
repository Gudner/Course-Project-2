{$O-} //Отключить оптимизацию, чтобы не мешала отладке
unit UnitCar;
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, UnitBaseClass;

//Описание направлений движения автомобиля
type TDirection = (Horisontal,Vertical);
  //Класс "Автомобиль"
type TCar = class(TBaseClass)
 public
  Target : TPoint; //Место назначения
  Color: TColor;
  Dir:TDirection; //Текущее направление движения
  constructor Create(Color:TColor; Target:TPoint; Current:TPoint);
  procedure Paint(Canvas:TCanvas); override;
  function Move():boolean;override;
end;

//Статистика
var Started,Finished,Moves,Idle:integer;

implementation
uses UnitLucipher;
{ TCar }
const Colors : array [0..4] of TColor = (clGreen,clYellow, clBlue, clRed, clGray);

procedure TCar.Paint(Canvas: TCanvas);
var
  Left,Right,Top,Bottom:integer;
begin
   //Рисуется просто квадратиком нужного цвета
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
   //И нарисовать направление движения
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
   //Нарисовать "цель"
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
    //SetLength(Town[row,column],Length(Town[row,column])+1); //Место для себя
    Inc(TownLength[row,column]);
    Town[row,column][TownLength[row,column]] := self; //Машина в городе
    if row mod 2 = 1
      then Dir := Horisontal
      else Dir := Vertical;
end;


//Математическая функция Sign
function Sign(x:integer):integer;
begin
  if x>0 then Result := 1
  else if x<0 then Result := -1
       else Result := 0;
end;

procedure Error; begin end;

function TCar.Move;
var Direction:boolean; //Направление движения
    L:TLucipher; //Регулирующий светофор
    rL,cL:integer; //Координаты светофора
    rD,cD:integer; //Разница между Target и текущим положением
    Green:boolean; //Разрешено ли движение
    oldrow,oldColumn:integer;
    k:integer;
begin
  Result := true;
  if Moved then exit;

 //Логика поведения автомобиля такова:
 //Если цель достигнута, то исчезнуть.
 if (abs(row - Target.Y)<2) and (abs(column - Target.X)<2) then begin
      Result := false;
      exit;
  end;

  oldRow := row;
  oldColumn := column;

  Result := true;
 //Если тот светофор, в направлении которого автомобиль двигался,
 //закрыт (не разрешает движения), то ничего и не делать
 //Если открыт - то ехать прямо, если это нужно для достижения цели,
 //или повернуть направо или налево, если по текущей координате цель уже достигнута
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
  then Green := true //Поворот на нерегулируемом перекрестке
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
       Green := true; //Такая вот обработка
      end;
  end;

  //Статистика
  if Green
   then inc(Moves)
   else inc(Idle);


  if not Green then exit; //Движение запрещено

  Direction := abs(Target.Y - row) > abs(Target.X - column);
  //Определить направление на цель
  if Direction
  then //Нужно двигаться по вертикали
  begin
      if Dir=Horisontal
       then //Если до этого двигался по горизонтали
          begin
                column := column  + Sign(Target.X - column);
                row := row +  Sign(Target.Y - row);
          end
       else //Если до этого двигался по вертикали
          begin
               row := row + 2 * Sign(Target.Y - row);
          end
  end
  else //Нужно двигаться по горизонтали
  begin
      if (Dir=Horisontal)
        then //Если до этого двигался по горизонтали
          begin
             column := column  + 2*Sign(Target.X - column);
          end
        else //Если до этого двигался по вертикали
          begin
                column := column  + Sign(Target.X - column);
                row := row +  Sign(Target.Y - row);
          end
  end;

      if row mod 2 = 1
        then Dir := Horisontal
        else Dir := Vertical;

   //Переместить себя в новое место города
   //SetLength(Town[row,column],Length(Town[row,column])+1);
   if TownLength[row,column] < ArraySize then
     inc(TownLength[row,column]);
   //Town[row,column][High(Town[row,column])] := self;
   Town[row,column][TownLength[row,column]] := self;
   for k := 1 to TownLength[Oldrow,Oldcolumn] - 1 do
    Town[OldRow,OldColumn][k] := Town[OldRow,OldColumn][k+1];
   k := TownLength[Oldrow,Oldcolumn];
   Town[OldRow,OldColumn][k] := nil; //На всякий случай
   //SetLength(Town[OldRow,OldColumn],Length(Town[OldRow,OldColumn])-1);
   if TownLength[Oldrow,Oldcolumn]>0 then
     dec(TownLength[Oldrow,Oldcolumn]);
   Moved := true;
end;

initialization
//Статистика
Started:=0;
Finished:=0;
Moves:=0;
Idle:=0;


end.
