unit UnitBaseClass;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls;
//������� �����

type
        TBaseClass = class
        public
             row,column:integer; //���������
             Moved:boolean; //������� "��� �������� �� ���� ����"
             function Move():boolean; virtual; abstract; //��������
             procedure Paint(Canvas:TCanvas); virtual; abstract; //���������
        end;

const TownSize = 21; //������ ������
const ArraySize = 99;
var Town:array[1..TownSize+1,1..TownSize+1] of array[1..ArraySize] of TBaseClass;
var TownLength: array[1..TownSize,1..TownSize] of integer;
//� ������������� ��������� ��������� ��������. �������� ������� �����������, �������


var CellSize : integer = 20; //������ ����� ������
//� ������ �� ������ ����������� ����� �� ���������.
//����������� - ��� ������� ������� � ��������� ������������. ��� ����� ���������.
//� ������ �������� - ���� �� ��������� ������ - ����� ���� ������������ ���������� �����
//� ����������� � ������ ������� ������������ ��� ������, ����� ������ �������

implementation

var r,c:integer;
//��� ������������� ����������� ��� ������
initialization
  for r := 1 to TownSize do
    for c := 1 to TownSize do
      TownLength[r,c]:=0;
end.
