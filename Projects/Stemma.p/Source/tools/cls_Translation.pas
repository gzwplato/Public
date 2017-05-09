unit cls_Translation;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type

{ TTranslation }

 TTranslation=class
  Fitems:Tstrings;
private
  function GetItems(index: integer): String;
public
  constructor Create;
  destructor Destroy;override;
  procedure LoadFromFile(aLanguage:string;out Success:boolean);overload;
  procedure LoadFromFile(aLanguage:string);overload;
  property Items[index:integer]:String read GetItems;
end;

resourcestring
  rsMenuHistoryCaption = '&%d- %s (%d)';

  SAreYouSureToQuit	= 'Are you syre you want to quit STEMMA?';
  SUnableToConnectToDB 	= 'Couldn''t connect to MySQL database %s.';
  SConfirmation		= 'Confirmation';
  SDatabaseName 	= 'Database name';
  SEnterDBName		= 'Enter the database name to be created';
  STitle		= 'Title';
  SSuffix		= 'Suffix';
  SFamilyName		= 'Name';
  SGivenName		= 'First name';

var Translation:TTranslation;

implementation

constructor TTranslation.Create;
begin
 Fitems:=TStringList.Create;
  FItems.Add(SAreYouSureToQuit);
FItems.Add(SConfirmation);
FItems.Add(SUnableToConnectToDB);
FItems.Add(SDatabaseName);
FItems.Add(SEnterDBName);
FItems.Add('Database already existing.');
FItems.Add('Location of the TMG 4.0d database');
FItems.Add('Step 1/12 - Event type importation');
FItems.Add('Step 2/12 - Source-repository association importation');
FItems.Add('Step 3/12 - Repository importation');
FItems.Add('Step 4/12 - Event Importation - Time to completion ');
FItems.Add('Step 5/12 - Citation importation - Time to completion ');
FItems.Add('Step 6/12 - Individual importation - Time to completion ');
FItems.Add('Step 7/12 - Place importation - Time to completion ');
FItems.Add('Step 8/12 - Witness importation - Time to completion ');
FItems.Add('Step 9/12 - Name importation - Time to completion ');
FItems.Add('Step 10/12 - Relation importation - Time to completion ');
FItems.Add('Step 11/12 - Source importation - Time to completion ');
FItems.Add('Step 12/12 - Exhibits importation - Time to completion ');
FItems.Add('Error: STEMMA Database already existing or impossible to open imported database.');
FItems.Add('Number of the individual');
FItems.Add('Enter the number of the desired individual');
FItems.Add('The individual ');
FItems.Add(' has not been found.');
FItems.Add('Enter the database name to delete');
FItems.Add('Enter the database name');
FItems.Add('Database not found.');
FItems.Add('Are you sure you want to delete repository "');
FItems.Add('" ?');
FItems.Add('Add a citation');
FItems.Add('Add an event');
FItems.Add('Are you sure you want to delete citation "');
FItems.Add('Are you sure you want to delete witness "');
FItems.Add('Add an exhibit');
FItems.Add('Text');
FItems.Add('Add an individual');
FItems.Add('Add a name');
FItems.Add(SFamilyName);
FItems.Add(SGivenName);
FItems.Add(SSuffix);
FItems.Add(STitle);
FItems.Add('Add a child');
FItems.Add('Add a parent');
FItems.Add('Add a source');
FItems.Add('Are you sure you want to delete the link to the depository "');
FItems.Add('Depository modification');
FItems.Add('Enter the depository #');
FItems.Add('Add a depository');
FItems.Add('Add a witness');
FItems.Add('B - Birth events');
FItems.Add('D - Death events');
FItems.Add('M - Union events');
FItems.Add('X - Other events');
FItems.Add('N - Names');
FItems.Add('R - Filiations');
FItems.Add('Z - Other relations');
FItems.Add('Add an event, name or relation type');
FItems.Add('Children');
FItems.Add('Are you sure you want to delete the link to the child "');
FItems.Add('Events');
FItems.Add('Are you sure you want to delete "');
FItems.Add('Only the exhibits associated to an individual (type "I") can be modified this way');
FItems.Add('Are you sure you want to delete exhibit "');
FItems.Add('NO TITLE, NO DESCRIPTION');
FItems.Add('image');
FItems.Add('Exhibits');
FItems.Add('she');
FItems.Add('he');
FItems.Add('her');
FItems.Add('his');
FItems.Add('daughter of ');
FItems.Add('son of ');
FItems.Add(' and ');
FItems.Add('TO BE PROGRAMMED');
FItems.Add('first');
FItems.Add('january');
FItems.Add('fébruary');
FItems.Add('march');
FItems.Add('april');
FItems.Add('may');
FItems.Add('june');
FItems.Add('july');
FItems.Add('august');
FItems.Add('september');
FItems.Add('october');
FItems.Add('november');
FItems.Add('december');
FItems.Add('before the ');
FItems.Add('before ');
FItems.Add('before a ');
FItems.Add(' of the year ');
FItems.Add('circa the ');
FItems.Add('circa ');
FItems.Add('circa a ');
FItems.Add('the ');
FItems.Add('in ');
FItems.Add('a ');
FItems.Add('after the ');
FItems.Add('after ');
FItems.Add('after a ');
FItems.Add('between the ');
FItems.Add('between ');
FItems.Add('between a ');
FItems.Add(' and the ');
FItems.Add(' and a ');
FItems.Add(' or the ');
FItems.Add(' or in ');
FItems.Add(' or a ');
FItems.Add('from ');
FItems.Add('from ');
FItems.Add('from a ');
FItems.Add(' to ');
FItems.Add(' to ');
FItems.Add(' to a ');
FItems.Add('c.');
FItems.Add(' or ');
FItems.Add('Siblings');
FItems.Add('Principal exhibit');
FItems.Add('Selected exhibit');
FItems.Add('Merge with...');
FItems.Add('Enter the place # with "');
FItems.Add('" should merge');
FItems.Add('Not the same place (');
FItems.Add(') vs (');
FItems.Add('Error');
FItems.Add('Are you sure you want to delete place "');
FItems.Add('Names');
FItems.Add(') and attributes');
FItems.Add('To remove a primary name, select the new primary name.');
FItems.Add('Are you sure you want to delete the name "');
FItems.Add('Parents');
FItems.Add('Are you sure you want to delete the link to the  parent "');
FItems.Add('Are you sure you want to delete source "');
FItems.Add('Are you sure you want to delete "');
FItems.Add('Event');
FItems.Add('Witness');
FItems.Add('Date');
FItems.Add('# Source');
FItems.Add('Source');
FItems.Add('# Author');
FItems.Add('Author');
FItems.Add('Select the desired language file');
FItems.Add('About');
FItems.Add('Version:');
FItems.Add('Date:');
FItems.Add('by François Marchi');
FItems.Add('Ancestors');
FItems.Add('Connexion to database');
FItems.Add('Close');
FItems.Add('User:');
FItems.Add('Server:');
FItems.Add('Password:');
FItems.Add('Ok');
FItems.Add('Repositories');
FItems.Add('Title');
FItems.Add('Description');
FItems.Add('Memo');
FItems.Add('Individual');
FItems.Add('Usage');
FItems.Add('Descendants');
FItems.Add('Citation modification');
FItems.Add('Source:');
FItems.Add('Description:');
FItems.Add('Quality:');
FItems.Add('Cancel');
FItems.Add('Event modification');
FItems.Add('Type:');
FItems.Add('Witnesses:');
FItems.Add('(presentation):');
FItems.Add('(sort):');
FItems.Add('Place:');
FItems.Add('Memo:');
FItems.Add('Sentence:');
FItems.Add('(default)');
FItems.Add('Citations:');
FItems.Add('Role');
FItems.Add('Name');
FItems.Add('Q');
FItems.Add('Exhibit modification');
FItems.Add('Title:');
FItems.Add('File:');
FItems.Add('Visualise');
FItems.Add('Name modification');
FItems.Add('Individual:');
FItems.Add('Name:');
FItems.Add('Type');
FItems.Add('Relation modification');
FItems.Add('Parent:');
FItems.Add('Child:');
FItems.Add('Sort date:');
FItems.Add('Source modification');
FItems.Add('Author:');
FItems.Add('Default Quality:');
FItems.Add('Repositories:');
FItems.Add('Repository');
FItems.Add('Witness modification');
FItems.Add('Witness:');
FItems.Add('Role:');
FItems.Add('Result:');
FItems.Add('Event type modification');
FItems.Add('Child');
FItems.Add('Format');
FItems.Add('Explorer');
FItems.Add('Birth');
FItems.Add('Death');
FItems.Add('Sibling');
FItems.Add('Navigation history');
FItems.Add('Places');
FItems.Add('Preposition');
FItems.Add('Detail');
FItems.Add('City');
FItems.Add('Region');
FItems.Add('State');
FItems.Add('Country');
FItems.Add('Names and Attributes');
FItems.Add('Last modification:');
FItems.Add('Parent');
FItems.Add('Exhibit display');
FItems.Add('Sources');
FItems.Add('Author');
FItems.Add('Event types');
FItems.Add('Phrase');
FItems.Add('&Go to');
FItems.Add('&Usage');
FItems.Add('&Add');
FItems.Add('&Modify');
FItems.Add('&Delete');
FItems.Add('&Witnesses');
FItems.Add('&Citations');
FItems.Add('Add &title');
FItems.Add('Add &first name');
FItems.Add('Add &surname');
FItems.Add('Add suffi&x');
FItems.Add('&Repositories');
FItems.Add('&Primary');
FItems.Add('Sort by &first name');
FItems.Add('Sort by &surname');
FItems.Add('Sort by &birth');
FItems.Add('Sort by &death');
FItems.Add('&Sort');
FItems.Add('by &detail');
FItems.Add('by &city');
FItems.Add('by &region');
FItems.Add('by &state');
FItems.Add('by countr&y');
FItems.Add('&Merge');
FItems.Add('by &number');
FItems.Add('by &title');
FItems.Add('&File');
FItems.Add('Conne&xion');
FItems.Add('&Create project');
FItems.Add('&Open project');
FItems.Add('&Import project');
FItems.Add('&TMG v. 4.0d');
FItems.Add('Delete project');
FItems.Add('&Language');
FItems.Add('&Quit');
FItems.Add('&Edit');
FItems.Add('Copy');
FItems.Add('Cut');
FItems.Add('Paste');
FItems.Add('Copy &name');
FItems.Add('Copy indi&vidual');
FItems.Add('Delete individual');
FItems.Add('&Father');
FItems.Add('&Mother');
FItems.Add('&Broter');
FItems.Add('&Sister');
FItems.Add('S&on');
FItems.Add('&Daughter');
FItems.Add('S&pouse');
FItems.Add('&Unrelated');
FItems.Add('B&irth');
FItems.Add('Bap&tism');
FItems.Add('D&eath');
FItems.Add('Buria&l');
FItems.Add('&Navigation');
FItems.Add('By &number');
FItems.Add('&Previous explorer element');
FItems.Add('Ne&xt explorer element');
FItems.Add('Complete &history');
FItems.Add('&Tools');
FItems.Add('&Sources');
FItems.Add('&Places');
FItems.Add('&Event Types');
FItems.Add('&Window');
FItems.Add('&Explorer');
FItems.Add('&Names and attributes');
FItems.Add('E&vents');
FItems.Add('&Parents');
FItems.Add('E&xhibits');
FItems.Add('&Children');
FItems.Add('&Siblings');
FItems.Add('&Image');
FItems.Add('&Ancestors');
FItems.Add('&Descendants');
FItems.Add('&Help');
FItems.Add('&About');
FItems.Add('Exhibits:');
FItems.Add('" and "');
FItems.Add('Do you want to unite "');
FItems.Add('There must be at least one witness.');
FItems.Add('&Parameters');
FItems.Add('&PDF');
FItems.Add('Select the location of the PDF viewer');
FItems.Add('Executables');
FItems.Add('Language translation table');
FItems.Add('The deleted person must not be a depot, author of a source, have principal child, parents nor events where another person is a principal witness.');
FItems.Add('Copie &event');
FItems.Add('Copie Pa&rent');
FItems.Add('Copie &Child');
FItems.Add('Adding a father to ');
FItems.Add('Adding a mother to ');
FItems.Add('Adding a brother to ');
FItems.Add('Adding a son to ');
FItems.Add('Adding a daughter to ');
FItems.Add('Selection of the other principal parent');
FItems.Add('None for now...');
FItems.Add('Adding a spouse to ');
FItems.Add('E');
FItems.Add('ENGLISH');
FItems.Add('&Export project');
FItems.Add('&Website');
FItems.Add('SITEMAP files creation (1/3)');
FItems.Add('Index creation (2/3)');
FItems.Add('Database transfer file creation (3/3)');
FItems.Add('Directory where to create HTML/PHP files');
FItems.Add('Enter the web site server name or address');
FItems.Add('Server name');
FItems.Add('Enter the website database name');
FItems.Add('Database name');
FItems.Add('Enter the website MySQL username');
FItems.Add('Username');
FItems.Add('Enter the username password');
FItems.Add('Password');
FItems.Add('Database compression');
FItems.Add('Repair Birth-Death');
FItems.Add('Adding a sister to ');
FItems.Add('Removal of orphan records');
FItems.Add('Repair names (for sorting)');
FItems.Add('Repair relation sort date');
end;

destructor TTranslation.Destroy;
begin
  freeandnil(Fitems);
end;

function TTranslation.GetItems(index: integer): String;
begin
  if (index>=0) and (index<Fitems.count) then
  result := Fitems[index];
end;

procedure TTranslation.LoadFromFile(aLanguage: string; out Success: boolean); overload;
begin
  Success:=false;
  if FileExists(aLanguage) then
    begin
      Fitems.LoadFromFile(aLanguage);
      Success:=true;
    end;
end;

procedure TTranslation.LoadFromFile(aLanguage: string);
var success:boolean;
begin
  LoadFromFile(aLanguage,Success);
end;


initialization
  Translation:=TTranslation.create;

finalization
  freeandnil(Translation);
end.
