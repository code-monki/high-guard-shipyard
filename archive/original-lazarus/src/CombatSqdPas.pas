unit CombatSqdPas;

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

implementation

uses
  ShipPas, SquadronPas;

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

end.

