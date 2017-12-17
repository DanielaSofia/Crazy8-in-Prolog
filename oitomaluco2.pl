:- use_module(oito_maluco).
%começa daqui para baixo a segunda parte do trabalho
% 
%distribui cartas para um jogador1 e jogador2   
hand_player1(X):-deal(_,X,_).
hand_player2(X):-deal(_,_,X).
    
%nextplayer(X1,X2) onde é verdade se X2 é o proximo jogador
nextplayer(p1,p2).
nextplayer(p2,p1).

utility([p1,win,_],1).
utility([p2,win,_],-1).

%maoqueganhajogo
%winHand(P,NewHand):-player(P),length(NewHand,0). 

min_to_move([p2,_,_]). %minplayer
max_to_move([p1,_,_]). %maxplayer

play:-nl,write('==================='),nl,
         write('====Oito Maluco===='),nl,
		 write('==================='),nl,playPlayerNumber.

  playPlayerNumber:-
    nl,write('Which player do you want to be? Player 1(p1) or Player 2(p2)?'),
    nl,read(Player),nl,
    (
     Player \= p1, Player \= p2,     
      write('Error: not a valid player!'),nl,
      %pergunta outra vez).
      playPlayerNumber,!;

       playing([p1,play,Deck],Player);  playing([p2,play,Deck],Player)
      ). 

playing([p1,play,Deck],Player):-hand_player1(Deck),Player = p1,write(Deck).
playing([p2,play,Deck],Player):- hand_player2(Deck),Player = p2,write(Deck).