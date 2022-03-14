% Project Leads: Kiril, Johann and Shiraz.
% Project: Prolog Implementation of an imperative scheduler.
% Details: TBD
%
%

% TODO FOR ENTIRE PROGRAM:
%		-We need to implement the data structures for rooms, classes and graphs.
%		-We need to implement the functions to process input data.
%		-We need to implement functions to read in files.
%		-We need to implement output of data structures.
%

:-include('Data_Struct.pl').

% user_intro will simply grab user input for the
% number of timeslots that will be used for the
% graph structure. This will likely be revised as
% the body of a "main" function.
%
% TODO: User input and processing.
user_intro:- see("data.txt"), write('Read worked').


% read_file will read in an input file and process it
% by error checking its information before putting it
% inside one of the data structures used in the program
% (class, room structure).
%
% TODO: Implement this function in its entirety
% read_file(fileName, List):-

% user_output will write to the console the resulting graph
% structure to the console (ie a successful schedule). If this
% failed to occour however, an error message will instead be
% printed.
%
% TODO: Implementation of reading out the graph structure members
user_outro:- write('Schedule of the classes: \n').