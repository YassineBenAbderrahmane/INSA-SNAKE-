Unit Types;

Interface

CONST XMAX = 50;
CONST YMAX = 50;
CONST MAXTAILLE = 100;
CONST MAXITEMS = 4;
CONST UpKey=#122;
CONST DownKey=#115;
CONST RightKey=#100;
Const LeftKey=#113;

Type Contenus = (pomme,orange,citron,piment,weed,coco,myrtille,kiwi,goldkiwi,mur,vide,obstacle,tunnel1,tunnel2);

Type Plateau = Array [1..XMAX,1..YMAX] of Contenus;


Type Position = record
	x: Integer;
	y: Integer;
end;

Type Serpent = record
	corps: Array [1..MAXTAILLE] of Position;
	tailleSerpent: Integer;
end;

Type Direction = (up,down,right,left);

Type Score = record
	Points : QWord;
	Nom : string;
end;

Type TableauDeScore = array[1..10] of Score;

Type TableauMenu = Array [1..MAXITEMS] of String;	

//Accesseurs Type Position

{fonction qui permet d'accéder à la coordonnée x d'une variable de type Position
@param(coordonnees variable de type Positon contenant une coordonnée x et une coordonnée y)
@returns(l'entier correspondant à la coordonnée x de la variable de type Position)
}
function obtenirCoordonneeX(coordonnees : Position): Integer;

{fonction qui permet d'accéder à la coordonnée y d'une variable de type Position
@param(coordonnees variable de type Positon contenant une coordonnée x et une coordonnée y)
@returns(l'entier correspondant à la coordonnée y de la variable de type Position)
}
function obtenirCoordonneeY(coordonnees :  Position): Integer;

{procédure qui permet de fixer la coordonnée x d'une variable coordonnées de type Position
@param(x l'entier correspondant à ce que l'on veut fixer)
@param(coordonnees variable de type Positon contenant une coordonnée x et une coordonnée y)
}
procedure fixerCoordonneeX(x : Integer; var coordonnees : Position);

{procédure qui permet de fixer la coordonnée y d'une variable coordonnées de type Position
@param(y l'entier correspondant à ce que l'on veut fixer)
@param(coordonnees variable de type Positon contenant une coordonnée x et une coordonnée y)
}
procedure fixerCoordonneeY(y : Integer;var coordonnees : Position);

//Accesseurs Type Serpent

{fonction qui permet d'obtenir la taille du serpent passé en entrée
@param(serp le serpent)
@returns(l'entier correspondant à la taille du serpent passé en entrée)
}
function obtenirTailleSerpent(serp : Serpent): Integer;

{fonction qui permet d'obtenir une variable de type Position contenant les coordonnées du morceau du serpent correspondant à l'indice demandé
@param(serp le serpent)
@param(indice le numéro du morceau du serpent correspondant à l'indice de la case du tableau contenant les coordonnées des morceaux du serpent)
@returns(les coordonnées de type Position contenant une coordonnée x et une coordonnée y)
}
function obtenirCoordonneesCorpsSerpent(serp : Serpent; indice : Integer): Position;

{procédure qui permet de fixer la taille du serpent
@param(tailleserp la taille que l'on souhaite donner au serpent)
@param(serp le serpent)
}
procedure fixerTailleSerpent(tailleserp : Integer; var serp : Serpent);

{procédure qui permet de fixer les coordonées x et y d'un morceau du serpent
@param(coordonneesCorpsX la coordonnée x que l'on souhaite donner au morceau)
@param(coordonneesCorpsY la coordonnée y que l'on souhaite donner au morceau)
@param(indice le numéro du morceau du serpent correspondant à l'indice de la case du tableau contenant les coordonnées des morceaux du serpent)
@param(serp le serpent)
}
procedure fixerCoordonneesCorpsSerpent(coordonneesCorpsX,coordonneesCorpsY : Integer; indice : Integer; var serp : Serpent);

//Accesseurs Type Score

{procédure qui permet de fixer les points du score
@param(point le nombre de points que l'on souhaite donner au score)
@param(Ajout la variable de type score sur laquelle on veut modifier le nombre de points)
}
procedure fixerPointScore(point : Integer; var Ajout : Score);

{procédure qui permet de fixer le nom de joueur à une variable de type score
@param(name le nom que l'on souhaite donner)
@param(Ajout la variable de type score sur laquelle on veut modifier le nom)
}
procedure fixerNomScore(name : String; var Ajout : Score);

{fonction qui permet d'obtenir le nombre de point d'une variable de type score 
@param(Ajout la variable de type score dont on veut connaître le nombre de points associé)
@returns(le nombre de points)
}
function obtenirPointScore(Ajout: Score): integer;

{fonction qui permet d'obtenir le nom associé à une variable de type score 
@param(Ajout la variable de type score dont on veut connaître le nom associé à cette variable)
@returns(le nom)
}
function obtenirNomScore(Ajout:Score):String;

Implementation 

//Accesseurs Type Position

function obtenirCoordonneeX(coordonnees : Position): Integer;

begin
	obtenirCoordonneeX := coordonnees.x;
end;

function obtenirCoordonneeY(coordonnees :  Position): Integer;

begin
	obtenirCoordonneeY := coordonnees.y;
end;

procedure fixerCoordonneeX(x : Integer; var coordonnees : Position);

begin
	coordonnees.x := x;
end;

procedure fixerCoordonneeY(y : Integer;var coordonnees : Position);

begin
	coordonnees.y := y;
end;

//Accesseurs Type Serpent

function obtenirTailleSerpent(serp : Serpent): Integer;

begin 
	obtenirTailleSerpent := serp.tailleSerpent;
end;

function obtenirCoordonneesCorpsSerpent(serp : Serpent; indice : Integer): Position;

begin
	obtenirCoordonneesCorpsSerpent := serp.corps[indice];
end;

procedure fixerTailleSerpent(tailleserp : Integer; var serp : Serpent);

begin
	serp.tailleSerpent := tailleserp;
end;

procedure fixerCoordonneesCorpsSerpent(coordonneesCorpsX,coordonneesCorpsY : Integer; indice : Integer; var serp : Serpent);

begin
	fixerCoordonneeX(coordonneesCorpsX,serp.corps[indice]);
	fixerCoordonneeY(coordonneesCorpsY,serp.corps[indice]);
end;

//Accesseurs Type Score

procedure fixerPointScore(point : Integer; var Ajout : Score);	
begin
	Ajout.Points:= point;
end;

procedure fixerNomScore(name : String; var Ajout : Score);
begin
	Ajout.Nom:= name;
end;

function obtenirPointScore(Ajout: Score): integer;
begin
	obtenirPointScore:= Ajout.Points;
end;

function obtenirNomScore(Ajout:Score):String;
begin
	obtenirNomScore:= Ajout.Nom;
end;

end.

