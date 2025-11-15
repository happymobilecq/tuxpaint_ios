;
; This script needs the InnoSetup PreProcessor (ISPP) to compile correctly. 
; I downloaded a combined 'QuickStart Pack' from here:
; http://www.jrsoftware.org/isdl.php#qsp
;
#define AppVersion     "2023-03-30"

#define PublisherName  "New Breed Software"
#define PublisherURL  "{code:MyPublisherURL}"

#define AppName        "Tux Paint Stamps"
#define AppDirName     "TuxPaint"
#define AppPrefix      "tuxpaint-stamps"
#define AppRegKey      "TuxPaint"
#define AppRegValue    "InstallStamps_Dir"
#define MainRegValue   "Install_Dir"
#define MainRegVersion "Version"

#define AppGroupName   "Tux Paint"
#define AppExe         AppPrefix+".exe"
#define AppConfigName  AppName+" Config"
#define AppConfigExe   AppPrefix+"-config.exe"
#define AppReadme     "{code:MyReadme}"
#define AppLicense    "docs\COPYING.txt"

#define BdistDir       ".."

[Setup]
AppName={#AppName}
AppVerName={#AppName} {#AppVersion}
AppPublisher={#PublisherName}
AppPublisherURL={#PublisherURL}
AppSupportURL={#PublisherURL}
AppUpdatesURL={#PublisherURL}
DefaultDirName={pf}\{#AppDirName}
DefaultGroupName={#AppGroupName}
InfoBeforeFile={#BdistDir}\docs\COPYING.txt
OutputDir=.\
OutputBaseFilename={#AppPrefix}-{#AppVersion}-windows-installer
SetupIconFile=.\tuxpaint-stamps-installer.ico
WizardStyle=modern
Compression=lzma2
SolidCompression=yes
DirExistsWarning=no
PrivilegesRequired=admin

ArchitecturesInstallIn64BitMode=x64

[Languages]
Name: "afr"; MessagesFile: "compiler:Languages\Afrikaans.isl"
Name: "alb"; MessagesFile: "compiler:Languages\Albanian.isl"
Name: "ara"; MessagesFile: "compiler:Languages\Arabic.isl"
Name: "arm"; MessagesFile: "compiler:Languages\Armenian.isl"
Name: "ast"; MessagesFile: "compiler:Languages\Asturian.isl"
Name: "baq"; MessagesFile: "compiler:Languages\Basque.isl"
Name: "bel"; MessagesFile: "compiler:Languages\Belarusian.isl"
Name: "ben"; MessagesFile: "compiler:Languages\Bengali.islu"
Name: "bos"; MessagesFile: "compiler:Languages\Bosnian.isl"
Name: "bra"; MessagesFile: "compiler:Languages\BrazilianPortuguese.isl"
Name: "bul"; MessagesFile: "compiler:Languages\Bulgarian.isl"
Name: "cat"; MessagesFile: "compiler:Languages\Catalan.isl"
Name: "chs"; MessagesFile: "compiler:Languages\ChineseSimplified.isl"
Name: "cht"; MessagesFile: "compiler:Languages\ChineseTraditional.isl"
Name: "cnr"; MessagesFile: "compiler:Languages\Montenegrin.isl"
Name: "cos"; MessagesFile: "compiler:Languages\Corsican.isl"
Name: "cze"; MessagesFile: "compiler:Languages\Czech.isl"
Name: "dan"; MessagesFile: "compiler:Languages\Danish.isl"
Name: "dut"; MessagesFile: "compiler:Languages\Dutch.isl"
Name: "enb"; MessagesFile: "compiler:Languages\EnglishBritish.isl"
Name: "eng"; MessagesFile: "compiler:Default.isl"
Name: "epo"; MessagesFile: "compiler:Languages\Esperanto.isl"
Name: "esp"; MessagesFile: "compiler:Languages\Spanish.isl"
Name: "est"; MessagesFile: "compiler:Languages\Estonian.isl"
Name: "fas"; MessagesFile: "compiler:Languages\Farsi.isl"
Name: "fin"; MessagesFile: "compiler:Languages\Finnish.isl"
Name: "fre"; MessagesFile: "compiler:Languages\French.isl"
Name: "gal"; MessagesFile: "compiler:Languages\Galician.isl"
Name: "geo"; MessagesFile: "compiler:Languages\Georgian.isl"
Name: "ger"; MessagesFile: "compiler:Languages\German.isl"
Name: "gla"; MessagesFile: "compiler:Languages\ScottishGaelic.isl"
Name: "gre"; MessagesFile: "compiler:Languages\Greek.isl"
Name: "heb"; MessagesFile: "compiler:Languages\Hebrew.isl"
Name: "hin"; MessagesFile: "compiler:Languages\Hindi.islu"
Name: "hun"; MessagesFile: "compiler:Languages\Hungarian.isl"
Name: "ice"; MessagesFile: "compiler:Languages\Icelandic.isl"
Name: "ind"; MessagesFile: "compiler:Languages\Indonesian.isl"
Name: "ita"; MessagesFile: "compiler:Languages\Italian.isl"
Name: "jpn"; MessagesFile: "compiler:Languages\Japanese.isl"
Name: "kaz"; MessagesFile: "compiler:Languages\Kazakh.islu"
Name: "kor"; MessagesFile: "compiler:Languages\Korean.isl"
Name: "kur"; MessagesFile: "compiler:Languages\Kurdish.isl"
Name: "lav"; MessagesFile: "compiler:Languages\Latvian.isl"
Name: "lij"; MessagesFile: "compiler:Languages\Ligurian.isl"
Name: "lit"; MessagesFile: "compiler:Languages\Lithuanian.isl"
Name: "ltz"; MessagesFile: "compiler:Languages\Luxemburgish.isl"
Name: "mac"; MessagesFile: "compiler:Languages\Macedonian.isl"
Name: "mar"; MessagesFile: "compiler:Languages\Marathi.islu"
Name: "may"; MessagesFile: "compiler:Languages\Malaysian.isl"
Name: "mon"; MessagesFile: "compiler:Languages\Mongolian.isl"
Name: "nep"; MessagesFile: "compiler:Languages\Nepali.islu"
Name: "nno"; MessagesFile: "compiler:Languages\NorwegianNynorsk.isl"
Name: "nor"; MessagesFile: "compiler:Languages\Norwegian.isl"
Name: "occ"; MessagesFile: "compiler:Languages\Occitan.isl"
Name: "pol"; MessagesFile: "compiler:Languages\Polish.isl"
Name: "por"; MessagesFile: "compiler:Languages\Portuguese.isl"
Name: "rum"; MessagesFile: "compiler:Languages\Romanian.isl"
Name: "rus"; MessagesFile: "compiler:Languages\Russian.isl"
Name: "scc"; MessagesFile: "compiler:Languages\SerbianCyrillic.isl"
Name: "scl"; MessagesFile: "compiler:Languages\SerbianLatin.isl"
Name: "scr"; MessagesFile: "compiler:Languages\Croatian.isl"
Name: "sin"; MessagesFile: "compiler:Languages\Sinhala.islu"
Name: "slo"; MessagesFile: "compiler:Languages\Slovak.isl"
Name: "slv"; MessagesFile: "compiler:Languages\Slovenian.isl"
Name: "swe"; MessagesFile: "compiler:Languages\Swedish.isl"
Name: "tai"; MessagesFile: "compiler:Languages\Thai.isl"
Name: "tat"; MessagesFile: "compiler:Languages\Tatar.isl"
Name: "tur"; MessagesFile: "compiler:Languages\Turkish.isl"
Name: "uig"; MessagesFile: "compiler:Languages\Uyghur.islu"
Name: "ukr"; MessagesFile: "compiler:Languages\Ukrainian.isl"        
Name: "urd"; MessagesFile: "compiler:Languages\Urdu.isl"
Name: "uzb"; MessagesFile: "compiler:Languages\Uzbek.isl"
Name: "vie"; MessagesFile: "compiler:Languages\Vietnamese.isl"
Name: "vlca";MessagesFile: "compiler:Languages\valencian.isl"

[Files]
Source: "{#BdistDir}\stamps\animals\*"; DestDir: "{app}\data\stamps\animals"; Excludes: "CVS"; Components: animals; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#BdistDir}\stamps\clothes\*"; DestDir: "{app}\data\stamps\clothes"; Excludes: "CVS"; Components: clothes; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#BdistDir}\stamps\food\*"; DestDir: "{app}\data\stamps\food"; Excludes: "CVS"; Components: food; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#BdistDir}\stamps\hobbies\*"; DestDir: "{app}\data\stamps\hobbies"; Excludes: "CVS"; Components: hobbies; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#BdistDir}\stamps\household\*"; DestDir: "{app}\data\stamps\household"; Excludes: "CVS"; Components: household; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#BdistDir}\stamps\medical\*"; DestDir: "{app}\data\stamps\medical"; Excludes: "CVS"; Components: medical; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#BdistDir}\stamps\military\*"; DestDir: "{app}\data\stamps\military"; Excludes: "CVS"; Components: military; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#BdistDir}\stamps\naturalforces\*"; DestDir: "{app}\data\stamps\naturalforces"; Excludes: "CVS"; Components: naturalforces; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#BdistDir}\stamps\people\*"; DestDir: "{app}\data\stamps\people"; Excludes: "CVS"; Components: people; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#BdistDir}\stamps\plants\*"; DestDir: "{app}\data\stamps\plants"; Excludes: "CVS"; Components: plants; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#BdistDir}\stamps\seasonal\*"; DestDir: "{app}\data\stamps\seasonal"; Excludes: "CVS"; Components: seasonal; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#BdistDir}\stamps\space\*"; DestDir: "{app}\data\stamps\space"; Excludes: "CVS"; Components: space; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#BdistDir}\stamps\sports\*"; DestDir: "{app}\data\stamps\sports"; Excludes: "CVS"; Components: sports; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#BdistDir}\stamps\symbols\*"; DestDir: "{app}\data\stamps\symbols"; Excludes: "CVS"; Components: symbols; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#BdistDir}\stamps\town\*"; DestDir: "{app}\data\stamps\town"; Excludes: "CVS"; Components: town; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#BdistDir}\stamps\vehicles\*"; DestDir: "{app}\data\stamps\vehicles"; Excludes: "CVS"; Components: vehicles; Flags: ignoreversion recursesubdirs createallsubdirs

Source: ".\tuxpaint-installer.ico"; DestDir: "{app}\data\images"; Excludes: "CVS"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#BdistDir}\docs\*"; DestDir: "{app}\docs\stamps"; Excludes: "CVS"; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Components]
Name: "animals"; Description: "Animals (Birds, fish, dinosaurs, etc.)"; Types: full;
Name: "clothes"; Description: "Clothes (Hats, etc.)"; Types: full compact;
Name: "food"; Description: "Food (Fruit, vegetables, dessert, etc.)"; Types: full;
Name: "hobbies"; Description: "Hobbies (Camera, binoculars, etc.)"; Types: full compact;
Name: "household"; Description: "Household (Toilet, dishes, garbage can, etc.)"; Types: full;
Name: "medical"; Description: "Medical (Syringe, stethescope, etc.)"; Types: full compact;
Name: "military"; Description: "Military (Tanks, etc.)"; Types: full;
Name: "naturalforces"; Description: "Natural Forces (Fire, lightning, etc.)"; Types: full;
Name: "people"; Description: "People (Fireman, etc.)"; Types: full compact;
Name: "plants"; Description: "Plants (Flowers, trees, etc.)"; Types: full;
Name: "seasonal"; Description: "Seasonal (Christmas, Easter, Hanukkah, etc.)"; Types: full;
Name: "space"; Description: "Space (Planets, space vehicles, etc.)"; Types: full;
Name: "sports"; Description: "Sports (Balls, tropheys, etc.)"; Types: full compact;
Name: "symbols"; Description: "Symbols (Digits, music, money, shapes, etc.)"; Types: full;
Name: "town"; Description: "Town (Houses, flags, roadsigns, etc.)"; Types: full;
Name: "vehicles"; Description: "Vehicles (Cars, construction, air, boats, etc.)"; Types: full;

[INI]
Filename: "{code:MyGroupDir}\{groupname}\{cm:ProgramOnTheWeb,{#AppName}}.url"; Section: "InternetShortcut"; Key: "URL"; String: "{#PublisherURL}"

[Icons]
Name: "{code:MyGroupDir}\{groupname}\{#AppName} Readme"; Filename: "{app}\{#AppReadme}"; Comment: "View {#AppName} ReadMe"
Name: "{code:MyGroupDir}\{groupname}\{#AppName} License"; Filename: "{app}\{#AppLicense}"; Comment: "View {#AppName} License"
Name: "{code:MyGroupDir}\{groupname}\{cm:UninstallProgram,{#AppName}}"; Filename: "{uninstallexe}"; IconFilename: "{app}\data\images\tuxpaint-installer.ico"; Comment: "Remove {#AppName}"

[Registry]
Root: HKLM; Subkey: "SOFTWARE\{#AppRegKey}"; Flags: uninsdeletekeyifempty uninsdeletevalue; ValueName: "{#AppRegValue}"; ValueType: string; ValueData: "{app}"; Check: AllUsers;
Root: HKCU; Subkey: "SOFTWARE\{#AppRegKey}"; Flags: uninsdeletekeyifempty uninsdeletevalue; ValueName: "{#AppRegValue}"; ValueType: string; ValueData: "{app}"; Check: ThisUserOnly;

[UninstallDelete]
Type: files; Name: "{code:MyGroupDir}\{groupname}\{cm:ProgramOnTheWeb,{#AppName}}.url"
Type: dirifempty; Name: "{code:MyGroupDir}\{groupname}"
; Tidy-up if uninstalled after 'Tux Paint'
Type: dirifempty; Name: "{app}\data\stamps\cartoon"
Type: dirifempty; Name: "{app}\data\stamps"
Type: dirifempty; Name: "{app}\data\images"
Type: dirifempty; Name: "{app}\data"
Type: dirifempty; Name: "{app}\docs"
Type: dirifempty; Name: "{app}"

[code]
const
  CSIDL_PROFILE                 = $0028;
  CSIDL_COMMON_PROGRAMS         = $0017;
  CSIDL_COMMON_DESKTOPDIRECTORY = $0019;

  WM_LBUTTONDOWN                = $0201;
  WM_LBUTTONUP                  = $0202;
var
  CheckListBox2: TNewCheckListBox;

function Restricted(): Boolean;
begin
  Result := not (IsAdminLoggedOn() or IsPowerUserLoggedOn())
end;

function NotRestricted(): Boolean;
begin
  Result := not Restricted()
end;

function Is9xME(): Boolean;
begin
  Result := not UsingWinNT()
end;

function CurrentUserOnly(): Boolean;
begin
  Result := CheckListBox2.Checked[2]
end;

function ThisUserOnly(): Boolean;
begin
  Result := Restricted() or CurrentUserOnly()
end;

function AllUsers(): Boolean;
begin
  Result := not ThisUserOnly()
end;

function GetHKLMKey(key: String): String;
begin
  Result := ExpandConstant('{reg:HKLM\SOFTWARE\{#AppRegKey},'+key+'|__MissingKey__}');
end;

function GetHKCUKey(key: String): String;
begin
  Result := ExpandConstant('{reg:HKCU\SOFTWARE\{#AppRegKey},'+key+'|__MissingKey__}');
end;

function GetMainAppKey(key: String): String;
var
  Path: String;
begin
  Path := GetHKLMKey(key);
  if Path = '__MissingKey__' then
    Path := GetHKCUKey(key);
  Result := Path
end;

function GetMainAppDir(): String;
begin
  Result := GetMainAppKey('{#MainRegValue}')
end;

function GetMainAppVersion(): String;
begin
  Result := GetMainAppKey('{#MainRegVersion}')
end;

function MainAppInstalled(): Boolean;
begin
  Result := not (GetMainAppDir() = '__MissingKey__')
end;

function ObsoleteVersion(): Boolean;
begin
  Result := MainAppInstalled() and (GetMainAppVersion() = '__MissingKey__');
end;

function MainAppCUInstall(): Boolean;
begin
  Result := not (GetHKCUKey('{#MainRegValue}') = '__MissingKey__');
end;

function MyStampsDir(): String;
var
  Path: String;
  HKCU_Path: String;
begin
  Path := GetMainAppDir();
  HKCU_Path := GetHKCUKey('{#MainRegValue}');
  if (Path = '__MissingKey__') or (ThisUserOnly() and (Path <> HKCU_Path)) then
  begin
    Path := ExpandConstant('{userappdata}')+'\TuxPaint';
  end;
  Result := Path
end;

function MyGroupDir(Default: String): String;
var
  Path: String;
begin
  if ThisUserOnly() then
    Path := ExpandConstant('{userprograms}')
  else
    Path := ExpandConstant('{commonprograms}');
  Result := Path
end;

function MyDesktopDir(Default: String): String;
var
  Path: String;
begin
  if ThisUserOnly() then
    Path := ExpandConstant('{userdesktop}')
  else
    Path := ExpandConstant('{commondesktop}');
  Result := Path
end;

function CmdLineParamExists(const Value: string): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 1 to ParamCount do
    if CompareText(ParamStr(I), Value) = 0 then
    begin
      Result := True;
      Exit;
    end;
end;

Procedure ForceUninstallPreviousX86Install();
var
  ResultCode: Integer;
begin
  if Is64BitInstallMode then
  begin
    if FileExists('C:\Program Files (x86)\TuxPaint\unins001.exe') then
    begin
      if CmdLineParamExists('/VERYSILENT') = False then
      begin
        if MsgBox('Old version will be uninstalled automatically.', mbInformation, MB_OKCANCEL) = IDOK then
        begin
          Exec('C:\Program Files (x86)\TuxPaint\unins001.exe', '/SILENT', '', SW_SHOW, ewWaitUntilTerminated, ResultCode);
        end
        else begin
          Abort;
        end;
      end
      else begin
        Exec('C:\Program Files (x86)\TuxPaint\unins001.exe', '/VERYSILENT', '', SW_SHOW, ewWaitUntilTerminated, ResultCode);
      end;
    end;
  end;
end;

procedure CreateTheWizardPages;
var
  Page: TWizardPage;
  Enabled, InstallAllUsers: Boolean;
begin
  Page := CreateCustomPage(wpLicense, 'Choose Installation Type', 'Who do you want to be able to use this stamp collection?');
  Enabled := NotRestricted() and not MainAppCUInstall();
  InstallAllUsers := NotRestricted() and not MainAppCUInstall();
  CheckListBox2 := TNewCheckListBox.Create(Page);
  CheckListBox2.Width := Page.SurfaceWidth;
  CheckListBox2.Height := ScaleY(97);
  CheckListBox2.BorderStyle := bsNone;
  CheckListBox2.ParentColor := True;
  CheckListBox2.MinItemHeight := WizardForm.TasksList.MinItemHeight;
  CheckListBox2.ShowLines := False;
  CheckListBox2.WantTabs := True;
  CheckListBox2.Parent := Page.Surface;
  CheckListBox2.AddGroup('Installation Type:', '', 0, nil);
  CheckListBox2.AddRadioButton('All Users', '', 0, InstallAllUsers, Enabled, nil);
  CheckListBox2.AddRadioButton('Current User Only', '', 0, not InstallAllUsers, True, nil);
end;

procedure CurPageChanged(CurPageID: Integer);
begin
  if CurPageID = wpSelectDir then
  begin
    WizardForm.DirEdit.Text := MyStampsDir();
  end
end;

procedure InitializeWizard();
begin
  ForceUninstallPreviousX86Install();
  CreateTheWizardPages;
  if not MainAppInstalled() then
    if MsgBox('I cannot find an installation of Tux Paint.'+#13#13+'Would you like to install anyway?', mbConfirmation, MB_YESNO) = IDNO then
    begin
      Abort()
    end;
  if ObsoleteVersion() then
    if MsgBox('You have an old version of Tux Paint installed.'+#13+'We recommend that you install the latest version.'+#13#13+'Would you like to install anyway?', mbConfirmation, MB_YESNO) = IDNO then
    begin
      Abort()
    end
end;

function Lang2Gettext(TwoLetter: Boolean): String;
var
  lang, lc: String;
begin
  lang := ActiveLanguage();

  if lang = 'afr' then
    lc := 'af'
  else
  if lang = 'alb' then
    lc := 'sq'
  else
  if lang = 'ara' then
    lc := 'ar'
  else
  if lang = 'arm' then
    lc := 'hy'
  else
  if lang = 'ast' then
    if TwoLetter = true then
      lc := 'es'
    else
      lc := 'ast'
  else
  if lang = 'baq' then
    lc := 'eu'
  else
  if lang = 'ben' then
    lc := 'bn'
  else
  if lang = 'bel' then
    lc := 'be'
  else
  if lang = 'bos' then
    lc := 'bs'
  else
  if lang = 'bra' then
    if TwoLetter = true then
      lc := 'pt'
    else
      lc := 'pt_br'
  else
  if lang = 'bul' then
    lc := 'bg'
  else
  if lang = 'cat' then
    lc := 'ca'
  else
  if lang = 'chs' then
    if TwoLetter = true then
      lc := 'zh'
    else
      lc := 'zh_cn'
  else
  if lang = 'cht' then
    if TwoLetter = true then
      lc := 'zh'
    else
      lc := 'zh_tw'
  else
  if lang = 'cnr' then
    if TwoLetter = true then
      lc := 'sr'
    else
      lc := 'sr_latin'
  else
  if lang = 'cos' then
    lc := 'co'
  else
  if lang = 'cze' then
    lc := 'cs'
  else
  if lang = 'dan' then
    lc := 'da'
  else
  if lang = 'dut' then
    lc := 'nl'
  else
  if lang = 'enb' then
    if TwoLetter = true then
      lc := 'en'
    else
      lc := 'en_gb'
  else
  if lang = 'epo' then
    lc := 'eo'
  else
  if lang = 'esp' then
    lc := 'es'
  else
  if lang = 'est' then
    lc := 'et'
  else
  if lang = 'fas' then
    lc := 'fa'
  else
  if lang = 'fin' then
    lc := 'fi'
  else
  if lang = 'fre' then
    lc := 'fr'
  else
  if lang = 'gal' then
    lc := 'gl'
  else
  if lang = 'geo' then
    lc := 'ka'
  else
  if lang = 'ger' then
    lc := 'de'
  else
  if lang = 'gla' then
    lc := 'gd'
  else
  if lang = 'gre' then
    lc := 'el'
  else
  if lang = 'heb' then
    lc := 'he'
  else
  if lang = 'hin' then
    lc := 'hi'
  else
  if lang = 'hun' then
    lc := 'hu'
  else
  if lang = 'ice' then
    lc := 'is'
  else
  if lang = 'ind' then
    lc := 'id'
  else
  if lang = 'ita' then
    lc := 'it'
  else
  if lang = 'jpn' then
    lc := 'ja'
  else
  if lang = 'kaz' then
    lc := 'kk'
  else
  if lang = 'kor' then
    lc := 'ko'
  else
  if lang = 'kur' then
    lc := 'ku'
  else
  if lang = 'lav' then
    lc := 'lv'
  else
  if lang = 'lit' then
    lc := 'lt'
  else
  if lang = 'ltz' then
    lc := 'lb'
  else
  if lang = 'mac' then
    lc := 'mk'
  else
  if lang = 'mar' then
    lc := 'mr'
  else
  if lang = 'may' then
    lc := 'ms'
  else
  if lang = 'mon' then
    lc := 'mn'
  else
  if lang = 'nep' then
    lc := 'ne'
  else
  if lang = 'nno' then
    lc := 'nn'
  else
  if lang = 'nor' then
    lc := 'nn'
  else
  if lang = 'occ' then
    lc := 'oc'
  else
  if lang = 'pol' then
    lc := 'pl'
  else
  if lang = 'por' then
    lc := 'pt'
  else
  if lang = 'rum' then
    lc := 'ro'
  else
  if lang = 'rus' then
    lc := 'ru'
  else
  if lang = 'scc' then
    lc := 'sr'
  else
  if lang = 'scl' then
    if TwoLetter = true then
      lc := 'sr'
    else
      lc := 'sr_latin'
  else
  if lang = 'scr' then
    lc := 'hr'
  else
  if lang = 'sin' then
    lc := 'si'
  else
  if lang = 'slo' then
    lc := 'sk'
  else
  if lang = 'slv' then
    lc := 'sl'
  else
  if lang = 'swe' then
    lc := 'sv'
  else
  if lang = 'tai' then
    lc := 'th'
  else
  if lang = 'tat' then
    lc := 'tt'
  else
  if lang = 'tur' then
    lc := 'tr'
  else
  if lang = 'uig' then
    lc := 'ug'
  else
  if lang = 'ukr' then
    lc := 'uk'
  else
  if lang = 'urd' then
    lc := 'ur'
  else
  if lang = 'uzb' then
    lc := 'uz'
  else
  if lang = 'vie' then
    lc := 'vi'
  else
    lc := 'en';
  Result := lc
end;

function MyReadme(Default: String): String;
var
  lang, readme: String;
begin
  lang := Lang2Gettext(false);

  if lang = 'el' then
    readme := 'el\README.txt'
  else
  if lang = 'es' then
    readme := 'es\LEEME.txt'
  else
  if lang = 'fr' then
    readme := 'fr\README.txt'
  else
  if lang = 'hu' then
    readme := 'hu\OLVASSEL.txt'
  else
    readme := 'README.txt';

  Result := 'docs\stamps\'+readme
end;

function MyPublisherURL(Default: String): String;
var
  lang: String;
begin
  lang := Lang2Gettext(false);

  if lang = 'chs' then
    lang := 'zh-cn'
  else
  if lang = 'cht' then
    lang := 'zh-tw';

  Result := 'http://www.tuxpaint.org/?lang='+lang
end;

#expr SaveToFile(AddBackslash(SourcePath) + "Preprocessed.iss")

