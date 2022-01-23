Unit Affichage;

Interface 

uses Types,crt,sysutils;

{fonction permettant de sortir le carctère ainsi que la "mise en page" (couleur + clignotement) correspondant à l'objet passé en entrée pour pouvoir afficher les éléments
@param(objet contenu de la case que l'on souhaite afficher)
@param(clignotement la variable booléenne pour savoir si le plateau doit clignoter lors de l'affichage)
@returns(la caractère correspond à l'objet passé en entrée avec la mise en page correspondante)
}
function objet2Caractere(objet : Contenus; clignotement: Boolean) : Char;

{procédure permettant l'affichage complet de tous les éléments nécessaires au jeu (la plateau et ses éléments, le score et le serpent)
@param(plateauJeu le plateau)
@param(score le score qui sera actualise à chaque fois que le joueur mange un fruit)
@param(serp le serpent)
@param(xtaille la taille du plateau sur l'axe horizontal)
@param(ytaille la taille du plateau sur l'axe vertical)
@param(clignotement la variable booléenne pour savoir si le plateau doit clignoter lors de l'affichage)
}
procedure affichaage(plateauJeu : Plateau; score : Score; serp : Serpent; xtaille,ytaille : Integer;clignotement : Boolean);

{procédure permettant l'affichage du serpent "sur le plateau de jeu" (en effet on superpose l'affichage du plateau et celui du serpent au même endroit
@param(serp le serpent)
@param(clignotement la variable booléenne pour savoir si le plateau doit clignoter lors de l'affichage)
}
procedure afficherSerpent(serp : Serpent; clignotement : Boolean);

{procédure permettant l'affichage de la légende avec les fruits
}
procedure afficherLegende();

{Procédure permettant d'afficher le plateau de jeu
@param(plateauJeu le plateau)
@param(xtaille la taille du plateau sur l'axe horizontal (nombre de colonnes du tableau représentant le plateau))
@param(ytaille la taille du plateau sur l'axe vertical (nombre de lignes du tableau représentant le plateau))
@param(clignotement la variable booléenne pour savoir si le plateau doit clignoter lors de l'affichage) 
}
procedure afficherPlateau(plateauJeu : Plateau; xtaille,ytaille : Integer; clignotement : Boolean);

{procédure permettant d'afficher le score
@param(score le score qui sera actualisé à chaque fois que le joueur mange un fruit) 
}
procedure afficherScore(score : Score);

{procédure permettant d'afficher le menu principal
}
procedure AfficherMenuuuuu();

{procédure permettant d'afficher les règles du jeu
 @param(reglesDuJeu le fichier contenant les règles du jeu)
}
procedure afficherReglesDuJeu(var reglesDuJeu : Text);

{procédure permettant d'afficher les meilleurs scores
 @param(fichierMeilleursScores le fichier contenant l'historique des meilleurs scores triés par ordre décroissant)
}
Procedure AfficherMeilleursScores (var fichierMeilleursScores: Text);

Implementation

uses LesMenus,Jouer;

function objet2Caractere(objet : Contenus; clignotement: Boolean) : Char;

var resultat : Char;

begin
	case objet of //Ici on fait juste les correspondances entre les objets et les caractères que l'on veut afficher. On s'occupe aussi des différentes couleurs + clignotement que l'on veut faire
	
	pomme :
	begin
		resultat := 'P';
		if clignotement then 
			TextColor(LightGreen + Blink)
		else
			TextColor(LightGreen);
	end;
	
	orange : 
	begin
		resultat := 'O';
		if clignotement then 
			TextColor(LightRed + Blink)
		else
			TextColor(LightRed);
	end;
	
	citron : 
	begin
		resultat := 'C';
		if clignotement then 
			TextColor(Yellow + Blink)
		else
			TextColor(Yellow);
	end;
	
	piment :
	begin
		resultat := 'P';
		if clignotement then 
		begin
			TextColor(Red + Blink);
			HighVideo;
		end
		else
		begin
			TextColor(Red);
			HighVideo;
		end;
	end;
	
	coco :
	begin
		resultat := 'C';
		if clignotement then 
			TextColor(White + Blink)
		else
			TextColor(White);
	end;
	
	weed :
	begin
		resultat := 'W';
		if clignotement then 
		begin
			TextColor(Green + Blink);
			HighVideo;
		end
		else
		begin
			TextColor(Green);
			HighVideo;
		end;
	end;
	
	myrtille :
	begin
		resultat := 'M';
		if clignotement then 
		begin
			TextColor(Blue + Blink);
			HighVideo;
		end
		else
		begin
			TextColor(Blue);
			HighVideo;
		end;
	end;
	
	kiwi :
	begin
		resultat := 'K';
		if clignotement then 
			TextColor(Brown + Blink)
		else
			TextColor(Brown);
	end;
	
	goldkiwi :
	begin
		resultat := 'K';
		if clignotement then 
		begin
			TextColor(Brown + Blink);
			HighVideo;
		end
		else
		begin
			TextColor(Brown);
			HighVideo
		end;
	end;
	
	obstacle : 
	begin
		resultat := 'X';
		if clignotement then 
			TextColor(LightMagenta + Blink)
		else
			TextColor(LightMagenta);
	end;
	
	mur : 
	begin
		resultat := '|';
		if clignotement then 
			TextColor(LightCyan + Blink)
		else
			TextColor(LightCyan);
	end;
	
	tunnel1 : 
	begin
		resultat := '+';
		if clignotement then 
			TextColor(LightGray + Blink)
		else
			TextColor(LightGray);
	end;
	
	tunnel2 : 
	begin
		resultat := '+';
		if clignotement then 
			TextColor(LightGray + Blink)
		else
			TextColor(LightGray);
	end;
	
	vide : 
	begin
		resultat := ' ';
	end;
	
	end;
	
	objet2Caractere := resultat;
end;

procedure affichaage(plateauJeu : Plateau; score : Score; serp : Serpent; xtaille,ytaille : Integer;clignotement : Boolean);

//Ici on affiche tous les éléments nécessaires à savoir : le plateau, le serpent et le score.

begin 
	afficherPlateau(plateauJeu,xtaille,ytaille,clignotement);
	afficherSerpent(serp,clignotement);
	afficherScore(score);
	afficherLegende();
	NormVideo;	//Cette instruction permet de "revenir à la normale" en terme de couleur et de clignotement.
	GotoXY(1,21); //Ici on se place en dessous de tous les éléments pour ne pas avoir de problèmes de "suraffichage". 
end;

procedure afficherSerpent(serp : Serpent; clignotement : Boolean);

//Remarque : l'affichage du serpent se fait de manière "superposée" par rapport à l'affichage du plateau

var numPartieCorps : Integer;

begin
	for numPartieCorps := 1 to obtenirTailleSerpent(serp)  do 
	begin
		GotoXY(obtenirCoordonneeX(obtenirCoordonneesCorpsSerpent(serp, numPartieCorps))+4,obtenirCoordonneeY(obtenirCoordonneesCorpsSerpent(serp, numPartieCorps))+2);
		if numPartieCorps = 1 then //Ce bloc if permet d'afficher la tête du serpent dans une couleur différente de celle que l'on va utiliser pour afficher le reste du serpent.
		begin
			if clignotement then 
				TextColor(LightRed + Blink)
			else
				TextColor(LightRed);
		end
		else 
		begin
			if clignotement then 
				TextColor(Green + Blink)
			else
				TextColor(Green);
		end;
		write('o');				
	end;
end;

procedure afficherLegende();

begin
	GotoXY(50,10);
	TextColor(LightGreen);
	write('P ');
	NormVideo;
	write(': Pomme');
	
	GotoXY(50,11);
	TextColor(LightRed);
	write('O ');
	NormVideo;
	write(': Orange');
	
	GotoXY(50,12);
	TextColor(Yellow);
	write('C ');
	NormVideo;
	write(': Citron');
	
	GotoXY(50,13);
	TextColor(Red);
	HighVideo;
	write('P ');
	NormVideo;
	write(': Piment');
	
	GotoXY(50,14);
	TextColor(White);
	write('C ');
	NormVideo;
	write(': Coco');
	
	GotoXY(50,15);
	TextColor(Green);
	HighVideo;
	write('W ');
	NormVideo;
	write(': Substance illicite');
	
	GotoXY(50,16);
	TextColor(Blue);
	HighVideo;
	write('M ');
	NormVideo;
	write(': Myrtille');
	
	GotoXY(50,17);
	TextColor(Brown);
	write('K ');
	NormVideo;
	write(': Kiwi');
	
	GotoXY(50,18);
	TextColor(Brown);
	HighVideo;
	write('K ');
	NormVideo;
	write(': Kiwi Gold');
	
	GotoXY(50,19);
	TextColor(LightMagenta);
	write('X ');
	NormVideo;
	write(': Obstacle');
	
	GotoXY(50,20);
	TextColor(LightGray);
	write('+ ');
	NormVideo;
	write(': Tunnel');
end;

procedure afficherPlateau(plateauJeu : Plateau; xtaille,ytaille : Integer;clignotement : Boolean);

var i,j : Integer;

//Pour faire l'affichage du plateau, on parcourt chaque case du plateau et on affiche son contenu grâce à la fonction objet2Caractere.

begin
	for i:= 1 to ytaille do
	begin
		GotoXY(5,i+2);
		for j:= 1 to xtaille do 
		begin
			write(objet2Caractere(plateauJeu[i][j],clignotement));
		end;
		writeln();
	end;
end;

procedure afficherScore(score : Score);

var i,j : Integer;

begin 
	TextColor(LightRed);
	
	GotoXY(50,5); //On se place au bon endroit
	
	//Les 4 boucles for qui suivent permettent de dessiner le petit encadré autour du score. 
	
	for j:= 1 to 11 do
	begin
		write('*')
	end;
	
	for i:= 1 to 2 do
	begin
		GotoXY(50,5+i);
		writeln('*')
	end;
	
	GotoXY(50,8);
	
	for j:= 1 to 11 do
	begin
		write('*')
	end;
	
	for i:= 1 to 2 do
	begin
		GotoXY(60,5+i);
		writeln('*')
	end;

	GotoXY(53,6);	//On se place au bon endroit et on affichage la valeur du score.
	TextColor(White);
	writeln('Score');
	
	GotoXY(53,7);
	writeln(obtenirPointScore(score));
end;

procedure AfficherMenuuuuu(); 

var	GameMenu : TMainMenu;
	Odp : char;
	reglesDuJeu,fichierMeilleursScores: Text;

begin
GameMenu.Create();
Odp:=#1;	
	while Odp <> #27 do
		begin
			GameMenu.AfficherMenu(); 
			Odp:= ReadKey();
			case Odp of 
				#13 : 
					begin
						case GameMenu.GetSelectionner() of 
							0 : 
							begin
								clrscr();
								snake(fichierMeilleursScores);					
						    end;

							1 : 
							begin
								ClrScr();
								afficherReglesDuJeu(reglesDuJeu);
								readln();
							end;	
							
							
							2: 
							begin
								ClrScr();
								AfficherMeilleursScores(fichierMeilleursScores);
								readln();
							end;
							
							3:Exit();										
						end;	
				    end;
				    							

			#0 : 
					begin
						Odp := ReadKey();
						case Odp of
								#72 : GameMenu.CurHaut(); 
								#80 : GameMenu.CurBas();   
						end;
				 end;	
			end;
	end;
end; 

procedure afficherReglesDuJeu(var reglesDuJeu : Text);
var uneLigne : String;
begin 
	assign(reglesDuJeu,'RegleDuJeu.txt');
	reset(reglesDuJeu);
	while not(eof(reglesDuJeu)) do 
	begin
		readln(reglesDuJeu,uneLigne);
		If (uneLigne='*PRINCIPE DU JEU*') or (uneLigne='*SPÉCIFICATION DES DIFFÉRENTS FRUITS*') then 
		begin
		TextColor(Red);
		end
	
		else 
		begin 
		TextColor(white);
		end;
		
		writeln(uneLigne);
	end;
	close(reglesDuJeu);	
end;

Procedure AfficherMeilleursScores (var fichierMeilleursScores: Text);
var uneLigne: String;
	choixVitesse:integer;
begin
	choixVitesse :=0;
	MenuVitesse(choixVitesse);

	Case choixVitesse of 

		// On assigne le fichier texte correspondant à la vitesse voulu

		1 : Assign(fichierMeilleursScores, 'Scores1.txt');
		2 : Assign(fichierMeilleursScores, 'Scores2.txt');
		3 : Assign(fichierMeilleursScores, 'Scores3.txt');
		4 : Assign(fichierMeilleursScores, 'ScoresP.txt');
		
	end;
		

	writeln('Voici les scores des best joueurs de SNAKE ever');
	writeln();
	reset(fichierMeilleursScores);

	while not(eof(fichierMeilleursScores))do
		
	// On affiche le fichier des meilleurs scores 
		
	begin
		readln(fichierMeilleursScores,uneligne);
		TextColor(LightRed);
		write(uneligne, ': ');
		readln(fichierMeilleursScores,uneligne);
		TextColor(White);
		writeln(uneligne);
	end;
		
	close(fichierMeilleursScores);
end;

end.
