program Cars;

uses
  Forms,
  UnitMain in 'UnitMain.pas' {Form1},
  UnitCar in 'UnitCar.pas',
  UnitLucipher in 'UnitLucipher.pas',
  UnitBaseClass in 'UnitBaseClass.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
