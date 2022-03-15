write_to_file(File,Text) :-
	open(File, write, Stream),
	write(Stream, Text), nl,
	close(Stream).
	
read_file(File) :-
	open(File, read, Stream),
	readRec(Stream, String),
	close(Stream),
	write(String).
	
%I think the best solution here is for some sort of
%readline function that then places what its read into
%a list.

readRec(Stream, String):-
	get_char(Stream, Ch),
	write(Ch),
	(
	  Ch = end_of_file,String = [],!,write('here1\n');
	  Ch = '\n',String = [],!,write('here2\n');
	  readRec(Stream, Rest),write('here3\n'),String=[Ch|Rest]
	).
