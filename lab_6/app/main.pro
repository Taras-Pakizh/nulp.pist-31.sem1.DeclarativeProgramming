implement main
    open core, console

domains
    gender = female; male.
    person = string.

class predicates
    person : (person Name, gender Gender) nondeterm.
    father : (person Person, person Father [out]) nondeterm.
    grandMother : (person Person [out], person GrandMother [out]) nondeterm.
    father_in_law : (person Person, person FatherInLaw [out]) nondeterm.

class facts
    married : (person Man, person Woman).
    child : (person Child, person Father, person Mother).

clauses
    father(Person, Father) :-
        child(Person, Father, _).

    grandMother(Person, GrandMother) :-
        child(Person, Parent, _),
        child(Parent, _, GrandMother)
        or
        child(Person, _, Parent),
        child(Parent, _, GrandMother).

    father_in_law(Person, FatherInLaw) :-
        married(Person, Woman),
        child(Woman, FatherInLaw, _).

    person("Anton", male()).

    person("Andrew", male()).

    person("Peter", male()).

    person("George", male()).

    person("Adolf", male()).

    person("Kate", female()).

    person("Maria", female()).

    person("Lisa", female()).

    person("Kira", female()).

    person("Elisabet", female()).

    married("Anton", "Kate").

    married("Andrew", "Maria").

    married("Peter", "Lisa").

    married("George", "Kira").

    married("Adolf", "Elisabet").

    child("Lisa", "Anton", "Kate").

    child("Andrew", "Anton", "Kate").

    child("Peter", "Andrew", "Maria").

    child("Kira", "Andrew", "Maria").

    child("Adolf", "Anton", "Kate").

clauses
    run() :-
        write("Всі баби: "),
        nl,
        grandMother(_, _),
        write(" - Баба ", GrandMother),
        nl,
        fail.

    run() :-
        nl,
        write("Введіть ім'я: "),
        Name = readLine(),
        father(Name, Father),
        write("Батько ", Name, " - ", Father),
        nl,
        fail.

    run() :-
        nl,
        write("Введіть ім'я: "),
        Name = readLine(),
        father_in_law(Name, Father),
        write("Тесть ", Name, " - ", Father),
        nl,
        fail.

    run() :-
        _ = readLine().

end implement main

goal
    console::runUtf8(main::run).
