unit LesMenus;


interface

uses Affichage, Types,crt,sysutils, GestionScore;
 
Const 
  { Place la barre de menu selon l'axe X et Y }
  MenuXofs = 10;
  MenuYofs = 2;
  {Couleur de premier et dernier plan}
  SelectedFC = White;
  { couleur de texte pour objet sélectionné }
  SelectedBC = LightCyan;
  { couleur de fond pour objet sélectionné}
  NormalFC = LightGray;
  { couleur de premier plan pour objet non sélectionné }
  NormalBC = Black;
  { fond de l'écran pour l'objet non sélectionné}
  SelectorLargeur = 50;
  {largeur barre de sélection }
 
 { ASCII code  }
  UpKey = #80;
  DownKey = #72;
  EscKey = #27;
  CRKey = #13;

Type TMainMenu = object	
		{Ce type objet: est utilisé pour construire des types de données complexes qui contiennent à la fois des fonctions, 
		des procédures et des données. L'objet permet à l'utilisateur d'effectuer une programmation orientée objet je me suis 
		servi de ce type pour construire un Menu visuel}	
			private
				Selectionner : integer;	{un entier qui renvoit l'indice de MenuItem selectionné}			
				MenuItems : array[0..3] of string;	{Tableau contenant les differents Propositions de Menu}	
		
			public
				constructor Create(); 
				{constructor: mot réservé appartenant à la programmation orientée objet. Le constructeur est une méthode 
				 de création de classe qui crée ici notre menu.}
				procedure AfficherMenu(); {var de type procédure}
						
				procedure CurHaut(); {Curseur Haut} 
				procedure CurBas();  {Curseur Bas}
				
				function GetSelectionner(): integer; {fonction GetSelectionner qui Renvoit à la fin 'Selectionner'}
		end;

Function Selection() : Char;

Procedure AfficheSousMenu(Curseur : Integer; MenuItem: TableauMenu; TotalItems : Integer);

Function Navigation(Selection : Char; Cur : Integer; TotalItems : Integer) : Integer;

{procedure qui permet d'afficher le sous menu pour la sélection de la vitesse du serpent
@param(choixVitesse entier correspondant au numéro du choix de l'utilisateur)
}
procedure MenuVitesse (var choixVitesse:integer);

{procedure qui permet d'afficher le sous menu pour la sélection de la taille du plateau
@param(choixTaille entier correspondant au numéro du choix de l'utilisateur)
}
procedure MenuTaille (var choixTaille : integer);

implementation

constructor TMainMenu.Create();

	begin
		MenuItems[0] := '1. Lancer une Partie ';
		MenuItems[1] := '2. Regles du Jeu';
		MenuItems[2] := '3. Meilleurs Scores';
		MenuItems[3] := '4. Quitter';
		Selectionner := 0; {Initialisation du Selectionner}
	end;

	procedure TMainMenu.AfficherMenu(); 
	var
		i : integer;
	begin		
		TextBackground(0);
		ClrScr;
		
		TextColor(7);
		GoToXY(34, 3);
		TextColor(LightRed);
		Writeln('AATTTY Snake');
		TextColor(7);
		GoToXY(22, 5);
		Writeln('*************************************');
		GoToXY(13, 7);
		TextColor(7);
		Write('By Alexandre O, Alexandre D, Titouan, Timothe, Tom, Yassine');
		GoToXY(23, 9);
		TextColor(7);
		Writeln('Domptez le serpent qui est en Vous !'); 
		GoToXY(33, 20);
		TextColor(7);
		Writeln();

		for i := 0 to 3 do
			begin
				GoToXY(30, 11 + i);
				 if Selectionner = i then 
					begin					
						TextColor(white);       
						TextBackground(Cyan);	{Colorer la ligne de Menu selectionnée(cyan:bleu ciel}											
					end
				else
					begin
						TextColor(white);
						Textbackground(black); {le reste n'est pas coloré (black)}
					end;	
				Writeln(MenuItems[i]);	
			end;	
	end;

	procedure TMainMenu.CurHaut();
	begin
		if Selectionner > 0 then Dec(Selectionner); {Lorsque 'Selectionner>0', càd notre curseur est dans la 2èmè ou 3èmè ligne
		 et qu'on veut se déplacer en haut  Selectionner reçoit sa valeur -1 et donc on fait une Decrementation de (1)}
	end;
	
	procedure TMainMenu.CurBas();
	begin
		if Selectionner < 3 then Inc(Selectionner){Lorsque 'Selectionner<3', càd notre curseur est dans la 1ere ou 2èmè ligne
		 et qu'on veut se déplacer en bas  Selectionner reçoit sa valeur +1 et donc on fait une incrementation de (1)};
	end;
	
	function TMainMenu.GetSelectionner(): integer;  
	begin
		GetSelectionner := Selectionner; {GetSelectionner  Renvoit à la fin la var Selectionner}
	end;

Function Selection(): Char;
{ Cette fonction permet de lire seulement les touches demandées sans prendre les autres en considération}

Var
  Key : Char;
Begin
  Repeat
    Key := ReadKey;
  Until Key in [UpKey,DownKey,EscKey,CRKey];
  Selection := Key;
End;



Procedure AfficheSousMenu(Curseur : Integer; MenuItem: TableauMenu; TotalItems : Integer);
{ Cette procedure permet d'afficher le menu en fonction de la position du curseur. Lorsque l'utilisateur appuie sur une touche la position change et donc le menu s'affiche de nouveau  }

Var
  Item     : Integer;
  i          : Integer;
  FC, BC          : Byte;
  TexteMenu : String;
  TailleMenu : Integer;
Begin
  For Item := 1 to TotalItems do
    Begin
      TexteMenu := MenuItem[Item];
      TailleMenu := Length(TexteMenu);
      
      {attribue les couleurs en fonction de la position du curseur}
      if Item = Curseur then
        Begin
          FC := SelectedFC;
          BC := SelectedBC;
        End
      Else
        Begin
          FC := NormalFC;
          BC := NormalBC;
        End;
        
      TextColor(FC);
      TextBackground(BC);
      GotoXY(MenuXofs+1,MenuYofs+Item);
      Write(TexteMenu);
      
      {permet que les deux cases soit de même longueur}
      For i := 1 to (SelectorLargeur-TailleMenu) do
        Write(#32);
    End;
End;


Function Navigation(Selection : Char; Cur : Integer; TotalItems : Integer) : Integer;
{  Cette fonction sort le l'item sélectionné qu'on utilise pour l'affichage de menu }
	
Var
  Curseur : Integer;
Begin
  Curseur := Cur;
  If Selection = UpKey then
    Inc(Curseur);           {ajoute 1}
  If Selection = DownKey then
    Dec(Curseur);           {retire 1}
  
  {s'il depasse le tableau il revient au début ou à la fin}
  If Curseur > TotalItems then   
    Curseur := 1;
  If Curseur < 1 then              
    Curseur := TotalItems;
    
  Navigation := Curseur;
End;



procedure MenuVitesse(var choixVitesse:integer);

var 
  Key : Char;
  MenuPos : Integer;
  MenuItem : TableauMenu; 
 
BEGIN
	MenuItem[1]:='Facile';
	MenuItem[2]:='Moyen';
	MenuItem[3]:='Difficile';
	MenuItem[4]:='Progressive';
	MenuPos := 1;
	Repeat
		Repeat
			AfficheSousMenu(MenuPos, MenuItem,4);
			Key := Selection;
			MenuPos := Navigation(Key, MenuPos,4);
		Until Key in [CRKey,EscKey];
		
		
		If MenuPos = 1 then
		begin
			choixVitesse:=1;
			clrscr();
		end;

		If MenuPos = 2 then
		begin
			choixVitesse:=2;
			clrscr();
		end;

		If MenuPos= 3  then
		begin
			choixVitesse:=3;
			clrscr();
		end;

		If MenuPos= 4  then
		begin
			choixVitesse:=4;
			clrscr();
		end;
	
	Until choixVitesse<>0;
	TextColor(NormalFC);
	TextBackground(NormalBC);
	ClrScr;
end;



procedure MenuTaille(var choixTaille : integer);

var
  Key : Char;
  MenuPos : Integer;
  MenuItem : TableauMenu; 
BEGIN
	MenuItem[1]:='Petit';
	MenuItem[2]:='Moyen';
	MenuItem[3]:='Grand';
	MenuPos := 1;
	Repeat
		Repeat
			AfficheSousMenu(MenuPos, MenuItem,3);
			Key := Selection;
			MenuPos := Navigation(Key, MenuPos,3);
		Until Key in [CRKey,EscKey];
		
		
		If MenuPos = 1 then
		begin
			choixTaille:=1;
			clrscr();
		end;

		If MenuPos = 2 then
		begin
			choixTaille:=2;
			clrscr();
		end;

		If MenuPos= 3  then
		begin
			choixTaille:=3;
			clrscr();
		end;

			   
	Until choixTaille<>0;
	TextColor(NormalFC);
	TextBackground(NormalBC);
	ClrScr;
end;
	
END.

