:- dynamic known/3, multivalued/1.

% Enter your KB below this line:
recommend(Cafe) :-
    % the cafe's rating is at least the base rating
    ask_base_rating(BaseRating),
    rating(Cafe, Rating), Rating >= BaseRating,

    % the cafe's budget matches the user's budget
    ask_budget(Budget),
    budget(Cafe, CafeBudget), budget_match(Budget, CafeBudget),
    
    % the cafe's distance is within the user's walking distance
    ask_distance(Distance),
    distance_walking(Cafe, CafeDistance), distance_match(Distance, CafeDistance),
    
    % the cafe is work-friendly (or not, depending on user preference)
    ask_work_friendly(WorkFriendly),
    work(Cafe, WorkFriendly),
    
    % the cafe has wifi (or not, depending on user preference)
    ask_wifi(WifiFriendly),
    wifi(Cafe, WifiFriendly),
    
    % the cafe has options for dietary restrictions (or not, depending on user preference)
    ask_dietary(DietaryFriendly),
    dietary_restrictions(Cafe, DietaryFriendly),
    
    % the cafe accepts card payments (or not, depending on user preference)
    ask_card_payment(CardFriendly),
    card_payment(Cafe, CardFriendly),
    
    % the cafe is the user's preferred size
    ask_size(Size),
    size(Cafe, Size).

% Budget matching predicate
% Here we implement a menu-based budget matching system
% The user can choose from 3 budget ranges: 1-10, 10-20, 20-30
% Note that the budget is not an exact match, but a maximum value
% For example, if the user chooses 1-10, the cafe's budget can be 10 or less
budget_match(1, Budget) :- Budget =< 10.
budget_match(2, Budget) :- Budget =< 20.
budget_match(3, Budget) :- Budget =< 30.

% Distance matching predicate
% Here we implement another menu-based distance matching system
% The user can choose from 4 distance ranges: 1-10, 10-20, 20-30, >30
distance_match(1, Distance) :- Distance >= 1, Distance =< 10.
distance_match(2, Distance) :- Distance > 10, Distance =< 20.
distance_match(3, Distance) :- Distance > 20, Distance =< 30.
distance_match(4, Distance) :- Distance > 30.

% Asking clauses
ask_base_rating(BaseRating) :-
    write('What is the minimum base rating of the cafe you want to go to (0-5)? '),
    read(BaseRating),
    assertz(known(yes, base_rating, BaseRating)).

ask_budget(Budget) :-
    known(yes, budget, Budget), !.
ask_budget(Budget) :-
    write('What is your budget?'), nl,
    write('1. 1-10 euros'), nl,
    write('2. 10-20 euros'), nl,
    write('3. 20-30 euros'), nl,
    read(Budget),
    assertz(known(yes, budget, Budget)).

ask_distance(Distance) :-
    known(yes, distance, Distance), !.
ask_distance(Distance) :-
    write('What is the maximum distance (walking) you are willing to travel to the cafe? '),
    write('1. 1-10 minutes'), nl,
    write('2. 10-20 minutes'), nl,
    write('3. 20-30 minutes'), nl,
    write('4. >30 minutes'), nl,
    read(Distance),
    assertz(known(yes, distance, Distance)).

ask_work_friendly(WorkFriendly) :-
    known(yes, work_friendly, WorkFriendly), !.
ask_work_friendly(WorkFriendly) :-
    write('Do you want to work there (Y/N)? '),
    read(WorkFriendly),
    assertz(known(yes, work_friendly, WorkFriendly)).

ask_wifi(WifiFriendly) :-
    known(yes, wifi, WifiFriendly), !.
ask_wifi(WifiFriendly) :-
    write('Do you need wifi (Y/N)? '),
    read(WifiFriendly),
    assertz(known(yes, wifi, WifiFriendly)).

ask_dietary(DietaryFriendly) :-
    known(yes, dietary, DietaryFriendly), !.
ask_dietary(DietaryFriendly) :-
    write('Do you have any dietary restrictions (Y/N)? '),
    read(DietaryFriendly),
    assertz(known(yes, dietary, DietaryFriendly)).

ask_card_payment(CardFriendly) :-
    known(yes, card_payment, CardFriendly), !.
ask_card_payment(CardFriendly) :-
    write('Do you need to pay by card (Y/N)? '),
    read(CardFriendly),
    assertz(known(yes, card_payment, CardFriendly)).

ask_size(Size) :-
    known(yes, size, Size), !.
ask_size(Size) :-
    write('What size cafe would you like to go to (S, M, or L)? '),
    read(Size),
    assertz(known(yes, size, Size)).

% Sample cafe data
cafe(blumental).
name(blumental, blumental).
rating(blumental, 4.4).
budget(blumental, 15).
work(blumental, "Y").
wifi(blumental, "Y").
dietary_restrictions(blumental, "Y").
card_payment(blumental, "Y").
size(blumental, "L").
distance_walking(blumental, 5).

cafe(cafe_le_vent).
name(cafe_le_vent, cafe_le_vent).
rating(cafe_le_vent, 4.7).
budget(cafe_le_vent, 5).
work(cafe_le_vent, "N").
wifi(cafe_le_vent, "N").
dietary_restrictions(cafe_le_vent, "N").
card_payment(cafe_le_vent, "N").
size(cafe_le_vent, "S").
distance_walking(cafe_le_vent, 2).

cafe(cocina_cafe).
name(cocina_cafe, cocina_cafe).
rating(cocina_cafe, 4.4).
budget(cocina_cafe, 5).
work(cocina_cafe, "Y").
wifi(cocina_cafe, "Y").
dietary_restrictions(cocina_cafe, "Y").
card_payment(cocina_cafe, "Y").
size(cocina_cafe, "L").
distance_walking(cocina_cafe, 3).

cafe(cafe_am_engelbecken).
name(cafe_am_engelbecken, cafe_am_engelbecken).
rating(cafe_am_engelbecken, 4.1).
budget(cafe_am_engelbecken, 15).
work(cafe_am_engelbecken, "Y").
wifi(cafe_am_engelbecken, "Y").
dietary_restrictions(cafe_am_engelbecken, "Y").
card_payment(cafe_am_engelbecken, "Y").
size(cafe_am_engelbecken, "L").
distance_walking(cafe_am_engelbecken, 13).

cafe(exclusive_coffee_bruckenstrasse).
name(exclusive_coffee_bruckenstrasse, exclusive_coffee_bruckenstrasse).
rating(exclusive_coffee_bruckenstrasse, 4.6).
budget(exclusive_coffee_bruckenstrasse, 5).
work(exclusive_coffee_bruckenstrasse, "Y").
wifi(exclusive_coffee_bruckenstrasse, "Y").
dietary_restrictions(exclusive_coffee_bruckenstrasse, "Y").
card_payment(exclusive_coffee_bruckenstrasse, "Y").
size(exclusive_coffee_bruckenstrasse, "L").
distance_walking(exclusive_coffee_bruckenstrasse, 14).

cafe(bonanza_coffee_roasters).
name(bonanza_coffee_roasters, bonanza_coffee_roasters).
rating(bonanza_coffee_roasters, 4.3).
budget(bonanza_coffee_roasters, 5).
work(bonanza_coffee_roasters, "Y").
wifi(bonanza_coffee_roasters, "N").
dietary_restrictions(bonanza_coffee_roasters, "Y").
card_payment(bonanza_coffee_roasters, "Y").
size(bonanza_coffee_roasters, "L").
distance_walking(bonanza_coffee_roasters, 12).

cafe(cafe_tres).
name(cafe_tres, cafe_tres).
rating(cafe_tres, 4.6).
budget(cafe_tres, 5).
work(cafe_tres, "Y").
wifi(cafe_tres, "Y").
dietary_restrictions(cafe_tres, "Y").
card_payment(cafe_tres, "Y").
size(cafe_tres, "S").
distance_walking(cafe_tres, 12).

cafe(kaffee_buro).
name(kaffee_buro, kaffee_buro).
rating(kaffee_buro, 4.6).
budget(kaffee_buro, 5).
work(kaffee_buro, "N").
wifi(kaffee_buro, "N").
dietary_restrictions(kaffee_buro, "Y").
card_payment(kaffee_buro, "N").
size(kaffee_buro, "S").
distance_walking(kaffee_buro, 15).

cafe(mano_cafe).
name(mano_cafe, mano_cafe).
rating(mano_cafe, 4.6).
budget(mano_cafe, 5).
work(mano_cafe, "Y").
wifi(mano_cafe, "N").
dietary_restrictions(mano_cafe, "Y").
card_payment(mano_cafe, "N").
size(mano_cafe, "L").
distance_walking(mano_cafe, 22).

cafe(cafe_m).
name(cafe_m, cafe_m).
rating(cafe_m, 4.7).
budget(cafe_m, 5).
work(cafe_m, "Y").
wifi(cafe_m, "Y").
dietary_restrictions(cafe_m, "Y").
card_payment(cafe_m, "Y").
size(cafe_m, "S").
distance_walking(cafe_m, 40).

cafe(cafe_bravo).
name(cafe_bravo, cafe_bravo).
rating(cafe_bravo, 4).
budget(cafe_bravo, 15).
work(cafe_bravo, "Y").
wifi(cafe_bravo, "Y").
dietary_restrictions(cafe_bravo, "Y").
card_payment(cafe_bravo, "Y").
size(cafe_bravo, "L").
distance_walking(cafe_bravo, 50).

cafe(yuna).
name(yuna, yuna).
rating(yuna, 4.8).
budget(yuna, 15).
work(yuna, "Y").
wifi(yuna, "Y").
dietary_restrictions(yuna, "Y").
card_payment(yuna, "Y").
size(yuna, "L").
distance_walking(yuna, 41).

cafe(espresso_house).
name(espresso_house, espresso_house).
rating(espresso_house, 3.8).
budget(espresso_house, 5).
work(espresso_house, "Y").
wifi(espresso_house, "Y").
dietary_restrictions(espresso_house, "Y").
card_payment(espresso_house, "Y").
size(espresso_house, "L").
distance_walking(espresso_house, 50).

cafe(cafe_berio).
name(cafe_berio, cafe_berio).
rating(cafe_berio, 4.2).
budget(cafe_berio, 15).
work(cafe_berio, "Y").
wifi(cafe_berio, "Y").
dietary_restrictions(cafe_berio, "Y").
card_payment(cafe_berio, "N").
size(cafe_berio, "L").
distance_walking(cafe_berio, 79).

cafe(galetterie_cafe).
name(galetterie_cafe, galetterie_cafe).
rating(galetterie_cafe, 4.2).
budget(galetterie_cafe, 15).
work(galetterie_cafe, "N").
wifi(galetterie_cafe, "N").
dietary_restrictions(galetterie_cafe, "Y").
card_payment(galetterie_cafe, "N").
size(galetterie_cafe, "L").
distance_walking(galetterie_cafe, 11).

cafe(cafe_zur_alten_zicke).
name(cafe_zur_alten_zicke, cafe_zur_alten_zicke).
rating(cafe_zur_alten_zicke, 4.5).
budget(cafe_zur_alten_zicke, 5).
work(cafe_zur_alten_zicke, "N").
wifi(cafe_zur_alten_zicke, "N").
dietary_restrictions(cafe_zur_alten_zicke, "Y").
card_payment(cafe_zur_alten_zicke, "N").
size(cafe_zur_alten_zicke, "S").
distance_walking(cafe_zur_alten_zicke, 28).

cafe(cafe_am_petriplatz).
name(cafe_am_petriplatz, cafe_am_petriplatz).
rating(cafe_am_petriplatz, 4.5).
budget(cafe_am_petriplatz, 15).
work(cafe_am_petriplatz, "N").
wifi(cafe_am_petriplatz, "N").
dietary_restrictions(cafe_am_petriplatz, "N").
card_payment(cafe_am_petriplatz, "N").
size(cafe_am_petriplatz, "L").
distance_walking(cafe_am_petriplatz, 24).

cafe(cuccuma).
name(cuccuma, cuccuma).
rating(cuccuma, 4.4).
budget(cuccuma, 5).
work(cuccuma, "Y").
wifi(cuccuma, "Y").
dietary_restrictions(cuccuma, "Y").
card_payment(cuccuma, "N").
size(cuccuma, "M").
distance_walking(cuccuma, 44).

cafe(ahorn).
name(ahorn, ahorn).
rating(ahorn, 4.2).
budget(ahorn, 15).
work(ahorn, "Y").
wifi(ahorn, "Y").
dietary_restrictions(ahorn, "Y").
card_payment(ahorn, "Y").
size(ahorn, "M").
distance_walking(ahorn, 38).

cafe(cafe_brick).
name(cafe_brick, cafe_brick).
rating(cafe_brick, 4.7).
budget(cafe_brick, 15).
work(cafe_brick, "N").
wifi(cafe_brick, "Y").
dietary_restrictions(cafe_brick, "Y").
card_payment(cafe_brick, "N").
size(cafe_brick, "M").
distance_walking(cafe_brick, 46).

cafe(the_greens).
name(the_greens, the_greens).
rating(the_greens, 4.5).
budget(the_greens, 15).
work(the_greens, "Y").
wifi(the_greens, "Y").
dietary_restrictions(the_greens, "Y").
card_payment(the_greens, "Y").
size(the_greens, "M").
distance_walking(the_greens, 5).

cafe(cafe_neundrei).
name(cafe_neundrei, cafe_neundrei).
rating(cafe_neundrei, 4.6).
budget(cafe_neundrei, 15).
work(cafe_neundrei, "N").
wifi(cafe_neundrei, "N").
dietary_restrictions(cafe_neundrei, "Y").
card_payment(cafe_neundrei, "Y").
size(cafe_neundrei, "M").
distance_walking(cafe_neundrei, 9).

% Main predicate to start the recommendation process
main :-
    write('Welcome to the Cafe Recommendation System!'), nl,
    findall(Cafe, recommend(Cafe), Recommendations),
    (Recommendations \= [] ->
        nth0(0, Recommendations, FirstCafe),
        write('The recommended cafe: '), write(FirstCafe), nl
    ;
        write('No cafes match your preferences.'), nl
    ).

:- main.