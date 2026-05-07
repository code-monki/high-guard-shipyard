unit UspItemPas;

{$mode delphi}

interface

uses
  Classes, SysUtils;

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

implementation

//uses
  //

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

end.

