capital(X, Y):-country(X, _, Y, _, _, _).
all_capitals(List):-
            findall(X, country(_, _, X, _, _, _), List).
sum(0,[]).
sum(Total,[Head|Tail]):- sum(Sum,Tail), Total is Head + Sum.

rm_null([], []).
rm_null(L, L3):- conc(L1, [null|L2], L), 
                 conc(L1, R, L3), 
                 rm_null(L2, R).
                 
rm_null([H|R], [H|L]):- rm_null(R, L).

people_in_capitals(N):-
            findall(X, (country(_, Z, Y, _, _, _), 
                        city(Y, Z, _, X, _, _, _)), L), 
			rm_null(L, L1),
            sum(N, L1).
whoSpeaks(Lang, Country, NumOfSpeakers):-
                language(Code, Lang, Per),
                country(Country, Code, _, _, _, Population), 
                NumOfSpeakers is Per * Population / 100.
grant(Location):-
               (city(Location, _, _, _, Latitude, _, _),
                     Latitude \= null, 
                     Latitude > -38, 
                     Latitude < -36); 
                (island(Location, _, _, _, _, Latitude1, _), 
                     Latitude1 \= null, 
                     Latitude1 > -38, 
                     Latitude1 < -36).
holiday(Country, Neighbour):-
            country(Country, CountryCode, _, _, _, _),
            country(Neighbour, NeighbourCode, _, _, _, _),
            geo_sea(Sea, CountryCode, _), 
            geo_sea(Sea, NeighbourCode, _),
            (borders(CountryCode, NeighbourCode, _);
            borders(NeighbourCode, CountryCode, _)),
            Country \= null,
            Neighbour \= null,
            CountryCode \= null,
            NeighbourCode \= null,
            Country \= Neighbour,
            CountryCode \= NeighbourCode.
flows(X, Y):-river(X, FlowsToRiver, FlowsToLake, Y, _, _, _, _, _, _, _, _), 
                Y \= null.
flows(X, Z):-river(X, Y, FlowsToLake, _, _, _, _, _, _, _, _, _),
                 flows(Y, Z),
                 Y \= null.       
flows(X, Z):-river(X, _, Y, _, _, _, _, _, _, _, _, _),
                 flows(Y, Z),
                 Y \= null.
landlocked2(Country):-
                Country \= null,
                country(Country, Code, _, _, _, _),
                Code \= null,
                geo_sea(_, Code, _) \= true,
                ((borders(Code, Code1, _);
                  borders(Code1, Code, _)),
                 Code1 \= Code,
                 Code1 \= null,
                 geo_sea(_, Code1, _) \= true).
all_countries(L):- findall(X, (country(X, _, _, _, _, _), X \= null), L).                   % get all countrie' name

abs(X, Y, S):- X >= Y,                                                                      % absolutely minus
               S is X - Y.
abs(X, Y, S):- X < Y,  
               S is Y - X.           
               
find_most_similar_countries(_, [], _, 0, _).                                                % find most similar country
find_most_similar_countries(X, [H|R], Distance, Diff, L):- X \= H,                                  % when Distance larger than min
                                                 country(X, _, _, _, _, PopulationX),
                                                 country(H, _, _, _, _, PopulationH),
                                                 number(PopulationX),
                                                 number(PopulationH),
                                                 abs(PopulationX, PopulationH, S),
                                                 Distance =< S,
                                                 find_most_similar_countries(X, R, Distance, Diff, L).
find_most_similar_countries(X, [H|R], Distance, S, H):- X \= H,                                     % when Distance smaller than min
                                                 country(X, _, _, _, _, PopulationX),
                                                 country(H, _, _, _, _, PopulationH), 
                                                 number(PopulationX),
                                                 number(PopulationH),
                                                 abs(PopulationX, PopulationH, S),
                                                 Distance > S,
                                                 find_most_similar_countries(X, R, S, S, H).
                                                 
simpop(X, Y, Diff):- X \= Y,
                     all_countries(L), 
                     find_most_similar_countries(X, L, 9999999999, Diff, Y).