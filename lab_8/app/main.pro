implement main
    open core, console, string

domains
    dateOfBirth = dateOfBirth(integer Day, integer Month, integer Year).
    job = job(string Place, integer Salary).
    person = person(string FirstName, string LastName, dateOfBirth Date, job Work).
    personList = person*.

class facts - familyDB
    family : (person, person, personList).
    father40unemployed : (person).

constants
    currentYear = 2017.

class predicates
    reconsult : (string FileName).
clauses
    reconsult(FileName) :-
        retractFactDB(familyDB),
        file::consult(FileName, familyDB).

class predicates
    childrenString : (personList Input) -> string.
clauses
    childrenString([]) = String :-
        String = "".

    childrenString([X1]) = String :-
        String = personToString(X1).

    childrenString([X1, X2 | Y1]) = String :-
        String = concat(personToString(X1), " \n\t\t", childrenString([X2 | Y1])).

class predicates
    childrenIncome : (personList Input) -> integer.
clauses
    childrenIncome([]) = In :-
        In = 0.

    childrenIncome([X1 | Y1]) = Sum :-
        person(_, _, _, job(_, X)) = X1,
        Sum = X + childrenIncome(Y1).

class predicates
    childrenCount : (personList Input) -> integer.
clauses
    childrenCount([]) = Count :-
        Count = 0.

    childrenCount([_ | Y1]) = Count :-
        Count = childrenCount(Y1) + 1.

class predicates
    personToString : (person) -> string.
clauses
    personToString(Person) = String :-
        person(F, L, dateOfBirth(_, _, Y), job(J, In)) = Person,
        String = concat(concat(F, " ", L), concat(" (", toString(currentYear - Y), " р.) ["), concat(J, " - ", concat(toString(In), " $]"))).

class predicates
    father : (string Job, integer Year, person Father [out], person Mother [out], personList Children [out]) nondeterm.
clauses
    father(Job, Year, Father, Mother, Children) :-
        family(Father, Mother, Children),
        person(_, _, dateOfBirth(_, _, Fy), job(Fj, _)) = Father,
        Job = Fj,
        currentYear - Fy < Year.

clauses
    run() :-
        init(),
        reconsult("..\\facts.src"),
        fail.

    run() :-
        write("\nDatabase:"),
        father40unemployed(F),
        write("\n", personToString(F)),
        fail.

    run() :-
        write("\n\nДохід на одного члена сім'ї, в якій не працює батько, якому менше 40 років:"),
        father("unemployed", 40, Father, Mother, Children),
        assert(father40unemployed(Father)),
        Father = person(_, Fl, _, job(_, Fin)),
        Mother = person(_, _, _, job(_, Min)),
        write("\n\nСім'я: ", Fl),
        write("\n\tБатько: ", personToString(Father)),
        write("\n\tМати: ", personToString(Mother)),
        write("\n\tДіти: \n\t\t", childrenString(Children)),
        write("\n\tДохід на особу: ", (Min + Fin + childrenIncome(Children)) / (childrenCount(Children) + 2)),
        fail.

    run() :-
        write("\n\nDatabase:"),
        father40unemployed(F),
        write("\n", personToString(F)),
        fail.

    run() :-
        retract(father40unemployed(_)),
        fail.

    run() :-
        write("\n\nDatabase:"),
        father40unemployed(F),
        write("\n", personToString(F)),
        fail.

    run() :-
        _ = readLine().

end implement main

goal
    mainExe::run(main::run).
