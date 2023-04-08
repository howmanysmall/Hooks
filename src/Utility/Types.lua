--!optimize 2
--!strict

--[=[
	@interface ColorData
	.Default Color3 -- The `Enum.StudioStyleGuideModifier.Default` Color3.
	.Disabled Color3 -- The `Enum.StudioStyleGuideModifier.Disabled` Color3.
	.Hover Color3 -- The `Enum.StudioStyleGuideModifier.Hover` Color3.
	.Pressed Color3 -- The `Enum.StudioStyleGuideModifier.Pressed` Color3.
	.Selected Color3 -- The `Enum.StudioStyleGuideModifier.Selected` Color3.
	@within Types
]=]
export type ColorData = {
	Default: Color3,
	Disabled: Color3,
	Hover: Color3,
	Pressed: Color3,
	Selected: Color3,
}

--[=[
	@interface ThemeData
	.ThemeName "Dark" | "Light" -- The name of the current theme.
	.GetColor (StudioStyleGuideColor: Enum.StudioStyleGuideColor, StudioStyleGuideModifier?: Enum.StudioStyleGuideModifier) -> Color3 -- A function that returns a Color3 based on the given `Enum.StudioStyleGuideColor` and `Enum.StudioStyleGuideModifier`.
	.AttributeCog ColorData -- The `Enum.StudioStyleGuideColor.AttributeCog` theme entry.
	.Border ColorData -- The `Enum.StudioStyleGuideColor.Border` theme entry.
	.BrightText ColorData -- The `Enum.StudioStyleGuideColor.BrightText` theme entry.
	.Button ColorData -- The `Enum.StudioStyleGuideColor.Button` theme entry.
	.ButtonBorder ColorData -- The `Enum.StudioStyleGuideColor.ButtonBorder` theme entry.
	.ButtonText ColorData -- The `Enum.StudioStyleGuideColor.ButtonText` theme entry.
	.CategoryItem ColorData -- The `Enum.StudioStyleGuideColor.CategoryItem` theme entry.
	.ChatIncomingBgColor ColorData -- The `Enum.StudioStyleGuideColor.ChatIncomingBgColor` theme entry.
	.ChatIncomingTextColor ColorData -- The `Enum.StudioStyleGuideColor.ChatIncomingTextColor` theme entry.
	.ChatModeratedMessageColor ColorData -- The `Enum.StudioStyleGuideColor.ChatModeratedMessageColor` theme entry.
	.ChatOutgoingBgColor ColorData -- The `Enum.StudioStyleGuideColor.ChatOutgoingBgColor` theme entry.
	.ChatOutgoingTextColor ColorData -- The `Enum.StudioStyleGuideColor.ChatOutgoingTextColor` theme entry.
	.CheckedFieldBackground ColorData -- The `Enum.StudioStyleGuideColor.CheckedFieldBackground` theme entry.
	.CheckedFieldBorder ColorData -- The `Enum.StudioStyleGuideColor.CheckedFieldBorder` theme entry.
	.CheckedFieldIndicator ColorData -- The `Enum.StudioStyleGuideColor.CheckedFieldIndicator` theme entry.
	.ColorPickerFrame ColorData -- The `Enum.StudioStyleGuideColor.ColorPickerFrame` theme entry.
	.CurrentMarker ColorData -- The `Enum.StudioStyleGuideColor.CurrentMarker` theme entry.
	.Dark ColorData -- The `Enum.StudioStyleGuideColor.Dark` theme entry.
	.DebuggerCurrentLine ColorData -- The `Enum.StudioStyleGuideColor.DebuggerCurrentLine` theme entry.
	.DebuggerErrorLine ColorData -- The `Enum.StudioStyleGuideColor.DebuggerErrorLine` theme entry.
	.DialogButton ColorData -- The `Enum.StudioStyleGuideColor.DialogButton` theme entry.
	.DialogButtonBorder ColorData -- The `Enum.StudioStyleGuideColor.DialogButtonBorder` theme entry.
	.DialogButtonText ColorData -- The `Enum.StudioStyleGuideColor.DialogButtonText` theme entry.
	.DialogMainButton ColorData -- The `Enum.StudioStyleGuideColor.DialogMainButton` theme entry.
	.DialogMainButtonText ColorData -- The `Enum.StudioStyleGuideColor.DialogMainButtonText` theme entry.
	.DiffFilePathBackground ColorData -- The `Enum.StudioStyleGuideColor.DiffFilePathBackground` theme entry.
	.DiffFilePathBorder ColorData -- The `Enum.StudioStyleGuideColor.DiffFilePathBorder` theme entry.
	.DiffFilePathText ColorData -- The `Enum.StudioStyleGuideColor.DiffFilePathText` theme entry.
	.DiffLineNum ColorData -- The `Enum.StudioStyleGuideColor.DiffLineNum` theme entry.
	.DiffLineNumAdditionBackground ColorData -- The `Enum.StudioStyleGuideColor.DiffLineNumAdditionBackground` theme entry.
	.DiffLineNumDeletionBackground ColorData -- The `Enum.StudioStyleGuideColor.DiffLineNumDeletionBackground` theme entry.
	.DiffLineNumNoChangeBackground ColorData -- The `Enum.StudioStyleGuideColor.DiffLineNumNoChangeBackground` theme entry.
	.DiffLineNumSeparatorBackground ColorData -- The `Enum.StudioStyleGuideColor.DiffLineNumSeparatorBackground` theme entry.
	.DiffTextAddition ColorData -- The `Enum.StudioStyleGuideColor.DiffTextAddition` theme entry.
	.DiffTextAdditionBackground ColorData -- The `Enum.StudioStyleGuideColor.DiffTextAdditionBackground` theme entry.
	.DiffTextDeletion ColorData -- The `Enum.StudioStyleGuideColor.DiffTextDeletion` theme entry.
	.DiffTextDeletionBackground ColorData -- The `Enum.StudioStyleGuideColor.DiffTextDeletionBackground` theme entry.
	.DiffTextHunkInfo ColorData -- The `Enum.StudioStyleGuideColor.DiffTextHunkInfo` theme entry.
	.DiffTextNoChange ColorData -- The `Enum.StudioStyleGuideColor.DiffTextNoChange` theme entry.
	.DiffTextNoChangeBackground ColorData -- The `Enum.StudioStyleGuideColor.DiffTextNoChangeBackground` theme entry.
	.DiffTextSeparatorBackground ColorData -- The `Enum.StudioStyleGuideColor.DiffTextSeparatorBackground` theme entry.
	.DimmedText ColorData -- The `Enum.StudioStyleGuideColor.DimmedText` theme entry.
	.DocViewCodeBackground ColorData -- The `Enum.StudioStyleGuideColor.DocViewCodeBackground` theme entry.
	.Dropdown ColorData -- The `Enum.StudioStyleGuideColor.Dropdown` theme entry.
	.DropShadow ColorData -- The `Enum.StudioStyleGuideColor.DropShadow` theme entry.
	.EmulatorBar ColorData -- The `Enum.StudioStyleGuideColor.EmulatorBar` theme entry.
	.EmulatorDropDown ColorData -- The `Enum.StudioStyleGuideColor.EmulatorDropDown` theme entry.
	.ErrorText ColorData -- The `Enum.StudioStyleGuideColor.ErrorText` theme entry.
	.FilterButtonAccent ColorData -- The `Enum.StudioStyleGuideColor.FilterButtonAccent` theme entry.
	.FilterButtonBorder ColorData -- The `Enum.StudioStyleGuideColor.FilterButtonBorder` theme entry.
	.FilterButtonBorderAlt ColorData -- The `Enum.StudioStyleGuideColor.FilterButtonBorderAlt` theme entry.
	.FilterButtonChecked ColorData -- The `Enum.StudioStyleGuideColor.FilterButtonChecked` theme entry.
	.FilterButtonDefault ColorData -- The `Enum.StudioStyleGuideColor.FilterButtonDefault` theme entry.
	.FilterButtonHover ColorData -- The `Enum.StudioStyleGuideColor.FilterButtonHover` theme entry.
	.GameSettingsTableItem ColorData -- The `Enum.StudioStyleGuideColor.GameSettingsTableItem` theme entry.
	.GameSettingsTooltip ColorData -- The `Enum.StudioStyleGuideColor.GameSettingsTooltip` theme entry.
	.HeaderSection ColorData -- The `Enum.StudioStyleGuideColor.HeaderSection` theme entry.
	.InfoBarWarningBackground ColorData -- The `Enum.StudioStyleGuideColor.InfoBarWarningBackground` theme entry.
	.InfoBarWarningText ColorData -- The `Enum.StudioStyleGuideColor.InfoBarWarningText` theme entry.
	.InfoText ColorData -- The `Enum.StudioStyleGuideColor.InfoText` theme entry.
	.InputFieldBackground ColorData -- The `Enum.StudioStyleGuideColor.InputFieldBackground` theme entry.
	.InputFieldBorder ColorData -- The `Enum.StudioStyleGuideColor.InputFieldBorder` theme entry.
	.Item ColorData -- The `Enum.StudioStyleGuideColor.Item` theme entry.
	.Light ColorData -- The `Enum.StudioStyleGuideColor.Light` theme entry.
	.LinkText ColorData -- The `Enum.StudioStyleGuideColor.LinkText` theme entry.
	.MainBackground ColorData -- The `Enum.StudioStyleGuideColor.MainBackground` theme entry.
	.MainButton ColorData -- The `Enum.StudioStyleGuideColor.MainButton` theme entry.
	.MainText ColorData -- The `Enum.StudioStyleGuideColor.MainText` theme entry.
	.Mid ColorData -- The `Enum.StudioStyleGuideColor.Mid` theme entry.
	.Midlight ColorData -- The `Enum.StudioStyleGuideColor.Midlight` theme entry.
	.Notification ColorData -- The `Enum.StudioStyleGuideColor.Notification` theme entry.
	.RibbonButton ColorData -- The `Enum.StudioStyleGuideColor.RibbonButton` theme entry.
	.RibbonTab ColorData -- The `Enum.StudioStyleGuideColor.RibbonTab` theme entry.
	.RibbonTabTopBar ColorData -- The `Enum.StudioStyleGuideColor.RibbonTabTopBar` theme entry.
	.ScriptBackground ColorData -- The `Enum.StudioStyleGuideColor.ScriptBackground` theme entry.
	.ScriptBool ColorData -- The `Enum.StudioStyleGuideColor.ScriptBool` theme entry.
	.ScriptBracket ColorData -- The `Enum.StudioStyleGuideColor.ScriptBracket` theme entry.
	.ScriptBuiltInFunction ColorData -- The `Enum.StudioStyleGuideColor.ScriptBuiltInFunction` theme entry.
	.ScriptComment ColorData -- The `Enum.StudioStyleGuideColor.ScriptComment` theme entry.
	.ScriptEditorCurrentLine ColorData -- The `Enum.StudioStyleGuideColor.ScriptEditorCurrentLine` theme entry.
	.ScriptError ColorData -- The `Enum.StudioStyleGuideColor.ScriptError` theme entry.
	.ScriptFindSelectionBackground ColorData -- The `Enum.StudioStyleGuideColor.ScriptFindSelectionBackground` theme entry.
	.ScriptFunction ColorData -- The `Enum.StudioStyleGuideColor.ScriptFunction` theme entry.
	.ScriptFunctionName ColorData -- The `Enum.StudioStyleGuideColor.ScriptFunctionName` theme entry.
	.ScriptKeyword ColorData -- The `Enum.StudioStyleGuideColor.ScriptKeyword` theme entry.
	.ScriptLocal ColorData -- The `Enum.StudioStyleGuideColor.ScriptLocal` theme entry.
	.ScriptLuauKeyword ColorData -- The `Enum.StudioStyleGuideColor.ScriptLuauKeyword` theme entry.
	.ScriptMatchingWordSelectionBackground ColorData -- The `Enum.StudioStyleGuideColor.ScriptMatchingWordSelectionBackground` theme entry.
	.ScriptMethod ColorData -- The `Enum.StudioStyleGuideColor.ScriptMethod` theme entry.
	.ScriptNil ColorData -- The `Enum.StudioStyleGuideColor.ScriptNil` theme entry.
	.ScriptNumber ColorData -- The `Enum.StudioStyleGuideColor.ScriptNumber` theme entry.
	.ScriptOperator ColorData -- The `Enum.StudioStyleGuideColor.ScriptOperator` theme entry.
	.ScriptProperty ColorData -- The `Enum.StudioStyleGuideColor.ScriptProperty` theme entry.
	.ScriptRuler ColorData -- The `Enum.StudioStyleGuideColor.ScriptRuler` theme entry.
	.ScriptSelectionBackground ColorData -- The `Enum.StudioStyleGuideColor.ScriptSelectionBackground` theme entry.
	.ScriptSelectionText ColorData -- The `Enum.StudioStyleGuideColor.ScriptSelectionText` theme entry.
	.ScriptSelf ColorData -- The `Enum.StudioStyleGuideColor.ScriptSelf` theme entry.
	.ScriptSideWidget ColorData -- The `Enum.StudioStyleGuideColor.ScriptSideWidget` theme entry.
	.ScriptString ColorData -- The `Enum.StudioStyleGuideColor.ScriptString` theme entry.
	.ScriptText ColorData -- The `Enum.StudioStyleGuideColor.ScriptText` theme entry.
	.ScriptTodo ColorData -- The `Enum.StudioStyleGuideColor.ScriptTodo` theme entry.
	.ScriptWarning ColorData -- The `Enum.StudioStyleGuideColor.ScriptWarning` theme entry.
	.ScriptWhitespace ColorData -- The `Enum.StudioStyleGuideColor.ScriptWhitespace` theme entry.
	.ScrollBar ColorData -- The `Enum.StudioStyleGuideColor.ScrollBar` theme entry.
	.ScrollBarBackground ColorData -- The `Enum.StudioStyleGuideColor.ScrollBarBackground` theme entry.
	.SensitiveText ColorData -- The `Enum.StudioStyleGuideColor.SensitiveText` theme entry.
	.Separator ColorData -- The `Enum.StudioStyleGuideColor.Separator` theme entry.
	.Shadow ColorData -- The `Enum.StudioStyleGuideColor.Shadow` theme entry.
	.StatusBar ColorData -- The `Enum.StudioStyleGuideColor.StatusBar` theme entry.
	.SubText ColorData -- The `Enum.StudioStyleGuideColor.SubText` theme entry.
	.Tab ColorData -- The `Enum.StudioStyleGuideColor.Tab` theme entry.
	.TabBar ColorData -- The `Enum.StudioStyleGuideColor.TabBar` theme entry.
	.TableItem ColorData -- The `Enum.StudioStyleGuideColor.TableItem` theme entry.
	.Titlebar ColorData -- The `Enum.StudioStyleGuideColor.Titlebar` theme entry.
	.TitlebarText ColorData -- The `Enum.StudioStyleGuideColor.TitlebarText` theme entry.
	.Tooltip ColorData -- The `Enum.StudioStyleGuideColor.Tooltip` theme entry.
	.ViewPortBackground ColorData -- The `Enum.StudioStyleGuideColor.ViewPortBackground` theme entry.
	.WarningText ColorData -- The `Enum.StudioStyleGuideColor.WarningText` theme entry.
	@within Types
]=]
export type ThemeData = {
	GetColor: (
		StudioStyleGuideColor: Enum.StudioStyleGuideColor,
		StudioStyleGuideModifier: Enum.StudioStyleGuideModifier?
	) -> Color3,

	ThemeName: "Dark" | "Light",

	AttributeCog: ColorData,
	Border: ColorData,
	BrightText: ColorData,
	Button: ColorData,
	ButtonBorder: ColorData,
	ButtonText: ColorData,
	CategoryItem: ColorData,
	ChatIncomingBgColor: ColorData,
	ChatIncomingTextColor: ColorData,
	ChatModeratedMessageColor: ColorData,
	ChatOutgoingBgColor: ColorData,
	ChatOutgoingTextColor: ColorData,
	CheckedFieldBackground: ColorData,
	CheckedFieldBorder: ColorData,
	CheckedFieldIndicator: ColorData,
	ColorPickerFrame: ColorData,
	CurrentMarker: ColorData,
	Dark: ColorData,
	DebuggerCurrentLine: ColorData,
	DebuggerErrorLine: ColorData,
	DialogButton: ColorData,
	DialogButtonBorder: ColorData,
	DialogButtonText: ColorData,
	DialogMainButton: ColorData,
	DialogMainButtonText: ColorData,
	DiffFilePathBackground: ColorData,
	DiffFilePathBorder: ColorData,
	DiffFilePathText: ColorData,
	DiffLineNum: ColorData,
	DiffLineNumAdditionBackground: ColorData,
	DiffLineNumDeletionBackground: ColorData,
	DiffLineNumNoChangeBackground: ColorData,
	DiffLineNumSeparatorBackground: ColorData,
	DiffTextAddition: ColorData,
	DiffTextAdditionBackground: ColorData,
	DiffTextDeletion: ColorData,
	DiffTextDeletionBackground: ColorData,
	DiffTextHunkInfo: ColorData,
	DiffTextNoChange: ColorData,
	DiffTextNoChangeBackground: ColorData,
	DiffTextSeparatorBackground: ColorData,
	DimmedText: ColorData,
	DocViewCodeBackground: ColorData,
	Dropdown: ColorData,
	DropShadow: ColorData,
	EmulatorBar: ColorData,
	EmulatorDropDown: ColorData,
	ErrorText: ColorData,
	FilterButtonAccent: ColorData,
	FilterButtonBorder: ColorData,
	FilterButtonBorderAlt: ColorData,
	FilterButtonChecked: ColorData,
	FilterButtonDefault: ColorData,
	FilterButtonHover: ColorData,
	GameSettingsTableItem: ColorData,
	GameSettingsTooltip: ColorData,
	HeaderSection: ColorData,
	InfoBarWarningBackground: ColorData,
	InfoBarWarningText: ColorData,
	InfoText: ColorData,
	InputFieldBackground: ColorData,
	InputFieldBorder: ColorData,
	Item: ColorData,
	Light: ColorData,
	LinkText: ColorData,
	MainBackground: ColorData,
	MainButton: ColorData,
	MainText: ColorData,
	Mid: ColorData,
	Midlight: ColorData,
	Notification: ColorData,
	RibbonButton: ColorData,
	RibbonTab: ColorData,
	RibbonTabTopBar: ColorData,
	ScriptBackground: ColorData,
	ScriptBool: ColorData,
	ScriptBracket: ColorData,
	ScriptBuiltInFunction: ColorData,
	ScriptComment: ColorData,
	ScriptEditorCurrentLine: ColorData,
	ScriptError: ColorData,
	ScriptFindSelectionBackground: ColorData,
	ScriptFunction: ColorData,
	ScriptFunctionName: ColorData,
	ScriptKeyword: ColorData,
	ScriptLocal: ColorData,
	ScriptLuauKeyword: ColorData,
	ScriptMatchingWordSelectionBackground: ColorData,
	ScriptMethod: ColorData,
	ScriptNil: ColorData,
	ScriptNumber: ColorData,
	ScriptOperator: ColorData,
	ScriptProperty: ColorData,
	ScriptRuler: ColorData,
	ScriptSelectionBackground: ColorData,
	ScriptSelectionText: ColorData,
	ScriptSelf: ColorData,
	ScriptSideWidget: ColorData,
	ScriptString: ColorData,
	ScriptText: ColorData,
	ScriptTodo: ColorData,
	ScriptWarning: ColorData,
	ScriptWhitespace: ColorData,
	ScrollBar: ColorData,
	ScrollBarBackground: ColorData,
	SensitiveText: ColorData,
	Separator: ColorData,
	Shadow: ColorData,
	StatusBar: ColorData,
	SubText: ColorData,
	Tab: ColorData,
	TabBar: ColorData,
	TableItem: ColorData,
	Titlebar: ColorData,
	TitlebarText: ColorData,
	Tooltip: ColorData,
	ViewPortBackground: ColorData,
	WarningText: ColorData,
}

return false
