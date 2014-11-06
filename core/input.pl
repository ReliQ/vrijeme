%%Vrijeme
%%input.pl

system('Vrijeme - v0.0.1').     %System info

write('Please Enter the following weather variables:').
humidity_input(Humidity,Status):-
                write('1.Humidity:'), read(Humidity), write ('%').
                
seaTemperature_input(Temperature,Status):-
                write('2.Sea Temperature:'), read(Temperature), write ('^C').
                
airPressure_input(Pressure,Status):-
                write('3.Pressure:'), read(Pressure).
                
windspeed_input(Speed,Status):-
                               write('4.Wind Speed (m/s):'), read(Speed).