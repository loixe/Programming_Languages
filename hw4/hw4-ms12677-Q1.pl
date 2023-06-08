engineer(brian).
engineer(kevin).
engineer(zhane).
manager(mary).
manager(emily).
senior_manager(sarah).
president(bob).
president(jane).
senior(mary, brian).
senior(jane, mary).
senior(jane, emily).
senior(emily, kevin).
senior(emily, zhane).
president_engineer_relation(X,Y) :- president(X), senior(X,Z), senior(Z,Y), engineer(Y).