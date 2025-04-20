unit DataPas;

{$MODE Delphi}

interface

uses
   Classes, SysUtils;

type
   TData = class

   public
      procedure InitialiseData;
      function GetComputerData (Column, Row : Integer): string;
      function GetSpnlMesData (Column, Row : Integer): string;
      function GetSpnlPAData (Column, Row : Integer): string;
      function GetNucDampData (Column, Row : Integer): string;
      function GetMesScrnData (Column, Row : Integer): string;
      function GetBlkGlbData (Column, Row : Integer): string;

   private
      ComputerArray: Array [1..8, 0..20] of string;
      SpnlMesArray: Array [1..5, 0..18] of string;
      SpnlPAArray: Array [1..5, 0..18] of string;
      NucDampArray: Array [1..5, 0..9] of string;
      MesScrnArray: Array [1..5, 0..9] of string;
      BlkGlbArray: Array [1..4, 0..9] of string;
      procedure CreateDataFiles(TheFile : String);
      procedure ReadDataFiles(UseStd : Boolean = True);
   end;

implementation

{ Data }

function TData.GetComputerData(Column, Row: Integer): string;
//return data from the computer array

begin
   Result := ComputerArray[Column, Row];
end;

function TData.GetSpnlMesData(Column, Row: Integer): string;
//return data from the meson gun spinal mount array

begin
   Result := SpnlMesArray[Column, Row];
end;

function TData.GetSpnlPAData(Column, Row: Integer): string;
//return data from the pa spinal mount array

begin
   Result := SpnlPAArray[Column, Row];
end;

function TData.GetNucDampData(Column, Row: Integer): string;
//return data from the nuclear damper array

begin
   Result := NucDampArray[Column, Row];
end;

function TData.GetMesScrnData(Column, Row: Integer): string;
//return data from the meson screen array

begin
   Result := MesScrnArray[Column, Row];
end;

function TData.GetBlkGlbData(Column, Row: Integer): string;
//return data from the black globe array

begin
   Result := BlkGlbArray[Column, Row];
end;

procedure TData.InitialiseData;
//fill the data arrays

begin
   //Initialise Computer Data
   //Initialise Code
   ComputerArray[1, 0] := '0';
   ComputerArray[1, 1] := '1';
   ComputerArray[1, 2] := 'A';
   ComputerArray[1, 3] := 'R';
   ComputerArray[1, 4] := '2';
   ComputerArray[1, 5] := 'B';
   ComputerArray[1, 6] := 'S';
   ComputerArray[1, 7] := '3';
   ComputerArray[1, 8] := 'C';
   ComputerArray[1, 9] := '4';
   ComputerArray[1, 10] := 'D';
   ComputerArray[1, 11] := '5';
   ComputerArray[1, 12] := 'E';
   ComputerArray[1, 13] := '6';
   ComputerArray[1, 14] := 'F';
   ComputerArray[1, 15] := '7';
   ComputerArray[1, 16] := 'G';
   ComputerArray[1, 17] := '8';
   ComputerArray[1, 18] := 'H';
   ComputerArray[1, 19] := '9';
   ComputerArray[1, 20] := 'J';
   //Initialise Cost
   ComputerArray[2, 0] := '0';
   ComputerArray[2, 1] := '2';
   ComputerArray[2, 2] := '3';
   ComputerArray[2, 3] := '4';
   ComputerArray[2, 4] := '9';
   ComputerArray[2, 5] := '14';
   ComputerArray[2, 6] := '18';
   ComputerArray[2, 7] := '18';
   ComputerArray[2, 8] := '27';
   ComputerArray[2, 9] := '30';
   ComputerArray[2, 10] := '45';
   ComputerArray[2, 11] := '45';
   ComputerArray[2, 12] := '68';
   ComputerArray[2, 13] := '55';
   ComputerArray[2, 14] := '83';
   ComputerArray[2, 15] := '80';
   ComputerArray[2, 16] := '100';
   ComputerArray[2, 17] := '110';
   ComputerArray[2, 18] := '140';
   ComputerArray[2, 19] := '140';
   ComputerArray[2, 20] := '200';
   //Initialise Tonnage
   ComputerArray[3, 0] := '0';
   ComputerArray[3, 1] := '1';
   ComputerArray[3, 2] := '2';
   ComputerArray[3, 3] := '1';
   ComputerArray[3, 4] := '2';
   ComputerArray[3, 5] := '4';
   ComputerArray[3, 6] := '2';
   ComputerArray[3, 7] := '3';
   ComputerArray[3, 8] := '6';
   ComputerArray[3, 9] := '4';
   ComputerArray[3, 10] := '8';
   ComputerArray[3, 11] := '5';
   ComputerArray[3, 12] := '10';
   ComputerArray[3, 13] := '7';
   ComputerArray[3, 14] := '14';
   ComputerArray[3, 15] := '9';
   ComputerArray[3, 16] := '18';
   ComputerArray[3, 17] := '11';
   ComputerArray[3, 18] := '22';
   ComputerArray[3, 19] := '13';
   ComputerArray[3, 20] := '26';
   //Initialise Ship
   ComputerArray[4, 0] := '0';
   ComputerArray[4, 1] := '6';
   ComputerArray[4, 2] := '6';
   ComputerArray[4, 3] := '6';
   ComputerArray[4, 4] := 'A';
   ComputerArray[4, 5] := 'A';
   ComputerArray[4, 6] := 'A';
   ComputerArray[4, 7] := 'D';
   ComputerArray[4, 8] := 'D';
   ComputerArray[4, 9] := 'K';
   ComputerArray[4, 10] := 'K';
   ComputerArray[4, 11] := 'P';
   ComputerArray[4, 12] := 'P';
   ComputerArray[4, 13] := 'R';
   ComputerArray[4, 14] := 'R';
   ComputerArray[4, 15] := 'Y';
   ComputerArray[4, 16] := 'Y';
   ComputerArray[4, 17] := 'Z';
   ComputerArray[4, 18] := 'Z';
   ComputerArray[4, 19] := 'Z';
   ComputerArray[4, 20] := 'Z';
   //Initialise Tech Level
   ComputerArray[5, 0] := '0';
   ComputerArray[5, 1] := '5';
   ComputerArray[5, 2] := '6';
   ComputerArray[5, 3] := '7';
   ComputerArray[5, 4] := '7';
   ComputerArray[5, 5] := '7';
   ComputerArray[5, 6] := '8';
   ComputerArray[5, 7] := '9';
   ComputerArray[5, 8] := '9';
   ComputerArray[5, 9] := '10';
   ComputerArray[5, 10] := '10';
   ComputerArray[5, 11] := '11';
   ComputerArray[5, 12] := '11';
   ComputerArray[5, 13] := '12';
   ComputerArray[5, 14] := '12';
   ComputerArray[5, 15] := '13';
   ComputerArray[5, 16] := '13';
   ComputerArray[5, 17] := '14';
   ComputerArray[5, 18] := '14';
   ComputerArray[5, 19] := '15';
   ComputerArray[5, 20] := '15';
   //Initialise EP
   ComputerArray[6, 0] := '0';
   ComputerArray[6, 1] := '0';
   ComputerArray[6, 2] := '0';
   ComputerArray[6, 3] := '0';
   ComputerArray[6, 4] := '0';
   ComputerArray[6, 5] := '0';
   ComputerArray[6, 6] := '0';
   ComputerArray[6, 7] := '1';
   ComputerArray[6, 8] := '1';
   ComputerArray[6, 9] := '2';
   ComputerArray[6, 10] := '2';
   ComputerArray[6, 11] := '3';
   ComputerArray[6, 12] := '3';
   ComputerArray[6, 13] := '5';
   ComputerArray[6, 14] := '5';
   ComputerArray[6, 15] := '7';
   ComputerArray[6, 16] := '7';
   ComputerArray[6, 17] := '9';
   ComputerArray[6, 18] := '9';
   ComputerArray[6, 19] := '12';
   ComputerArray[6, 20] := '12';
   //Initialise Description
   ComputerArray[7, 0] := '0 None';
   ComputerArray[7, 1] := '1 Model/1';
   ComputerArray[7, 2] := 'A Model/1fib';
   ComputerArray[7, 3] := 'R Model/1bis';
   ComputerArray[7, 4] := '2 Model/2';
   ComputerArray[7, 5] := 'B Model/2fib';
   ComputerArray[7, 6] := 'S Model/2bis';
   ComputerArray[7, 7] := '3 Model/3';
   ComputerArray[7, 8] := 'C Model/3fib';
   ComputerArray[7, 9] := '4 Model/4';
   ComputerArray[7, 10] := 'D Model/4fib';
   ComputerArray[7, 11] := '5 Model/5';
   ComputerArray[7, 12] := 'E Model/5fib';
   ComputerArray[7, 13] := '6 Model/6';
   ComputerArray[7, 14] := 'F Model/6fib';
   ComputerArray[7, 15] := '7 Model/7';
   ComputerArray[7, 16] := 'G Model/7fib';
   ComputerArray[7, 17] := '8 Model/8';
   ComputerArray[7, 18] := 'H Model/8fib';
   ComputerArray[7, 19] := '9 Model/9';
   ComputerArray[7, 20] := 'J Model/9fib';
   //Initialise Jump
   ComputerArray[8, 0] := '0';
   ComputerArray[8, 1] := '1';
   ComputerArray[8, 2] := '1';
   ComputerArray[8, 3] := '2';
   ComputerArray[8, 4] := '2';
   ComputerArray[8, 5] := '2';
   ComputerArray[8, 6] := '3';
   ComputerArray[8, 7] := '3';
   ComputerArray[8, 8] := '3';
   ComputerArray[8, 9] := '4';
   ComputerArray[8, 10] := '4';
   ComputerArray[8, 11] := '5';
   ComputerArray[8, 12] := '5';
   ComputerArray[8, 13] := '6';
   ComputerArray[8, 14] := '6';
   ComputerArray[8, 15] := '6';
   ComputerArray[8, 16] := '6';
   ComputerArray[8, 17] := '6';
   ComputerArray[8, 18] := '6';
   ComputerArray[8, 19] := '6';
   ComputerArray[8, 20] := '6';

   //Initialise Spinal Meson Data
   //Initialise Code
   SpnlMesArray[1, 0] := '0 None';
   SpnlMesArray[1, 1] := 'A Meson';
   SpnlMesArray[1, 2] := 'B Meson';
   SpnlMesArray[1, 3] := 'C Meson';
   SpnlMesArray[1, 4] := 'D Meson';
   SpnlMesArray[1, 5] := 'E Meson';
   SpnlMesArray[1, 6] := 'F Meson';
   SpnlMesArray[1, 7] := 'G Meson';
   SpnlMesArray[1, 8] := 'H Meson';
   SpnlMesArray[1, 9] := 'J Meson';
   SpnlMesArray[1, 10] := 'K Meson';
   SpnlMesArray[1, 11] := 'L Meson';
   SpnlMesArray[1, 12] := 'M Meson';
   SpnlMesArray[1, 13] := 'N Meson';
   SpnlMesArray[1, 14] := 'P Meson';
   SpnlMesArray[1, 15] := 'Q Meson';
   SpnlMesArray[1, 16] := 'R Meson';
   SpnlMesArray[1, 17] := 'S Meson';
   SpnlMesArray[1, 18] := 'T Meson';
   //Initialise Tonnage
   SpnlMesArray[2, 0] := '0';
   SpnlMesArray[2, 1] := '5000';
   SpnlMesArray[2, 2] := '8000';
   SpnlMesArray[2, 3] := '2000';
   SpnlMesArray[2, 4] := '5000';
   SpnlMesArray[2, 5] := '1000';
   SpnlMesArray[2, 6] := '2000';
   SpnlMesArray[2, 7] := '1000';
   SpnlMesArray[2, 8] := '2000';
   SpnlMesArray[2, 9] := '1000';
   SpnlMesArray[2, 10] := '8000';
   SpnlMesArray[2, 11] := '5000';
   SpnlMesArray[2, 12] := '4000';
   SpnlMesArray[2, 13] := '2000';
   SpnlMesArray[2, 14] := '8000';
   SpnlMesArray[2, 15] := '7000';
   SpnlMesArray[2, 16] := '5000';
   SpnlMesArray[2, 17] := '8000';
   SpnlMesArray[2, 18] := '7000';
   //Initialise Tech level
   SpnlMesArray[3, 0] := '0';
   SpnlMesArray[3, 1] := '11';
   SpnlMesArray[3, 2] := '11';
   SpnlMesArray[3, 3] := '12';
   SpnlMesArray[3, 4] := '12';
   SpnlMesArray[3, 5] := '13';
   SpnlMesArray[3, 6] := '13';
   SpnlMesArray[3, 7] := '14';
   SpnlMesArray[3, 8] := '14';
   SpnlMesArray[3, 9] := '15';
   SpnlMesArray[3, 10] := '12';
   SpnlMesArray[3, 11] := '13';
   SpnlMesArray[3, 12] := '14';
   SpnlMesArray[3, 13] := '15';
   SpnlMesArray[3, 14] := '13';
   SpnlMesArray[3, 15] := '14';
   SpnlMesArray[3, 16] := '15';
   SpnlMesArray[3, 17] := '14';
   SpnlMesArray[3, 18] := '15';
   //Initialise Cost
   SpnlMesArray[4, 0] := '0';
   SpnlMesArray[4, 1] := '10000';
   SpnlMesArray[4, 2] := '12000';
   SpnlMesArray[4, 3] := '3000';
   SpnlMesArray[4, 4] := '5000';
   SpnlMesArray[4, 5] := '800';
   SpnlMesArray[4, 6] := '1000';
   SpnlMesArray[4, 7] := '400';
   SpnlMesArray[4, 8] := '600';
   SpnlMesArray[4, 9] := '400';
   SpnlMesArray[4, 10] := '10000';
   SpnlMesArray[4, 11] := '3000';
   SpnlMesArray[4, 12] := '800';
   SpnlMesArray[4, 13] := '600';
   SpnlMesArray[4, 14] := '5000';
   SpnlMesArray[4, 15] := '1000';
   SpnlMesArray[4, 16] := '800';
   SpnlMesArray[4, 17] := '2000';
   SpnlMesArray[4, 18] := '1000';
   //Initialise EP
   SpnlMesArray[5, 0] := '0';
   SpnlMesArray[5, 1] := '500';
   SpnlMesArray[5, 2] := '600';
   SpnlMesArray[5, 3] := '600';
   SpnlMesArray[5, 4] := '700';
   SpnlMesArray[5, 5] := '700';
   SpnlMesArray[5, 6] := '800';
   SpnlMesArray[5, 7] := '800';
   SpnlMesArray[5, 8] := '900';
   SpnlMesArray[5, 9] := '900';
   SpnlMesArray[5, 10] := '1000';
   SpnlMesArray[5, 11] := '1000';
   SpnlMesArray[5, 12] := '1000';
   SpnlMesArray[5, 13] := '1000';
   SpnlMesArray[5, 14] := '1100';
   SpnlMesArray[5, 15] := '1100';
   SpnlMesArray[5, 16] := '1100';
   SpnlMesArray[5, 17] := '1200';
   SpnlMesArray[5, 18] := '1200';

   //Initialise Spinal PA Data
   //Initialise Code
   SpnlPAArray[1, 0] := '0 None';
   SpnlPAArray[1, 1] := 'A PA';
   SpnlPAArray[1, 2] := 'B PA';
   SpnlPAArray[1, 3] := 'C PA';
   SpnlPAArray[1, 4] := 'D PA';
   SpnlPAArray[1, 5] := 'E PA';
   SpnlPAArray[1, 6] := 'F PA';
   SpnlPAArray[1, 7] := 'G PA';
   SpnlPAArray[1, 8] := 'H PA';
   SpnlPAArray[1, 9] := 'J PA';
   SpnlPAArray[1, 10] := 'K PA';
   SpnlPAArray[1, 11] := 'L PA';
   SpnlPAArray[1, 12] := 'M PA';
   SpnlPAArray[1, 13] := 'N PA';
   SpnlPAArray[1, 14] := 'P PA';
   SpnlPAArray[1, 15] := 'Q PA';
   SpnlPAArray[1, 16] := 'R PA';
   SpnlPAArray[1, 17] := 'S PA';
   SpnlPAArray[1, 18] := 'T PA';
   //Initialise Tonnage
   SpnlPAArray[2, 0] := '0';
   SpnlPAArray[2, 1] := '5500';
   SpnlPAArray[2, 2] := '5000';
   SpnlPAArray[2, 3] := '4500';
   SpnlPAArray[2, 4] := '4000';
   SpnlPAArray[2, 5] := '3500';
   SpnlPAArray[2, 6] := '3000';
   SpnlPAArray[2, 7] := '2500';
   SpnlPAArray[2, 8] := '2500';
   SpnlPAArray[2, 9] := '5000';
   SpnlPAArray[2, 10] := '4500';
   SpnlPAArray[2, 11] := '4000';
   SpnlPAArray[2, 12] := '3500';
   SpnlPAArray[2, 13] := '3000';
   SpnlPAArray[2, 14] := '2500';
   SpnlPAArray[2, 15] := '4500';
   SpnlPAArray[2, 16] := '4000';
   SpnlPAArray[2, 17] := '3500';
   SpnlPAArray[2, 18] := '3000';
   //Initialise Tech level
   SpnlPAArray[3, 0] := '0';
   SpnlPAArray[3, 1] := '8';
   SpnlPAArray[3, 2] := '9';
   SpnlPAArray[3, 3] := '10';
   SpnlPAArray[3, 4] := '11';
   SpnlPAArray[3, 5] := '12';
   SpnlPAArray[3, 6] := '13';
   SpnlPAArray[3, 7] := '14';
   SpnlPAArray[3, 8] := '15';
   SpnlPAArray[3, 9] := '10';
   SpnlPAArray[3, 10] := '11';
   SpnlPAArray[3, 11] := '12';
   SpnlPAArray[3, 12] := '13';
   SpnlPAArray[3, 13] := '14';
   SpnlPAArray[3, 14] := '15';
   SpnlPAArray[3, 15] := '12';
   SpnlPAArray[3, 16] := '13';
   SpnlPAArray[3, 17] := '14';
   SpnlPAArray[3, 18] := '15';
   //Initialise Cost
   SpnlPAArray[4, 0] := '0';
   SpnlPAArray[4, 1] := '3500';
   SpnlPAArray[4, 2] := '3000';
   SpnlPAArray[4, 3] := '2400';
   SpnlPAArray[4, 4] := '1500';
   SpnlPAArray[4, 5] := '1200';
   SpnlPAArray[4, 6] := '1200';
   SpnlPAArray[4, 7] := '800';
   SpnlPAArray[4, 8] := '500';
   SpnlPAArray[4, 9] := '3000';
   SpnlPAArray[4, 10] := '2000';
   SpnlPAArray[4, 11] := '1600';
   SpnlPAArray[4, 12] := '1200';
   SpnlPAArray[4, 13] := '1000';
   SpnlPAArray[4, 14] := '800';
   SpnlPAArray[4, 15] := '2000';
   SpnlPAArray[4, 16] := '1500';
   SpnlPAArray[4, 17] := '1200';
   SpnlPAArray[4, 18] := '1000';
   //Initialise EP
   SpnlPAArray[5, 0] := '0';
   SpnlPAArray[5, 1] := '500';
   SpnlPAArray[5, 2] := '500';
   SpnlPAArray[5, 3] := '500';
   SpnlPAArray[5, 4] := '600';
   SpnlPAArray[5, 5] := '600';
   SpnlPAArray[5, 6] := '600';
   SpnlPAArray[5, 7] := '700';
   SpnlPAArray[5, 8] := '700';
   SpnlPAArray[5, 9] := '800';
   SpnlPAArray[5, 10] := '800';
   SpnlPAArray[5, 11] := '800';
   SpnlPAArray[5, 12] := '900';
   SpnlPAArray[5, 13] := '900';
   SpnlPAArray[5, 14] := '900';
   SpnlPAArray[5, 15] := '1000';
   SpnlPAArray[5, 16] := '1000';
   SpnlPAArray[5, 17] := '1000';
   SpnlPAArray[5, 18] := '1000';

   //Initialise Nuclear Damper Data
   //Initialise Code
   NucDampArray[1, 0] := '0';
   NucDampArray[1, 1] := '1';
   NucDampArray[1, 2] := '2';
   NucDampArray[1, 3] := '3';
   NucDampArray[1, 4] := '4';
   NucDampArray[1, 5] := '5';
   NucDampArray[1, 6] := '6';
   NucDampArray[1, 7] := '7';
   NucDampArray[1, 8] := '8';
   NucDampArray[1, 9] := '9';
   //Initialise Tech Level
   NucDampArray[2, 0] := '0';
   NucDampArray[2, 1] := '12';
   NucDampArray[2, 2] := '13';
   NucDampArray[2, 3] := '13';
   NucDampArray[2, 4] := '14';
   NucDampArray[2, 5] := '14';
   NucDampArray[2, 6] := '14';
   NucDampArray[2, 7] := '15';
   NucDampArray[2, 8] := '15';
   NucDampArray[2, 9] := '15';
   //Initialise Tonnage
   NucDampArray[3, 0] := '0';
   NucDampArray[3, 1] := '50';
   NucDampArray[3, 2] := '15';
   NucDampArray[3, 3] := '20';
   NucDampArray[3, 4] := '8';
   NucDampArray[3, 5] := '10';
   NucDampArray[3, 6] := '12';
   NucDampArray[3, 7] := '10';
   NucDampArray[3, 8] := '15';
   NucDampArray[3, 9] := '20';
   //Initialise Cost
   NucDampArray[4, 0] := '0';
   NucDampArray[4, 1] := '50';
   NucDampArray[4, 2] := '40';
   NucDampArray[4, 3] := '45';
   NucDampArray[4, 4] := '30';
   NucDampArray[4, 5] := '35';
   NucDampArray[4, 6] := '38';
   NucDampArray[4, 7] := '30';
   NucDampArray[4, 8] := '40';
   NucDampArray[4, 9] := '50';
   //Initialise EP
   NucDampArray[5, 0] := '0';
   NucDampArray[5, 1] := '10';
   NucDampArray[5, 2] := '20';
   NucDampArray[5, 3] := '30';
   NucDampArray[5, 4] := '40';
   NucDampArray[5, 5] := '50';
   NucDampArray[5, 6] := '60';
   NucDampArray[5, 7] := '70';
   NucDampArray[5, 8] := '80';
   NucDampArray[5, 9] := '90';

   //Initialise Meson Screen Data
   //Initialise Code
   MesScrnArray[1, 0] := '0';
   MesScrnArray[1, 1] := '1';
   MesScrnArray[1, 2] := '2';
   MesScrnArray[1, 3] := '3';
   MesScrnArray[1, 4] := '4';
   MesScrnArray[1, 5] := '5';
   MesScrnArray[1, 6] := '6';
   MesScrnArray[1, 7] := '7';
   MesScrnArray[1, 8] := '8';
   MesScrnArray[1, 9] := '9';
   //Initialise Tech Level
   MesScrnArray[2, 0] := '0';
   MesScrnArray[2, 1] := '12';
   MesScrnArray[2, 2] := '13';
   MesScrnArray[2, 3] := '13';
   MesScrnArray[2, 4] := '14';
   MesScrnArray[2, 5] := '14';
   MesScrnArray[2, 6] := '14';
   MesScrnArray[2, 7] := '15';
   MesScrnArray[2, 8] := '15';
   MesScrnArray[2, 9] := '15';
   //Initialise Tonnage
   MesScrnArray[3, 0] := '0';
   MesScrnArray[3, 1] := '90';
   MesScrnArray[3, 2] := '30';
   MesScrnArray[3, 3] := '45';
   MesScrnArray[3, 4] := '16';
   MesScrnArray[3, 5] := '20';
   MesScrnArray[3, 6] := '24';
   MesScrnArray[3, 7] := '20';
   MesScrnArray[3, 8] := '30';
   MesScrnArray[3, 9] := '40';
   //Initialise Cost
   MesScrnArray[4, 0] := '0';
   MesScrnArray[4, 1] := '80';
   MesScrnArray[4, 2] := '50';
   MesScrnArray[4, 3] := '55';
   MesScrnArray[4, 4] := '40';
   MesScrnArray[4, 5] := '45';
   MesScrnArray[4, 6] := '50';
   MesScrnArray[4, 7] := '40';
   MesScrnArray[4, 8] := '50';
   MesScrnArray[4, 9] := '60';
   //Initialise EP
   MesScrnArray[5, 0] := '0.0';
   MesScrnArray[5, 1] := '0.2';
   MesScrnArray[5, 2] := '0.4';
   MesScrnArray[5, 3] := '0.6';
   MesScrnArray[5, 4] := '0.8';
   MesScrnArray[5, 5] := '1.0';
   MesScrnArray[5, 6] := '1.2';
   MesScrnArray[5, 7] := '1.4';
   MesScrnArray[5, 8] := '1.6';
   MesScrnArray[5, 9] := '1.8';

   //Initialise Black Globe Data
   //Initialise Code
   BlkGlbArray[1, 0] := '0';
   BlkGlbArray[1, 1] := '1';
   BlkGlbArray[1, 2] := '2';
   BlkGlbArray[1, 3] := '3';
   BlkGlbArray[1, 4] := '4';
   BlkGlbArray[1, 5] := '5';
   BlkGlbArray[1, 6] := '6';
   BlkGlbArray[1, 7] := '7';
   BlkGlbArray[1, 8] := '8';
   BlkGlbArray[1, 9] := '9';
   //Initialise Tech Level
   BlkGlbArray[2, 0] := '0';
   BlkGlbArray[2, 1] := '15';
   BlkGlbArray[2, 2] := '15';
   BlkGlbArray[2, 3] := '15';
   BlkGlbArray[2, 4] := '15';
   BlkGlbArray[2, 5] := '16';
   BlkGlbArray[2, 6] := '16';
   BlkGlbArray[2, 7] := '16';
   BlkGlbArray[2, 8] := '17';
   BlkGlbArray[2, 9] := '18';
   //Initialise Tonnage
   BlkGlbArray[3, 0] := '0';
   BlkGlbArray[3, 1] := '10';
   BlkGlbArray[3, 2] := '15';
   BlkGlbArray[3, 3] := '20';
   BlkGlbArray[3, 4] := '25';
   BlkGlbArray[3, 5] := '20';
   BlkGlbArray[3, 6] := '30';
   BlkGlbArray[3, 7] := '35';
   BlkGlbArray[3, 8] := '20';
   BlkGlbArray[3, 9] := '20';
   //Initialise Cost
   BlkGlbArray[4, 0] := '0';
   BlkGlbArray[4, 1] := '400';
   BlkGlbArray[4, 2] := '600';
   BlkGlbArray[4, 3] := '800';
   BlkGlbArray[4, 4] := '1000';
   BlkGlbArray[4, 5] := '0';
   BlkGlbArray[4, 6] := '0';
   BlkGlbArray[4, 7] := '0';
   BlkGlbArray[4, 8] := '0';
   BlkGlbArray[4, 9] := '0';
end;

procedure TData.CreateDataFiles(TheFile: String);
//if the data files don't exist create them

var
   DataList : TStringList;
begin
   DataList := TStringList.Create;
   try
      DataList.Add(':Standard Units');
      DataList.Add('');
      DataList.Add(':Computer Data');
      DataList.Add(':Code,Cost,Tonnage,Ship,Tech,EP,Description,Jump');
      DataList.Add('"0","0","0","0","0","0","0 None","0"');
      DataList.Add('"1","2","1","6","5","0","1 Model/1","1"');
      DataList.Add('"A","3","2","6","7","0","A Model/1fib","1"');
      DataList.Add('"R","4","1","6","6","0","R Model/1bis","2"');
      DataList.Add('"2","9","2","A","7","0","2 Model/2","2"');
      DataList.Add('"B","14","4","A","7","0","B Model/2fib","2"');
      DataList.Add('"S","18","2","A","8","0","S Model/2bis","3"');
      DataList.Add('"3","18","3","D","9","1","3 Model/3","3"');
      DataList.Add('"C","27","6","D","9","1","C Model/3fib","3"');
      DataList.Add('"4","30","4","K","10","2","4 Model/4","4"');
      DataList.Add('"D","45","8","K","10","2","D Model/4fib","4"');
      DataList.Add('"5","45","5","P","11","3","5 Model/5","5"');
      DataList.Add('"E","68","10","P","11","3","E Model/5fib","5"');
      DataList.Add('"6","55","7","R","12","5","6 Model/6","6"');
      DataList.Add('"F","83","14","R","12","5","F Model/6fib","6"');
      DataList.Add('"7","80","9","Y","13","7","7 Model/7","6"');
      DataList.Add('"G","100","18","Y","13","7","G Model/7fib","6"');
      DataList.Add('"8","110","11","Z","14","9","8 Model/8","6"');
      DataList.Add('"H","140","22","Z","14","9","H Model/8fib","6"');
      DataList.Add('"9","140","13","Z","15","12","9 Model/9","6"');
      DataList.Add('"J","200","26","Z","15","12","J Model/9fib","6"');
      DataList.Add('');
      DataList.Add(':Spinal Meson Data');
      DataList.Add(':Code,Tonnage,Tech,Cost,EP');
      DataList.Add('"0 None","0","0","0","0"');
      DataList.Add('"A Meson","5000","11","10000","500"');
      DataList.Add('"B Meson","8000","11","12000","600"');
      DataList.Add('"C Meson","2000","12","3000","600"');
      DataList.Add('"D Meson","5000","12","5000","700"');
      DataList.Add('"E Meson","1000","13","800","700"');
      DataList.Add('"F Meson","2000","13","1000","800"');
      DataList.Add('"G Meson","1000","14","400","800"');
      DataList.Add('"H Meson","2000","14","600","900"');
      DataList.Add('"J Meson","1000","15","400","900"');
      DataList.Add('"K Meson","8000","12","10000","1000"');
      DataList.Add('"L Meson","5000","13","3000","1000"');
      DataList.Add('"M Meson","4000","14","800","1000"');
      DataList.Add('"N Meson","2000","15","600","1000"');
      DataList.Add('"P Meson","8000","13","5000","1100"');
      DataList.Add('"Q Meson","7000","14","1000","1100"');
      DataList.Add('"R Meson","5000","15","800","1100"');
      DataList.Add('"S Meson","8000","14","2000","1200"');
      DataList.Add('"T Meson","7000","15","1000","1200"');
      DataList.Add('');
      DataList.Add(':Spinal PA Data');
      DataList.Add(':Code,Tonnage,Tech,Cost,EP');
      DataList.Add('"0 None","0","0","0","0"');
      DataList.Add('"A PA","5500","8","3500","500"');
      DataList.Add('"B PA","5000","9","3000","500"');
      DataList.Add('"C PA","4500","10","2400","500"');
      DataList.Add('"D PA","4000","11","1500","600"');
      DataList.Add('"E PA","3500","12","1200","600"');
      DataList.Add('"F PA","3000","13","1200","600"');
      DataList.Add('"G PA","2500","14","800","700"');
      DataList.Add('"H PA","2500","15","500","700"');
      DataList.Add('"J PA","5000","10","3000","800"');
      DataList.Add('"K PA","4500","11","2000","800"');
      DataList.Add('"L PA","4000","12","1600","800"');
      DataList.Add('"M PA","3500","13","1200","900"');
      DataList.Add('"N PA","3000","14","1000","900"');
      DataList.Add('"P PA","2500","15","800","900"');
      DataList.Add('"Q PA","4500","12","2000","1000"');
      DataList.Add('"R PA","4000","13","1500","1000"');
      DataList.Add('"S PA","3500","14","1200","1000"');
      DataList.Add('"T PA","3000","15","1000","1000"');
      DataList.Add('');
      DataList.Add(':Nuclear Damper Data');
      DataList.Add(':Code,Tech,Tonnage,Cost,EP');
      DataList.Add('"0","0","0","0","0"');
      DataList.Add('"1","12","50","50","10"');
      DataList.Add('"2","13","15","40","20"');
      DataList.Add('"3","13","20","45","30"');
      DataList.Add('"4","14","8","30","40"');
      DataList.Add('"5","14","10","35","50"');
      DataList.Add('"6","14","12","38","60"');
      DataList.Add('"7","15","10","30","70"');
      DataList.Add('"8","15","15","40","80"');
      DataList.Add('"9","15","20","50","90"');
      DataList.Add('');
      DataList.Add(':Meson Screen Data');
      DataList.Add(':Code,Tech,Tonnage,Cost,EP');
      DataList.Add('"0","0","0","0","0.0"');
      DataList.Add('"1","12","90","80","0.2"');
      DataList.Add('"2","13","30","50","0.4"');
      DataList.Add('"3","13","45","55","0.6"');
      DataList.Add('"4","14","16","40","0.8"');
      DataList.Add('"5","14","20","45","1.0"');
      DataList.Add('"6","14","24","50","1.2"');
      DataList.Add('"7","15","20","40","1.4"');
      DataList.Add('"8","15","30","50","1.6"');
      DataList.Add('"9","15","40","60","1.8"');
      DataList.Add('');
      DataList.Add(':Black Globe Data');
      DataList.Add(':Code,Tech,Tonnage,Cost');
      DataList.Add('"0","0","0","0"');
      DataList.Add('"1","15","10","400"');
      DataList.Add('"2","15","15","600"');
      DataList.Add('"3","15","20","800"');
      DataList.Add('"4","15","25","1000"');
      DataList.Add('"5","16","20","0"');
      DataList.Add('"6","16","30","0"');
      DataList.Add('"7","16","35","0"');
      DataList.Add('"8","17","20","0"');
      DataList.Add('"9","18","20","0"');
      DataList.SaveToFile(TheFile);
  finally
      FreeAndNil(DataList);
   end;
end;

procedure TData.ReadDataFiles(UseStd: Boolean);
//read in the data files selecting standard or user defined

var
   CompDataList : TStringList;
   iCol, iRow : Integer;
begin
   CompDataList := TStringList.Create;
   try
      if (UseStd) then begin
         //
      end
      else begin
         //
      end;
   finally
      FreeAndNil(CompDataList)
   end;
end;

end.
