write_to_file(File,Text) :-
	open(File, write, Stream),
	write(Stream, Text), nl,
	close(Stream).
	
read_file(File) :-
	open(File, read, Stream),
	get_char(Stream,Char1),
	process_stream(Char1, Stream),
	close(Stream).
	
process_stream(end_of_file, _) :- !.

process_stream(Char, Stream) :-
	write(Char),
	get_char(Stream, Char2),
	process_stream(Char2, Stream).
	
%I think the best solution here is for some sort of
%readline function that then places what its read into
%a list.