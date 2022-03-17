:- module(myModule, [newCourse/2, withAdjacent/2, isNotEmpty/1, getThird/2, getFourth/2, getSecond/2,writeCourse/1, getFirst/2]).

course(Name, StudentIdSet, Adj, TimeSlot).


newCourse((Name,Ids), Course):-
    Course = course(Name,Ids,_,_).

withAdjacent(_, []).
withAdjacent(Course, [Courses|OtherCourses]):-
    Course =.. List, getThird(List, StudentIdSet),Courses =.. List2, getThird(List2, StudentIdSet2),
    intersection(StudentIdSet, StudentIdSet2, CommonID), (isNotEmpty(CommonID), getFourth(List, Adj),
    append([Courses], Adj, NewAdj), Adj = NewAdj, withAdjacent(Course, OtherCourses));withAdjacent(Course, OtherCourses).

myWrite([]).
myWrite([X]):-  X =.. List, getSecond(List,ClassName), write(ClassName),nl.
myWrite([X|Xs]):- X =.. List, getSecond(List,ClassName), write(ClassName),nl ,myWrite(Xs).
writeCourse(Course):-
    Course =.. List, getSecond(List, CourseName), write(CourseName), write(" Adjacent Classes:"),nl, getFourth(List, Adj), myWrite(Adj).


isNotEmpty([_|_]).
getThird([_,_,Z|_], Z).
getFourth([_,_,_,Z|_], Z).
getSecond([_,Z|_],Z).
getFirst([Z|_],Z).
