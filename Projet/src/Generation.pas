unit Generation;

Interface


uses Types, Deplacement;


{fonction qui génère un fruit parmis la pomme l'orange et le citron, chaque fruit possède une certaine probabilité d'apparition 
@returns(Contenus informe de la nature de l'objet)
}
function randomFruit ():Contenus;

{procédure qui permet de rechercher un objet sur le plateau, savoir s'il est présent sur le plateau, et s'il est présent, connaître ses coordonnées.
@param(tab correspond au plateau)
@param(xtaille taille en x du plateau)
@param(ytaille taille en y du plateau)
@param(objet correspond à l'objet dont on veut connaître la présence et les coordonnées sur le plateau)
@param(Xobjet coordonnée x de l'objet recherché)
@param(Yobjet coordonnée y de l'objet recherché)
@param(ObjetPresent variable booléenne qui stocke si l'objet recherché est présent ou pas sur le plateau de jeu)
}
procedure RechercherObjet (var tab : plateau; xtaille, ytaille: integer ;objet : Contenus;var Xobjet, Yobjet: integer; var ObjetPresent:boolean);

{fonction qui contrôle si les coordonnées font partis du plateau
@param(x coordonnée)
@param(y coordonnée)
@param(xtaille taille en x du plateau)
@param(ytaille taille en y du plateau)
@returns(le booléen permettant de savoir si les coordonnées sont dans le plateau)
}
function DansPlateau (x,y, xtaille ,ytaille :integer):boolean; 

{fonction qui génère un naturel entre -2 et +2
@returns(le naturel qui servira de distance)
}
function randomDistance ():integer;

{fonction qui vérifie que le serpent n'occupe pas les coordonnées fournis en entrée 
@param(x coordonnée)
@param(y coordonnée)
@param(serp le serpent)
@returns(le booléen permettant de savoir si le serpent est sur ces coordonnées ou non)
}
function NoSerpent (x, y :integer; serp: Serpent):boolean;

{fonction qui vérifie que la tete du serpent n'est pas proche des coordonnées fournis en entrée 
@param(x coordonnée)
@param(y coordonnée)
@param(serp le serpent)
@returns(le booléen permettant de savoir si le serpent est sur ces coordonnées ou non)
}
function NoTeteSerpent (x,y :integer; serp:Serpent): boolean;

{procédure qui génère un fruit et le place sur le plateau en vérifiant que l'espace est bien vide
@param(tab correspond au plateau)
@param(xtaille taille en x du plateau)
@param(ytaille taille en y du plateau)
@param(serp le serpent)
}
procedure genererFruit (var tab:Plateau; xtaille,ytaille: integer; serp:Serpent);
{procédure qui génère un obstacle et le place sur le plateau en vérifiant que l'espace est bien vide
@param(xtaille taille en x du plateau)
@param(ytaille taille en y du plateau)
@param(serp le serpent)
@param(tab correspond au plateau)
}
procedure genererObstacle ( xtaille, ytaille : integer; serp:Serpent ;var tab : Plateau);

{procédure qui génère les deux portes du tunnel et les place sur une partie distincte du plateau en vérifiant que l'espace est bien vide
@param(xtaille taille en x du plateau)
@param(ytaille taille en y du plateau)
@param(serp le serpent)
@param(tab correspond au plateau)
@param(xtunnel1 coordonnée en x de la porte 1)
@param(ytunnel1 coordonnée en y de la porte 1)
@param(xtunnel2 coordonnée en x de la porte 2)
@param(ytunnel2 coordonnée en y de la porte 2)
}
procedure genererTunnel ( xtaille, ytaille : integer; serp:Serpent; var tab : Plateau; var xtunnel1, ytunnel1, xtunnel2,ytunnel2:integer);


IMPLEMENTATION

////Génère aléatoirement une coordonnée entre 2 et xtaille-1 (=ytaille-1)
{la fonction randomcoor ne fait pas partie de l'espace public de l'unité}
function randomcoorX (xtaille : integer):integer; 
begin
	randomcoorX:=1+random(xtaille-2);   
end;

function randomcoorY (ytaille : integer):integer; 
begin
	randomcoorY:=1+random(ytaille-2);   
end;


function randomFruit ():Contenus; ////Pioche un fruit avec proba différentes
var randomint :integer;
begin
	randomint:=1+random(105); //prend une valeur entre 1 et 105 inclus
	case randomint of            
		1..21 :randomFruit:=pomme;   	//proba= 22%
		22..33:randomFruit:=orange; 	//proba= 11%
		34..47:randomFruit:=citron;		//proba= 13%
		48..61:randomFruit:=coco;		//proba= 13%
		62..76:randomFruit:=weed; 		//proba= 14%
		77..92:randomFruit:=piment;		//proba= 15%
		93..98:randomFruit:=myrtille;	//proba= 5%
		99..105:randomFruit:=kiwi;		//proba= 7%
	end;
end;



procedure RechercherObjet (var tab : plateau; xtaille, ytaille: integer ;objet : Contenus;var Xobjet, Yobjet: integer; var ObjetPresent:boolean);
var i, j :integer;
begin
		ObjetPresent:=FALSE;
		for i:= 2 to ytaille-1 do
			begin
				for j:= 2 to xtaille-1 do //Ajout d'un begin end; dans cette boucle for
				begin
					if (quelObjet(j,i,tab)=objet) then //si les coordonnées correspondent à l'objet choisis alors 
					begin									//on enregistre ces coordonnées et le boolean passe VRAI
						Yobjet:=i;
						Xobjet:=j;
						ObjetPresent:=TRUE;
					end;
				end;
			end;
end;

function DansPlateau (x,y, xtaille ,ytaille :integer):boolean; 
begin
	DansPlateau:= ((x>1) and (x<xtaille-1)) and ((y>1) and (y<ytaille-1));
end;


function randomDistance ():integer;
var temp: integer;
begin
	repeat
		temp:=random(3)-random(3);
	until temp<>0;
	randomDistance:=temp;
end;


function NoSerpent (x, y :integer; serp: Serpent):boolean;
//Cette fonction permet de savoir si un couple de coordonnées est au même endroit qu'un morceau du seprent
var NoSerpentTemp :boolean;
var i: integer;
begin
	NoSerpentTemp:=TRUE;
	for i:=1 to obtenirTailleSerpent(serp) do
	begin
		if (x=obtenirCoordonneeX(obtenirCoordonneesCorpsSerpent(serp,i))) and (y=obtenirCoordonneeY(obtenirCoordonneesCorpsSerpent(serp,i))) then
			NoSerpentTemp:=FALSE;
	end;
	NoSerpent:=NoSerpentTemp;
end;

//On compare les coordonnées où l'on veut générer quelque chose avec les coordonnées proches de la tête du serpent
function NoTeteSerpent (x,y :integer; serp:Serpent): boolean;
var xSerp,ySerp:integer;
begin
xSerp:=obtenirCoordonneeX(obtenirCoordonneesCorpsSerpent(serp,1));
ySerp:=obtenirCoordonneeY(obtenirCoordonneesCorpsSerpent(serp,1));

NoTeteSerpent:=TRUE;
if ((x=xSerp+1) or (x=xSerp-1) or (x=xSerp+2) or (x=xSerp-2) or (y=ySerp+1) or (y=ySerp-1) or (y=ySerp+2) or (y=ySerp-2)) then 
	NoTeteSerpent:=FALSE;
end;


procedure genererFruit (var tab:Plateau; xtaille,ytaille: integer; serp:Serpent);////génère un type de fruit et le place sur le plateau
var xr,yr :integer;
begin 
	repeat 
	begin
		xr:=randomcoorX(xtaille); 
		yr:=randomcoorY(ytaille);
	end; 	
	until (quelObjet(xr,yr,tab)=vide) and NoSerpent(xr,yr,serp);//Remarque: Même après un randomize() les valeurs tirées sont les mêmes					
																//Pour éviter cela j'utilise la condition (xr<>yr)
	tab[yr,xr]:=randomFruit();
	
end;

procedure genererObstacle ( xtaille, ytaille : integer; serp:Serpent; var tab : Plateau);
var xo,yo,xfruit,yfruit : integer ;
var fruitPresent:Boolean;
begin
	RechercherObjet(tab,xtaille, ytaille, orange, xfruit, yfruit, fruitPresent); //On recherche un fruit sur le plateau pour ensuite générer un obstacle proche de ce fruit
	repeat 
	begin														
		if fruitPresent then				//si le fruit est present on place un obstacle proche du fruit
		begin
			xo:=xfruit+randomDistance();
			yo:=yfruit+randomDistance();
		end
		else								//sinon on place un obstacle alétoirement sur le plateau
		begin			
			xo:=randomcoorX(xtaille);
			yo:=randomcoorY(ytaille);
		end;
		
	end;
	until ((quelObjet(xo,yo,tab)=vide) and DansPlateau(xo,yo,xtaille,ytaille) and (NoSerpent(xo,yo,serp))) and (NoTeteSerpent(xo,yo,serp));
	
	tab[yo,xo]:=obstacle;
	

end; 




//on coupe le plateau en 4
//	1-xtaille/2  		1-ytaille/2
//	xtaille/2-xtaille   1-ytaille/2
//	xtaille/2-xtaille 	ytaille/2-ytaille
//	1-xtaille/2			ytaille/2-ytaille


//On génére tunnel1 et tunnel2 aléatoirement dans deux "parties distinctes" du Plateau
procedure genererTunnel ( xtaille, ytaille : integer; serp:Serpent; var tab : Plateau; var xtunnel1, ytunnel1, xtunnel2,ytunnel2:integer);
var xt1, yt1,xt2,yt2, choix1, choix2 :integer;
begin
	
	choix1:=random(4);
	
	repeat
		//4 parties différentes = plateau coupé en 4
		case choix1 of 
		0:begin
			xt1:=randomcoorX(xtaille div 2 );
			yt1:=randomcoorY(ytaille div 2);
		  end;
		  
		1:begin
			xt1:=(xtaille div 2)+randomcoorX(xtaille div 2);
			yt1:=randomcoorY(ytaille div 2);
		  end;
		  
		2:begin
			xt1:=(xtaille div 2)+ randomcoorX(xtaille div 2);
			yt1:=(ytaille div 2) +randomcoorY(ytaille div 2);
		  end;
		
		3:begin
			xt1:=randomcoorX(xtaille div 2);
			yt1:=(ytaille div 2) + randomcoorY(ytaille div 2);
		  end;
		end;		
	until (quelObjet(xt1,yt1,tab)=vide) and NoSerpent(xt1,yt1,serp);
    
    //On choisit une partie différente de l'ancienne 
    repeat
		choix2:=random(4);
    until choix2<>choix1;
    
    repeat
		case choix2 of 
		0:begin
			xt2:=randomcoorX(xtaille div 2 );
			yt2:=randomcoorY(ytaille div 2);
		  end;
		  
		1:begin
			xt2:=(xtaille div 2)+randomcoorX(xtaille div 2);
			yt2:=randomcoorY(ytaille div 2);
		  end;
		  
		2:begin
			xt2:=(xtaille div 2)+ randomcoorX(xtaille div 2);
			yt2:=(ytaille div 2) +randomcoorY(ytaille div 2);
		  end;
		
		3:begin
			xt2:=randomcoorX(xtaille div 2);
			yt2:=(ytaille div 2) + randomcoorY(ytaille div 2);
		  end;
		end;	
	until (quelObjet(xt2,yt2,tab)=vide) and NoSerpent(xt2,yt2,serp);
    
    xtunnel1:=xt1;
	ytunnel1:=yt1;
    tab[ytunnel1,xtunnel1]:=tunnel1;
    
    xtunnel2:=xt2;
	ytunnel2:=yt2;
    tab[ytunnel2,xtunnel2]:=tunnel2;

end;


END.
