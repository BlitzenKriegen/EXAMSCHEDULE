% Project Leads: Kiril, Johann and Shiraz.
% Project: This is the data structure implementation
% of the imparative scheduler.
% Details: TBD

% TODO:
%		-Implement the Class structure.
%		-Implement the Room structure.
%		-Implement the Graph structure.

%IMPORTANT: list_delete and list_insert is code
%found on the internet. This is purely to get basic
%operations for list modification going.
list_delete(X, [X], []).
list_delete(X,[X|L1], L1).
list_delete(X, [Y|L2], [Y|L1]) :- list_delete(X,L2,L1).

list_insert(X,L,R) :- list_delete(X,R,L).

% class_info is the data structure that holds
% the information of both the class name as well
% as the student list of the class. These will be
% stored as a string and an int array, respectively.
class_info:- write('I am a stub!').

% room_info is the data structure that holds
% the information of both the room name as well
% as the capacity of said room. THis will be stored
% as a String and an integer respectively.
room_info:- write('I am a stub!').

% graph is the data structure that will eventually
% hold the imparative scheduler. More detail will be
% added in the future as I, kiril, cannot comment too
% much on what the graph will look like.
graph:- write('I am a stub!').