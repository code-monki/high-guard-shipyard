unit UspWpnItemPas; 

{$mode delphi}

interface

uses
  Classes, SysUtils, UspItemPas;

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

implementation

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

