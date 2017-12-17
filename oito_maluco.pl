:-module(oito_maluco,[deck/1,colorcard/2,card/1,ranks/1,suits/1,rankshigher/2,
samesuit/2,color/2,colorofcard/2,printcard/1,newdeck/1,deckshuffle/2,
deckdeal/3,remove_list/3,dealer/3,deal/3]).

%baralho
deck(Z):-findall(c(X,Y),card(c(X,Y)),Z).  

%cor_da_carta
colorofcard(vermelho,c(_,Y)):-Y=copas;Y=ouros.
colorofcard(preto,c(_,Y)):-Y=paus;Y=espadas.

%definicao_de_carta
card(c(X,Y)):-ranks(Z),suits(W),member(X,Z),member(Y,W).

%valor_em_relacao_umas_as_outras
ranks([2,3,4,5,6,7,8,9,10,valete,dama,rei,as]).
suits([copas,ouros,espadas,paus]).
rankshigher(X,Y):-ranks(Z),append(_,[Y|W],Z),member(X,W).

%verifica_se_sao_do_mesmo_naipe
samesuit(c(_,Y),c(_,Y)).

%cor_das_cartas_de_cada_naipe
color(copas,vermelho).
color(ouros,vermelho).
color(espadas,preto).
color(paus,preto).

colorcard(C,c(X,Y)):-color(Y,C),ranks(L),member(X,L).

%imprime a carta
printcard(c(X,Y)):-format('~a de ~a~n',[X,Y]).

%novo_baralho
newdeck(Deck):- Suits=[copas,ouros,espadas,paus],Ranks=[2,3,4,5,6,7,8,9,10,valete,dama,rei,as],
setof(c(X,Y),(member(Y,Ranks),member(X,Suits)),Deck).

%baralhar_as_cartas
deckshuffle(Deck,NewDeck):-deck(Deck),
length(Deck,NumDeck_I),
findall(X,(between(1,NumDeck_I,Value), X is random(100)),Ord),
pairs_keys_values(Pairs,Ord,Deck),
keysort(Pairs,OrdPairs),pairs_values(OrdPairs,NewDeck).


deckdeal([X|Y],X,Y).
%printdeck(Deck):-maplist(printcard,Deck),deck(Deck).

%remover elementos comuns de duas listas
remove_list([], _, []).
remove_list([X|Tail], L2, Result):- member(X, L2), !, remove_list(Tail, L2, Result). 
remove_list([X|Tail], L2, [X|Result]):- remove_list(Tail, L2, Result).
rm_subset(L1, L2, L1).
rm_subset(L1, L2, L):-remove_list(L1, L2, L),!.

trim([],0,[]).  
trim([L1|L],0,[L1|L]) .    
trim([],N,[]) . 
trim([L1|L],N,R) :- !, N >= 1,! ,  N1 is N-1,! ,trim(L,N1,R).         
  
%distrib1uiçao_inicial_das_cartas
dealer([],[],[]).
dealer([C1,C2|Cards],[C1|H1],[C2|H2]) :-
   trim(Cards, 42 , H1),remove_list(Cards,H1,Result),
   length(Result,R),
   trim(Result,34, H2).
  
deal(_,A,B) :- deck(Deck),dealer(Deck,A,B). 


