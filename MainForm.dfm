object FormMain: TFormMain
  Left = 192
  Top = 114
  Width = 800
  Height = 600
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  Caption = 'TCCDE'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 13
  object Toolbar: TKOLToolbar
    Tag = 0
    Left = 0
    Top = 0
    Width = 792
    Height = 20
    HelpContext = 0
    IgnoreDefault = False
    AnchorLeft = False
    AnchorTop = False
    AnchorRight = False
    AnchorBottom = False
    AcceptChildren = False
    MouseTransparent = False
    TabOrder = 0
    MinWidth = 0
    MinHeight = 0
    MaxWidth = 0
    MaxHeight = 0
    PlaceDown = False
    PlaceRight = False
    PlaceUnder = False
    Visible = True
    Enabled = True
    DoubleBuffered = False
    Align = caTop
    CenterOnParent = False
    Ctl3D = True
    Color = clBtnFace
    parentColor = True
    Font.Color = clWindowText
    Font.FontStyle = []
    Font.FontHeight = 0
    Font.FontWidth = 0
    Font.FontWeight = 0
    Font.FontName = 'MS Sans Serif'
    Font.FontOrientation = 0
    Font.FontCharset = 1
    Font.FontPitch = fpDefault
    Font.FontQuality = fqDefault
    parentFont = True
    EraseBackground = False
    Localizy = loForm
    Transparent = False
    Options = [tboFlat]
    buttons = '&New'#1'&Open...'#1'&Save'#1'-'#1'&Undo'#1'Cu&t'#1'&Copy'#1'&Paste'#1'-'#1'O&ptions...'
    noTextLabels = True
    tooltips.Strings = (
      'New file'
      'Open file'
      'Save file'
      'Undo'
      'Cut'
      'Copy'
      'Paste'
      'Options')
    showTooltips = True
    mapBitmapColors = True
    Border = 0
    MarginTop = 0
    MarginBottom = 0
    MarginLeft = 0
    MarginRight = 0
    HasBorder = False
    StandardImagesLarge = False
    generateConstants = False
    generateVariables = False
    TBButtonsMinWidth = 0
    TBButtonsMaxWidth = 0
    TBButtonsWidth = 0
    HeightAuto = True
    Brush.Color = clBtnFace
    Brush.BrushStyle = bsSolid
    imageListNormal = ToolbarImageList
    FixFlatXP = True
    CompactCode = False
    AutosizeButtons = True
    NoSpaceForImages = False
    Autosize = False
    Buttons_Count = 10
    Btn1Name = 'TB1'
    Btn1caption = '&New'
    Btn1checked = False
    Btn1dropdown = False
    Btn1enabled = True
    Btn1separator = False
    Btn1tooltip = 'New file'
    Btn1visible = True
    Btn1onClick = ''
    Btn1picture = ''
    Btn1sysimg = 0
    Btn1imgIndex = 0
    Btn2Name = 'TB2'
    Btn2caption = '&Open...'
    Btn2checked = False
    Btn2dropdown = False
    Btn2enabled = True
    Btn2separator = False
    Btn2tooltip = 'Open file'
    Btn2visible = True
    Btn2onClick = ''
    Btn2picture = ''
    Btn2sysimg = 0
    Btn2imgIndex = 1
    Btn3Name = 'TB3'
    Btn3caption = '&Save'
    Btn3checked = False
    Btn3dropdown = False
    Btn3enabled = True
    Btn3separator = False
    Btn3tooltip = 'Save file'
    Btn3visible = True
    Btn3onClick = ''
    Btn3picture = ''
    Btn3sysimg = 0
    Btn3imgIndex = 2
    Btn4Name = 'TB4'
    Btn4caption = '-'
    Btn4checked = False
    Btn4dropdown = False
    Btn4enabled = True
    Btn4separator = True
    Btn4tooltip = ''
    Btn4visible = True
    Btn4onClick = ''
    Btn4picture = ''
    Btn4sysimg = 0
    Btn5Name = 'TB5'
    Btn5caption = '&Undo'
    Btn5checked = False
    Btn5dropdown = False
    Btn5enabled = True
    Btn5separator = False
    Btn5tooltip = 'Undo'
    Btn5visible = True
    Btn5onClick = ''
    Btn5picture = ''
    Btn5sysimg = 0
    Btn5imgIndex = 3
    Btn6Name = 'TB6'
    Btn6caption = 'Cu&t'
    Btn6checked = False
    Btn6dropdown = False
    Btn6enabled = True
    Btn6separator = False
    Btn6tooltip = 'Cut'
    Btn6visible = True
    Btn6onClick = ''
    Btn6picture = ''
    Btn6sysimg = 0
    Btn6imgIndex = 4
    Btn7Name = 'TB7'
    Btn7caption = '&Copy'
    Btn7checked = False
    Btn7dropdown = False
    Btn7enabled = True
    Btn7separator = False
    Btn7tooltip = 'Copy'
    Btn7visible = True
    Btn7onClick = ''
    Btn7picture = ''
    Btn7sysimg = 0
    Btn7imgIndex = 5
    Btn8Name = 'TB8'
    Btn8caption = '&Paste'
    Btn8checked = False
    Btn8dropdown = False
    Btn8enabled = True
    Btn8separator = False
    Btn8tooltip = 'Paste'
    Btn8visible = True
    Btn8onClick = ''
    Btn8picture = ''
    Btn8sysimg = 0
    Btn8imgIndex = 6
    Btn9Name = 'TB9'
    Btn9caption = '-'
    Btn9checked = False
    Btn9dropdown = False
    Btn9enabled = True
    Btn9separator = True
    Btn9tooltip = ''
    Btn9visible = True
    Btn9onClick = ''
    Btn9picture = ''
    Btn9sysimg = 0
    Btn10Name = 'TB10'
    Btn10caption = 'O&ptions...'
    Btn10checked = False
    Btn10dropdown = False
    Btn10enabled = True
    Btn10separator = False
    Btn10tooltip = 'Options'
    Btn10visible = True
    Btn10onClick = ''
    Btn10picture = ''
    Btn10sysimg = 0
    Btn10imgIndex = 8
    NewVersion = True
  end
  object ToolsTabs: TKOLTabControl
    Tag = 0
    Left = 0
    Top = 20
    Width = 180
    Height = 526
    HelpContext = 0
    IgnoreDefault = False
    AnchorLeft = False
    AnchorTop = False
    AnchorRight = False
    AnchorBottom = False
    AcceptChildren = False
    MouseTransparent = False
    TabOrder = 1
    MinWidth = 0
    MinHeight = 0
    MaxWidth = 0
    MaxHeight = 0
    PlaceDown = False
    PlaceRight = False
    PlaceUnder = False
    Visible = True
    Enabled = True
    DoubleBuffered = False
    Align = caLeft
    CenterOnParent = False
    Ctl3D = True
    Color = clBtnFace
    parentColor = True
    Font.Color = clWindowText
    Font.FontStyle = []
    Font.FontHeight = 0
    Font.FontWidth = 0
    Font.FontWeight = 0
    Font.FontName = 'MS Sans Serif'
    Font.FontOrientation = 0
    Font.FontCharset = 1
    Font.FontPitch = fpDefault
    Font.FontQuality = fqDefault
    parentFont = True
    EraseBackground = False
    Localizy = loForm
    Transparent = False
    Options = [tcoFocusTabs]
    ImageList1stIdx = 0
    Count = 2
    edgeType = esNone
    Border = 0
    MarginTop = 0
    MarginBottom = 0
    MarginLeft = 0
    MarginRight = 0
    generateConstants = True
    Brush.Color = clBtnFace
    Brush.BrushStyle = bsSolid
    object PageSymbols: TKOLTabPage
      Tag = 0
      Left = 4
      Top = 26
      Width = 172
      Height = 496
      HelpContext = 0
      IgnoreDefault = False
      AnchorLeft = False
      AnchorTop = False
      AnchorRight = False
      AnchorBottom = False
      AcceptChildren = True
      MouseTransparent = False
      TabOrder = 1
      MinWidth = 0
      MinHeight = 0
      MaxWidth = 0
      MaxHeight = 0
      PlaceDown = False
      PlaceRight = False
      PlaceUnder = False
      Visible = True
      Enabled = True
      DoubleBuffered = False
      Align = caNone
      CenterOnParent = False
      Caption = 'Symbols'
      Ctl3D = True
      Color = clBtnFace
      parentColor = True
      Font.Color = clWindowText
      Font.FontStyle = []
      Font.FontHeight = 0
      Font.FontWidth = 0
      Font.FontWeight = 0
      Font.FontName = 'MS Sans Serif'
      Font.FontOrientation = 0
      Font.FontCharset = 1
      Font.FontPitch = fpDefault
      Font.FontQuality = fqDefault
      parentFont = True
      EraseBackground = False
      Localizy = loForm
      Transparent = False
      TextAlign = taLeft
      edgeStyle = esNone
      VerticalAlign = vaTop
      Border = 0
      MarginTop = 0
      MarginBottom = 0
      MarginLeft = 0
      MarginRight = 0
      Brush.Color = clBtnFace
      Brush.BrushStyle = bsSolid
      ShowAccelChar = False
    end
    object PageProject: TKOLTabPage
      Tag = 0
      Left = 4
      Top = 26
      Width = 172
      Height = 496
      HelpContext = 0
      IgnoreDefault = False
      AnchorLeft = False
      AnchorTop = False
      AnchorRight = False
      AnchorBottom = False
      AcceptChildren = True
      MouseTransparent = False
      TabOrder = 0
      MinWidth = 0
      MinHeight = 0
      MaxWidth = 0
      MaxHeight = 0
      PlaceDown = False
      PlaceRight = False
      PlaceUnder = False
      Visible = True
      Enabled = True
      DoubleBuffered = False
      Align = caNone
      CenterOnParent = False
      Caption = 'Project'
      Ctl3D = True
      Color = clBtnFace
      parentColor = True
      Font.Color = clWindowText
      Font.FontStyle = []
      Font.FontHeight = 0
      Font.FontWidth = 0
      Font.FontWeight = 0
      Font.FontName = 'MS Sans Serif'
      Font.FontOrientation = 0
      Font.FontCharset = 1
      Font.FontPitch = fpDefault
      Font.FontQuality = fqDefault
      parentFont = True
      EraseBackground = False
      Localizy = loForm
      Transparent = False
      TextAlign = taLeft
      edgeStyle = esNone
      VerticalAlign = vaTop
      Border = 0
      MarginTop = 0
      MarginBottom = 0
      MarginLeft = 0
      MarginRight = 0
      Brush.Color = clBtnFace
      Brush.BrushStyle = bsSolid
      ShowAccelChar = False
      object ProjectTree: TKOLTreeView
        Tag = 0
        Left = 0
        Top = 0
        Width = 172
        Height = 496
        HelpContext = 0
        IgnoreDefault = False
        AnchorLeft = False
        AnchorTop = False
        AnchorRight = False
        AnchorBottom = False
        AcceptChildren = False
        MouseTransparent = False
        TabOrder = 0
        MinWidth = 0
        MinHeight = 0
        MaxWidth = 0
        MaxHeight = 0
        PlaceDown = False
        PlaceRight = False
        PlaceUnder = False
        Visible = True
        Enabled = True
        DoubleBuffered = False
        Align = caClient
        CenterOnParent = False
        Ctl3D = True
        Color = clWindow
        parentColor = False
        Font.Color = clWindowText
        Font.FontStyle = []
        Font.FontHeight = 0
        Font.FontWidth = 0
        Font.FontWeight = 0
        Font.FontName = 'MS Sans Serif'
        Font.FontOrientation = 0
        Font.FontCharset = 1
        Font.FontPitch = fpDefault
        Font.FontQuality = fqDefault
        parentFont = True
        EraseBackground = False
        Localizy = loForm
        Transparent = False
        Options = [tvoLinesRoot, tvoInfoTip]
        ImageListNormal = ProjectTreeImageList
        CurIndex = 0
        TVRightClickSelect = True
        popupMenu = ProjectTreeMenu
        TVIndent = 0
        HasBorder = True
        TabStop = True
        Brush.Color = clWindow
        Brush.BrushStyle = bsSolid
        OverrideScrollbars = False
      end
    end
  end
  object ProjectSplitter: TKOLSplitter
    Tag = 0
    Left = 180
    Top = 20
    Width = 4
    Height = 526
    HelpContext = 0
    IgnoreDefault = False
    AnchorLeft = False
    AnchorTop = False
    AnchorRight = False
    AnchorBottom = False
    AcceptChildren = False
    MouseTransparent = False
    TabOrder = 2
    MinWidth = 0
    MinHeight = 0
    MaxWidth = 0
    MaxHeight = 0
    PlaceDown = False
    PlaceRight = False
    PlaceUnder = False
    Visible = True
    Enabled = True
    DoubleBuffered = False
    Align = caLeft
    CenterOnParent = False
    Ctl3D = True
    Color = clBtnFace
    parentColor = True
    Font.Color = clWindowText
    Font.FontStyle = []
    Font.FontHeight = 0
    Font.FontWidth = 0
    Font.FontWeight = 0
    Font.FontName = 'MS Sans Serif'
    Font.FontOrientation = 0
    Font.FontCharset = 1
    Font.FontPitch = fpDefault
    Font.FontQuality = fqDefault
    parentFont = True
    EraseBackground = False
    Localizy = loForm
    Transparent = False
    MinSizePrev = 0
    MinSizeNext = 100
    edgeStyle = esNone
    Brush.Color = clBtnFace
    Brush.BrushStyle = bsSolid
  end
  object EditorPanel: TKOLPanel
    Tag = 0
    Left = 184
    Top = 20
    Width = 608
    Height = 526
    HelpContext = 0
    IgnoreDefault = False
    AnchorLeft = False
    AnchorTop = False
    AnchorRight = False
    AnchorBottom = False
    AcceptChildren = True
    MouseTransparent = False
    TabOrder = -1
    MinWidth = 0
    MinHeight = 0
    MaxWidth = 0
    MaxHeight = 0
    PlaceDown = False
    PlaceRight = False
    PlaceUnder = False
    Visible = True
    Enabled = True
    DoubleBuffered = False
    Align = caClient
    CenterOnParent = False
    Ctl3D = True
    Color = clBtnFace
    parentColor = True
    Font.Color = clWindowText
    Font.FontStyle = []
    Font.FontHeight = 0
    Font.FontWidth = 0
    Font.FontWeight = 0
    Font.FontName = 'MS Sans Serif'
    Font.FontOrientation = 0
    Font.FontCharset = 1
    Font.FontPitch = fpDefault
    Font.FontQuality = fqDefault
    parentFont = True
    EraseBackground = False
    Localizy = loForm
    Transparent = False
    TextAlign = taLeft
    edgeStyle = esNone
    VerticalAlign = vaTop
    Border = 0
    MarginTop = 0
    MarginBottom = 0
    MarginLeft = 0
    MarginRight = 0
    Brush.Color = clBtnFace
    Brush.BrushStyle = bsSolid
    ShowAccelChar = False
    object MessagesList: TKOLListBox
      Tag = 0
      Left = 0
      Top = 426
      Width = 608
      Height = 100
      HelpContext = 0
      IgnoreDefault = False
      AnchorLeft = False
      AnchorTop = False
      AnchorRight = False
      AnchorBottom = False
      AcceptChildren = False
      MouseTransparent = False
      TabOrder = 0
      MinWidth = 0
      MinHeight = 0
      MaxWidth = 0
      MaxHeight = 0
      PlaceDown = False
      PlaceRight = False
      PlaceUnder = False
      Visible = True
      Enabled = True
      DoubleBuffered = False
      Align = caBottom
      CenterOnParent = False
      Ctl3D = True
      Color = clWindow
      parentColor = False
      Font.Color = clWindowText
      Font.FontStyle = []
      Font.FontHeight = 0
      Font.FontWidth = 0
      Font.FontWeight = 0
      Font.FontName = 'MS Sans Serif'
      Font.FontOrientation = 0
      Font.FontCharset = 1
      Font.FontPitch = fpDefault
      Font.FontQuality = fqDefault
      parentFont = False
      EraseBackground = False
      Localizy = loForm
      Transparent = False
      TabStop = True
      Options = [loMultiSelect, loNoIntegralHeight]
      CurIndex = 0
      Count = 0
      HasBorder = True
      Brush.Color = clWindow
      Brush.BrushStyle = bsSolid
      LBItemHeight = 0
      OverrideScrollbars = False
      AlwaysAssignItems = False
    end
    object MessagesSplitter: TKOLSplitter
      Tag = 0
      Left = 0
      Top = 422
      Width = 608
      Height = 4
      HelpContext = 0
      IgnoreDefault = False
      AnchorLeft = False
      AnchorTop = False
      AnchorRight = False
      AnchorBottom = False
      AcceptChildren = False
      MouseTransparent = False
      TabOrder = 1
      MinWidth = 0
      MinHeight = 0
      MaxWidth = 0
      MaxHeight = 0
      PlaceDown = False
      PlaceRight = False
      PlaceUnder = False
      Visible = True
      Enabled = True
      DoubleBuffered = False
      Align = caBottom
      CenterOnParent = False
      Ctl3D = True
      Color = clBtnFace
      parentColor = True
      Font.Color = clWindowText
      Font.FontStyle = []
      Font.FontHeight = 0
      Font.FontWidth = 0
      Font.FontWeight = 0
      Font.FontName = 'MS Sans Serif'
      Font.FontOrientation = 0
      Font.FontCharset = 1
      Font.FontPitch = fpDefault
      Font.FontQuality = fqDefault
      parentFont = False
      EraseBackground = False
      Localizy = loForm
      Transparent = False
      MinSizePrev = 0
      MinSizeNext = 100
      edgeStyle = esNone
      Brush.Color = clBtnFace
      Brush.BrushStyle = bsSolid
    end
    object EditorTabs: TKOLTabControl
      Tag = 0
      Left = 0
      Top = 0
      Width = 608
      Height = 422
      HelpContext = 0
      IgnoreDefault = False
      AnchorLeft = False
      AnchorTop = False
      AnchorRight = False
      AnchorBottom = False
      AcceptChildren = False
      MouseTransparent = False
      TabOrder = 2
      MinWidth = 100
      MinHeight = 100
      MaxWidth = 0
      MaxHeight = 0
      PlaceDown = False
      PlaceRight = False
      PlaceUnder = False
      Visible = True
      Enabled = True
      DoubleBuffered = False
      Align = caClient
      CenterOnParent = False
      Ctl3D = True
      Color = clBtnFace
      parentColor = True
      Font.Color = clWindowText
      Font.FontStyle = []
      Font.FontHeight = 0
      Font.FontWidth = 0
      Font.FontWeight = 0
      Font.FontName = 'MS Sans Serif'
      Font.FontOrientation = 0
      Font.FontCharset = 1
      Font.FontPitch = fpDefault
      Font.FontQuality = fqDefault
      parentFont = False
      OnMouseDblClk = EditorTabsMouseDblClk
      OnDropFiles = EditorTabsDropFiles
      EraseBackground = False
      Localizy = loForm
      Transparent = False
      Options = [tcoFocusTabs]
      ImageList1stIdx = 0
      Count = 0
      edgeType = esNone
      Border = 0
      MarginTop = 0
      MarginBottom = 0
      MarginLeft = 0
      MarginRight = 0
      generateConstants = False
      Brush.Color = clBtnFace
      Brush.BrushStyle = bsSolid
    end
  end
  object KOLProject: TKOLProject
    Locked = False
    Localizy = False
    projectName = 'TCCDE'
    projectDest = 'TCCDE'
    sourcePath = 'C:\Documents and Settings\Vga\'#1052#1086#1080' '#1076#1086#1082#1091#1084#1077#1085#1090#1099'\Delphi\TCCDE\'
    outdcuPath = '.\DCU\'
    dprResource = True
    protectFiles = True
    showReport = False
    isKOLProject = True
    autoBuild = True
    autoBuildDelay = 500
    BUILD = False
    consoleOut = False
    SupportAnsiMnemonics = 0
    PaintType = ptWYSIWIG
    ShowHint = True
    ReportDetailed = True
    GeneratePCode = False
    NewIF = True
    DefaultFont.Color = clWindowText
    DefaultFont.FontStyle = []
    DefaultFont.FontHeight = 0
    DefaultFont.FontWidth = 0
    DefaultFont.FontWeight = 0
    DefaultFont.FontName = 'MS Sans Serif'
    DefaultFont.FontOrientation = 0
    DefaultFont.FontCharset = 1
    DefaultFont.FontPitch = fpDefault
    DefaultFont.FontQuality = fqDefault
    FormCompactDisabled = False
    Left = 24
    Top = 280
  end
  object KOLForm: TKOLForm
    Tag = 0
    ForceIcon16x16 = True
    Caption = 'TCCDE'
    Visible = True
    OnClose = KOLFormClose
    AllBtnReturnClick = False
    Tabulate = False
    TabulateEx = False
    UnitSourcePath = 'C:\Documents and Settings\Vga\'#1052#1086#1080' '#1076#1086#1082#1091#1084#1077#1085#1090#1099'\Delphi\TCCDE\'
    Locked = False
    formUnit = 'MainForm'
    formMain = True
    Enabled = True
    defaultSize = False
    defaultPosition = False
    MinWidth = 400
    MinHeight = 300
    MaxWidth = 0
    MaxHeight = 0
    HasBorder = True
    HasCaption = True
    StayOnTop = False
    CanResize = True
    CenterOnScreen = True
    CenterOnCurrentScreen = True
    Ctl3D = True
    WindowState = wsNormal
    minimizeIcon = True
    maximizeIcon = True
    closeIcon = True
    helpContextIcon = False
    borderStyle = fbsSingle
    HelpContext = 0
    Color = clBtnFace
    Font.Color = clWindowText
    Font.FontStyle = []
    Font.FontHeight = 0
    Font.FontWidth = 0
    Font.FontWeight = 0
    Font.FontName = 'MS Sans Serif'
    Font.FontOrientation = 0
    Font.FontCharset = 1
    Font.FontPitch = fpDefault
    Font.FontQuality = fqDefault
    FontDefault = True
    Brush.Color = clBtnFace
    Brush.BrushStyle = bsSolid
    DoubleBuffered = False
    PreventResizeFlicks = False
    Transparent = False
    AlphaBlend = 255
    Border = 0
    MarginLeft = 0
    MarginRight = 0
    MarginTop = 0
    MarginBottom = 0
    MinimizeNormalAnimated = False
    RestoreNormalMaximized = False
    zOrderChildren = False
    statusSizeGrip = True
    Localizy = False
    ShowHint = True
    KeyPreview = False
    OnShow = KOLFormShow
    OnFormCreate = KOLFormFormCreate
    EraseBackground = False
    supportMnemonics = False
    FormCompact = False
    GenerateCtlNames = True
    Unicode = False
    OverrideScrollbars = False
    AssignTabOrders = False
    Left = 24
    Top = 376
  end
  object MainMenu: TKOLMainMenu
    showShortcuts = True
    generateConstants = False
    generateSeparatorConstants = False
    OwnerDraw = False
    Localizy = loForm
    Left = 24
    Top = 424
    ItemCount = 4
    Item0Name = 'N1'
    Item0Caption = 'File'
    Item0Enabled = True
    Item0Visible = True
    Item0Checked = False
    Item0RadioGroup = 0
    Item0Separator = False
    Item0Accelerator = 0
    Item0Bitmap = ()
    Item0SubItemCount = 12
    Item0WindowMenu = False
    Item0SubItem0Name = 'N7'
    Item0SubItem0Caption = '&New'#9'Ctrl+N'
    Item0SubItem0Enabled = True
    Item0SubItem0Visible = True
    Item0SubItem0Checked = False
    Item0SubItem0RadioGroup = 0
    Item0SubItem0Separator = False
    Item0SubItem0Accelerator = 0
    Item0SubItem0Bitmap = ()
    Item0SubItem0SubItemCount = 0
    Item0SubItem0WindowMenu = False
    Item0SubItem1Name = 'N8'
    Item0SubItem1Caption = '&Open...'#9'Ctrl+O'
    Item0SubItem1Enabled = True
    Item0SubItem1Visible = True
    Item0SubItem1Checked = False
    Item0SubItem1RadioGroup = 0
    Item0SubItem1Separator = False
    Item0SubItem1Accelerator = 0
    Item0SubItem1Bitmap = ()
    Item0SubItem1SubItemCount = 0
    Item0SubItem1WindowMenu = False
    Item0SubItem2Name = 'N9'
    Item0SubItem2Caption = '&Save'#9'Ctrl+S'
    Item0SubItem2Enabled = True
    Item0SubItem2Visible = True
    Item0SubItem2Checked = False
    Item0SubItem2RadioGroup = 0
    Item0SubItem2Separator = False
    Item0SubItem2Accelerator = 0
    Item0SubItem2Bitmap = ()
    Item0SubItem2SubItemCount = 0
    Item0SubItem2WindowMenu = False
    Item0SubItem3Name = 'N11'
    Item0SubItem3Caption = 'Save &As...'#9'Ctrl+Alt+S'
    Item0SubItem3Enabled = True
    Item0SubItem3Visible = True
    Item0SubItem3Checked = False
    Item0SubItem3RadioGroup = 0
    Item0SubItem3Separator = False
    Item0SubItem3Accelerator = 0
    Item0SubItem3Bitmap = ()
    Item0SubItem3SubItemCount = 0
    Item0SubItem3WindowMenu = False
    Item0SubItem4Name = 'N64'
    Item0SubItem4Caption = 'Save &all'#9'Ctrl+Shift+S'
    Item0SubItem4Enabled = True
    Item0SubItem4Visible = True
    Item0SubItem4Checked = False
    Item0SubItem4RadioGroup = 0
    Item0SubItem4Separator = False
    Item0SubItem4Accelerator = 0
    Item0SubItem4Bitmap = ()
    Item0SubItem4SubItemCount = 0
    Item0SubItem4WindowMenu = False
    Item0SubItem5Name = 'N51'
    Item0SubItem5Enabled = True
    Item0SubItem5Visible = True
    Item0SubItem5Checked = False
    Item0SubItem5RadioGroup = 0
    Item0SubItem5Separator = True
    Item0SubItem5Accelerator = 0
    Item0SubItem5Bitmap = ()
    Item0SubItem5SubItemCount = 0
    Item0SubItem5WindowMenu = False
    Item0SubItem6Name = 'N10'
    Item0SubItem6Caption = '&Close'#9'Ctrl+W'
    Item0SubItem6Enabled = True
    Item0SubItem6Visible = True
    Item0SubItem6Checked = False
    Item0SubItem6RadioGroup = 0
    Item0SubItem6Separator = False
    Item0SubItem6Accelerator = 0
    Item0SubItem6Bitmap = ()
    Item0SubItem6SubItemCount = 0
    Item0SubItem6WindowMenu = False
    Item0SubItem7Name = 'N50'
    Item0SubItem7Caption = 'C&lose all'#9'Ctrl+Shift+W'
    Item0SubItem7Enabled = True
    Item0SubItem7Visible = True
    Item0SubItem7Checked = False
    Item0SubItem7RadioGroup = 0
    Item0SubItem7Separator = False
    Item0SubItem7Accelerator = 0
    Item0SubItem7Bitmap = ()
    Item0SubItem7SubItemCount = 0
    Item0SubItem7WindowMenu = False
    Item0SubItem8Name = 'N5'
    Item0SubItem8Enabled = True
    Item0SubItem8Visible = True
    Item0SubItem8Checked = False
    Item0SubItem8RadioGroup = 0
    Item0SubItem8Separator = True
    Item0SubItem8Accelerator = 0
    Item0SubItem8Bitmap = ()
    Item0SubItem8SubItemCount = 0
    Item0SubItem8WindowMenu = False
    Item0SubItem9Name = 'N63'
    Item0SubItem9Caption = 'O&ptions...'#9'Ctrl+Shift+O'
    Item0SubItem9Enabled = True
    Item0SubItem9Visible = True
    Item0SubItem9Checked = False
    Item0SubItem9RadioGroup = 0
    Item0SubItem9Separator = False
    Item0SubItem9Accelerator = 0
    Item0SubItem9Bitmap = ()
    Item0SubItem9SubItemCount = 0
    Item0SubItem9WindowMenu = False
    Item0SubItem10Name = 'N62'
    Item0SubItem10Enabled = True
    Item0SubItem10Visible = True
    Item0SubItem10Checked = False
    Item0SubItem10RadioGroup = 0
    Item0SubItem10Separator = True
    Item0SubItem10Accelerator = 0
    Item0SubItem10Bitmap = ()
    Item0SubItem10SubItemCount = 0
    Item0SubItem10WindowMenu = False
    Item0SubItem11Name = 'N6'
    Item0SubItem11Caption = 'E&xit'#9'Alt+X'
    Item0SubItem11Enabled = True
    Item0SubItem11Visible = True
    Item0SubItem11Checked = False
    Item0SubItem11RadioGroup = 0
    Item0SubItem11Separator = False
    Item0SubItem11Accelerator = 0
    Item0SubItem11Bitmap = ()
    Item0SubItem11SubItemCount = 0
    Item0SubItem11WindowMenu = False
    Item1Name = 'N2'
    Item1Caption = 'Edit'
    Item1Enabled = True
    Item1Visible = True
    Item1Checked = False
    Item1RadioGroup = 0
    Item1Separator = False
    Item1Accelerator = 0
    Item1Bitmap = ()
    Item1SubItemCount = 14
    Item1WindowMenu = False
    Item1SubItem0Name = 'N12'
    Item1SubItem0Caption = '&Undo'#9'Ctrl+Z'
    Item1SubItem0Enabled = True
    Item1SubItem0Visible = True
    Item1SubItem0Checked = False
    Item1SubItem0RadioGroup = 0
    Item1SubItem0Separator = False
    Item1SubItem0Accelerator = 0
    Item1SubItem0Bitmap = ()
    Item1SubItem0SubItemCount = 0
    Item1SubItem0WindowMenu = False
    Item1SubItem1Name = 'N13'
    Item1SubItem1Caption = '&Redo'#9'Ctrl+Shift+Z'
    Item1SubItem1Enabled = True
    Item1SubItem1Visible = True
    Item1SubItem1Checked = False
    Item1SubItem1RadioGroup = 0
    Item1SubItem1Separator = False
    Item1SubItem1Accelerator = 0
    Item1SubItem1Bitmap = ()
    Item1SubItem1SubItemCount = 0
    Item1SubItem1WindowMenu = False
    Item1SubItem2Name = 'N14'
    Item1SubItem2Enabled = True
    Item1SubItem2Visible = True
    Item1SubItem2Checked = False
    Item1SubItem2RadioGroup = 0
    Item1SubItem2Separator = True
    Item1SubItem2Accelerator = 0
    Item1SubItem2Bitmap = ()
    Item1SubItem2SubItemCount = 0
    Item1SubItem2WindowMenu = False
    Item1SubItem3Name = 'N15'
    Item1SubItem3Caption = 'Cu&t'#9'Ctrl+X'
    Item1SubItem3Enabled = True
    Item1SubItem3Visible = True
    Item1SubItem3Checked = False
    Item1SubItem3RadioGroup = 0
    Item1SubItem3Separator = False
    Item1SubItem3Accelerator = 0
    Item1SubItem3Bitmap = ()
    Item1SubItem3SubItemCount = 0
    Item1SubItem3WindowMenu = False
    Item1SubItem4Name = 'N16'
    Item1SubItem4Caption = '&Copy'#9'Ctrl+C'
    Item1SubItem4Enabled = True
    Item1SubItem4Visible = True
    Item1SubItem4Checked = False
    Item1SubItem4RadioGroup = 0
    Item1SubItem4Separator = False
    Item1SubItem4Accelerator = 0
    Item1SubItem4Bitmap = ()
    Item1SubItem4SubItemCount = 0
    Item1SubItem4WindowMenu = False
    Item1SubItem5Name = 'N17'
    Item1SubItem5Caption = '&Paste'#9'Ctrl+V'
    Item1SubItem5Enabled = True
    Item1SubItem5Visible = True
    Item1SubItem5Checked = False
    Item1SubItem5RadioGroup = 0
    Item1SubItem5Separator = False
    Item1SubItem5Accelerator = 0
    Item1SubItem5Bitmap = ()
    Item1SubItem5SubItemCount = 0
    Item1SubItem5WindowMenu = False
    Item1SubItem6Name = 'N18'
    Item1SubItem6Enabled = True
    Item1SubItem6Visible = True
    Item1SubItem6Checked = False
    Item1SubItem6RadioGroup = 0
    Item1SubItem6Separator = True
    Item1SubItem6Accelerator = 0
    Item1SubItem6Bitmap = ()
    Item1SubItem6SubItemCount = 0
    Item1SubItem6WindowMenu = False
    Item1SubItem7Name = 'N19'
    Item1SubItem7Caption = 'Select &all'#9'Ctrl+A'
    Item1SubItem7Enabled = True
    Item1SubItem7Visible = True
    Item1SubItem7Checked = False
    Item1SubItem7RadioGroup = 0
    Item1SubItem7Separator = False
    Item1SubItem7Accelerator = 0
    Item1SubItem7Bitmap = ()
    Item1SubItem7SubItemCount = 0
    Item1SubItem7WindowMenu = False
    Item1SubItem8Name = 'N57'
    Item1SubItem8Caption = '&Indent'#9'Ctrl+Shift+I'
    Item1SubItem8Enabled = True
    Item1SubItem8Visible = True
    Item1SubItem8Checked = False
    Item1SubItem8RadioGroup = 0
    Item1SubItem8Separator = False
    Item1SubItem8Accelerator = 0
    Item1SubItem8Bitmap = ()
    Item1SubItem8SubItemCount = 0
    Item1SubItem8WindowMenu = False
    Item1SubItem9Name = 'N58'
    Item1SubItem9Caption = 'U&nindent'#9'Ctrl+Shift+U'
    Item1SubItem9Enabled = True
    Item1SubItem9Visible = True
    Item1SubItem9Checked = False
    Item1SubItem9RadioGroup = 0
    Item1SubItem9Separator = False
    Item1SubItem9Accelerator = 0
    Item1SubItem9Bitmap = ()
    Item1SubItem9SubItemCount = 0
    Item1SubItem9WindowMenu = False
    Item1SubItem10Name = 'N52'
    Item1SubItem10Enabled = True
    Item1SubItem10Visible = True
    Item1SubItem10Checked = False
    Item1SubItem10RadioGroup = 0
    Item1SubItem10Separator = True
    Item1SubItem10Accelerator = 0
    Item1SubItem10Bitmap = ()
    Item1SubItem10SubItemCount = 0
    Item1SubItem10WindowMenu = False
    Item1SubItem11Name = 'N59'
    Item1SubItem11Caption = '&Search/Replace...'#9'Ctrl+F'
    Item1SubItem11Enabled = True
    Item1SubItem11Visible = True
    Item1SubItem11Checked = False
    Item1SubItem11RadioGroup = 0
    Item1SubItem11Separator = False
    Item1SubItem11Accelerator = 0
    Item1SubItem11Bitmap = ()
    Item1SubItem11SubItemCount = 0
    Item1SubItem11WindowMenu = False
    Item1SubItem12Name = 'N60'
    Item1SubItem12Caption = '&Find next'#9'F3'
    Item1SubItem12Enabled = True
    Item1SubItem12Visible = True
    Item1SubItem12Checked = False
    Item1SubItem12RadioGroup = 0
    Item1SubItem12Separator = False
    Item1SubItem12Accelerator = 0
    Item1SubItem12Bitmap = ()
    Item1SubItem12SubItemCount = 0
    Item1SubItem12WindowMenu = False
    Item1SubItem13Name = 'N53'
    Item1SubItem13Caption = '&Goto...'#9'Ctrl+G'
    Item1SubItem13Enabled = True
    Item1SubItem13Visible = True
    Item1SubItem13Checked = False
    Item1SubItem13RadioGroup = 0
    Item1SubItem13Separator = False
    Item1SubItem13Accelerator = 0
    Item1SubItem13Bitmap = ()
    Item1SubItem13SubItemCount = 0
    Item1SubItem13WindowMenu = False
    Item2Name = 'N3'
    Item2Caption = 'Project'
    Item2Enabled = True
    Item2Visible = True
    Item2Checked = False
    Item2RadioGroup = 0
    Item2Separator = False
    Item2Accelerator = 0
    Item2Bitmap = ()
    Item2SubItemCount = 12
    Item2WindowMenu = False
    Item2SubItem0Name = 'N66'
    Item2SubItem0Caption = '&New project...'#9'Ctrl+F11'
    Item2SubItem0Enabled = True
    Item2SubItem0Visible = True
    Item2SubItem0Checked = False
    Item2SubItem0RadioGroup = 0
    Item2SubItem0Separator = False
    Item2SubItem0Accelerator = 0
    Item2SubItem0Bitmap = ()
    Item2SubItem0SubItemCount = 0
    Item2SubItem0WindowMenu = False
    Item2SubItem1Name = 'N70'
    Item2SubItem1Caption = '&Options...'#9'Ctrl+Shift+F11'
    Item2SubItem1Enabled = True
    Item2SubItem1Visible = True
    Item2SubItem1Checked = False
    Item2SubItem1RadioGroup = 0
    Item2SubItem1Separator = False
    Item2SubItem1Accelerator = 0
    Item2SubItem1Bitmap = ()
    Item2SubItem1SubItemCount = 0
    Item2SubItem1WindowMenu = False
    Item2SubItem2Name = 'N72'
    Item2SubItem2Caption = '&Close project'#9'Ctrl+Shift+F10'
    Item2SubItem2Enabled = True
    Item2SubItem2Visible = True
    Item2SubItem2Checked = False
    Item2SubItem2RadioGroup = 0
    Item2SubItem2Separator = False
    Item2SubItem2Accelerator = 0
    Item2SubItem2Bitmap = ()
    Item2SubItem2SubItemCount = 0
    Item2SubItem2WindowMenu = False
    Item2SubItem3Name = 'N65'
    Item2SubItem3Enabled = True
    Item2SubItem3Visible = True
    Item2SubItem3Checked = False
    Item2SubItem3RadioGroup = 0
    Item2SubItem3Separator = True
    Item2SubItem3Accelerator = 0
    Item2SubItem3Bitmap = ()
    Item2SubItem3SubItemCount = 0
    Item2SubItem3WindowMenu = False
    Item2SubItem4Name = 'N68'
    Item2SubItem4Caption = '&Add file...'
    Item2SubItem4Enabled = True
    Item2SubItem4Visible = True
    Item2SubItem4Checked = False
    Item2SubItem4RadioGroup = 0
    Item2SubItem4Separator = False
    Item2SubItem4Accelerator = 0
    Item2SubItem4Bitmap = ()
    Item2SubItem4SubItemCount = 0
    Item2SubItem4WindowMenu = False
    Item2SubItem5Name = 'N69'
    Item2SubItem5Caption = 'R&emove file'
    Item2SubItem5Enabled = True
    Item2SubItem5Visible = True
    Item2SubItem5Checked = False
    Item2SubItem5RadioGroup = 0
    Item2SubItem5Separator = False
    Item2SubItem5Accelerator = 0
    Item2SubItem5Bitmap = ()
    Item2SubItem5SubItemCount = 0
    Item2SubItem5WindowMenu = False
    Item2SubItem6Name = 'N71'
    Item2SubItem6Caption = 'File &properties...'
    Item2SubItem6Enabled = True
    Item2SubItem6Visible = True
    Item2SubItem6Checked = False
    Item2SubItem6RadioGroup = 0
    Item2SubItem6Separator = False
    Item2SubItem6Accelerator = 0
    Item2SubItem6Bitmap = ()
    Item2SubItem6SubItemCount = 0
    Item2SubItem6WindowMenu = False
    Item2SubItem7Name = 'N73'
    Item2SubItem7Enabled = True
    Item2SubItem7Visible = True
    Item2SubItem7Checked = False
    Item2SubItem7RadioGroup = 0
    Item2SubItem7Separator = True
    Item2SubItem7Accelerator = 0
    Item2SubItem7Bitmap = ()
    Item2SubItem7SubItemCount = 0
    Item2SubItem7WindowMenu = False
    Item2SubItem8Name = 'N74'
    Item2SubItem8Caption = '&Run'#9'F9'
    Item2SubItem8Enabled = True
    Item2SubItem8Visible = True
    Item2SubItem8Checked = False
    Item2SubItem8RadioGroup = 0
    Item2SubItem8Separator = False
    Item2SubItem8Accelerator = 0
    Item2SubItem8Bitmap = ()
    Item2SubItem8SubItemCount = 0
    Item2SubItem8WindowMenu = False
    Item2SubItem9Name = 'N75'
    Item2SubItem9Caption = '&Build'#9'Ctrl+F9'
    Item2SubItem9Enabled = True
    Item2SubItem9Visible = True
    Item2SubItem9Checked = False
    Item2SubItem9RadioGroup = 0
    Item2SubItem9Separator = False
    Item2SubItem9Accelerator = 0
    Item2SubItem9Bitmap = ()
    Item2SubItem9SubItemCount = 0
    Item2SubItem9WindowMenu = False
    Item2SubItem10Name = 'N76'
    Item2SubItem10Caption = 'Reb&uild'#9'Ctrl+Shift+F9'
    Item2SubItem10Enabled = True
    Item2SubItem10Visible = True
    Item2SubItem10Checked = False
    Item2SubItem10RadioGroup = 0
    Item2SubItem10Separator = False
    Item2SubItem10Accelerator = 0
    Item2SubItem10Bitmap = ()
    Item2SubItem10SubItemCount = 0
    Item2SubItem10WindowMenu = False
    Item2SubItem11Name = 'N77'
    Item2SubItem11Caption = 'Clean'
    Item2SubItem11Enabled = True
    Item2SubItem11Visible = True
    Item2SubItem11Checked = False
    Item2SubItem11RadioGroup = 0
    Item2SubItem11Separator = False
    Item2SubItem11Accelerator = 0
    Item2SubItem11Bitmap = ()
    Item2SubItem11SubItemCount = 0
    Item2SubItem11WindowMenu = False
    Item3Name = 'N4'
    Item3Caption = 'Help'
    Item3Enabled = True
    Item3Visible = True
    Item3Checked = False
    Item3RadioGroup = 0
    Item3Separator = False
    Item3Accelerator = 0
    Item3Bitmap = ()
    Item3SubItemCount = 1
    Item3WindowMenu = False
    Item3SubItem0Name = 'N78'
    Item3SubItem0Caption = '&About...'#9'Shift+F1'
    Item3SubItem0Enabled = True
    Item3SubItem0Visible = True
    Item3SubItem0Checked = False
    Item3SubItem0RadioGroup = 0
    Item3SubItem0Separator = False
    Item3SubItem0Accelerator = 0
    Item3SubItem0Bitmap = ()
    Item3SubItem0SubItemCount = 0
    Item3SubItem0WindowMenu = False
  end
  object ActionList: TKOLActionList
    OnUpdateActions = ActionListUpdateActions
    Left = 24
    Top = 472
    object ActionNew: TKOLAction
      Caption = '&New'
      Hint = 'New file'
      Accelerator.Prefix = [kapControl]
      Accelerator.Key = vkN
      OnExecute = ActionNewExecute
      Links = (
        'FormMain.MainMenu.N7'
        'FormMain.Toolbar.TB1')
    end
    object ActionOpen: TKOLAction
      Caption = '&Open...'
      Hint = 'Open file'
      Accelerator.Prefix = [kapControl]
      Accelerator.Key = vkO
      OnExecute = ActionOpenExecute
      Links = (
        'FormMain.MainMenu.N8'
        'FormMain.Toolbar.TB2')
    end
    object ActionSave: TKOLAction
      Caption = '&Save'
      Hint = 'Save file'
      Accelerator.Prefix = [kapControl]
      Accelerator.Key = vkS
      OnExecute = ActionSaveExecute
      Links = (
        'FormMain.MainMenu.N9'
        'FormMain.Toolbar.TB3')
    end
    object ActionSaveAll: TKOLAction
      Caption = 'Save &all'
      Hint = 'Save all files'
      Accelerator.Prefix = [kapShift, kapControl]
      Accelerator.Key = vkS
      OnExecute = ActionSaveAllExecute
      Links = (
        'FormMain.MainMenu.N64')
    end
    object ActionSaveAs: TKOLAction
      Caption = 'Save &As...'
      Hint = 'Save file as...'
      Accelerator.Prefix = [kapControl, kapAlt]
      Accelerator.Key = vkS
      OnExecute = ActionSaveAsExecute
      Links = (
        'FormMain.MainMenu.N11')
    end
    object ActionClose: TKOLAction
      Caption = '&Close'
      Hint = 'Close file'
      Accelerator.Prefix = [kapControl]
      Accelerator.Key = vkW
      OnExecute = ActionCloseExecute
      Links = (
        'FormMain.MainMenu.N10')
    end
    object ActionCloseAll: TKOLAction
      Caption = 'C&lose all'
      Hint = 'Close all files'
      Accelerator.Prefix = [kapShift, kapControl]
      Accelerator.Key = vkW
      OnExecute = ActionCloseAllExecute
      Links = (
        'FormMain.MainMenu.N50')
    end
    object ActionOptions: TKOLAction
      Caption = 'O&ptions...'
      Hint = 'Options'
      Accelerator.Prefix = [kapShift, kapControl]
      Accelerator.Key = vkO
      OnExecute = ActionOptionsExecute
      Links = (
        'FormMain.Toolbar.TB10'
        'FormMain.MainMenu.N63')
    end
    object ActionExit: TKOLAction
      Caption = 'E&xit'
      Hint = 'Exit'
      Accelerator.Prefix = [kapAlt]
      Accelerator.Key = vkX
      OnExecute = ActionExitExecute
      Links = (
        'FormMain.MainMenu.N6')
    end
    object ActionUndo: TKOLAction
      Caption = '&Undo'
      Hint = 'Undo'
      Accelerator.Prefix = [kapControl]
      Accelerator.Key = vkZ
      OnExecute = ActionUndoExecute
      Links = (
        'FormMain.Toolbar.TB5'
        'FormMain.MainMenu.N12'
        'FormMain.EditorMenu.N20')
    end
    object ActionRedo: TKOLAction
      Caption = '&Redo'
      Hint = 'Redo'
      Accelerator.Prefix = [kapShift, kapControl]
      Accelerator.Key = vkZ
      OnExecute = ActionRedoExecute
      Links = (
        'FormMain.MainMenu.N13')
    end
    object ActionCut: TKOLAction
      Caption = 'Cu&t'
      Hint = 'Cut'
      Accelerator.Prefix = [kapControl]
      Accelerator.Key = vkX
      OnExecute = ActionCutExecute
      Links = (
        'FormMain.Toolbar.TB6'
        'FormMain.MainMenu.N15'
        'FormMain.EditorMenu.N22')
    end
    object ActionCopy: TKOLAction
      Caption = '&Copy'
      Hint = 'Copy'
      Accelerator.Prefix = [kapControl]
      Accelerator.Key = vkC
      OnExecute = ActionCopyExecute
      Links = (
        'FormMain.Toolbar.TB7'
        'FormMain.MainMenu.N16'
        'FormMain.EditorMenu.N23')
    end
    object ActionPaste: TKOLAction
      Caption = '&Paste'
      Hint = 'Paste'
      Accelerator.Prefix = [kapControl]
      Accelerator.Key = vkV
      OnExecute = ActionPasteExecute
      Links = (
        'FormMain.Toolbar.TB8'
        'FormMain.MainMenu.N17'
        'FormMain.EditorMenu.N24')
    end
    object ActionSelectAll: TKOLAction
      Caption = 'Select &all'
      Hint = 'Select all'
      Accelerator.Prefix = [kapControl]
      Accelerator.Key = vkA
      OnExecute = ActionSelectAllExecute
      Links = (
        'FormMain.MainMenu.N19'
        'FormMain.EditorMenu.N26')
    end
    object ActionGoto: TKOLAction
      Caption = '&Goto...'
      Hint = 'Goto line...'
      Accelerator.Prefix = [kapControl]
      Accelerator.Key = vkG
      OnExecute = ActionGotoExecute
      Links = (
        'FormMain.MainMenu.N53'
        'FormMain.EditorMenu.N54')
    end
    object ActionIndent: TKOLAction
      Caption = '&Indent'
      Hint = 'Indent selected lines'
      Accelerator.Prefix = [kapShift, kapControl]
      Accelerator.Key = vkI
      OnExecute = ActionIndentExecute
      Links = (
        'FormMain.MainMenu.N57'
        'FormMain.EditorMenu.N55')
    end
    object ActionUnindent: TKOLAction
      Caption = 'U&nindent'
      Hint = 'Unindent selected lines'
      Accelerator.Prefix = [kapShift, kapControl]
      Accelerator.Key = vkU
      OnExecute = ActionUnindentExecute
      Links = (
        'FormMain.EditorMenu.N56'
        'FormMain.MainMenu.N58')
    end
    object ActionSearch: TKOLAction
      Caption = '&Search/Replace...'
      Hint = 'Search/Replace'
      Accelerator.Prefix = [kapControl]
      Accelerator.Key = vkF
      OnExecute = ActionSearchExecute
      Links = (
        'FormMain.MainMenu.N59')
    end
    object ActionFindNext: TKOLAction
      Caption = '&Find next'
      Hint = 'Find next'
      Accelerator.Prefix = []
      Accelerator.Key = vkF3
      OnExecute = ActionFindNextExecute
      Links = (
        'FormMain.MainMenu.N60')
    end
    object ActionHilight: TKOLAction
      Caption = 'Highlight syntax'
      Hint = 'Highlight syntax'
      Accelerator.Prefix = []
      Accelerator.Key = vkNotPresent
      OnExecute = ActionHilightExecute
      Links = (
        'FormMain.EditorMenu.N61')
    end
    object ActionNewProject: TKOLAction
      Caption = '&New project...'
      Hint = 'New project'
      Accelerator.Prefix = [kapControl]
      Accelerator.Key = vkF11
      OnExecute = ActionNewProjectExecute
      Links = (
        'FormMain.MainMenu.N66')
    end
    object ActionCloseProject: TKOLAction
      Caption = '&Close project'
      Hint = 'Close project'
      Accelerator.Prefix = [kapShift, kapControl]
      Accelerator.Key = vkF10
      Links = (
        'FormMain.MainMenu.N72')
    end
    object ActionProjectAdd: TKOLAction
      Caption = '&Add file...'
      Hint = 'Add file to project'
      Accelerator.Prefix = []
      Accelerator.Key = vkNotPresent
      OnExecute = ActionProjectAddExecute
      Links = (
        'FormMain.ProjectTreeMenu.N67'
        'FormMain.MainMenu.N68')
    end
    object ActionProjectRemove: TKOLAction
      Caption = 'R&emove file'
      Hint = 'Remove file from project'
      Accelerator.Prefix = []
      Accelerator.Key = vkNotPresent
      Links = (
        'FormMain.MainMenu.N69'
        'FormMain.ProjectTreeMenu.N80')
    end
    object ActionProjectOptions: TKOLAction
      Caption = '&Options...'
      Hint = 'Project options'
      Accelerator.Prefix = [kapShift, kapControl]
      Accelerator.Key = vkF11
      Links = (
        'FormMain.MainMenu.N70')
    end
    object ActionProjectProperties: TKOLAction
      Caption = 'File &properties...'
      Hint = 'File properties'
      Accelerator.Prefix = []
      Accelerator.Key = vkNotPresent
      Links = (
        'FormMain.MainMenu.N71'
        'FormMain.ProjectTreeMenu.N79')
    end
    object ActionProjectBuild: TKOLAction
      Caption = '&Build'
      Hint = 'Build project'
      Accelerator.Prefix = [kapControl]
      Accelerator.Key = vkF9
      Links = (
        'FormMain.MainMenu.N75')
    end
    object ActionProjectRebuild: TKOLAction
      Caption = 'Reb&uild'
      Hint = 'Rebuild project'
      Accelerator.Prefix = [kapShift, kapControl]
      Accelerator.Key = vkF9
      Links = (
        'FormMain.MainMenu.N76')
    end
    object ActionProjectRun: TKOLAction
      Caption = '&Run'
      Hint = 'Run'
      Accelerator.Prefix = []
      Accelerator.Key = vkF9
      Links = (
        'FormMain.MainMenu.N74')
    end
    object ActionProjectClean: TKOLAction
      Caption = 'Clean'
      Hint = 'Clean'
      Accelerator.Prefix = []
      Accelerator.Key = vkNotPresent
      Links = (
        'FormMain.MainMenu.N77')
    end
    object ActionAbout: TKOLAction
      Caption = '&About...'
      Hint = 'About'
      Accelerator.Prefix = [kapShift]
      Accelerator.Key = vkF1
      OnExecute = ActionAboutExecute
      Links = (
        'FormMain.MainMenu.N78')
    end
  end
  object KOLApplet: TKOLApplet
    Tag = 0
    ForceIcon16x16 = True
    Caption = 'TCCDE'
    Visible = True
    AllBtnReturnClick = False
    Tabulate = False
    TabulateEx = False
    UnitSourcePath = 'C:\Documents and Settings\Vga\'#1052#1086#1080' '#1076#1086#1082#1091#1084#1077#1085#1090#1099'\Delphi\TCCDE\'
    Left = 24
    Top = 328
  end
  object ToolbarImageList: TKOLImageList
    ImgWidth = 16
    ImgHeight = 16
    Count = 9
    bitmap.Data = {
      F6040000424DF604000000000000760000002800000090000000100000000100
      0400000000008004000000000000000000001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
      DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
      DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
      DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD0000000000000DDDDDDDDDDDDD
      DDDDDDDDD44DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD444444444DD0000000000
      0DDDD00DDDDDDD00DDDDDDD00000000000DDD00000000000DDDDD03300000088
      030DDDDDDDDDDDDDDDDDDDDD4DD4DD44DDDDDDDDDDD444444444DD000004FFFF
      FFF4D0888888888080DDD010DDDDD080DDDDDDD0FFFFFFFFF0DDD00333333333
      0DDDD03300000088030DDDDDDDDDDDDDDDDDDDDD4DD4D4DD4DDDDDDDDDD4FFFF
      FFF4D0373734F44444F4000000000000080DDD010DDD080DDDDDDDD0FFFFFFFF
      F0DDD0F03333333330DDD03300000088030DDDDDDDDDDDDD4DDDDDDD4DD4D4DD
      4DDDDDDDDDD4F00000F4D0737374FFFFFFF40888888BBB88000DDDD010D080DD
      DDDDDDD0FFFFFFFFF0DDD0BF03333333330DD03300000000030DDD44444DDDDD
      4DDDDDDDD444D4DD4DDDD0000004FFFFFFF4D0373734F444F444088888877788
      080DDDDD01080DDDDDDDDDD0FFFFFFFFF0DDD0FBF03333333330D03333333333
      330DDD4444DDDDDDD4DDDDDDDDD4D444DDDDD0FFFFF4F00000F4D0737374FFFF
      F4F40000000000000880DDDDD080DDDDDDDDDDD0FFFFFFFFF0DDD0BFBF000000
      0000D03300000000330DDD444DDDDDDDD4DDDDDDDDD404DDDDDDD0F00004FFFF
      FFF4D0373734FFFFF44D0888888888808080DDDD08010DDDD0DDDDD0FFFFFFFF
      F0DDD0FBFBFBFBF0DDDDD03088888888030DDD44D4DDDDDDD4DDDDDDDDDD0DDD
      DDDDD0FFFFF4F00F4444D07373744444440DD000000000080800000080D010DD
      030DDDD0FFFFFFFFF0DDD0BFBFBFBFB0DDDDD03088888888030DDD4DDD44DDDD
      4DDDDDDDDDD000DDDDDDD0F00004FFFF4F4DD03737373737370DDD0FFFFFFFF0
      808000000DDD01000330DDD0FFFFFFFFF0DDD0FBF0000000DDDDD03088888888
      030DDDDDDDDD4444DDDDDDDDDDD0D0DDDDDDD0FFFFF4FFFF44DDD07300000000
      730DDDD0F00000F0000D0DD00DDDD003300DDDD0FFFFFF0000DDDD000DDDDDDD
      D000D03088888888030DDDDDDDDDDDDDDDDDDDDDDD00D00DDDDDD0F00F044444
      4DDDD03708888880370DDDD0FFFFFFFF0DDDDDD00DDDD03330DDDDD0FFFFFF0F
      0DDDDDDDDDDDDDDDDD00D03088888888000DDDDDDDDDDDDDDDDDDDDDDD0DDD0D
      DDDDD0FFFF0F0DDDDDDDD07370B00B03730DDDDD0F00000F0DDDDD000DDD0033
      30DDDDD0FFFFFF00DDDDDDDDDDDDD0DDD0D0D03088888888080DDDDDDDDDDDDD
      DDDDDDDDDD0DDD0DDDDDD0FFFF00DDDDDDDDDD00000BB00000DDDDDD0FFFFFFF
      F0DDDDDDDD0033000DDDDDD00000000DDDDDDDDDDDDDDD000DDDD00000000000
      000DDDDDDDDDDDDDDDDDDDDDDD0DDD0DDDDDD000000DDDDDDDDDDDDDDD0000DD
      DDDDDDDDD000000000DDDDDDDDD0000DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
      DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
      DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD}
    TransparentColor = clFuchsia
    systemimagelist = False
    Colors = ilcColor4
    Masked = True
    BkColor = clNone
    Force32bit = False
    Left = 104
    Top = 424
  end
  object SourceFileDialog: TKOLOpenSaveDialog
    Options = [OSFileMustExist, OSAllowMultiSelect, OSOverwritePrompt, OSPathMustExist]
    NoPlaceBar = False
    Filter = 'C source files|*.c;*.h|All files|*.*'
    FilterIndex = 0
    DefExtension = '.c'
    OpenDialog = True
    Localizy = loForm
    Left = 104
    Top = 280
  end
  object EditorMenu: TKOLPopupMenu
    showShortcuts = True
    generateConstants = False
    generateSeparatorConstants = False
    OwnerDraw = False
    Flags = []
    OnPopup = EditorMenuPopup
    Localizy = loForm
    Left = 104
    Top = 328
    ItemCount = 14
    Item0Name = 'N20'
    Item0Caption = '&Undo'#9'Ctrl+Z'
    Item0Enabled = True
    Item0Visible = True
    Item0Checked = False
    Item0RadioGroup = 0
    Item0Separator = False
    Item0Accelerator = 0
    Item0Bitmap = ()
    Item0SubItemCount = 0
    Item0WindowMenu = False
    Item1Name = 'N21'
    Item1Enabled = True
    Item1Visible = True
    Item1Checked = False
    Item1RadioGroup = 0
    Item1Separator = True
    Item1Accelerator = 0
    Item1Bitmap = ()
    Item1SubItemCount = 0
    Item1WindowMenu = False
    Item2Name = 'N22'
    Item2Caption = 'Cu&t'#9'Ctrl+X'
    Item2Enabled = True
    Item2Visible = True
    Item2Checked = False
    Item2RadioGroup = 0
    Item2Separator = False
    Item2Accelerator = 0
    Item2Bitmap = ()
    Item2SubItemCount = 0
    Item2WindowMenu = False
    Item3Name = 'N23'
    Item3Caption = '&Copy'#9'Ctrl+C'
    Item3Enabled = True
    Item3Visible = True
    Item3Checked = False
    Item3RadioGroup = 0
    Item3Separator = False
    Item3Accelerator = 0
    Item3Bitmap = ()
    Item3SubItemCount = 0
    Item3WindowMenu = False
    Item4Name = 'N24'
    Item4Caption = '&Paste'#9'Ctrl+V'
    Item4Enabled = True
    Item4Visible = True
    Item4Checked = False
    Item4RadioGroup = 0
    Item4Separator = False
    Item4Accelerator = 0
    Item4Bitmap = ()
    Item4SubItemCount = 0
    Item4WindowMenu = False
    Item5Name = 'N25'
    Item5Enabled = True
    Item5Visible = True
    Item5Checked = False
    Item5RadioGroup = 0
    Item5Separator = True
    Item5Accelerator = 0
    Item5Bitmap = ()
    Item5SubItemCount = 0
    Item5WindowMenu = False
    Item6Name = 'N26'
    Item6Caption = 'Select &all'#9'Ctrl+A'
    Item6Enabled = True
    Item6Visible = True
    Item6Checked = False
    Item6RadioGroup = 0
    Item6Separator = False
    Item6Accelerator = 0
    Item6Bitmap = ()
    Item6SubItemCount = 0
    Item6WindowMenu = False
    Item7Name = 'N55'
    Item7Caption = '&Indent'#9'Ctrl+Shift+I'
    Item7Enabled = True
    Item7Visible = True
    Item7Checked = False
    Item7RadioGroup = 0
    Item7Separator = False
    Item7Accelerator = 0
    Item7Bitmap = ()
    Item7SubItemCount = 0
    Item7WindowMenu = False
    Item8Name = 'N56'
    Item8Caption = 'U&nindent'#9'Ctrl+Shift+U'
    Item8Enabled = True
    Item8Visible = True
    Item8Checked = False
    Item8RadioGroup = 0
    Item8Separator = False
    Item8Accelerator = 0
    Item8Bitmap = ()
    Item8SubItemCount = 0
    Item8WindowMenu = False
    Item9Name = 'N27'
    Item9Enabled = True
    Item9Visible = True
    Item9Checked = False
    Item9RadioGroup = 0
    Item9Separator = True
    Item9Accelerator = 0
    Item9Bitmap = ()
    Item9SubItemCount = 0
    Item9WindowMenu = False
    Item10Name = 'N61'
    Item10Caption = 'Highlight syntax'
    Item10Enabled = True
    Item10Visible = True
    Item10Checked = False
    Item10RadioGroup = 0
    Item10Separator = False
    Item10Accelerator = 0
    Item10Bitmap = ()
    Item10SubItemCount = 0
    Item10WindowMenu = False
    Item11Name = 'N28'
    Item11Caption = '&Toggle bookmark'
    Item11Enabled = True
    Item11Visible = True
    Item11Checked = False
    Item11RadioGroup = 0
    Item11Separator = False
    Item11Accelerator = 0
    Item11Bitmap = ()
    Item11SubItemCount = 10
    Item11WindowMenu = False
    Item11SubItem0Name = 'N29'
    Item11SubItem0Caption = 'Bookmark &0'
    Item11SubItem0Enabled = True
    Item11SubItem0Visible = True
    Item11SubItem0Checked = False
    Item11SubItem0RadioGroup = 0
    Item11SubItem0Separator = False
    Item11SubItem0Accelerator = 791
    Item11SubItem0Bitmap = ()
    Item11SubItem0OnMenu = 'EditorMenuToggleBookmark'
    Item11SubItem0SubItemCount = 0
    Item11SubItem0WindowMenu = False
    Item11SubItem1Name = 'N30'
    Item11SubItem1Caption = 'Bookmark &1'
    Item11SubItem1Enabled = True
    Item11SubItem1Visible = True
    Item11SubItem1Checked = False
    Item11SubItem1RadioGroup = 0
    Item11SubItem1Separator = False
    Item11SubItem1Accelerator = 792
    Item11SubItem1Bitmap = ()
    Item11SubItem1OnMenu = 'EditorMenuToggleBookmark'
    Item11SubItem1SubItemCount = 0
    Item11SubItem1WindowMenu = False
    Item11SubItem1Tag = 1
    Item11SubItem2Name = 'N31'
    Item11SubItem2Caption = 'Bookmark &2'
    Item11SubItem2Enabled = True
    Item11SubItem2Visible = True
    Item11SubItem2Checked = False
    Item11SubItem2RadioGroup = 0
    Item11SubItem2Separator = False
    Item11SubItem2Accelerator = 793
    Item11SubItem2Bitmap = ()
    Item11SubItem2OnMenu = 'EditorMenuToggleBookmark'
    Item11SubItem2SubItemCount = 0
    Item11SubItem2WindowMenu = False
    Item11SubItem2Tag = 2
    Item11SubItem3Name = 'N32'
    Item11SubItem3Caption = 'Bookmark &3'
    Item11SubItem3Enabled = True
    Item11SubItem3Visible = True
    Item11SubItem3Checked = False
    Item11SubItem3RadioGroup = 0
    Item11SubItem3Separator = False
    Item11SubItem3Accelerator = 794
    Item11SubItem3Bitmap = ()
    Item11SubItem3OnMenu = 'EditorMenuToggleBookmark'
    Item11SubItem3SubItemCount = 0
    Item11SubItem3WindowMenu = False
    Item11SubItem3Tag = 3
    Item11SubItem4Name = 'N33'
    Item11SubItem4Caption = 'Bookmark &4'
    Item11SubItem4Enabled = True
    Item11SubItem4Visible = True
    Item11SubItem4Checked = False
    Item11SubItem4RadioGroup = 0
    Item11SubItem4Separator = False
    Item11SubItem4Accelerator = 795
    Item11SubItem4Bitmap = ()
    Item11SubItem4OnMenu = 'EditorMenuToggleBookmark'
    Item11SubItem4SubItemCount = 0
    Item11SubItem4WindowMenu = False
    Item11SubItem4Tag = 4
    Item11SubItem5Name = 'N34'
    Item11SubItem5Caption = 'Bookmark &5'
    Item11SubItem5Enabled = True
    Item11SubItem5Visible = True
    Item11SubItem5Checked = False
    Item11SubItem5RadioGroup = 0
    Item11SubItem5Separator = False
    Item11SubItem5Accelerator = 796
    Item11SubItem5Bitmap = ()
    Item11SubItem5OnMenu = 'EditorMenuToggleBookmark'
    Item11SubItem5SubItemCount = 0
    Item11SubItem5WindowMenu = False
    Item11SubItem5Tag = 5
    Item11SubItem6Name = 'N35'
    Item11SubItem6Caption = 'Bookmark &6'
    Item11SubItem6Enabled = True
    Item11SubItem6Visible = True
    Item11SubItem6Checked = False
    Item11SubItem6RadioGroup = 0
    Item11SubItem6Separator = False
    Item11SubItem6Accelerator = 797
    Item11SubItem6Bitmap = ()
    Item11SubItem6OnMenu = 'EditorMenuToggleBookmark'
    Item11SubItem6SubItemCount = 0
    Item11SubItem6WindowMenu = False
    Item11SubItem6Tag = 6
    Item11SubItem7Name = 'N36'
    Item11SubItem7Caption = 'Bookmark &7'
    Item11SubItem7Enabled = True
    Item11SubItem7Visible = True
    Item11SubItem7Checked = False
    Item11SubItem7RadioGroup = 0
    Item11SubItem7Separator = False
    Item11SubItem7Accelerator = 798
    Item11SubItem7Bitmap = ()
    Item11SubItem7OnMenu = 'EditorMenuToggleBookmark'
    Item11SubItem7SubItemCount = 0
    Item11SubItem7WindowMenu = False
    Item11SubItem7Tag = 7
    Item11SubItem8Name = 'N37'
    Item11SubItem8Caption = 'Bookmark &8'
    Item11SubItem8Enabled = True
    Item11SubItem8Visible = True
    Item11SubItem8Checked = False
    Item11SubItem8RadioGroup = 0
    Item11SubItem8Separator = False
    Item11SubItem8Accelerator = 799
    Item11SubItem8Bitmap = ()
    Item11SubItem8OnMenu = 'EditorMenuToggleBookmark'
    Item11SubItem8SubItemCount = 0
    Item11SubItem8WindowMenu = False
    Item11SubItem8Tag = 8
    Item11SubItem9Name = 'N38'
    Item11SubItem9Caption = 'Bookmark &9'
    Item11SubItem9Enabled = True
    Item11SubItem9Visible = True
    Item11SubItem9Checked = False
    Item11SubItem9RadioGroup = 0
    Item11SubItem9Separator = False
    Item11SubItem9Accelerator = 800
    Item11SubItem9Bitmap = ()
    Item11SubItem9OnMenu = 'EditorMenuToggleBookmark'
    Item11SubItem9SubItemCount = 0
    Item11SubItem9WindowMenu = False
    Item11SubItem9Tag = 9
    Item11Tag = 42
    Item12Name = 'N39'
    Item12Caption = '&Goto bookmark'
    Item12Enabled = True
    Item12Visible = True
    Item12Checked = False
    Item12RadioGroup = 0
    Item12Separator = False
    Item12Accelerator = 0
    Item12Bitmap = ()
    Item12SubItemCount = 10
    Item12WindowMenu = False
    Item12SubItem0Name = 'N40'
    Item12SubItem0Caption = 'Bookmark &0'
    Item12SubItem0Enabled = True
    Item12SubItem0Visible = True
    Item12SubItem0Checked = False
    Item12SubItem0RadioGroup = 0
    Item12SubItem0Separator = False
    Item12SubItem0Accelerator = 535
    Item12SubItem0Bitmap = ()
    Item12SubItem0OnMenu = 'EditorMenuGotoBookmark'
    Item12SubItem0SubItemCount = 0
    Item12SubItem0WindowMenu = False
    Item12SubItem1Name = 'N41'
    Item12SubItem1Caption = 'Bookmark &1'
    Item12SubItem1Enabled = True
    Item12SubItem1Visible = True
    Item12SubItem1Checked = False
    Item12SubItem1RadioGroup = 0
    Item12SubItem1Separator = False
    Item12SubItem1Accelerator = 536
    Item12SubItem1Bitmap = ()
    Item12SubItem1OnMenu = 'EditorMenuGotoBookmark'
    Item12SubItem1SubItemCount = 0
    Item12SubItem1WindowMenu = False
    Item12SubItem1Tag = 1
    Item12SubItem2Name = 'N42'
    Item12SubItem2Caption = 'Bookmark &2'
    Item12SubItem2Enabled = True
    Item12SubItem2Visible = True
    Item12SubItem2Checked = False
    Item12SubItem2RadioGroup = 0
    Item12SubItem2Separator = False
    Item12SubItem2Accelerator = 537
    Item12SubItem2Bitmap = ()
    Item12SubItem2OnMenu = 'EditorMenuGotoBookmark'
    Item12SubItem2SubItemCount = 0
    Item12SubItem2WindowMenu = False
    Item12SubItem2Tag = 2
    Item12SubItem3Name = 'N43'
    Item12SubItem3Caption = 'Bookmark &3'
    Item12SubItem3Enabled = True
    Item12SubItem3Visible = True
    Item12SubItem3Checked = False
    Item12SubItem3RadioGroup = 0
    Item12SubItem3Separator = False
    Item12SubItem3Accelerator = 538
    Item12SubItem3Bitmap = ()
    Item12SubItem3OnMenu = 'EditorMenuGotoBookmark'
    Item12SubItem3SubItemCount = 0
    Item12SubItem3WindowMenu = False
    Item12SubItem3Tag = 3
    Item12SubItem4Name = 'N44'
    Item12SubItem4Caption = 'Bookmark &4'
    Item12SubItem4Enabled = True
    Item12SubItem4Visible = True
    Item12SubItem4Checked = False
    Item12SubItem4RadioGroup = 0
    Item12SubItem4Separator = False
    Item12SubItem4Accelerator = 539
    Item12SubItem4Bitmap = ()
    Item12SubItem4OnMenu = 'EditorMenuGotoBookmark'
    Item12SubItem4SubItemCount = 0
    Item12SubItem4WindowMenu = False
    Item12SubItem4Tag = 4
    Item12SubItem5Name = 'N45'
    Item12SubItem5Caption = 'Bookmark &5'
    Item12SubItem5Enabled = True
    Item12SubItem5Visible = True
    Item12SubItem5Checked = False
    Item12SubItem5RadioGroup = 0
    Item12SubItem5Separator = False
    Item12SubItem5Accelerator = 540
    Item12SubItem5Bitmap = ()
    Item12SubItem5OnMenu = 'EditorMenuGotoBookmark'
    Item12SubItem5SubItemCount = 0
    Item12SubItem5WindowMenu = False
    Item12SubItem5Tag = 5
    Item12SubItem6Name = 'N46'
    Item12SubItem6Caption = 'Bookmark &6'
    Item12SubItem6Enabled = True
    Item12SubItem6Visible = True
    Item12SubItem6Checked = False
    Item12SubItem6RadioGroup = 0
    Item12SubItem6Separator = False
    Item12SubItem6Accelerator = 541
    Item12SubItem6Bitmap = ()
    Item12SubItem6OnMenu = 'EditorMenuGotoBookmark'
    Item12SubItem6SubItemCount = 0
    Item12SubItem6WindowMenu = False
    Item12SubItem6Tag = 6
    Item12SubItem7Name = 'N47'
    Item12SubItem7Caption = 'Bookmark &7'
    Item12SubItem7Enabled = True
    Item12SubItem7Visible = True
    Item12SubItem7Checked = False
    Item12SubItem7RadioGroup = 0
    Item12SubItem7Separator = False
    Item12SubItem7Accelerator = 542
    Item12SubItem7Bitmap = ()
    Item12SubItem7OnMenu = 'EditorMenuGotoBookmark'
    Item12SubItem7SubItemCount = 0
    Item12SubItem7WindowMenu = False
    Item12SubItem7Tag = 7
    Item12SubItem8Name = 'N48'
    Item12SubItem8Caption = 'Bookmark &8'
    Item12SubItem8Enabled = True
    Item12SubItem8Visible = True
    Item12SubItem8Checked = False
    Item12SubItem8RadioGroup = 0
    Item12SubItem8Separator = False
    Item12SubItem8Accelerator = 543
    Item12SubItem8Bitmap = ()
    Item12SubItem8OnMenu = 'EditorMenuGotoBookmark'
    Item12SubItem8SubItemCount = 0
    Item12SubItem8WindowMenu = False
    Item12SubItem8Tag = 8
    Item12SubItem9Name = 'N49'
    Item12SubItem9Caption = 'Bookmark &9'
    Item12SubItem9Enabled = True
    Item12SubItem9Visible = True
    Item12SubItem9Checked = False
    Item12SubItem9RadioGroup = 0
    Item12SubItem9Separator = False
    Item12SubItem9Accelerator = 544
    Item12SubItem9Bitmap = ()
    Item12SubItem9OnMenu = 'EditorMenuGotoBookmark'
    Item12SubItem9SubItemCount = 0
    Item12SubItem9WindowMenu = False
    Item12SubItem9Tag = 9
    Item12Tag = 42
    Item13Name = 'N54'
    Item13Caption = '&Goto...'#9'Ctrl+G'
    Item13Enabled = True
    Item13Visible = True
    Item13Checked = False
    Item13RadioGroup = 0
    Item13Separator = False
    Item13Accelerator = 0
    Item13Bitmap = ()
    Item13SubItemCount = 0
    Item13WindowMenu = False
  end
  object ProjectTreeMenu: TKOLPopupMenu
    showShortcuts = True
    generateConstants = False
    generateSeparatorConstants = False
    OwnerDraw = False
    Flags = []
    OnPopup = ProjectTreeMenuPopup
    Localizy = loForm
    Left = 104
    Top = 376
    ItemCount = 3
    Item0Name = 'N67'
    Item0Caption = '&Add file...'
    Item0Enabled = True
    Item0Visible = True
    Item0Checked = False
    Item0RadioGroup = 0
    Item0Separator = False
    Item0Accelerator = 0
    Item0Bitmap = ()
    Item0SubItemCount = 0
    Item0WindowMenu = False
    Item1Name = 'N80'
    Item1Caption = 'R&emove file'
    Item1Enabled = True
    Item1Visible = True
    Item1Checked = False
    Item1RadioGroup = 0
    Item1Separator = False
    Item1Accelerator = 0
    Item1Bitmap = ()
    Item1SubItemCount = 0
    Item1WindowMenu = False
    Item2Name = 'N79'
    Item2Caption = 'File &properties...'
    Item2Enabled = True
    Item2Visible = True
    Item2Checked = False
    Item2RadioGroup = 0
    Item2Separator = False
    Item2Accelerator = 0
    Item2Bitmap = ()
    Item2SubItemCount = 0
    Item2WindowMenu = False
  end
  object ProjectTreeImageList: TKOLImageList
    ImgWidth = 16
    ImgHeight = 16
    Count = 3
    bitmap.Data = {
      F6010000424DF601000000000000760000002800000030000000100000000100
      0400000000008001000000000000000000001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
      DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
      DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD0000000000DDDDDDDDDDDDDD
      DDDDDDD00000000000DDDDD0FBFBFBFBF00DD0000000000000DDDD0BFBFBFBFB
      FB0DDD0FBFBFBFBF0B0D777777777777770DDD0FBFBFBFBFBF0DDD0BFBFBFBFB
      0F0D78FFFFFFFFFF8770DD0BFBFBFBFBFB0DD0BFBFBFBFB0FB0D787777777777
      8770DD0FBFBFBFBFBF0DD0FBFBFBFBF0BF0D7888888888888770DD0BFBFBFBFB
      FB0DD0000000000BFB0D7888888888828770DD0FBFBFBFBFBF0DDD0FBFBFBFBF
      BF0D7FFFFFFFFFFFF770DD0000000BFBFB0DDD0BFBFBFBFBFB0DD78888888888
      8870DD0FBFBFB00000DDDD0FBFBFB00000DDDD7777777777777DDDD0FBFB0DDD
      DDDDDDD0FBFB0DDDDDDDDDDDDDDDDDDDDDDDDDDD0000DDDDDDDDDDDD0000DDDD
      DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
      DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD}
    TransparentColor = clFuchsia
    systemimagelist = False
    Colors = ilcColor4
    Masked = True
    BkColor = clNone
    Force32bit = False
    Left = 104
    Top = 472
  end
end
