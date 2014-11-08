%%      Vrijeme - v0.0.0
%%      main.pl 

:- [base, input]. 


run:-
    system(X),
    string_concat('Welcome to ', X, WelcomeMessage),
    write(WelcomeMessage), nl, write('Select Option:'), nl,
    write('1. Information Input'), nl, write('2. View History'), nl,
    write('3. Get Prediction'), nl,
    write('-| Choice: '), read(Choice), doOption(Choice).
      
      
doOption(Choice):-
    integer(Choice),
    string_concat('time to do...', Choice, X), nl,
    (Choice == 1 -> getInput; write(X)).

