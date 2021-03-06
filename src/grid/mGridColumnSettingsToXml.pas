// This is part of the Mommon Library
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.
//
// This software is distributed without any warranty.
//
// @author Domenico Mammola (mimmo71@gmail.com - www.mammola.net)
unit mGridColumnSettingsToXml;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  mXML, mGridColumnSettings;


procedure SaveGridColumnSettingToXmlElement (const aSource : TmGridColumnSettings; aXmlElement : TmXmlElement);
procedure LoadGridColumnSettingFromXmlElement (aDestination : TmGridColumnSettings; aXmlElement : TmXmlElement);

procedure SaveGridColumnsSettingToXmlElement (const aSource : TmGridColumnsSettings; aXmlElement : TmXmlElement);
procedure LoadGridColumnsSettingFromXmlElement (aDestination : TmGridColumnsSettings; aXmlElement : TmXmlElement);


implementation

uses
  SysUtils;

procedure SaveGridColumnSettingToXmlElement(const aSource: TmGridColumnSettings; aXmlElement: TmXmlElement);
begin
  if aSource.Visible.NotNull then
    aXmlElement.SetAttribute('visible', BoolToStr(aSource.Visible.Value, true));
  if aSource.DisplayFormat.NotNull then
    aXmlElement.SetAttribute('displayFormat', aSource.DisplayFormat.Value);
  if aSource.DisplayLabel.NotNull then
    aXmlElement.SetAttribute('displayLabel', aSource.DisplayLabel.Value);
  if aSource.Width.NotNull then
    aXmlElement.SetIntegerAttribute('width', aSource.Width.Value);
  if aSource.SortOrder.NotNull then
    aXmlElement.SetIntegerAttribute('sortOrder', aSource.SortOrder.Value);
  aXmlElement.SetAttribute('fieldName', aSource.FieldName);
end;

procedure LoadGridColumnSettingFromXmlElement(aDestination: TmGridColumnSettings; aXmlElement: TmXmlElement);
begin
  aDestination.Clear;
  if aXmlElement.HasAttribute('visible') then
    aDestination.Visible.Value := StrToBool(aXmlElement.GetAttribute('visible'));
  if aXmlElement.HasAttribute('displayFormat') then
    aDestination.DisplayFormat.Value := aXmlElement.GetAttribute('displayFormat');
  if aXmlElement.HasAttribute('displayLabel') then
  begin
    aDestination.DisplayLabel.Value := aXmlElement.GetAttribute('displayLabel');
    {$IFDEF DEBUG_COL_SET}DebugLn('[TmGridColumnSettings.LoadFromXmlElement] ' + FieldName + ' displayLabel:' + FDisplayLabel.Value);{$ENDIF}
  end;
  if aXmlElement.HasAttribute('width') then
    aDestination.Width.Value := aXmlElement.GetIntegerAttribute('width');
  if aXmlElement.HasAttribute('sortOrder') then
    aDestination.SortOrder.Value := aXmlElement.GetIntegerAttribute('sortOrder');
end;

procedure SaveGridColumnsSettingToXmlElement(const aSource: TmGridColumnsSettings; aXmlElement: TmXmlElement);
var
  i : integer;
begin
  for i := 0 to aSource.Count - 1 do
  begin
    SaveGridColumnSettingToXmlElement(aSource.Get(i), aXmlElement.AddElement('column'));
  end;
end;

procedure LoadGridColumnsSettingFromXmlElement(aDestination: TmGridColumnsSettings; aXmlElement: TmXmlElement);
var
  tmpCursor : TmXmlElementCursor;
  i : integer;
  op : TmGridColumnSettings;
begin
  aDestination.Clear;
  tmpCursor := TmXmlElementCursor.Create(aXmlElement, 'column');
  try
    for i := 0 to tmpCursor.Count - 1 do
    begin
      op := aDestination.AddSettingsForField(tmpCursor.Elements[i].GetAttribute('fieldName'));
      LoadGridColumnSettingFromXmlElement(op, tmpCursor.Elements[i]);
    end;
  finally
    tmpCursor.Free;
  end;
end;

end.
