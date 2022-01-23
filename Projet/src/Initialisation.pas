Unit Initialisation;

Interface

Uses Types,crt,LesMenus;

{procédure qui permet d'initialiser le score de la partie à 0 et de donner un Nom au joueur
@param(score le score qui sera actualisé à chaque fois que le joueur mange un fruit)
}
procedure initScore(var scoore : Score);

{procédure qui permet d'initialiser le serpent en intialisant la taille de son corps à 1 et en positionnant le premier morceau du corps au centre du plateau de jeu. 
@param(xtaille la taille du plateau sur l'axe horizontal)
@param(ytaille la taille du plateau sur l'axe vertical)
@param(serp le serpent)
}
procedure initSerpent(xtaille, ytaille : Integer;var serp:Serpent);

{procédure qui permet d'initialiser la taille du plateau de jeu en demandant à l'utilisateur de choisir entre 3 niveaux.
@param(xtaille la taille du plateau sur l'axe horizontal)
@param(ytaille la taille du plateau sur l'axe vertical)
}
procedure initTaillePlateau(var xtaille, ytaille : Integer);

{procédure qui permet d'initialiser la vitesse de déplacement du serpent.
@param(vitesse la vitesse de déplacement du serpent sur le plateau de jeu qui correspond en fait au nombre de millisecondes entre chaque affichage des éléments)
@param(vitesseEvo booléen qui permet de savoir si le mode progressif a été selectionné par le joueur ou non)
}
procedure initDifficulteVitesse (var vitesse : Integer; var vitesseEvo: Boolean);

{procédure permettant d'initialiser la plateau de jeu en intialisant toutes les cases à vide. 
@param(xtaille la taille du plateau sur l'axe horizontal)
@param(ytaille la taille du plateau sur l'axe vertical)
@param(plateauJeu le plateau)
}
procedure initPlateau(xtaille,ytaille : Integer; var plateauJeu : Plateau);

{procédure qui permet d'initialiser la partie en réalisant successivement les différentes initialisations nécessaires au lancement d'une partie
@param(vitesse la vitesse de déplacement du serpent sur le plateau de jeu)
@param(score le score qui sera actualisé à chaque fois que le joueur mange un fruit)
@param(serp le serpent)
@param(xtaille la taille du plateau sur l'axe horizontal)
@param(ytaille la taille du plateau sur l'axe vertical)
@param(findepartie variable booléenne qui permet de savoir si la partie est terminée ou pas)
@param(plateauJeu le plateau de jeu)
@param(clignotement variable booléenne qui permet de savoir si on doit faire clignoter les éléments à l'affichage)
}
procedure initPartie(var vitesse : Integer;var vitesseEvo:Boolean; var scoore : Score; var serp: Serpent; var xtaille,ytaille: Integer; var findepartie : Boolean; var plateauJeu : Plateau;var clignotement : Boolean);

Implementation

procedure initScore(var scoore : Score); // Initialisation des points et du nom //
var nomJoueur: String;
begin
	repeat
	writeln('Donner votre Nom');
	readln(nomJoueur);
	until (nomJoueur)<>'';
	fixerNomScore(nomJoueur, scoore);
	fixerPointScore(0, scoore);
end;

procedure initTaillePlateau(var xtaille, ytaille : Integer);
var choixTaille:integer;
begin
	writeln('Choisissez votre taille de plateau : '); 
	writeln();
	choixTaille := 0;
	MenuTaille(choixTaille);
	case choixTaille of

            1:  
				begin
                xtaille:=23;
                ytaille:=12;
                end;

            2:  
				begin
                xtaille:=30;
                ytaille:=15;
                end;
            3:	
				begin
                xtaille:=39;
                ytaille:=18;
                end;

        end;
end;

procedure initSerpent(xtaille, ytaille : Integer; var serp : Serpent);

var i : Integer;

begin
for i:= 1 to MAXTAILLE do
	fixerCoordonneesCorpsSerpent(0,0,i,serp);
fixerTailleSerpent(1,serp);
fixerCoordonneesCorpsSerpent((xtaille div 2),(ytaille div 2),1, serp);	
end;



procedure initDifficulteVitesse (var vitesse : Integer; var vitesseEvo: Boolean);
var choixVitesse:integer;
begin
	writeln('Choisissez une difficulté  : ');  
	writeln();
	choixVitesse :=0;
	MenuVitesse(choixVitesse);
	case choixVitesse of
            1:    
				begin
                vitesse:=300;
                end;

            2:     
				begin
                vitesse:=200;
                end;

            3:  
				begin
                vitesse:=100;
                end;
               
            4:
				begin
				vitesse:=299;
				vitesseEvo:=True;	
				end;
        end;
		
end;

procedure initPlateau(xtaille,ytaille : Integer; var plateauJeu : Plateau);

var i,j : Integer;

begin
	for i:=1 to YMAX do
	begin
		for j:= 1 to XMAX do
		begin
			plateauJeu[i][j] := vide;
		end;
	end;

	for j:= 1 to xtaille do
	begin
		plateauJeu[1][j] := mur;
		plateauJeu[ytaille][j] := mur;
	end;

	for i := 1 to ytaille do
	begin
		plateauJeu[i][1] := mur;
		plateauJeu[i][xtaille] := mur;
	end;
	
	plateauJeu[(ytaille div 2)][(xtaille div 2) + 6] := pomme;
end;

procedure initPartie(var vitesse : Integer;var vitesseEvo:Boolean; var scoore : Score; var serp: Serpent; var xtaille,ytaille: Integer; var findepartie : Boolean; var plateauJeu : Plateau;var clignotement : Boolean);

begin 
	vitesseEvo:=False;
	findepartie := False;
	clignotement := False;
	initScore(scoore);
	clrscr();
	NormVideo;
	initDifficulteVitesse(vitesse,vitesseEvo);
	clrscr();
	NormVideo;
	initTaillePlateau(xtaille,ytaille); 
	clrscr();
	initSerpent(xtaille,ytaille,serp);
	initPlateau(xtaille,ytaille,plateauJeu);
end;
end.
