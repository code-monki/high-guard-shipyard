unit HgCombatPas;

{$mode delphi}

interface

uses
  SysUtils, Classes, Maths, ShipModulePas;

type

{ HgCombat }

HgCombat = class(TShipExporter)
  private
    FArmour: Integer;
    FBackupComputerCode: Integer;
    FBackupFibComputer: Boolean;
    FBackupJumpDrive: Integer;
    FBackupManDrive: Integer;
    FBackupPowerPlant: Integer;
    FComputerCode: Integer;
    FConfiguration: Integer;
    FCrewCode: Integer;
    FFibComputer: Boolean;
    FJumpDrive: Integer;
    FManDrive: Integer;
    FNumBackupComputer: Integer;
    FNumBackupJumpDrive: Integer;
    FNumBackupManDrive: Integer;
    FNumBackupPowerPlant: Integer;
    FPowerPlant: Integer;
    FSandBattery: Integer;
    FSandBatteryBearing: Integer;
    FSandFactor: Integer;
    FSizeCode: Integer;
    FSizeCrewSection: Integer;
    procedure SetArmour(const AValue: Integer);
    procedure SetBackupComputerCode(const AValue: Integer);
    procedure SetBackupFibComputer(const AValue: Boolean);
    procedure SetBackupJumpDrive(const AValue: Integer);
    procedure SetBackupManDrive(const AValue: Integer);
    procedure SetBackupPowerPlant(const AValue: Integer);
    procedure SetComputerCode(const AValue: Integer);
    procedure SetConfiguration(const AValue: Integer);
    procedure SetCrewCode(const AValue: Integer);
    procedure SetFibComputer(const AValue: Boolean);
    procedure SetJumpDrive(const AValue: Integer);
    procedure SetManDrive(const AValue: Integer);
    procedure SetNumBackupComputer(const AValue: Integer);
    procedure SetNumBackupJumpDrive(const AValue: Integer);
    procedure SetNumBackupManDrive(const AValue: Integer);
    procedure SetNumBackupPowerPlant(const AValue: Integer);
    procedure SetPowerPlant(const AValue: Integer);
    procedure SetSandBattery(const AValue: Integer);
    procedure SetSandBatteryBearing(const AValue: Integer);
    procedure SetSandFactor(const AValue: Integer);
    procedure SetSizeCode(const AValue: Integer);
    procedure SetSizeCrewSection(const AValue: Integer);

  public
    property SizeCode: Integer read FSizeCode write SetSizeCode;
    property Configuration: Integer read FConfiguration write SetConfiguration;
    property JumpDrive: Integer read FJumpDrive write SetJumpDrive;
    property BackupJumpDrive: Integer read FBackupJumpDrive write SetBackupJumpDrive;
    property NumBackupJumpDrive: Integer read FNumBackupJumpDrive write SetNumBackupJumpDrive;
    property ManDrive: Integer read FManDrive write SetManDrive;
    property BackupManDrive: Integer read FBackupManDrive write SetBackupManDrive;
    property NumBackupManDrive: Integer read FNumBackupManDrive write SetNumBackupManDrive;
    property PowerPlant: Integer read FPowerPlant write SetPowerPlant;
    property BackupPowerPlant: Integer read FBackupPowerPlant write SetBackupPowerPlant;
    property NumBackupPowerPlant: Integer read FNumBackupPowerPlant write SetNumBackupPowerPlant;
    property ComputerCode: Integer read FComputerCode write SetComputerCode;
    property FibComputer: Boolean read FFibComputer write SetFibComputer;
    property BackupComputerCode: Integer read FBackupComputerCode write SetBackupComputerCode;
    property BackupFibComputer: Boolean read FBackupFibComputer write SetBackupFibComputer;
    property NumBackupComputer: Integer read FNumBackupComputer write SetNumBackupComputer;
    property CrewCode: Integer read FCrewCode write SetCrewCode;
    property SizeCrewSection: Integer read FSizeCrewSection write SetSizeCrewSection;
    property Armour: Integer read FArmour write SetArmour;
    property SandFactor: Integer read FSandFactor write SetSandFactor;
    property SandBattery: Integer read FSandBattery write SetSandBattery;
    property SandBatteryBearing: Integer read FSandBatteryBearing write SetSandBatteryBearing;

  end;

implementation

uses
  ShiPas, SquadronPas;

{ HgCombat }

procedure HgCombat.SetSizeCode(const AValue: Integer);
begin
  if FSizeCode=AValue then exit;
  FSizeCode:=AValue;
end;

procedure HgCombat.SetSizeCrewSection(const AValue: Integer);
begin
  if FSizeCrewSection=AValue then exit;
  FSizeCrewSection:=AValue;
end;

procedure HgCombat.SetConfiguration(const AValue: Integer);
begin
  if FConfiguration=AValue then exit;
  FConfiguration:=AValue;
end;

procedure HgCombat.SetCrewCode(const AValue: Integer);
begin
  if FCrewCode=AValue then exit;
  FCrewCode:=AValue;
end;

procedure HgCombat.SetFibComputer(const AValue: Boolean);
begin
  if FFibComputer=AValue then exit;
  FFibComputer:=AValue;
end;

procedure HgCombat.SetComputerCode(const AValue: Integer);
begin
  if FComputerCode=AValue then exit;
  FComputerCode:=AValue;
end;

procedure HgCombat.SetArmour(const AValue: Integer);
begin
  if FArmour=AValue then exit;
  FArmour:=AValue;
end;

procedure HgCombat.SetBackupComputerCode(const AValue: Integer);
begin
  if FBackupComputerCode=AValue then exit;
  FBackupComputerCode:=AValue;
end;

procedure HgCombat.SetBackupFibComputer(const AValue: Boolean);
begin
  if FBackupFibComputer=AValue then exit;
  FBackupFibComputer:=AValue;
end;

procedure HgCombat.SetBackupJumpDrive(const AValue: Integer);
begin
  if FBackupJumpDrive=AValue then exit;
  FBackupJumpDrive:=AValue;
end;

procedure HgCombat.SetBackupManDrive(const AValue: Integer);
begin
  if FBackupManDrive=AValue then exit;
  FBackupManDrive:=AValue;
end;

procedure HgCombat.SetBackupPowerPlant(const AValue: Integer);
begin
  if FBackupPowerPlant=AValue then exit;
  FBackupPowerPlant:=AValue;
end;

procedure HgCombat.SetJumpDrive(const AValue: Integer);
begin
  if FJumpDrive=AValue then exit;
  FJumpDrive:=AValue;
end;

procedure HgCombat.SetManDrive(const AValue: Integer);
begin
  if FManDrive=AValue then exit;
  FManDrive:=AValue;
end;

procedure HgCombat.SetNumBackupComputer(const AValue: Integer);
begin
  if FNumBackupComputer=AValue then exit;
  FNumBackupComputer:=AValue;
end;

procedure HgCombat.SetNumBackupJumpDrive(const AValue: Integer);
begin
  if FNumBackupJumpDrive=AValue then exit;
  FNumBackupJumpDrive:=AValue;
end;

procedure HgCombat.SetNumBackupManDrive(const AValue: Integer);
begin
  if FNumBackupManDrive=AValue then exit;
  FNumBackupManDrive:=AValue;
end;

procedure HgCombat.SetNumBackupPowerPlant(const AValue: Integer);
begin
  if FNumBackupPowerPlant=AValue then exit;
  FNumBackupPowerPlant:=AValue;
end;

procedure HgCombat.SetPowerPlant(const AValue: Integer);
begin
  if FPowerPlant=AValue then exit;
  FPowerPlant:=AValue;
end;

procedure HgCombat.SetSandBattery(const AValue: Integer);
begin
  if FSandBattery=AValue then exit;
  FSandBattery:=AValue;
end;

procedure HgCombat.SetSandBatteryBearing(const AValue: Integer);
begin
  if FSandBatteryBearing=AValue then exit;
  FSandBatteryBearing:=AValue;
end;

procedure HgCombat.SetSandFactor(const AValue: Integer);
begin
  if FSandFactor=AValue then exit;
  FSandFactor:=AValue;
end;

end.

