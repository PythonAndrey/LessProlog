% account(НомерСчета, ДеньОткрытия, МесяцОткрытия, ГодОткрытия,
%         ФИОКлиента, СуммаВклада, Процент).

account(1001, 5, 10, 2026, "Ivanov Ivan Ivanovich", 1500000, 8).
account(1002, 12, 10, 2026, "Petrov Petr Petrovich", 500000, 7).
account(1003, 18, 9, 2026, "Sidorov Sidor Sidorovich", 2000000, 9).
account(1004, 2, 10, 2026, "Ivanova Anna Sergeevna", 300000, 6).
account(1005, 22, 8, 2026, "Petrova Maria Ivanovna", 1200000, 8).

% Работники банка.
bank_employee("Petrov Petr Petrovich").
bank_employee("Smirnov Alexey Olegovich").


% Руководство: ФИО и должность.
bank_manager("Smirnov Alexey Olegovich", "director").
bank_manager("Orlova Elena Viktorovna", "chief accountant").

% Текущий месяц — октябрь.
current_month(10).

% Вклад с начисленными процентами.
% X — клиент, Y — сумма вклада вместе с процентами за год.
deposit_with_interest(X, Y) :-
	account(_, _, _, _, X, Amount, Rate),
	Y is round(Amount*(1 + Rate/100)).

% Вклад руководителя банка.
% X — руководитель, Y — сумма его вклада вместе с процентами.
manager_deposit(X, Y) :-
	bank_manager(X, _),
	deposit_with_interest(X, Y).

% Состоятельный клиент: сумма вклада не меньше миллиона.
wealthy_client(X) :-
	account(_, _, _, _, X, Amount, _),
	Amount >= 1000000.

% Извлечь фамилию из строки ФИО вида "Фамилия Имя Отчество".
opened_this_month(FullName) :-
	account(_, _, Month, _, FullName, _, _),
	current_month(Month).


% Среди клиентов есть работник банка.
client_is_bank_employee(FullName) :-
	account(_, _, _, _, FullName, _, _),
	bank_employee(FullName).


% Пара разных клиентов-однофамильцев. 
clients_with_same_surname(Name1, Name2, Surname) :-
	account(_, _, _, _, Name1, _, _),
	account(_, _, _, _, Name2, _, _),
	Name1 @< Name2,
	surname(Name1, Surname),
	surname(Name2, Surname).

%  Команды запросы

% ?- deposit_with_interest(X, Y).
% ?- manager_deposit(X, Y).
% ?- wealthy_client(X).
% ?- opened_this_month(FullName), surname(FullName, Surname).
% ?- client_is_bank_employee(FullName).
% ?- clients_with_same_surname(Name1, Name2, Surname).

% Запуск программы в Terminale swipl -s .\bank.pl 

%  Выход команда halt.