% Author:
% Date: 09/11/2014

%provides warnings based on the weatherstatus
warning(WeatherStatus):-
     WeatherStatus== -1
                     ->write('Weather is normal, continue with normal activities'),nl;
     WeatherStatus==0
                     ->write('There is a tropical storm!'),nl,
                     write('\tListen to the radio for information on what is happening.'),nl,
                     write('\tThis storm could develop into a hurricane'),nl,
                     write('\tPrepare a hurricane survival kit'),nl,
                     write('\t\tStore clean water in large containers'),nl,
                     write('\t\tKeep at least a 7 day supply of non-perishable foods'),nl,
                     write('\t\tStock up on clean water & canned foods'),nl,
                     write('\t\tPrepare a first aid kit'),nl,
                     write('\t\tStock up on basic tools, (batteries, candles, knives,lanterns)'),nl,
                     write('\t\tStore sanitation supplies (soap ,toilet paper, disinfectant'),nl;
     WeatherStatus==1
                     ->write('There is a category 1 hurricane!'),nl,
                     write('\tDuring a hurricane:'),nl,
                     write('\t\tStay inside at all times.'),nl,
                     write('\t\tBe prepared for materials to fall from the ceiling.'),nl,
                     write('\t\tIf the house shows signs of breaking up, stay under a table or stand in a sturdy closet.'),nl,
                     write('\t\tListen to the radio for information on what is happening.'),nl,
                     write('Ensure your hurricane survival kit is properly stocked and readily accessible.'),nl;
     WeatherStatus==2
                     ->write('There is a category 2 hurricane!'),nl,
                     write('\tDuring a hurricane:'),nl,
                     write('\t\tStay inside at all times.'),nl,
                     write('\t\tBe prepared for materials to fall from the ceiling.'),nl,
                     write('\t\tIf the house shows signs of breaking up, stay under a table or stand in a sturdy closet.'),nl,
                     write('\t\tListen to the radio for information on what is happening.'),nl,
                     write('Ensure your hurricane survival kit is properly stocked and readily accessible.'),nl;
     WeatherStatus==3
                     ->write('There is a category 3 hurricane!'),nl,
                     write('\tDuring a hurricane:'),nl,
                     write('\t\tStay inside at all times.'),nl,
                     write('\t\tBe prepared for materials to fall from the ceiling.'),nl,
                     write('\t\tIf the house shows signs of breaking up, stay under a table or stand in a sturdy closet.'),nl,
                     write('\t\tListen to the radio for information on what is happening.'),nl,
                     write('Ensure your hurricane survival kit is properly stocked and readily accessible.'),nl;
     WeatherStatus==4
                     ->write('There is a category 4 hurricane!'),nl,
                     write('\tDuring a hurricane:'),nl,
                     write('\t\tStay inside at all times.'),nl,
                     write('\t\tBe prepared for materials to fall from the ceiling.'),nl,
                     write('\t\tIf the house shows signs of breaking up, stay under a table or stand in a sturdy closet.'),nl,
                     write('\t\tListen to the radio for information on what is happening.'),nl,
                     write('\tEnsure your hurricane survival kit is properly stocked and readily accessible.'),nl;
     WeatherStatus==5
                     ->write('There is a category 5 hurricane!'),nl,
                     write('\tDuring a hurricane:'),nl,
                     write('\t\tStay inside at all times.'),nl,
                     write('\t\tBe prepared for materials to fall from the ceiling.'),nl,
                     write('\t\tIf the house shows signs of breaking up, stay under a table or stand in a sturdy closet.'),nl,
                     write('\t\tListen to the radio for information on what is happening.'),nl,
                     write('\tEnsure your hurricane survival kit is properly stocked and readily accessible.'),nl.

