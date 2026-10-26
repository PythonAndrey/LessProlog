% Члены клуба:
% club_member(Фамилия, День, Месяц, Год вступления, Профессия).

club_member("Ivanov", 10, 2, 2013, "pharmacist").
club_member("Roshkov", 12, 5, 2012, "CHP").
club_member("Semenov", 17, 3, 2012, "doctor").
club_member("Lobanov", 21, 1, 2014, "CHP").
club_member("Ivanchuk", 18, 7, 2011, "police").
club_member("Glebova", 2, 9, 2011, "cosmetologist").
club_member("Shukshin", 27, 8, 2012, "police").
club_member("Semenova", 17, 3, 2012, "lawyer").
club_member("Ufimcev", 2, 9, 2013, "unemployed").

wife("Semenova", "Semenov").
wife("Glebova", "Korovin").

husband("Semenov", "Semenova").

companies_sponsors("Roshkov").
companies_sponsors("Lobanov").
companies_sponsors("Tihonov").

activists_club("Glebova", 2, 9, 2011).
activists_club("Ivanchuk", 18, 7, 2011).
activists_club("Roshkov", 12, 5, 2012).

% Текущая дата: день, месяц, год.
data(16, 2, 2014).

% Супруги, оба указанные как пара друг для друга.
married(X, Y) :-
	wife(X, Y),
	husband(Y, X).

% Новички, вступившие в клуб в текущем году.
new_club(X) :-
	club_member(X, _, _, JoinYear, _),
	data(_, _, CurrentYear),
	JoinYear =:= CurrentYear.

% Стаж активиста в годах на текущий год.
stash(X, Years) :-
	activists_club(X, _, _, JoinYear),
	data(_, _, CurrentYear),
	Years is CurrentYear - JoinYear.

% Пары коллег с одинаковой профессией.
colleagues(X, Y) :-
	club_member(X, _, _, _, Job),
	club_member(Y, _, _, _, Job),
	X \= Y.

% Член клуба, который указан среди спонсоров.
sponsor_member(X) :-
	club_member(X, _, _, _, _),
	companies_sponsors(X).

% Члены клуба, у которых профессия — unemployed.
unemployed_member(X) :-
	club_member(X, _, _, _, "unemployed").