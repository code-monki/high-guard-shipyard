unit CombatPas;

{$mode delphi}

interface

uses
  Classes, SysUtils, Math, ShipModulePas, SquadronPas, ShipPas;

type

  { TCombatSqd }

  TCombatSqd = class(TShipExporter)
  private
    FFleetTacticsSkill: Integer;
    FSqdAggression: Integer;
    FSqdCommander: String;
    FSqdDoctrine: Integer;
    FSqdId: Integer;
    FSqdMorale: Integer;
    FSqdName: String;
    FSqdSkillLevel: Integer;
    procedure SetFleetTacticsSkill(const AValue: Integer);
    procedure SetSqdAggression(const AValue: Integer);
    procedure SetSqdCommander(const AValue: String);
    procedure SetSqdDoctrine(const AValue: Integer);
    procedure SetSqdId(const AValue: Integer);
    procedure SetSqdMorale(const AValue: Integer);
    procedure SetSqdName(const AValue: String);
    procedure SetSqdSkillLevel(const AValue: Integer);

  public
    ShipList: TList;
    property SqdName: String read FSqdName write SetSqdName;
    property SqdId: Integer read FSqdId write SetSqdId;
    property SqdCommander: String read FSqdCommander write SetSqdCommander;
    property FleetTacticsSkill: Integer read FFleetTacticsSkill write SetFleetTacticsSkill;
    property SqdSkillLevel: Integer read FSqdSkillLevel write SetSqdSkillLevel;
    property SqdMorale: Integer read FSqdMorale write SetSqdMorale;
    property SqdAggression: Integer read FSqdAggression write SetSqdAggression;
    property SqdDoctrine: Integer read FSqdDoctrine write SetSqdDoctrine;

    constructor Create;
    destructor Destroy;

    function AddAShip(TheShip: TShip; ShipName, CommanderName: String;
      CurrentFuelLoad: Extended): Boolean;
    function DeleteAShip(ShipIndex: Integer): Boolean;
  end;

type

  { TCombatShip }

  TCombatShip = class(TShipExporter)
  private
    FAvailableFuelTankage: Extended;
    FBaseAgility: Integer;
    FCurrentFuel: Extended;
    FEffectiveAgility: Integer;
    FExtraCapacitors: Extended;
    FFrozenWatches: Integer;
    FFuelHits: Integer;
    FFuelTankage: Extended;
    FInReserve: Boolean;
    FIsVapourised: Boolean;
    FMarines: Integer;
    FOriginalAgility: Integer;
    FOtherCrew: Integer;
    FPilotSkill: Integer;
    FShipAggression: Integer;
    FShipArmour: Integer;
    FShipCommander: String;
    FShipId: Integer;
    FShipMorale: Integer;
    FShipName: String;
    FShipSkillLevel: Integer;
    FShipsTroops: Integer;
    FShipTacticsSkill: Integer;
    FShipUspConfiguration: Integer;
    FShipUspSize: Integer;
    FTargetValue: Integer;
    FUseEmergencyAgility: Boolean;
    procedure SetAvailableFuelTankage(const AValue: Extended);
    procedure SetBaseAgility(const AValue: Integer);
    procedure SetCurrentFuel(const AValue: Extended);
    procedure SetEffectiveAgility(const AValue: Integer);
    procedure SetExtraCapacitors(const AValue: Extended);
    procedure SetFrozenWatches(const AValue: Integer);
    procedure SetFuelHits(const AValue: Integer);
    procedure SetFuelTankage(const AValue: Extended);
    procedure SetInReserve(const AValue: Boolean);
    procedure SetIsVapourised(const AValue: Boolean);
    procedure SetMarines(const AValue: Integer);
    procedure SetOriginalAgility(const AValue: Integer);
    procedure SetOtherCrew(const AValue: Integer);
    procedure SetPilotSkill(const AValue: Integer);
    procedure SetShipAggression(const AValue: Integer);
    procedure SetShipArmour(const AValue: Integer);
    procedure SetShipCommander(const AValue: String);
    procedure SetShipId(const AValue: Integer);
    procedure SetShipMorale(const AValue: Integer);
    procedure SetShipName(const AValue: String);
    procedure SetShipSkillLevel(const AValue: Integer);
    procedure SetShipsTroops(const AValue: Integer);
    procedure SetShipTacticsSkill(const AValue: Integer);
    procedure SetShipUspConfiguration(const AValue: Integer);
    procedure SetShipUspSize(const AValue: Integer);
    procedure SetTargetValue(const AValue: Integer);
    procedure SetUseEmergencyAgility(const AValue: Boolean);

  public
    JumpUspItem: TUspItem;
    BakJumpUspItem: TUspItem;
    ManUspItem: TUspItem;
    BakManUspItem: TUspItem;
    PowerUspItem: TUspItem;
    BakPowerUspItem: TUspItem;
    ComputerUspItem: TUspItem;
    BakComputerUspItem: TUspItem;
    BridgeUspItem: TUspItem;
    BakBridgeUspItem: TUspItem;
    CrewUspItem: TUspItem;
    SandUspItem: TWpnUspItem;
    MesonScrnUspItem: TUspItem;
    BakMesonScrnUspItem: TUspItem;
    NukDampUspItem: TUspItem;
    BakNukDampUspItem: TUspItem;
    BlackGlobeUspItem: TUspItem;
    BakBlackGlobeUspItem: TUspItem;
    RepulsorsUspItem: TWpnUspItem;
    LasersUspItem: TWpnUspItem;
    EnergyUspItem: TWpnUspItem;
    PaUspItem: TWpnUspItem;
    MesonGunUspItem: TWpnUspItem;
    MissileUspItem: TWpnUspItem;
    Battery: TBattery;
    property ShipName: String read FShipName write SetShipName;
    property ShipId: Integer read FShipId write SetShipId;
    property ShipCommander: String read FShipCommander write SetShipCommander;
    property OriginalAgility: Integer read FOriginalAgility write SetOriginalAgility;
    property BaseAgility: Integer read FBaseAgility write SetBaseAgility;
    property EffectiveAgility: Integer read FEffectiveAgility write SetEffectiveAgility;
    property UseEmergencyAgility: Boolean read FUseEmergencyAgility write SetUseEmergencyAgility;
    property InReserve: Boolean read FInReserve write SetInReserve;
    property Marines: Integer read FMarines write SetMarines;
    property ShipsTroops: Integer read FShipsTroops write SetShipsTroops;
    property OtherCrew: Integer read FOtherCrew write SetOtherCrew;
    property FrozenWatches: Integer read FFrozenWatches write SetFrozenWatches;
    property FuelTankage: Extended read FFuelTankage write SetFuelTankage;
    property AvailableFuelTankage: Extended read FAvailableFuelTankage write SetAvailableFuelTankage;
    property CurrentFuel: Extended read FCurrentFuel write SetCurrentFuel;
    property FuelHits: Integer read FFuelHits write SetFuelHits;
    property ExtraCapacitors: Extended read FExtraCapacitors write SetExtraCapacitors;
    property ShipSkillLevel: Integer read FShipSkillLevel write SetShipSkillLevel;
    property ShipTacticsSkill: Integer read FShipTacticsSkill write SetShipTacticsSkill;
    property PilotSkill: Integer read FPilotSkill write SetPilotSkill;
    property ShipMorale: Integer read FShipMorale write SetShipMorale;
    property ShipAggression: Integer read FShipAggression write SetShipAggression;
    property TargetValue: Integer read FTargetValue write SetTargetValue;
    property ShipUspSize: Integer read FShipUspSize write SetShipUspSize;
    property ShipUspConfiguration: Integer read FShipUspConfiguration write SetShipUspConfiguration;
    property ShipArmour: Integer read FShipArmour write SetShipArmour;
    property IsVapourised: Boolean read FIsVapourised write SetIsVapourised;
    constructor Create;
    destructor Destroy;
  end;

type

  { TUspItem }

  TUspItem = class
  private
    FIsFib: Boolean;
    FItemBaseFactor: Integer;
    FItemBaseNumber: Integer;
    FItemEffectiveFactor: Integer;
    FItemEffectiveNumber: Integer;
    FItemOriginalFactor: Integer;
    FItemOriginalNumber: Integer;
    procedure SetIsFib(const AValue: Boolean);
    procedure SetItemBaseFactor(const AValue: Integer);
    procedure SetItemBaseNumber(const AValue: Integer);
    procedure SetItemEffectiveFactor(const AValue: Integer);
    procedure SetItemEffectiveNumber(const AValue: Integer);
    procedure SetItemOriginalFactor(const AValue: Integer);
    procedure SetItemOriginalNumber(const AValue: Integer);

  public
    property ItemOriginalFactor: Integer read FItemOriginalFactor write SetItemOriginalFactor;
    property ItemEffectiveFactor: Integer read FItemEffectiveFactor write SetItemEffectiveFactor;
    property ItemBaseFactor: Integer read FItemBaseFactor write SetItemBaseFactor;
    property ItemOriginalNumber: Integer read FItemOriginalNumber write SetItemOriginalNumber;
    property ItemEffectiveNumber: Integer read FItemEffectiveNumber write SetItemEffectiveNumber;
    property ItemBaseNumber: Integer read FItemBaseNumber write SetItemBaseNumber;
    property IsFib: Boolean read FIsFib write SetIsFib;
  end;

type

  { TWpnUspItem }

  TWpnUspItem = class(TUspItem)
  private
    FIsSpinal: Boolean;
    FNumBearing: Integer;
    FNumberAllocated: Integer;
    FOriginalNumber: Integer;
    procedure SetIsSpinal(const AValue: Boolean);
    procedure SetNumBearing(const AValue: Integer);
    procedure SetNumberAllocated(const AValue: Integer);
    procedure SetOriginalNumber(const AValue: Integer);

  public
    property OriginalNumber: Integer read FOriginalNumber write SetOriginalNumber;
    property NumBearing: Integer read FNumBearing write SetNumBearing;
    property NumberAllocated: Integer read FNumberAllocated write SetNumberAllocated;
    property IsSpinal: Boolean read FIsSpinal write SetIsSpinal;
  end;

type

  { TBattery }

  TBattery = class(TShipModule)
  private
    FWeaponHits: Integer;
    procedure SetWeaponHits(const AValue: Integer);

  public
    property WeaponHits: Integer read FWeaponHits write SetWeaponHits;
  end;

type

  { TAttack }

  TAttack = class
  private
    FIsNuclear: Boolean;
    FTargetId: Integer;
    FWeaponFactor: Integer;
    FWeaponType: Integer;
    procedure SetIsNuclear(const AValue: Boolean);
    procedure SetTargetId(const AValue: Integer);
    procedure SetWeaponFactor(const AValue: Integer);
    procedure SetWeaponType(const AValue: Integer);

  public
    property TargetId: Integer read FTargetId write SetTargetId;
    property WeaponType: Integer read FWeaponType write SetWeaponType;
    property WeaponFactor: Integer read FWeaponFactor write SetWeaponFactor;
    property IsNuclear: Boolean read FIsNuclear write SetIsNuclear;
  end;


implementation

uses
  ;

  { TAttack }

procedure TAttack.SetIsNuclear(const AValue: Boolean);
begin
  if FIsNuclear=AValue then exit;
  FIsNuclear:=AValue;
end;

procedure TAttack.SetTargetId(const AValue: Integer);
begin
  if FTargetId=AValue then exit;
  FTargetId:=AValue;
end;

procedure TAttack.SetWeaponFactor(const AValue: Integer);
begin
  if FWeaponFactor=AValue then exit;
  FWeaponFactor:=AValue;
end;

procedure TAttack.SetWeaponType(const AValue: Integer);
begin
  if FWeaponType=AValue then exit;
  FWeaponType:=AValue;
end;

  { TBattery }

procedure TBattery.SetWeaponHits(const AValue: Integer);
begin
  if FWeaponHits=AValue then exit;
  FWeaponHits:=AValue;
end;

  { TCombatSqd }

procedure TCombatSqd.SetFleetTacticsSkill(const AValue: Integer);
begin
  if FFleetTacticsSkill=AValue then exit;
  FFleetTacticsSkill:=AValue;
end;

procedure TCombatSqd.SetSqdAggression(const AValue: Integer);
begin
  if FSqdAggression=AValue then exit;
  FSqdAggression:=AValue;
end;

procedure TCombatSqd.SetSqdCommander(const AValue: String);
begin
  if FSqdCommander=AValue then exit;
  FSqdCommander:=AValue;
end;

procedure TCombatSqd.SetSqdDoctrine(const AValue: Integer);
begin
  if FSqdDoctrine=AValue then exit;
  FSqdDoctrine:=AValue;
end;

procedure TCombatSqd.SetSqdId(const AValue: Integer);
begin
  if FSqdId=AValue then exit;
  FSqdId:=AValue;
end;

procedure TCombatSqd.SetSqdMorale(const AValue: Integer);
begin
  if FSqdMorale=AValue then exit;
  FSqdMorale:=AValue;
end;

procedure TCombatSqd.SetSqdName(const AValue: String);
begin
  if FSqdName=AValue then exit;
  FSqdName:=AValue;
end;

procedure TCombatSqd.SetSqdSkillLevel(const AValue: Integer);
begin
  if FSqdSkillLevel=AValue then exit;
  FSqdSkillLevel:=AValue;
end;

constructor TCombatSqd.Create;
begin
  inherited;
  ShipList := TList.Create;
end;

destructor TCombatSqd.Destroy;
var
  iCount: Integer;
begin
  for iCount := 0  to ShipList.Count - 1 do
  begin
    DeleteAShip(0);
  end;
  ShipList.Free;
  inherited;
end;

function TCombatSqd.AddAShip(TheShip: TShip; ShipName, CommanderName: String;
  CurrentFuelLoad: Extended): Boolean;
var
  TheCombatShip: TCombatShip;
begin
  TheCombatShip := TCombatShip.Create;
  TheCombatShip.ShipName := ShipName;
  TheCombatShip.ShipId := ShipList.Count + 1;
  TheCombatShip.ShipCommander := CommanderName;
  TheCombatShip.OriginalAgility := TheShip.Agility;
  TheCombatShip.BaseAgility := Trunc(TheShip.GetRemPower / (TheShip.Tonnage * 0.01));
  TheCombatShip.EffectiveAgility := TheCombatShip.OriginalAgility;
  TheCombatShip.UseEmergencyAgility := False;
  TheCombatShip.InReserve := True;
  TheCombatShip.Marines := TheShip.Accom.Marines;
  TheCombatShip.ShipsTroops := TheShip.Accom.ShipsTroops;
  //this is ham fisted find a better way
  TheCombatShip.OtherCrew := TheShip.GetTotalCmdCrew + TheShip.GetTotalCrew
      - (TheCombatShip.Marines + TheCombatShip.ShipsTroops);
  TheCombatShip.FrozenWatches := TheShip.Accom.FrozWatch;
  TheCombatShip.FuelTankage := TheShip.Fuel.FuelSpace(TheShip.Tonnage,
      TheShip.Eng.PowerTons, TheShip.Eng.PPlant, TheShip.TechLevel,
      TheShip.ShipRace, TheShip.DesignRules);
  TheCombatShip.AvailableFuelTankage := TheCombatShip.FuelTankage;
  TheCombatShip.CurrentFuel := CurrentFuelLoad;
  TheCombatShip.FuelHits := 0;
  TheCombatShip.ExtraCapacitors := TheShip.Screens.ExtraCaps;
  //for later use adding skill, aggression etc to ships
  TheCombatShip.ShipSkillLevel := 0;
  TheCombatShip.ShipTacticsSkill := 0;
  TheCombatShip.PilotSkill := 0;
  TheCombatShip.ShipMorale := 0;
  TheCombatShip.ShipAggression := 0;
  TheCombatShip.TargetValue := 0;
  //TheCombatShip.ShipUspSize := TravToInt(TheShip.CalcSizeCode);   inttotrav needs to be defined
  TheCombatShip.ShipUspConfiguration := TheShip.Hull.Config;
  case (TheCombatShip.ShipUspConfiguration) of
    0..6: TheCombatShip.ShipArmour := The Ship.Hull.Armour;
    7: TheCombatShip.ShipArmour := 0;
    8: TheCombatShip.ShipArmour := TheShip.Hull.Armour + 3;
    9: TheCombatShip.ShipArmour := TheShip.Hull.Armour + 6;
    else TheCombatShip.ShipArmour := The Ship.Hull.Armour;
  end;
  TheCombatShip.IsVapourised := False;
  ShipList.Add(TheCombatShip);
end;

function TCombatSqd.DeleteAShip(ShipIndex: Integer): Boolean;
begin
  ShipList.Delete(ShipIndex);
end;

  { TCombatShip }

procedure TCombatShip.SetBaseAgility(const AValue: Integer);
begin
  if FBaseAgility=AValue then exit;
  FBaseAgility:=AValue;
end;

procedure TCombatShip.SetAvailableFuelTankage(const AValue: Extended);
begin
  if FAvailableFuelTankage=AValue then exit;
  FAvailableFuelTankage:=AValue;
end;

procedure TCombatShip.SetCurrentFuel(const AValue: Extended);
begin
  if FCurrentFuel=AValue then exit;
  FCurrentFuel:=AValue;
end;

procedure TCombatShip.SetEffectiveAgility(const AValue: Integer);
begin
  if FEffectiveAgility=AValue then exit;
  FEffectiveAgility:=AValue;
end;

procedure TCombatShip.SetExtraCapacitors(const AValue: Extended);
begin
  if FExtraCapacitors=AValue then exit;
  FExtraCapacitors:=AValue;
end;

procedure TCombatShip.SetFrozenWatches(const AValue: Integer);
begin
  if FFrozenWatches=AValue then exit;
  FFrozenWatches:=AValue;
end;

procedure TCombatShip.SetFuelHits(const AValue: Integer);
begin
  if FFuelHits=AValue then exit;
  FFuelHits:=AValue;
end;

procedure TCombatShip.SetFuelTankage(const AValue: Extended);
begin
  if FFuelTankage=AValue then exit;
  FFuelTankage:=AValue;
end;

procedure TCombatShip.SetInReserve(const AValue: Boolean);
begin
  if FInReserve=AValue then exit;
  FInReserve:=AValue;
end;

procedure TCombatShip.SetIsVapourised(const AValue: Boolean);
begin
  if FIsVapourised=AValue then exit;
  FIsVapourised:=AValue;
end;

procedure TCombatShip.SetMarines(const AValue: Integer);
begin
  if FMarines=AValue then exit;
  FMarines:=AValue;
end;

procedure TCombatShip.SetOriginalAgility(const AValue: Integer);
begin
  if FOriginalAgility=AValue then exit;
  FOriginalAgility:=AValue;
end;

procedure TCombatShip.SetOtherCrew(const AValue: Integer);
begin
  if FOtherCrew=AValue then exit;
  FOtherCrew:=AValue;
end;

procedure TCombatShip.SetPilotSkill(const AValue: Integer);
begin
  if FPilotSkill=AValue then exit;
  FPilotSkill:=AValue;
end;

procedure TCombatShip.SetShipAggression(const AValue: Integer);
begin
  if FShipAggression=AValue then exit;
  FShipAggression:=AValue;
end;

procedure TCombatShip.SetShipArmour(const AValue: Integer);
begin
  if FShipArmour=AValue then exit;
  FShipArmour:=AValue;
end;

procedure TCombatShip.SetShipCommander(const AValue: String);
begin
  if FShipCommander=AValue then exit;
  FShipCommander:=AValue;
end;

procedure TCombatShip.SetShipId(const AValue: Integer);
begin
  if FShipId=AValue then exit;
  FShipId:=AValue;
end;

procedure TCombatShip.SetShipMorale(const AValue: Integer);
begin
  if FShipMorale=AValue then exit;
  FShipMorale:=AValue;
end;

procedure TCombatShip.SetShipName(const AValue: String);
begin
  if FShipName=AValue then exit;
  FShipName:=AValue;
end;

procedure TCombatShip.SetShipSkillLevel(const AValue: Integer);
begin
  if FShipSkillLevel=AValue then exit;
  FShipSkillLevel:=AValue;
end;

procedure TCombatShip.SetShipsTroops(const AValue: Integer);
begin
  if FShipsTroops=AValue then exit;
  FShipsTroops:=AValue;
end;

procedure TCombatShip.SetShipTacticsSkill(const AValue: Integer);
begin
  if FShipTacticsSkill=AValue then exit;
  FShipTacticsSkill:=AValue;
end;

procedure TCombatShip.SetShipUspConfiguration(const AValue: Integer);
begin
  if FShipUspConfiguration=AValue then exit;
  FShipUspConfiguration:=AValue;
end;

procedure TCombatShip.SetShipUspSize(const AValue: Integer);
begin
  if FShipUspSize=AValue then exit;
  FShipUspSize:=AValue;
end;

procedure TCombatShip.SetTargetValue(const AValue: Integer);
begin
  if FTargetValue=AValue then exit;
  FTargetValue:=AValue;
end;

procedure TCombatShip.SetUseEmergencyAgility(const AValue: Boolean);
begin
  if FUseEmergencyAgility=AValue then exit;
  FUseEmergencyAgility:=AValue;
end;

constructor TCombatShip.Create;
begin
  JumpUspItem := TUspItem.Create;
  BakJumpUspItem := TUspItem.Create;
  ManUspItem := TUspItem.Create;
  BakManUspItem := TUspItem.Create;
  PowerUspItem := TUspItem.Create;
  BakPowerUspItem := TUspItem.Create;
  ComputerUspItem := TUspItem.Create;
  BakComputerUspItem := TUspItem.Create;
  BridgeUspItem := TUspItem.Create;
  BakBridgeUspItem := TUspItem.Create;
  CrewUspItem := TUspItem.Create;
  SandUspItem := TWpnUspItem.Create;
  MesonScrnUspItem := TUspItem.Create;
  BakMesonScrnUspItem := TUspItem.Create;
  NukDampUspItem := TUspItem.Create;
  BakNukDampUspItem := TUspItem.Create;
  BlackGlobeUspItem := TUspItem.Create;
  BakBlackGlobeUspItem := TUspItem.Create;
  RepulsorsUspItem := TWpnUspItem.Create;
  LasersUspItem := TWpnUspItem.Create;
  EnergyUspItem := TWpnUspItem.Create;
  PaUspItem := TWpnUspItem.Create;
  MesonGunUspItem := TWpnUspItem.Create;
  MissileUspItem := TWpnUspItem.Create;
  Battery := TBattery.Create;
end;

destructor TCombatShip.Destroy;
begin
  JumpUspItem.Free;
  BakJumpUspItem.Free;
  ManUspItem.Free;
  BakManUspItem.Free;
  PowerUspItem.Free;
  BakPowerUspItem.Free;
  ComputerUspItem.Free;
  BakComputerUspItem.Free;
  BridgeUspItem.Free;
  BakBridgeUspItem.Free;
  CrewUspItem.Free;
  SandUspItem.Free;
  MesonScrnUspItem.Free;
  BakMesonScrnUspItem.Free;
  NukDampUspItem.Free;
  BakNukDampUspItem.Free;
  BlackGlobeUspItem.Free;
  BakBlackGlobeUspItem.Free;
  RepulsorsUspItem.Free;
  LasersUspItem.Free;
  EnergyUspItem.Free;
  PaUspItem.Free;
  MesonGunUspItem.Free;
  MissileUspItem.Free;
  Battery.Free;
end;

  { TUspItem }

procedure TUspItem.SetItemBaseFactor(const AValue: Integer);
begin
  if FItemBaseFactor=AValue then exit;
  FItemBaseFactor:=AValue;
end;

procedure TUspItem.SetIsFib(const AValue: Boolean);
begin
  if FIsFib=AValue then exit;
  FIsFib:=AValue;
end;

procedure TUspItem.SetItemBaseNumber(const AValue: Integer);
begin
  if FItemBaseNumber=AValue then exit;
  FItemBaseNumber:=AValue;
end;

procedure TUspItem.SetItemEffectiveFactor(const AValue: Integer);
begin
  if FItemEffectiveFactor=AValue then exit;
  FItemEffectiveFactor:=AValue;
end;

procedure TUspItem.SetItemEffectiveNumber(const AValue: Integer);
begin
  if FItemEffectiveNumber=AValue then exit;
  FItemEffectiveNumber:=AValue;
end;

procedure TUspItem.SetItemOriginalFactor(const AValue: Integer);
begin
  if FItemOriginalFactor=AValue then exit;
  FItemOriginalFactor:=AValue;
end;

procedure TUspItem.SetItemOriginalNumber(const AValue: Integer);
begin
  if FItemOriginalNumber=AValue then exit;
  FItemOriginalNumber:=AValue;
end;

  { TWpnUspItem }

procedure TWpnUspItem.SetIsSpinal(const AValue: Boolean);
begin
  if FIsSpinal=AValue then exit;
  FIsSpinal:=AValue;
end;

procedure TWpnUspItem.SetNumBearing(const AValue: Integer);
begin
  if FNumBearing=AValue then exit;
  FNumBearing:=AValue;
end;

procedure TWpnUspItem.SetNumberAllocated(const AValue: Integer);
begin
  if FNumberAllocated=AValue then exit;
  FNumberAllocated:=AValue;
end;

procedure TWpnUspItem.SetOriginalNumber(const AValue: Integer);
begin
  if FOriginalNumber=AValue then exit;
  FOriginalNumber:=AValue;
end;

end.

