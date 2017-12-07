implement main
    open core, console, string

domains
    dateOfBirth = dateOfBirth(integer Day, integer Month, integer Year).
    job = job(string Place, integer Salary).
    person = person(string FirstName, string LastName, dateOfBirth Date, job Work).
    personList = person*.

class facts - familyDB
    family : (person, person, personList).

constants
    currentYear = 2017.

class predicates
    reconsult : (string FileName).
clauses
    reconsult(FileName) :-
        retractFactDB(familyDB),
        file::consult(FileName, familyDB).

class predicates
    childrenString : (personList Input [in], string Output [out]).
clauses
    childrenString([], "").

    childrenString([X1], X) :-
        person(F, L, dateOfBirth(_, _, Y), job(J, In)) = X1,
        X = concat(concat(F, " ", L), concat(" (", toString(currentYear - Y), " р.) ["), concat(J, " - ", concat(toString(In), " $]"))),
        !.

    childrenString([X1 | Y1], String) :-
        childrenString(Y1, Str),
        person(F, L, dateOfBirth(_, _, Y), job(J, In)) = X1,
        Child = concat(concat(F, " ", L), concat(" (", toString(currentYear - Y), " р.) ["), concat(J, " - ", concat(toString(In), " $]"))),
        String = concat(Child, " \n\t\t", Str).

class predicates
    childrenIncome : (personList Input [in], integer Output [out]).
clauses
    childrenIncome([], 0).

    childrenIncome([X1], Sum) :-
        person(_, _, _, job(_, Sum)) = X1,
        !.

    childrenIncome([X1 | Y1], Sum) :-
        person(_, _, _, job(_, X)) = X1,
        childrenIncome(Y1, Y),
        Sum = X + Y.

class predicates
    childrenCount : (personList Input [in], integer Output [out]).
clauses
    childrenCount([], 0).

    childrenCount([_], 1) :-
        !.

    childrenCount([_ | Y1], Count) :-
        childrenCount(Y1, Y),
        Count = Y + 1.

clauses
    run() :-
        init(),
        reconsult("..\\facts.src"),
        fail.

    run() :-
        write("Дохід на одного члена сім'ї, в якій не працює батько, якому менше 40 років:"),
        Job = "unemployed",
        Year = 40,
        family(Father, Mother, Children),
        person(Mf, Ml, dateOfBirth(_, _, My), job(Mj, Min)) = Mother,
        person(Ff, Fl, dateOfBirth(_, _, Fy), job(Fj, Fin)) = Father,
        Job = Fj,
        currentYear - Fy < Year,
        childrenString(Children, C),
        childrenIncome(Children, Cin),
        childrenCount(Children, Cc),
        write("\n\nСім'я: ", Fl),
        write("\n\tБатько: ", Ff, " ", Fl, " (", currentYear - Fy, " р.) [", Fj, " - ", Fin, " $]"),
        write("\n\tМати: ", Mf, " ", Ml, " (", currentYear - My, " р.) [", Mj, " - ", Min, " $]"),
        write("\n\tДіти: \n\t\t", C),
        write("\n\tДохід на особу: ", (Min + Fin + Cin) / (Cc + 2)),
        fail.

    run() :-
        _ = readLine().

end implement main

goal
    mainExe::run(main::run).
