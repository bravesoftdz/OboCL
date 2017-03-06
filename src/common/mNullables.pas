// This is part of the Obo Component Library
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.
//
// This software is distributed without any warranty.
//
// @author Domenico Mammola (mimmo71@gmail.com - www.mammola.net)

unit mNullables;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

type

  { TAbstractNullable }

  TAbstractNullable = class abstract
  protected
    FIsNull : Boolean;
  public
    constructor Create(); virtual;
    property IsNull : Boolean read FIsNull write FIsNull;
  end;

  { TNullableUnicodeString }

  TNullableUnicodeString = class (TAbstractNullable)
    private
      FValue : UnicodeString;
      function GetValue: UnicodeString;
      procedure SetValue(AValue: UnicodeString);
    public
      class function CreateNew(aValue: UnicodeString): TNullableUnicodeString; overload;
      class function CreateNew(): TNullableUnicodeString; overload;

      property Value : UnicodeString read GetValue write SetValue;
  end;

  { TNullableAnsiString }

  TNullableAnsiString = class (TAbstractNullable)
    private
      FValue : AnsiString;
      function GetValue: AnsiString;
      procedure SetValue(AValue: AnsiString);
    public
      class function CreateNew(aValue: AnsiString): TNullableAnsiString; overload;
      class function CreateNew(): TNullableAnsiString; overload;

      property Value : AnsiString read GetValue write SetValue;
  end;


  { TNullableDateTime }

  TNullableDateTime = class(TAbstractNullable)
    private
      FValue : TDateTime;
      function GetValue : TDateTime;
      procedure SetValue (AValue : TDateTime);
    public
      class function CreateNew(aValue : TDateTime) : TNullableDateTime; overload;
      class function CreateNew() : TNullableDateTime; overload;

      property Value : TDateTime read GetValue write SetValue;
  end;

  { TNullableDouble }

  TNullableDouble = class (TAbstractNullable)
  private
    FValue : Double;
    function GetValue : Double;
    procedure SetValue (AValue : Double);
  public
    class function CreateNew(aValue : Double) : TNullableDouble; overload;
    class function CreateNew() : TNullableDouble; overload;

    property Value : Double read GetValue write SetValue;
  end;


implementation

{ TNullableDouble }

function TNullableDouble.GetValue: Double;
begin
  Result := FValue;
end;

procedure TNullableDouble.SetValue(AValue: Double);
begin
  FValue:= aValue;
  FIsNull := false;
end;

class function TNullableDouble.CreateNew(aValue: Double): TNullableDouble;
var
  tmp : TNullableDouble;
begin
  tmp := TNullableDouble.Create();
  tmp.Value := aValue;
  Result := tmp;
end;

class function TNullableDouble.CreateNew: TNullableDouble;
begin
  Result := TNullableDouble.Create();
end;

{ TNullableAnsiString }

function TNullableAnsiString.GetValue: AnsiString;
begin
  if (FIsNull) then
     Result := null
  else
    Result := FValue;
end;

procedure TNullableAnsiString.SetValue(AValue: AnsiString);
begin
  FValue:= aValue;
  FIsNull := false;
end;

class function TNullableAnsiString.CreateNew(aValue: AnsiString): TNullableAnsiString;
var
  tmp : TNullableAnsiString;
begin
  tmp := TNullableAnsiString.Create();
  tmp.Value := aValue;
  Result := tmp;
end;

class function TNullableAnsiString.CreateNew: TNullableAnsiString;
begin
  Result := TNullableAnsiString.Create();
end;

{ TNullableDateTime }

function TNullableDateTime.GetValue: TDateTime;
begin
  Result := FValue;
end;

procedure TNullableDateTime.SetValue(AValue: TDateTime);
begin
  FValue:= aValue;
  FIsNull := false;
end;

class function TNullableDateTime.CreateNew(aValue: TDateTime): TNullableDateTime;
var
  tmp : TNullableDateTime;
begin
  tmp := TNullableDateTime.Create();
  tmp.Value := aValue;
  Result := tmp;
end;

class function TNullableDateTime.CreateNew: TNullableDateTime;
begin
  Result := TNullableDateTime.Create();
end;

{ TAbstractNullable }

constructor TAbstractNullable.Create;
begin
  FIsNull := true;
end;

{ TNullableUnicodeString }


function TNullableUnicodeString.GetValue: UnicodeString;
begin
  if (FIsNull) then
     Result := null
  else
    Result := FValue;
end;

procedure TNullableUnicodeString.SetValue(AValue: UnicodeString);
begin
  FValue:= aValue;
  FIsNull := False;
end;


class function TNullableUnicodeString.CreateNew(aValue: UnicodeString): TNullableUnicodeString;
var
  tmp : TNullableUnicodeString;
begin
  tmp := TNullableUnicodeString.Create();
  tmp.Value := aValue;
  Result := tmp;
end;

class function TNullableUnicodeString.CreateNew: TNullableUnicodeString;
begin
  Result := TNullableUnicodeString.Create();
end;

end.