unit CombatPas;

{$mode delphi}

interface

uses
  Classes, SysUtils, ShipModulePas;

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
    property SqdName: String read FSqdName write SetSqdName;
    property SqdId: Integer read FSqdId write SetSqdId;
    property SqdCommander: String read FSqdCommander write SetSqdCommander;
    property FleetTacticsSkill: Integer read FFleetTacticsSkill write SetFleetTacticsSkill;
    property SqdSkillLevel: Integer read FSqdSkillLevel write SetSqdSkillLevel;
    property SqdMorale: Integer read FSqdMorale write SetSqdMorale;
    property SqdAggression: Integer read FSqdAggression write SetSqdAggression;
    property SqdDoctrine: Integer read FSqdDoctrine write SetSqdDoctrine;
  end;

type

  { TCombatShip }

  TCombatShip = class(TShipExporter)
  private
    FBaseAgility: Integer;
    FEffectiveAgility: Integer;
    FFrozenWatches: Integer;
    FInReserve: Boolean;
    FMarines: Integer;
    FOriginalAgility: Integer;
    FOtherCrew: Integer;
    FPilotSkill: Integer;
    FShipAggression: Integer;
    FShipCommander: String;
    FShipId: Integer;
    FShipMorale: Integer;
    FShipName: String;
    FShipSkillLevel: Integer;
    FShipsTroops: Integer;
    FShipTacticsSkill: Integer;
    FTargetValue: Integer;
    FUseEmergencyAgility: Boolean;
    procedure SetBaseAgility(const AValue: Integer);
    procedure SetEffectiveAgility(const AValue: Integer);
    procedure SetFrozenWatches(const AValue: Integer);
    procedure SetInReserve(const AValue: Boolean);
    procedure SetMarines(const AValue: Integer);
    procedure SetOriginalAgility(const AValue: Integer);
    procedure SetOtherCrew(const AValue: Integer);
    procedure SetPilotSkill(const AValue: Integer);
    procedure SetShipAggression(const AValue: Integer);
    procedure SetShipCommander(const AValue: String);
    procedure SetShipId(const AValue: Integer);
    procedure SetShipMorale(const AValue: Integer);
    procedure SetShipName(const AValue: String);
    procedure SetShipSkillLevel(const AValue: Integer);
    procedure SetShipsTroops(const AValue: Integer);
    procedure SetShipTacticsSkill(const AValue: Integer);
    procedure SetTargetValue(const AValue: Integer);
    procedure SetUseEmergencyAgility(const AValue: Boolean);

  public
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
    property ShipSkillLevel: Integer read FShipSkillLevel write SetShipSkillLevel;
    property ShipTacticsSkill: Integer read FShipTacticsSkill write SetShipTacticsSkill;
    property PilotSkill: Integer read FPilotSkill write SetPilotSkill;
    property ShipMorale: Integer read FShipMorale write SetShipMorale;
    property ShipAggression: Integer read FShipAggression write SetShipAggression;
    property TargetValue: Integer read FTargetValue write SetTargetValue;
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
    ShipPas, SquadronPas;

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

  { TCombatShip }

  procedure TCombatShip.SetBaseAgility(const AValue: Integer);
  begin
    if FBaseAgility=AValue then exit;
    FBaseAgility:=AValue;
  end;

  procedure TCombatShip.SetEffectiveAgility(const AValue: Integer);
  begin
    if FEffectiveAgility=AValue then exit;
    FEffectiveAgility:=AValue;
  end;

  procedure TCombatShip.SetFrozenWatches(const AValue: Integer);
  begin
    if FFrozenWatches=AValue then exit;
    FFrozenWatches:=AValue;
  end;

  procedure TCombatShip.SetInReserve(const AValue: Boolean);
  begin
    if FInReserve=AValue then exit;
    FInReserve:=AValue;
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

