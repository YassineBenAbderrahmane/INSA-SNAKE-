Unit Deplacement;

Interface 

Uses Types;

{fonction déterminant la direction pour laquelle le serpent de se retourne sur lui-même
  @param(dir est la direction actuelle du serpent)
  @returns(Direction donne la direction )
}
function sensInterdit(dir : Direction) : Direction;

{procedure qui permet de faire avancer le corps de manière à ce qu'il suive la tête
  @param(coordtete les coordoonées de la tête du serpent au moment où on va effectuer le deplacement du corps)
  @param(serp le serpent)
}
Procedure avancerCorps(coordtete : Position; var serp:Serpent);

{procédure permettant de faire avancer le serpent selon la direction entrée et les coordonnées du serpent
  @param(xtunnel1 la coordonnée x de la première partie du tunnel)
  @param(ytunnel1 la coordonnée y de la première partie du tunnel)
  @param(xtunnel2 la coordonnée x de la deuxième partie du tunnel)
  @param(ytunnel2 la coordonnée y de la deuxième partie du tunnel)
  @param(objet correspond à l'objet rencontrer par la tête du serpent au déplacement précédent)
  @param(dir est la direction entrée par l'utilisateur)
  @param(serp stocke les positions du corps du serpent)
  @param(coordtete les coordonnées de la tête du serpent)
}
procedure avancerSerpent(xtunnel1,ytunnel1,xtunnel2,ytunnel2 : Integer;objet : Contenus;dir : Direction; var serp : Serpent;var coordtete : Position);

{fonction qui prend des coordonnées en entré et indique quel objet se trouve sur le plateau à ces coordonnées
@param(x coordonnée sur l'axe des X)
@param(y coordonnée sur l'axe des Y)
@param(tab correspond au plateau)
@returns(Contenus informe de la nature de l'objet)
}
function quelObjet (x , y : integer; tab:plateau):Contenus;

{fonction qui contrôle si le serpent entre en collision avec l'une des parties de son corps
@param(serp Serpent)
@returns(le booléen permettant de savoir si il y a eu une collision ou pas)
}
function collisionSerpent(serp : Serpent) : Boolean;

{procedure permettant de déplacer le serpent, en prenant en compte la direction entrée par l'utilisateur, la vitesse de déplacement(difficulté), les coordonnées du serpent et s'il rencontre un objet de type contenu ou pas
 @param(xtunnel1 la coordonnée x de la première partie du tunnel)
 @param(ytunnel1 la coordonnée y de la première partie du tunnel)
 @param(xtunnel2 la coordonnée x de la deuxième partie du tunnel)
 @param(ytunnel2 la coordonnée y de la deuxième partie du tunnel)
 @param(dir est la direction entrée par l'utilisateur)
 @param(tab correspond au plateau de jeu)
 @param(serp stocke les positions du corps du serpent)
 @param(objet correspond à l'objet rencontré par la tête du serpent lors de son déplacement)
 @param(mortSerp le booléen permettant de savoir si il y a eu une collision entre la tête du serpent et une partie de son corps)
 }
procedure deplacementSerpent(xtunnel1,ytunnel1,xtunnel2,ytunnel2 : Integer; dir : Direction; tab:plateau; var serp : Serpent; var objet : Contenus; var mortSerp: Boolean);

Implementation  

function collisionSerpent(serp : Serpent) : Boolean; //On part du principe que la tête est toujours dans la première case du tableau de coordonnées du serpent.
var i : Integer;
begin
	collisionSerpent := False;
	for i:= 3 to obtenirTailleSerpent(serp) do  //On commence à 3 pusiqu'on suppose que le serpent ne peut pas mordre sa queue quand il mesure moins de 3 unités.
		if ((obtenirCoordonneeX(obtenirCoordonneesCorpsSerpent(serp,i)) = obtenirCoordonneeX(obtenirCoordonneesCorpsSerpent(serp,1))) and 
			(obtenirCoordonneeY(obtenirCoordonneesCorpsSerpent(serp,i)) = obtenirCoordonneeY(obtenirCoordonneesCorpsSerpent(serp,1))))then
			collisionSerpent :=  True; 
end;

function sensInterdit(dir : Direction) : Direction;

//Pour la direction interdite, j'ai juste enlevé le repeat de la saisie puisque la saisie se fait dans une autre procedure
//Ici on ne veut garder que l'aspect calcul de la direction interdite et rien d'autre

begin
	case dir of
		up:sensInterdit:= down;
		down:sensInterdit:= up;
		left:sensInterdit:=right;
		right:sensInterdit:= left;
	end;
end; 


Procedure avancerCorps(coordtete : Position; var serp:Serpent);

var i,tailleSerpent:Integer;
var coordtemp,coordtempcorps : Position;

begin
tailleSerpent:=obtenirTailleSerpent(serp);
coordtemp := coordtete;
				for i:=2 to tailleSerpent do 
					begin
						coordtempcorps := obtenirCoordonneesCorpsSerpent(serp,i);
						fixerCoordonneesCorpsSerpent(obtenirCoordonneeX(coordtemp),obtenirCoordonneeY(coordtemp),i,serp);/// on a déjà modifié les coordonnées de la tête, le corps du serpent suit en prenant les coord de la case du corps d'indice précédant
						coordtemp := coordtempcorps;
					end;
end;


procedure avancerSerpent(xtunnel1,ytunnel1,xtunnel2,ytunnel2 : Integer;objet : Contenus;dir : Direction; var serp : Serpent;var coordtete : Position);/// Provisoires: le serpent ne se déplace pas d'un coup : d'abord la tête puis la case juste après... 
																								/// Pour l'instant, si on n'entre pas de touches, le serpent est immobile / s'arrête.
var pas: integer;
																							
begin
	pas:=1;
	if (dir= up) then
	begin
		coordtete:= obtenirCoordonneesCorpsSerpent(serp,1);
		if ((objet=tunnel1) or (objet = tunnel2)) then
		begin
		case objet of 
		tunnel1:fixerCoordonneesCorpsSerpent(xtunnel2,ytunnel2-1,1,serp);
		tunnel2:fixerCoordonneesCorpsSerpent(xtunnel1,ytunnel1-1,1,serp);
		end;
		end
		else
		fixerCoordonneesCorpsSerpent(obtenirCoordonneeX(coordtete),obtenirCoordonneeY(coordtete)-pas,1,serp);
		avancerCorps(coordtete,serp);
	end;
		
	if dir= down then
	begin
		coordtete:= obtenirCoordonneesCorpsSerpent(serp,1);
		if ((objet=tunnel1) or (objet = tunnel2)) then
		begin
		case objet of 
		tunnel1:fixerCoordonneesCorpsSerpent(xtunnel2,ytunnel2+1,1,serp);
		tunnel2:fixerCoordonneesCorpsSerpent(xtunnel1,ytunnel1+1,1,serp);
		end;
		end
		else
		fixerCoordonneesCorpsSerpent(obtenirCoordonneeX(coordtete),obtenirCoordonneeY(coordtete)+pas,1,serp);
		avancerCorps(coordtete,serp);
	end;
		
	if dir= right then
	begin
		coordtete:= obtenirCoordonneesCorpsSerpent(serp,1);
		if ((objet=tunnel1) or (objet = tunnel2)) then
		begin
		case objet of 
		tunnel1:fixerCoordonneesCorpsSerpent(xtunnel2+1,ytunnel2,1,serp);
		tunnel2:fixerCoordonneesCorpsSerpent(xtunnel1+1,ytunnel1,1,serp);
		end;
		end
		else
		fixerCoordonneesCorpsSerpent(obtenirCoordonneeX(coordtete)+pas,obtenirCoordonneeY(coordtete),1,serp);
		avancerCorps(coordtete,serp);
	end;
			
	if dir=left then	
	begin
		coordtete:= obtenirCoordonneesCorpsSerpent(serp,1);
		if ((objet=tunnel1) or (objet = tunnel2)) then
		begin
		case objet of 
		tunnel1:fixerCoordonneesCorpsSerpent(xtunnel2-1,ytunnel2,1,serp);
		tunnel2:fixerCoordonneesCorpsSerpent(xtunnel1-1,ytunnel1,1,serp);
		end;
		end
		else
		fixerCoordonneesCorpsSerpent(obtenirCoordonneeX(coordtete)-pas,obtenirCoordonneeY(coordtete),1,serp);
		avancerCorps(coordtete,serp);
	end;
end;


function quelObjet (x , y : integer; tab:Plateau):Contenus;////Renvoie le contenu de la case
begin
	quelObjet:=tab[y][x]; //Ici il faut bien faire attention de retouner tab[y][x] et non pas tab[x][y]
						  //car ici y = nb lignes et x = nb colonnes 
end;



procedure deplacementSerpent(xtunnel1,ytunnel1,xtunnel2,ytunnel2 : Integer; dir : Direction; tab:plateau; var serp : Serpent; var objet : Contenus; var mortSerp: Boolean);

var coordtete : Position;

begin

avancerSerpent(xtunnel1,ytunnel1,xtunnel2,ytunnel2,objet,dir,serp,coordtete);
mortSerp:= collisionSerpent(serp);
objet:= quelObjet(obtenirCoordonneeX(obtenirCoordonneesCorpsSerpent(serp,1)),obtenirCoordonneeY(obtenirCoordonneesCorpsSerpent(serp,1)),tab);

end;

END.
