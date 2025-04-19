unit UserDefPas;

{$MODE Delphi}

interface

uses
   Classes, SysUtils, ShipModulePas;

type
   TUserDef = class(TWpnShipModule)
   private
      fItem1Num : Integer;
      fItem1Size : Extended;
      fItem1Desc : String;
      fItem1Crew : Integer;
      fItem1Ep : Extended;
      fItem1Cost : Extended;
      fItem1Hp : Integer;
      fItem2Num : Integer;
      fItem2Size : Extended;
      fItem2Desc : String;
      fItem2Crew : Integer;
      fItem2Ep : Extended;
      fItem2Cost : Extended;
      fItem2Hp : Integer;
      fItem3Num : Integer;
      fItem3Size : Extended;
      fItem3Desc : String;
      fItem3Crew : Integer;
      fItem3Ep : Extended;
      fItem3Cost : Extended;
      fItem3Hp : Integer;
      fItem4Num : Integer;
      fItem4Size : Extended;
      fItem4Desc : String;
      fItem4Crew : Integer;
      fItem4Ep : Extended;
      fItem4Cost : Extended;
      fItem4Hp : Integer;
      fItem5Num : Integer;
      fItem5Size : Extended;
      fItem5Desc : String;
      fItem5Crew : Integer;
      fItem5Ep : Extended;
      fItem5Cost : Extended;
      fItem5Hp : Integer;
      fItem6Num : Integer;
      fItem6Size : Extended;
      fItem6Desc : String;
      fItem6Crew : Integer;
      fItem6Ep : Extended;
      fItem6Cost : Extended;
      fItem6Hp : Integer;
      fItem7Num : Integer;
      fItem7Size : Extended;
      fItem7Desc : String;
      fItem7Crew : Integer;
      fItem7Ep : Extended;
      fItem7Cost : Extended;
      fItem7Hp : Integer;
      fItem8Num : Integer;
      fItem8Size : Extended;
      fItem8Desc : String;
      fItem8Crew : Integer;
      fItem8Ep : Extended;
      fItem8Cost : Extended;
      fItem8Hp : Integer;
      procedure CalcHardPoints;
   public
      procedure CalcCrew;
      procedure CalcPower;
      function UserDefCost : Extended;
      function UserDefSpace : Extended;
      property Item1Num : Integer read fItem1Num write fItem1Num;
      property Item1Size : Extended read fItem1Size write fItem1Size;
      property Item1Desc : String read fItem1Desc write fItem1Desc;
      property Item1Crew : Integer read fItem1Crew write fItem1Crew;
      property Item1Ep : Extended read fItem1Ep write fItem1Ep;
      property Item1Cost : Extended read fItem1Cost write fItem1Cost;
      property Item1Hp : Integer read fItem1Hp write fItem1Hp;
      property Item2Num : Integer read fItem2Num write fItem2Num;
      property Item2Size : Extended read fItem2Size write fItem2Size;
      property Item2Desc : String read fItem2Desc write fItem2Desc;
      property Item2Crew : Integer read fItem2Crew write fItem2Crew;
      property Item2Ep : Extended read fItem2Ep write fItem2Ep;
      property Item2Cost : Extended read fItem2Cost write fItem2Cost;
      property Item2Hp : Integer read fItem2Hp write fItem2Hp;
      property Item3Num : Integer read fItem3Num write fItem3Num;
      property Item3Size : Extended read fItem3Size write fItem3Size;
      property Item3Desc : String read fItem3Desc write fItem3Desc;
      property Item3Crew : Integer read fItem3Crew write fItem3Crew;
      property Item3Ep : Extended read fItem3Ep write fItem3Ep;
      property Item3Cost : Extended read fItem3Cost write fItem3Cost;
      property Item3Hp : Integer read fItem3Hp write fItem3Hp;
      property Item4Num : Integer read fItem4Num write fItem4Num;
      property Item4Size : Extended read fItem4Size write fItem4Size;
      property Item4Desc : String read fItem4Desc write fItem4Desc;
      property Item4Crew : Integer read fItem4Crew write fItem4Crew;
      property Item4Ep : Extended read fItem4Ep write fItem4Ep;
      property Item4Cost : Extended read fItem4Cost write fItem4Cost;
      property Item4Hp : Integer read fItem4Hp write fItem4Hp;
      property Item5Num : Integer read fItem5Num write fItem5Num;
      property Item5Size : Extended read fItem5Size write fItem5Size;
      property Item5Desc : String read fItem5Desc write fItem5Desc;
      property Item5Crew : Integer read fItem5Crew write fItem5Crew;
      property Item5Ep : Extended read fItem5Ep write fItem5Ep;
      property Item5Cost : Extended read fItem5Cost write fItem5Cost;
      property Item5Hp : Integer read fItem5Hp write fItem5Hp;
      property Item6Num : Integer read fItem6Num write fItem6Num;
      property Item6Size : Extended read fItem6Size write fItem6Size;
      property Item6Desc : String read fItem6Desc write fItem6Desc;
      property Item6Crew : Integer read fItem6Crew write fItem6Crew;
      property Item6Ep : Extended read fItem6Ep write fItem6Ep;
      property Item6Cost : Extended read fItem6Cost write fItem6Cost;
      property Item6Hp : Integer read fItem6Hp write fItem6Hp;
      property Item7Num : Integer read fItem7Num write fItem7Num;
      property Item7Size : Extended read fItem7Size write fItem7Size;
      property Item7Desc : String read fItem7Desc write fItem7Desc;
      property Item7Crew : Integer read fItem7Crew write fItem7Crew;
      property Item7Ep : Extended read fItem7Ep write fItem7Ep;
      property Item7Cost : Extended read fItem7Cost write fItem7Cost;
      property Item7Hp : Integer read fItem7Hp write fItem7Hp;
      property Item8Num : Integer read fItem8Num write fItem8Num;
      property Item8Size : Extended read fItem8Size write fItem8Size;
      property Item8Desc : String read fItem8Desc write fItem8Desc;
      property Item8Crew : Integer read fItem8Crew write fItem8Crew;
      property Item8Ep : Extended read fItem8Ep write fItem8Ep;
      property Item8Cost : Extended read fItem8Cost write fItem8Cost;
      property Item8Hp : Integer read fItem8Hp write fItem8Hp;
      procedure AssignDefaults(ShipData : String); virtual;
      procedure DesignUserDef(ShipData : String);
   end;

var
   UserDef : TUserDef;

implementation

{ TUserDef }

procedure TUserDef.AssignDefaults(ShipData: String);
var
   Props : TStringList;
begin
   Props := TStringList.Create;
   try
      Props.CommaText := ShipData;
      Item1Num := StrToInt(Props[0]);
      Item1Size := StrToFloat(Props[1]);
      Item1Desc := Props[2];
      Item1Crew := StrToInt(Props[3]);
      Item1Ep := StrToFloat(Props[4]);
      Item1Cost := StrToFloat(Props[5]);
      Item1Hp := StrToInt(Props[6]);
      //three lines wiggle room
      Item2Num := StrToInt(Props[10]);
      Item2Size := StrToFloat(Props[11]);
      Item2Desc := Props[12];
      Item2Crew := StrToInt(Props[13]);
      Item2Ep := StrToFloat(Props[14]);
      Item2Cost := StrToFloat(Props[15]);
      Item2Hp := StrToInt(Props[16]);
      //three lines wiggle room
      Item3Num := StrToInt(Props[20]);
      Item3Size := StrToFloat(Props[21]);
      Item3Desc := Props[22];
      Item3Crew := StrToInt(Props[23]);
      Item3Ep := StrToFloat(Props[24]);
      Item3Cost := StrToFloat(Props[25]);
      Item3Hp := StrToInt(Props[26]);
      //three lines wiggle room
      Item4Num := StrToInt(Props[30]);
      Item4Size := StrToFloat(Props[31]);
      Item4Desc := Props[32];
      Item4Crew := StrToInt(Props[33]);
      Item4Ep := StrToFloat(Props[34]);
      Item4Cost := StrToFloat(Props[35]);
      Item4Hp := StrToInt(Props[36]);
      //three lines wiggle room
      Item5Num := StrToInt(Props[40]);
      Item5Size := StrToFloat(Props[41]);
      Item5Desc := Props[42];
      Item5Crew := StrToInt(Props[43]);
      Item5Ep := StrToFloat(Props[44]);
      Item5Cost := StrToFloat(Props[45]);
      Item5Hp := StrToInt(Props[46]);
      //three lines wiggle room
      Item6Num := StrToInt(Props[50]);
      Item6Size := StrToFloat(Props[51]);
      Item6Desc := Props[52];
      Item6Crew := StrToInt(Props[53]);
      Item6Ep := StrToFloat(Props[54]);
      Item6Cost := StrToFloat(Props[55]);
      Item6Hp := StrToInt(Props[56]);
      //three lines wiggle room
      Item7Num := StrToInt(Props[60]);
      Item7Size := StrToFloat(Props[61]);
      Item7Desc := Props[62];
      Item7Crew := StrToInt(Props[63]);
      Item7Ep := StrToFloat(Props[64]);
      Item7Cost := StrToFloat(Props[65]);
      Item7Hp := StrToInt(Props[66]);
      //three lines wiggle room
      Item8Num := StrToInt(Props[70]);
      Item8Size := StrToFloat(Props[71]);
      Item8Desc := Props[72];
      Item8Crew := StrToInt(Props[73]);
      Item8Ep := StrToFloat(Props[74]);
      Item8Cost := StrToFloat(Props[75]);
      Item8Hp := StrToInt(Props[76]);
      Space := 0;
      Cost := 0;
      HardPoints := 0;
   finally
      Props.Free;
   end;
end;

procedure TUserDef.CalcCrew;
begin
   CmdCrew := 0;
   Crew := (Item1Num * Item1Crew)
         + (Item2Num * Item2Crew)
         + (Item3Num * Item3Crew)
         + (Item4Num * Item4Crew)
         + (Item5Num * Item5Crew)
         + (Item6Num * Item6Crew)
         + (Item7Num * Item7Crew)
         + (Item8Num * Item8Crew);
end;

procedure TUserDef.CalcHardPoints;
begin
   HardPoints := (Item1Num * Item1Hp)
         + (Item2Num * Item2Hp)
         + (Item3Num * Item3Hp)
         + (Item4Num * Item4Hp)
         + (Item5Num * Item5Hp)
         + (Item6Num * Item6Hp)
         + (Item7Num * Item7Hp)
         + (Item8Num * Item8Hp);
end;

procedure TUserDef.CalcPower;
begin
   Power := (Item1Num * Item1Ep)
         + (Item2Num * Item2Ep)
         + (Item3Num * Item3Ep)
         + (Item4Num * Item4Ep)
         + (Item5Num * Item5Ep)
         + (Item6Num * Item6Ep)
         + (Item7Num * Item7Ep)
         + (Item8Num * Item8Ep);
end;

procedure TUserDef.DesignUserDef(ShipData: String);
var
   ShipDetails : TStringList;
begin
   ShipDetails := TStringList.Create;
   try
      ShipDetails.CommaText := ShipData;
      Cost := UserDefCost;
      Space := UserDefSpace;
      CalcCrew;
      CalcPower;
      CalcHardPoints;
   finally
      ShipDetails.Free;
   end;
end;

function TUserDef.UserDefCost: Extended;
begin
   Result := (Item1Num * Item1Cost)
         + (Item2Num * Item2Cost)
         + (Item3Num * Item3Cost)
         + (Item4Num * Item4Cost)
         + (Item5Num * Item5Cost)
         + (Item6Num * Item6Cost)
         + (Item7Num * Item7Cost)
         + (Item8Num * Item8Cost);
end;

function TUserDef.UserDefSpace: Extended;
begin
   Result := (Item1Num * Item1Size)
         + (Item2Num * Item2Size)
         + (Item3Num * Item3Size)
         + (Item4Num * Item4Size)
         + (Item5Num * Item5Size)
         + (Item6Num * Item6Size)
         + (Item7Num * Item7Size)
         + (Item8Num * Item8Size);
end;

end.
