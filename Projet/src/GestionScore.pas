unit GestionScore;


interface
uses Types,crt;

{Procedure permettant de charger les scores en provenance du fichier texte Score.txt dans un tableau
@param(vitesseEvo booléen qui permet de savoir si le mode vitesse progressive a été selectionné par le joueur ou non)
@param(vitesse : vitesse dont le joueur veut voir les scores)
@param(TabScore : le tableau ou sont charges les scores)
}

procedure ChargerScores(vitesseEvo:Boolean;vitesse : Integer; var TabScore : TableauDeScore);


{Procedure permettant d'actualiser le tableau de score (trié)
@param(vitesseEvo booléen qui permet de savoir si le mode vitesse progressive a été selectionné par le joueur ou non)
@param(Nbpoint : le nombre de point obtenu par le jouer lors de la partie)
@param(nomJoueur : le nom du joueur venant de faire une partie)
@param(TabScore : le tableau ou sont charges les scores)
}
procedure actualiserMeilleursScores( vitesseEvo:Boolean;vitesse : Integer; Nbpoint : Integer; nomJoueur : String; var TabScore : TableauDeScore);

{Procedure qui permet d'écrire les nouveaux scores dans le fichier texte correspondant
@param(vitesseEvo booléen qui permet de savoir si le mode vitesse progressive a été selectionné par le joueur ou non)
@param(vitesse : vitesse de la partie préalablement jouée)
@param(TabScore : le tableau de score à retranscrir dans le fichier texte)
@param(fichierMeilleursScores : le fichier  texte dans lequel nous écrivons les nouveaux scores)} 
procedure EcrireFichierTexte (vitesseEvo:Boolean; vitesse : Integer; TabScore : TableauDeScore ; var fichierMeilleursScores : Text);

implementation

procedure EcrireFichierTexte (vitesseEvo:Boolean; vitesse : Integer; TabScore : TableauDeScore ; var fichierMeilleursScores : Text);
var k : integer;

begin

if vitesseEvo then // si la vitesse est évolutive on assigne le fichier ScoresP.txt
begin
	Assign(fichierMeilleursScores, 'ScoresP.txt'); 
end
else
begin
		Case vitesse of 

		// On assigne le fichier texte correspondant à la vitesse

		300 : Assign(fichierMeilleursScores, 'Scores1.txt'); 
		200 : Assign(fichierMeilleursScores, 'Scores2.txt');
		100 : Assign(fichierMeilleursScores, 'Scores3.txt');
	
		end;
end;
        rewrite(fichierMeilleursScores);
        for k := 1 to 10 do
            begin
            
            // on ecrit dans le fichier texte les scores 
            
            writeln(fichierMeilleursScores, ObtenirNomScore( TabScore[k]));  
            writeln (fichierMeilleursScores, ObtenirPointScore(TabScore[k]));
            
            end;
       close(fichierMeilleursScores);
end;

procedure ChargerScores(vitesseEvo:Boolean;vitesse : Integer; var TabScore : TableauDeScore); // on charge tout les scores (pseudo et nombre de point dans un tableau)
var 
	i, lueInt : Integer;
	lueStr : String;
	f : Text;
	
begin
if vitesseEvo then
begin
		Assign(f, 'ScoresP.txt'); // si la vitesse est évolutive on assigne le fichier ScoresP.txt
end
else
begin
	Case vitesse of 
	
	// On assigne le fichier texte correspondant à la vitesse
														
	300 : Assign(f, 'Scores1.txt');
	200 : Assign(f, 'Scores2.txt');
	100 : Assign(f, 'Scores3.txt');
	
	end;
end;
Reset(f);
for i := 1 to 20 do
	begin
	
	// on remplit le tableau grace au fichier texte
	
	Readln(f, lueStr);
	FixerNomScore(lueStr,TabScore[i]);	
	Readln(f, lueStr);
	Val(lueStr, lueInt);
	FixerPointScore(lueInt,TabScore[i]);
	
	end;
	
Close(f);
end;

procedure actualiserMeilleursScores( vitesseEvo:Boolean;vitesse : Integer; Nbpoint : Integer; nomJoueur : String; var TabScore : TableauDeScore);
var 
i, j : integer;
Ajout : Score;
fichierMeilleursScores : Text;
actualise: boolean;

begin
i := 1;
fixerPointScore(Nbpoint, Ajout);
fixerNomScore(nomJoueur, Ajout);
actualise:= false;

while (i <= 10) and (actualise=false) do
begin
if (ObtenirPointScore(Ajout) >= ObtenirPointScore(TabScore[i])) then //Ajout du Score au bon Endroit dans le tableau
        begin
        
        If obtenirNomScore(TabScore[i]) = ObtenirNomScore(Ajout) then // Si  le nom est le meme on modifie que le nombre de points
        begin
        FixerPointScore(ObtenirPointScore(Ajout),TabScore[i]);
        actualise:= true; // On arrette la boucle car le tableau est actualisé
        end
        
        else
        begin
        
        for j := 10 downto i do    
		// On décale les scores
		begin
		fixerPointScore(obtenirPointScore(TabScore[j-1]),TabScore[j]); 
        fixerNomScore(obtenirNomScore(TabScore[j-1]),TabScore[j]); 
        end;
            
        // On ajoute dans le tableau le score 
        FixerPointScore(ObtenirPointScore(Ajout),TabScore[i]);
        FixerNomScore(ObtenirNomScore(Ajout),TabScore[i]);
        actualise:= true; // On arrette la boucle car le tableau est actualisé
        end
        end
        
	else i:=i+1;
end;

EcrireFichierTexte(vitesseEvo,vitesse,TabScore, fichierMeilleursScores);

end;


end.
