unit UnitBaseClass;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls;
//Базовый класс

type
        TBaseClass = class
        public
             row,column:integer; //Положение
             Moved:boolean; //Признак "уже двигался на этом шаге"
             function Move():boolean; virtual; abstract; //Движение
             procedure Paint(Canvas:TCanvas); virtual; abstract; //Рисование
        end;

const TownSize = 21; //Размер города
const ArraySize = 99;
var Town:array[1..TownSize+1,1..TownSize+1] of array[1..ArraySize] of TBaseClass;
var TownLength: array[1..TownSize,1..TownSize] of integer;
//С динамическими массивами постоянно зависает. Пришлось сделать статический, большой


var CellSize : integer = 20; //Размер одной клетки
//В городе на каждом перекрестке стоит по светофору.
//перекресток - это элемент матрицы с нечетными координатами. Там будут светофоры.
//в каждом квартале - одна из координат четная - может быть произвольное количество машин
//в координатах о обеими четными координатами нет никого, кроме мирных жителей

implementation

var r,c:integer;
//При инициализации выполняется эта секция
initialization
  for r := 1 to TownSize do
    for c := 1 to TownSize do
      TownLength[r,c]:=0;
end.
