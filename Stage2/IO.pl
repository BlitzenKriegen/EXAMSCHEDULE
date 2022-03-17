write_to_file(File,Text) :-
	open(File, write, Stream),
	write(Stream, Text), nl,
	close(Stream).

%readFile processes an input file and
%turns it into form 
%L=[[Item1,Item2],[Item3,Item4]...].
read_file(File) :-
	open(File, read, Stream),
	readLoop(Stream,Tokens),
	close(Stream),
	processList(Tokens,CourseList),
	write(CourseList).

%processList takes in a list and cordons
%its members into elements, taking a list
%of form L=[Item1,Item2,...,Item(n)] and
%processing it to turn into
%L=[[Item1,Item2],[Item3,Item4]...].
processList([],[]).
processList(Tokens,CourseList):-
	buildCourse(Tokens,TokensLeft,Course),
	processList(TokensLeft,Rest),CourseList=[Course|Rest].

buildCourse([H|T],TokensLeft,Course):-
	setUpCourse(H,CompCourse),
	readTillNoNum(T,TokensLeft,SL),
	completeCourse(CompCourse,SL,Course).

completeCourse((X,_),Y,(X,Y)).

readTillNoNum([],_,[]).
readTillNoNum([H|T],TokensLeft,SL):-
	atom_number(H,NumVal),readTillNoNum(T,TokensLeft,Rest),SL=[NumVal|Rest];
	TokensLeft = [H|T],SL=[].

makeEqual(X,X).

addToList(X,[],[X]).
addToList(Head,Tail,[Head|Tail]).

setUpCourse(H,(H,[])).
makeMember(H,[H]).
	
%atom_number(H,NumValue),write("up here\n"),!;
%write("down here\n"),!.

%Using two SWI pre-defined functions and
%one user defined function, readLoop() takes
%in a file input, removes the whitespace and
%any empty space to place it all inside one list.
%This takes the form L=[Item1,Item2,...,Item(n)]

readLoop(Stream,String):-
	read_string(Stream,_,Lines),
	split_string(Lines, "\t\n", "",Output),
	remover("",Output,String).

%These functors are taken from an online source
%(https://stackoverflow.com/questions/60919189/prolog-remove-element-from-list).
%The use of this functor in the program is to remove empty space that exist as
%elements in the list created by readLoop.
remover( _, [], []).
remover( R, [R|T], T2) :- remover( R, T, T2).
remover( R, [H|T], [H|T2]) :- H \= R, remover( R, T, T2).

%turnToElm() takes an input and puts it into
%an array.
turnToElm(X,[X]).