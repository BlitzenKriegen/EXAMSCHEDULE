:-include('Data_Struct.pl').

write_to_file(File,Text) :-
	open(File, write, Stream),
	write(Stream, Text), nl,
	close(Stream).
	
read_file(File) :-
	open(File, read, Stream),
	readLoop(Stream,String),
	write(String),
	close(Stream).

%I think the best solution here is for some sort of
%readline function that then places what its read into
%a list.

readLoop(Stream,String):-
	readRec(Stream, String),
	write(String),
	addToTail(String,oldStruct,Struct),
	makeEquivalent(oldStruct,Struct),
	write(Struct).

readRec(Stream, String):-
	get_char(Stream, Ch),
	write(Ch),
	(
	  Ch = end_of_file,String = [],!;
	  Ch = '\n',String = [],!;
	  Ch = '\t',readRec(Stream,String),!;
	  readRec(Stream, Rest),String=[Ch|Rest]
	).

addToTail(X,[],[X]).
addToTail(X,[_|YT],[_|ZT]):- addToTail(X,YT,ZT).
addToTail(X,[_|YT],[]):- addToTail(X,YT,[]).

makeEquivalent(X,X).
