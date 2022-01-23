unit Stage;

interface

uses Types;

{fonction qui permet transformer  un carcatère en un contenu
@param(lue le caracète lu)
@returns(le contenu correspondant au caractère lu)
}
function Char2Contenus( lue : char ) : contenus; 

{procédure qui va permettre de remplir un plateau de jeu de stage à partir d'un fichier texte contenant la carte du stage sous forme de caractères
@param(plateauJeuStage la plteau de jeu du stage que l'on veut remplir)
@param(fichierSTAGE la variable qui va contenir le fichier que l'on souhaite lire)
@param(nomFichier le nom du fichier que l'on souhaite lire
}
Procedure RemplirPlateauSTAGE(var plateauJeuStage:Plateau; var fichierSTAGE: Text; nomFichier : String);

{procédure qui permet d'intialiser le stage
@param(xtaille la taille du plateau sur l'axe horizontal)
@param(ytaille la taille du plateau sur l'axe vertical)
@param(vitesse la vitesse de déplacement du serpent sur le plateau de jeu)
@param(clignotement la variable booléenne pour savoir si le plateau doit clignoter lors de l'affichage)
@param(findepartieStage booléen permettant de savoir quand le stage doit se terminer)
@param(scoore le score)
@param(serpNiveauParallele le serpent qui va être utilisé pour jouer le stage)
}
procedure initStage(var xtaille,ytaille : Integer; var vitesse : Integer; var clignotement,findepartieStage : Boolean; var serpNiveauParallele : Serpent);

{procédure qui va permettre de gérer la fin du stage en cas de collision avec un mur ou un obstacle 
@param(objet l'objet rencontré par la tête du serpent)
@param(finpartieStage booléen permettant de savoir quand le stage doit se terminer)
}
procedure estMortStage(objet :Contenus; var finpartieStage : Boolean);

{procédure qui gère le déroulement du stage
@param(clignotement la variable booléenne pour savoir si le plateau doit clignoter lors de l'affichage)
@param(plateauJeuStage le plateau de jeu utilisé pour le stage)
@param(finpartieStage booléen permettant de savoir quand le stage doit se terminer)
@param(vitesse la vitesse de déplacement du serpent sur le plateau de jeu)
@param(serpNiveauParallele le serpent qui va être utilisé pour jouer le stage)
@param(xtaille la taille du plateau sur l'axe horizontal)
@param(ytaille la taille du plateau sur l'axe vertical)
@param(objetFinal le dernier objet rencontré par la tête du serpent afin de regarder si c'est un kiwi en or)
}
procedure jouerPartieStage(clingotement : Boolean; plateauJeuStage : Plateau; findepartieStage : Boolean; vitesse : Integer; serpNiveauParallele : Serpent; xtaille, ytaille : Integer; var scoore : Score; var objetFinal : Contenus);

{procedure qui permet de gérer la fin de partie dans le cas où le serpent parvient à atteindre le kiwi en or
@param(objetFinal le dernier objet rencontré par la tête du serpent afin de regarder si c'est un kiwi en or)
@param(scoore le score)
}
procedure traitementObjetFinal(var objetFinal : Contenus; var scoore : Score);

{fonction qui permet de tirer aléatoirement un nom de fichier parmi les 7 disponibles
@retunrs(nomFichier le nom du fichier choisi aléatoirement)}
function choixFichierStage() : string;


{procedure qui gère le mécanisme de jeu du stage
@param(xtaille la taille du plateau sur l'axe horizontal)
@param(ytaille la taille du plateau sur l'axe vertical)
@param(vitesse la vitesse de déplacement du serpent sur le plateau de jeu)
@param(clignotement la variable booléenne pour savoir si le plateau doit clignoter lors de l'affichage)
@param(findepartieStage booléen permettant de savoir quand le stage doit se terminer)
@param(scoore le score)
@param(serpNiveauParallele le serpent qui va être utilisé pour jouer le stage)
}
procedure jouerStage(xtaille,ytaille : Integer; vitesse : Integer; clignotement,findepartieStage : Boolean; var scoore : Score; serpNiveauParallele : Serpent);


implementation

uses crt,Affichage,GestionScore,Initialisation,Deplacement,Jouer;

function Char2Contenus( lue : char ) : contenus; // transforme un caractère du tableau en contenue
begin 
	case lue of 
	'1' : Char2Contenus:= obstacle;
	'2' : Char2Contenus:= orange;
	'0' : Char2Contenus:= vide;
	'3' : Char2Contenus:= citron;
	'4' : Char2Contenus:=pomme;
	'5' : Char2Contenus:= mur;
	'6' : Char2Contenus:= goldkiwi;
	'7' : Char2Contenus:= coco;
	'8' : Char2Contenus:= weed;
	'9' : Char2Contenus:= piment;
	'A' : Char2Contenus:= myrtille;
	end;
end;

Procedure RemplirPlateauSTAGE(var plateauJeuStage:Plateau; var fichierSTAGE: Text; nomFichier : String); // remplie le plateau à partir du fichier texte
var lue: char;
	x,y: integer;
begin
	initPlateau(39,18,plateauJeuStage);
	assign(fichierSTAGE,nomFichier);
	reset(fichierSTAGE);

	For y:=1 to 18 do
		begin
		for x:=1 to 39 do
			begin
				read(fichierSTAGE,lue);
				plateauJeuStage[y,x]:=Char2Contenus(lue);
			end;
			x:=40;
			read(fichierSTAGE,lue);
			plateauJeuStage[y,x]:=Char2Contenus(lue);
		end;
		
	close(fichierSTAGE);
end;

procedure initStage(var xtaille,ytaille : Integer; var vitesse : Integer; var clignotement,findepartieStage : Boolean; var serpNiveauParallele : Serpent);

//Cette procédure permet d'initialiser les différents éléments dont on va avoir besoin pour le stage

begin
    vitesse := 300; //On ne permet pas à l'utilisateur de choisir sa vitesse pour le stage, on la fixe (elle sera la même quelque soit la vitesse choisit au début de la partie)
    findepartieStage := false; //On initialise le booléen de fin de stage à faux 
    clignotement := false; //Il n'y a pas besoin de faire clignoter le plateau du stage donc on met la variable du clignotement à faux
    xtaille := 39; //Le stage ne se joue que sur le grand plateau, on initialise donc les dimensions du plateau de stage avec les dimensions du grand plateau
    ytaille := 18; //Encore une fois, le stage se jouera en grand plateau et ce, quelque soit le choix de taille du plateau de l'utilisateur au début de la partie
    fixerTailleSerpent(1,serpNiveauParallele); //Lors du stage on utilise un nouveau serpent de taille 1, puisque le stage constitue uniquement un niveau technique
    fixerCoordonneesCorpsSerpent(3,16 ,1, serpNiveauParallele); //On fixe le serpent à l'endroit où on souhaite le faire démarrer 
    //Ici il faudra penser à faire une modification si on vatu faire plusieurs niveau de stage (écrire la position initiale du serpent dans le fichier et la récupérer ici ?)
end;

procedure estMortStage(objet :Contenus; var finpartieStage : Boolean);

//Cette procédure permet de gérer la fin du stage par la mort du serpent, autrement dit de gérer la fin du stage lorsque le serpent rencontre un obstacle ou un mur 

begin

If ((objet=mur) or (objet=obstacle)) then
begin
	ClrScr();
	finpartieStage:=true; //Ici c'est bien le booléen de fin de partie du stage que l'on passe à vrai et non pas le booléen de fin de partie (de la partie en cours)
	TextColor(Red);
	HighVideo;
	GotoXY(15,4);
	writeln('Vous n''avez pas réussi à atteindre le KIWI EN OR');
	GotoXY(15,5);
	writeln('Attention ! Retour à la partie imminent !');
	delay(3000);
end;
end;

procedure jouerPartieStage(clingotement : Boolean; plateauJeuStage : Plateau; findepartieStage : Boolean; vitesse : Integer; serpNiveauParallele : Serpent; xtaille, ytaille : Integer; var scoore : Score; var objetFinal : Contenus);

//Cette procédure ressemble fortement à jouerPartie mais on ne garde que les éléments qui nous intéresse pour jouer le stage

var clignotement : Boolean;
var objet : Contenus;
var toucheDirection : Char;
var dir : Direction;
var xtunnel1,ytunnel1,xtunnel2,ytunnel2 : Integer;
var mortSerp : Boolean;
var detec : Contenus;


begin 
	clignotement := False;
	dir := right;
	objet := vide;
	detec := vide;
	
	Repeat 
	begin
		affichaage(plateauJeuStage,scoore,serpNiveauParallele,xtaille,ytaille,clignotement);
		selectionTouche(toucheDirection,dir,detec);
		repeat
		begin
			deplacementSerpent(xtunnel1,ytunnel1,xtunnel2,ytunnel2,dir,plateauJeuStage,serpNiveauParallele,objet,mortSerp);
			clrscr();
			affichaage(plateauJeuStage,scoore,serpNiveauParallele,xtaille,ytaille,clignotement);
			estMortStage(objet,findepartieStage);
			if objet=goldkiwi then
				findepartieStage :=True;
			delay(vitesse);		
		end;
		until (keypressed() or (findepartieStage)); 
	end;
	until findepartieStage; //On arrête la boucle principale du jeu quand le serpent est mort ou lorsque le serpent a mangé le kiwi en or
	objetFinal := objet;
end;

procedure traitementObjetFinal(var objetFinal : Contenus; var scoore : Score);

//Cette procédure permet de traiter le dernier objet rencontré par le serpent lors du stage est un kiwi en or
//On fait aussi ici l'augmentation du score (avec le nombre de points correspondant au kiwi en or)

begin
	if objetFinal=goldkiwi then
	begin
		fixerPointScore(obtenirPointScore(scoore)+500,scoore);
		TextColor(LightCyan);
		GotoXY(15,4); //On prépare le retour à la partie avec quelques messages destinés à l'utilisateur
		writeln('Bravo ! Vous avez réussi ce stage !');
		GotoXY(15,5);
		writeln('Attention ! Retour à la partie imminent !');
		delay(3000);
		clrscr();
	end;	
end;

function choixFichierStage() : string;

var temp : Integer;

begin
	temp:= random(8)+1;
	case temp of 
		1 : choixFichierStage := 'fichierSTAGE1.txt';
		2 : choixFichierStage := 'fichierSTAGETim.txt';
		3 : choixFichierStage := 'fichierSTAGEAlexD.txt';
		4 : choixFichierStage := 'fichierSTAGEAlexO.txt';
		5 : choixFichierStage := 'fichierSTAGEYassine.txt';
		6 : choixFichierStage := 'fichierSTAGETitouan.txt';
		7 : choixFichierStage := 'fichierSTAGETom.txt';
	end;
end;

procedure jouerStage(xtaille,ytaille : Integer; vitesse : Integer; clignotement,findepartieStage : Boolean; var scoore : Score; serpNiveauParallele : Serpent);

//ici c'est la procédure principale du stage

var fichierSTAGE: Text;
var plateauJeuStage : Plateau;
var objetFinal : Contenus;
var nomFichier : String;

BEGIN	
	nomFichier := choixFichierStage;
    RemplirPlateauSTAGE(plateauJeuStage, fichierSTAGE,nomFichier);//on charge le plateau de jeu du stage à partir du fichier correspondant
	affichaage(plateauJeuStage,scoore,serpNiveauParallele,xtaille,ytaille,clignotement); //On affichage le plateau du stage avant de lancer le stage en lui même 
	jouerPartieStage(clignotement,plateauJeuStage,findepartieStage,vitesse,serpNiveauParallele,xtaille,ytaille,scoore,objetFinal); // On joue le stage
	clrscr();
	traitementObjetFinal(objetFinal,scoore); // Enfin on traite le dernier objet rencontré par le serpent
END;

end.
