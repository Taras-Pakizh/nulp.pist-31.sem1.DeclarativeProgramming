implement main
    open core, console

domains
    list = string*.

class facts - vocabularyDB
    replace : (string In, string Out).

class predicates
    convertToString : (list Input) -> string Output.
clauses
    convertToString([]) = "".

    convertToString([X1]) = X1.

    convertToString([X1, X2 | Y1]) = String :-
        X3 = string::concat(X1, " "),
        String = string::concat(X3, convertToString([X2 | Y1])).

class predicates
    transformation : (list First, list Second [out]) determ.
clauses
    transformation([], []).

    transformation([X1 | Y1], [X2 | Y2]) :-
        replace(X1, X2),
        transformation(Y1, Y2),
        !.

    transformation([X1 | Y1], [X2 | Y2]) :-
        replace(X2, X1),
        transformation(Y1, Y2),
        !.

    transformation([X1 | Y1], [X1 | Y2]) :-
        transformation(Y1, Y2).

clauses
    replace("a", "b").
    replace("c", "d").
    replace("?", "!").

clauses
    run() :-
        init(),
        fail.

    run() :-
        Sentence = readLine(),
        StrList = string::split(Sentence, ", "),
        writef("%\n", Sentence),
        transformation(StrList, StrList2),
        writef("%\n", StrList2),
        Sentence1 = convertToString(StrList2),
        writef("%\n", Sentence1),
        fail.

    run() :-
        write("End\n"),
        _ = readLine().

end implement main

goal
    mainExe::run(main::run).
