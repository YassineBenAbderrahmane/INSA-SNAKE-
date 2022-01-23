Unit Jouer;

Interface

Uses Types, crt,Affichage,Deplacement,Stage, Generation,GestionScore,Initialisation;

{procédure permettant d'augmenter le score d'un certain nombre de points en fonction du fruit mangé
@param(objet donne le type de fruit mangé par le serpent)
@param(score le score qui sera actualise à chaque fois que le joueur mange un fruit)
}
procedure augmenterScore(objet : Contenus; var score : Score); 

{Fonction permettant de recevoir une touche entrée par l'utilisateur et la transformer en  une direction
 @param(toucheDirection est une touche du clavier, qui devra être une flèche directionnelle)
 @returns(dir Une direction du serpent, qui pourra être utilisée pour déplacer le serpent)
}
function transformerToucheEnDirection(toucheDirection : Char) : Direction;

{procédure permettant d'arrêter la partie lorsque le serpent touche un mur/obstacle ou se mord la queue
@param(mortSerp booléen permettant de savoir si le serpent s'est mordu la queue ou non)
@param(objet le contenu de la case où se trouve la tête du serpent)
@param(finpartie booléen qui indique si la partie est finie ou non)
@param(score le score qui est affiché lorsque la partie est finie)
}
procedure estMort(mortSerp : Boolean; objet :Contenus; var finpartie : boolean;score : Score);

{procédure permettant de faire grandir le serpent d'une case après l'ingestion d'un fruit
@param(dir la direction dans laquelle on doit ajouter le nouveau morceau de serpent)
@param(objet le contenu de la case où se trouve la tête du serpent)
@param(serp le serpent)
}
procedure grandirSerpent(dir : Direction; objet : Contenus; var serp : Serpent);

{procédure permettant de donner la touche opposée à la touche prise en entrée si l'objet pris en entrée est une coco
@param(objet l'objet que l'on regarde pour savoir si c'est une coco)
@param(toucheDirection la touche direction que l'on va modifier si le fruit est une coco)
}
procedure directionOpposee(objet : Contenus;var toucheDirection : char);

{procedure qui permet de diminuer la taille du serpent de moitité si le fruit pris en entrée est une myrtille
@param(objet l'objet que l'on regarde pour savoir si c'est une myrtille)
@param(serp le serpent)
}
Procedure Renaissance(objet:Contenus ;var serp:Serpent);

{Fonction dont le rôle est de renvoyer un booléen indiquant si un citron a été mangé et donc de faire clignoter le jeu
 @param(objet le type de fruit mangé par le serpent)
 @returns(Un booléen qui indique si le jeu doit clignoter ou non )
}
function doitClignoter(objet : Contenus):Boolean;

{procedure qui permet de gérer les variations de vitesse avec les fruits weed et piment
@param(vitesseEvo booléen qui permet de savoir si le mode vitesse progressive a été selectionné par le joueur ou non)
@param(vitesseInitiale la vitesse initiale telle qu'elle a été choisie par l'utilisateur lors de l'initialisation)
@param(objet l'objet que le serpent recontre lors de son déplacement)
@param(vitesse la variable qui contient la valeur de la vitesse modifiée par les fruits)
}
procedure vitesseWeedPiment(vitesseEvo : Boolean; vitesseInitiale : Integer; objet: Contenus; var vitesse: Integer);

{procédure qui permet d'activer la vitesse progressive du serpent en fonction du nombre de points du joueur
@param(objet l'objet que le serpent recontre lors de son déplacement)
@param(vitesseEvo booléen qui permet de savoir si le mode vitesse progressive a été selectionné par le joueur ou non)
@param(score le nombre de points permet à la procédure d'augmenter la vitesse ou non)
@param(vitesse la variable qui contient la valeur de la vitesse modifiée par les fruits)
* }
procedure vitesseEvolutive(objet : Contenus; vitesseEvo: Boolean;score: Score; var vitesse:Integer);

{procedure qui permet de vider le plateau lorsque le serpent mange un fruit
@param(objet l'objet rencontré par le serpent lors de son déplacement (on regarde si c'est un fruit ou pas))
@param(xtaille la taille du plateau sur l'axe horizontal)
@param(ytaille la taille du plateau sur l'axe vertical)
@param(plateauJeu le plateau de jeu)
@param(estVide variable booléenne qui permet de savoir si la plateau a été vidé ou pas)
* }
procedure videPlateau(objet : Contenus; xtaille,ytaille : Integer; var plateauJeu : Plateau; var estVide : Boolean);

{Procédure qui permet de gérer certaines les effets sur le serpent (et la partie) en fonction de l'objet rencontré par le serpent
@param(xtaille la taille du plateau sur l'axe horizontal)
@param(ytaille la taille du plateau sur l'axe vertical)
@param(dir la direction dans laquelle le serpent se déplace au moment de l'appel)
@param(mortSerp booléen permettant de savoir si le serpent s'est mordu la queue ou non)
@param(objet le contenu de la case où se trouve la tête du serpent)
@param(serp le serpent)
@param(score le score)
@param(finpartie booléen qui indique si la partie est finie ou non)
}
procedure jakadi(xtaille,ytaille : Integer; dir : Direction; mortSerp : Boolean; objet :Contenus; var serp : Serpent; var score : Score; var finpartie : Boolean);

{procédure qui permet de savoir si l'objet rencontré par la tête du serpent lors de son déplacement est un fruit ou pas et de retourner le fruit en question si c'est un fruit
@param(objet l'objet rencontré par la tête du serpent)
@param(fruit le fruit rencontré par le serpent (si l'objet rencontré est un fruit))
}
procedure detectionFruit(objet : Contenus; var fruit : Contenus);

{procedure qui permet la sélection de la touche du clavier par l'utilisateur tout en vérifiant qu'elle est valide
@param(derniereTouche contient la dernière touche entrée par l'utilisateur pour l'affecter à la saisie en cours si la saisie est fausse et ainsi ne pas stopper le programme)
}
Function SelectionChar(derniereTouche : char) : char;

{procedure qui permet de gérer tout le mécanisme de saisie de la direction de sorte à ce que la direction envoyée en sortie soit valide
@param(toucheDirection la touche du clavier saisie par l'utilisateur)
@param(dir permet d'avoir la dernière direction et de sortir la direction traitée)
@param(objet l'objet rencontré par la tête du serpent pour savoir si c'est une coco et ainsi inverser les touches directionnelles)
}
procedure selectionTouche(var toucheDirection : char; var dir : Direction; objet : Contenus);

{procédure qui gère le lancement du mécanisme de stage au sein de la partie
@param(serp le serpent)
@param(plateauJeu le plateau de jeu)
@param(objet l'objet rencontré par la tête du serpent pour savoir si c'est un kiwi)
@param(scoore le score de la partie en cours pour pouvoir directment l'incrémenter dans le mécanisme de stage si nécessaire)
@param(xtaille la taille du plateau sur l'axe horizontal)
@param(ytaille la taille du plateau sur l'axe vertical)
@param(vitesse la variable qui contient la valeur de la vitesse du serpent au moment de l'appel)
@param(clignotement la variable booléenne pour savoir si le plateau doit clignoter lors de l'affichage) 
}
procedure niveauStage(serp : Serpent;plateauJeu : Plateau;objet : Contenus; var scoore : Score; var xtaille,ytaille : Integer; var vitesse : Integer; var clignotement : Boolean);

{procédure centrale qui gère le mécanisme de jeu
@param(vitesseEvo booléen qui permet de savoir si le mode progressif a été selectionné par le joueur ou non)
@param(clignotement la variable booléenne pour savoir si le plateau doit clignoter lors de l'affichage)
@param(plateauJeu le plateau de jeu)
@param(findepartie booléen permettant de savoir quand la partie doit se terminer)
@param(vitesse la vitesse de déplacement du serpent sur le plateau de jeu)
@param(serp le serpent)
@param(xtaille la taille du plateau sur l'axe horizontal)
@param(ytaille la taille du plateau sur l'axe vertical)
@param(score le score qui sera actualisé à chaque fois que le joueur mange un fruit)
}
procedure jouerPartie(vitesseEvo:Boolean;clingotement : Boolean; plateauJeu : Plateau; findepartie : Boolean; vitesse : Integer; serp : Serpent;var xtaille, ytaille : Integer; var scoore : Score);

{procédure permettant de lancer une partie
 @param(fichierMeilleursScores le fichier contenant l'historique des meilleurs scores triés par ordre décroissant)
}
procedure snake(var fichierMeilleursScores : Text);

Implementation 

procedure augmenterScore(objet : Contenus; var score : Score); 

var points : Integer;

begin

points:=obtenirPointScore(score);

case objet of
	pomme : fixerPointScore(points+100,score);
	orange : fixerPointScore(points+200,score);
	citron : fixerPointScore(points+150,score);
	piment : fixerPointScore(points+100,score);
	coco : fixerPointScore(points+150,score);
	weed : fixerPointScore(points+50,score);
	myrtille : fixerPointScore(points+50,score);
end;
 
end;


function transformerToucheEnDirection(toucheDirection : Char) : Direction;
var direct:Direction;

begin
 
  case toucheDirection of 
	UpKey:direct:=up;
	Downkey:direct:=down;
	Rightkey:direct:=right;
	LeftKey:direct:=left;
	end;
  
  transformerToucheEnDirection:= direct
end;

procedure estMort(mortSerp : Boolean; objet :Contenus; var finpartie : boolean;score : Score);

begin

If (mortSerp or (objet=mur) or (objet=obstacle)) then
begin
	ClrScr();
	finpartie:=true;
	TextColor(Red + Blink);
	HighVideo;
	GotoXY(30,4);
	writeln('VOUS ETES MORT ',obtenirNomScore(score));
	GotoXY(25,5);
	writeln('Votre score est de : ', obtenirPointScore(score)); 
	delay(3000);
end;
end;

procedure grandirSerpent(dir : Direction; objet : Contenus; var serp : Serpent);

var positionajout : Position;
var tailleserp : Integer;

begin 

tailleserp:=obtenirTailleSerpent(serp);
positionajout:= obtenirCoordonneesCorpsSerpent(serp,1);

if objet in [pomme,orange,citron,coco,piment,weed] then
begin
	fixerTailleSerpent(tailleserp +1,serp);
	case dir of 
	up : fixerCoordonneesCorpsSerpent(obtenirCoordonneeX(positionajout),obtenirCoordonneeY(positionajout)+1,obtenirTailleSerpent(serp),serp);
	down : fixerCoordonneesCorpsSerpent(obtenirCoordonneeX(positionajout),obtenirCoordonneeY(positionajout)-1,obtenirTailleSerpent(serp),serp);
	right : fixerCoordonneesCorpsSerpent(obtenirCoordonneeX(positionajout)-1,obtenirCoordonneeY(positionajout),obtenirTailleSerpent(serp),serp);
	left : fixerCoordonneesCorpsSerpent(obtenirCoordonneeX(positionajout)+1,obtenirCoordonneeY(positionajout),obtenirTailleSerpent(serp),serp);
	end;
end;
end;

procedure directionOpposee(objet : Contenus;var toucheDirection : char);

begin
	if objet = coco then
	begin
		case toucheDirection of 
		UpKey : toucheDirection := DownKey;
		DownKey : toucheDirection := UpKey;
		RightKey : toucheDirection := LeftKey;
		LeftKey : toucheDirection := RightKey;
		end;
	end;
end;

Procedure Renaissance(objet: Contenus ;var serp : Serpent);

var tailleserp,moitie,i: Integer;

begin
tailleserp:= obtenirTailleSerpent(serp);
	if objet = myrtille then
	begin
		if tailleserp>1 then
		begin
			tailleserp:= obtenirTailleSerpent(serp);
			moitie:= tailleserp div 2;
			fixerTailleSerpent(moitie, serp);
				for i:=moitie+1 to tailleserp do
				begin
				fixerCoordonneesCorpsSerpent(0,0,i,serp);
				end;
		end;
	end;
end;

function doitClignoter(objet : Contenus):Boolean;

begin

doitClignoter := (objet = citron);

end; 

procedure vitesseWeedPiment(vitesseEvo : Boolean; vitesseInitiale : Integer; objet: Contenus; var vitesse: Integer);


begin

if ((objet=piment) or(objet=weed)) then
begin
	case objet of

		weed: case vitesse of
				300: vitesse:=600;
				200: vitesse:=400;
				100: vitesse:= 201;
				150 : vitesse:= 600;
				101 : vitesse :=400;
				75 : vitesse := 201;
				299: vitesse := 600;
				250: vitesse :=600;
				202: vitesse :=600;
				151: vitesse := 600;
				125: vitesse := 600;
				102: vitesse := 600;
				76: vitesse :=600;
			   end;
		  
		piment: case vitesse of
				300: vitesse:=150;
				200: vitesse:=101;
				100: vitesse:= 75;
				600 : vitesse:=150;
				400 :vitesse := 101;
				201 :vitesse := 75;
				299: vitesse := 150;
				250: vitesse :=150;
				202: vitesse :=150;
				151: vitesse := 150;
				125: vitesse := 150;
				102: vitesse := 150;
				76: vitesse :=150;
			end;

	end;
end
else 
begin
	if ((objet in [orange,pomme,citron,myrtille,kiwi,coco]) and not(vitesseEvo)) then
	begin
		vitesse := vitesseInitiale;
	end;
end;
end;

procedure vitesseEvolutive(objet : Contenus; vitesseEvo: Boolean;score: Score; var vitesse:Integer);

begin

if (vitesseEvo and (objet<>weed) and (objet<>piment) and (objet<>tunnel1) and (objet<>tunnel2)) then
begin
	case obtenirPointScore(score) of

	0..500: vitesse:=299;
	501..1200: vitesse:=250;
	1201..2000: vitesse:=200;
	2001..3000: vitesse:=150;
	3001..4000: vitesse:=125;
	4001..5000: vitesse:=100;
	5001..32767: vitesse:=75;

	end;

end;

end;


procedure videPlateau(objet : Contenus; xtaille,ytaille : Integer; var plateauJeu : Plateau; var estVide : Boolean);

var i,j : Integer;

begin
	if ((objet=pomme) or (objet=orange) or (objet=citron) or (objet = coco) or (objet=weed) or (objet=myrtille) or (objet=piment) or (objet=kiwi)) then
	begin
	for i:=2 to ytaille-1 do
		begin
			for j:= 2 to xtaille-1 do
			begin
				plateauJeu[i][j] := vide;
			end;
		end;
	estVide :=  True;
	end
	else 
	estVide := False;
end;

procedure jakadi(xtaille,ytaille : Integer; dir : Direction; mortSerp : Boolean; objet :Contenus; var serp : Serpent; var score : Score; var finpartie : Boolean);

begin

estMort(mortSerp,objet,finpartie,score);
augmenterScore(objet,score);
grandirSerpent(dir,objet,serp);
Renaissance(objet,serp);

end;

procedure detectionFruit(objet : Contenus; var fruit : Contenus);

begin
	if ((objet <> mur) and (objet<>obstacle) and (objet<>vide)) then 
		fruit := objet;
end;

Function SelectionChar(derniereTouche : char) : char;
{ Cette fonction permet de lire seulement les touches demandées sans prendre les autres en considération}

Var
  Key : Char;
Begin
  Repeat
    Key := ReadKey;
    if not(Key in [UpKey,DownKey,LeftKey,RightKey]) then 
		Key := derniereTouche;
  Until Key in [UpKey,DownKey,LeftKey,RightKey];
  SelectionChar := Key;
End;

procedure selectionTouche(var toucheDirection : char; var dir : Direction; objet : Contenus);

var x:char;
var directionInterdite : Direction;
var dirtemp : Direction;
var derniereTouche : Char ;

begin
	directionInterdite := sensInterdit(dir); //On calcule la direction interdite avant, car on la calcule à partir de la dernière 
										 //direction et non pas à partir de celle que l'on s'apprête à entrer
	derniereTouche := toucheDirection;
	toucheDirection := SelectionChar(derniereTouche); //Ici on fait juste la lecture de la touche : la fonction readkey sort juste le caractère 
								  //correspondant à la touche sur laquelle on vient d'appuyer (c'est un fonction de crt)

	directionOpposee(objet,toucheDirection);							  
	dir := transformerToucheEnDirection(toucheDirection); //Ici on calcule la direction correspondant au caractère que l'on 
														  //vient de récupérer
	
	if dir = directionInterdite then //Si jamais cette direction est la même que la direction interdite calculée à partir de 
		dir := sensInterdit(dir);	//la direction précédente, alors pour éviter que le serpent ne s'arrête mais continue
									//d'avancer, on affecte à la direction en cours (qui est donc interdite), sa direction 
									//interdite (donc en fait sa direction opposée) pour obtenir la direction dans laquelle 
									//le serpent était entrain d'avancer (la direction précédente)
		
	
	while keypressed() do // Ici on vide le buffer, le buffer c'est la file d'attente des saisies, en gros si on appuie plein
		x:=readkey();	  //de fois sur des touches, elles "attendent leur tour" pour entrer dans la boucle, donc pour éviter 
						  //les problèmes on ne veut travailler que sur une touche saisie par l'utilisateur, donc tant que 
						  //l'utilisateur entre une touche après avoir saisie sa première touche, on la lit avec readkey ce qui
						  //la fait sortir du buffer
end;

procedure niveauStage(serp : Serpent;plateauJeu : Plateau;objet : Contenus; var scoore : Score; var xtaille,ytaille : Integer; var vitesse : Integer; var clignotement : Boolean);

var serpNiveauParallele : Serpent;
var findepartieStage : Boolean;
var xtailletemp,ytailletemp,vitessetemp : Integer;

begin
	if objet=kiwi then 
	begin
		xtailletemp :=xtaille;
		ytailletemp :=ytaille;
		vitessetemp :=vitesse;
		initStage(xtaille,ytaille,vitesse,clignotement,findepartieStage,serpNiveauParallele);
		jouerStage(xtaille,ytaille,vitesse,clignotement,findepartieStage,scoore,serpNiveauParallele);
		xtaille := xtailletemp;
		ytaille := ytailletemp;
		vitesse := vitessetemp;
		affichaage(plateauJeu,scoore,serp,xtaille,ytaille,false);
		GoToXY(53,3);
		write('3');
		delay(1000);
		GoToXY(53,3);
		write('2');
		delay(1000);
		GoToXY(53,3);
		write('1');
		delay(1000);
	end;
	clrscr();
end;

procedure jouerPartie(vitesseEvo:Boolean;clingotement : Boolean; plateauJeu : Plateau; findepartie : Boolean; vitesse : Integer; serp : Serpent;var xtaille, ytaille : Integer; var scoore : Score);

var clignotement : Boolean;
var objet : Contenus;
var toucheDirection : Char;
var dir : Direction;
var fruit : Contenus;
var Xobjet,Yobjet,xtunnel1,ytunnel1,xtunnel2,ytunnel2 : Integer;
var ObjetPresent : Boolean; 
var mortSerp : Boolean;
var estVide : Boolean;
var xfruit,yfruit : Integer;
var detec : Contenus;
var vitesseInitiale : Integer;

begin 
	dir := right; //Ici on initialise la première direction à droite puisqu'on décide de placer le premier fruit toujours au même endroit (quelques cases à droite du serpent)
	objet := vide;
	detec := vide;
	vitesseInitiale :=vitesse; //Ici on stocke la vitesse telle qu'elle est choisie par l'utilisateur lors de l'intialisation
	
	affichaage(plateauJeu,scoore,serp,xtaille,ytaille,clignotement); //On affichage une première fois le plateau de jeu avec les éléments intialisés avant que la partie ne commence
	
	Repeat 
	begin
		selectionTouche(toucheDirection,dir,detec); 
		repeat
		begin
				randomize(); //Il faut faire attention à ne mettre qu'une seule fois la commande randomize dans tout le programme
				//Sinon cela engendre des problèmes de génération aléatoire et donc le gros problème de latence que l'on a eu
				deplacementSerpent(xtunnel1,ytunnel1,xtunnel2,ytunnel2,dir,plateauJeu,serp,objet,mortSerp);
				clrscr();
				videPlateau(objet,xtaille,ytaille,plateauJeu,estVide); //Ici on regarde si on doit vider le plateau (enlever le 
				//fruit dégusté et l'obstacle) en mettant tout le plateau à vide. 
				affichaage(plateauJeu,scoore,serp,xtaille,ytaille,clignotement);
				jakadi(xtaille,ytaille,dir,collisionSerpent(serp),objet,serp,scoore,findepartie);
				detectionFruit(objet,detec);
				vitesseEvolutive(detec,vitesseEvo,scoore,vitesse);
				if estVide then 
					begin
						vitesseWeedPiment(vitesseEvo,vitesseInitiale,objet,vitesse);
						clignotement := doitClignoter(objet);
						genererFruit(plateauJeu,xtaille,ytaille,serp);
						genererObstacle(xtaille,ytaille,serp,plateauJeu);
						genererTunnel(xtaille,ytaille,serp,plateauJeu, xtunnel1, ytunnel1, xtunnel2, ytunnel2);
						niveauStage(serp,plateauJeu,objet,scoore,xtaille,ytaille,vitesse,clignotement);
						affichaage(plateauJeu,scoore,serp,xtaille,ytaille,clignotement);
					end;
				delay(vitesse);	//On gère la vitesse du serpent en fonction de la fréquence d'affichage
		end;
		until (keypressed() or (findepartie));  //On déplace le serpent jusqu'à temps que le joueur appuie sur une nouvelle
		//touche ou que la partie soit terminé 	
	end;
	until findepartie; //On arrête la boucle principale du jeu quand le serpent est mort 
	vitesse := vitesseInitiale; //Ici on reprend la vitesse intiale puisque la valeur de la vitesse a pu être changé à cause des fruits weed et piment.
	// On a besoin de faire cette manipulation puisque l'actualisation des scores et l'affichages des scores se fait en fonction de la vitesse 
	
end;

procedure snake(var fichierMeilleursScores : Text);
var	scoore : Score;
	vitesse: Integer;
	serp: Serpent; 
	xtaille,ytaille: Integer; 
	findepartie : Boolean; 
	TabScore : TableauDeScore;
	plateauJeu : Plateau;
	clignotement : Boolean;
	vitesseEvo : Boolean;

begin
 initPartie(vitesse, vitesseEvo, scoore, serp, xtaille,ytaille, findepartie,plateauJeu,clignotement);
 jouerPartie(vitesseEvo,clignotement,plateauJeu, findepartie, vitesse,serp,xtaille, ytaille,scoore);
 ChargerScores(vitesseEvo,vitesse,TabScore);
 actualiserMeilleursScores(vitesseEvo,vitesse,obtenirPointScore(scoore),obtenirNomScore(scoore),TabScore);
end;

END.
