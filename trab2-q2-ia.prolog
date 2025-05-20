% Definindo os valores possíveis para Str (condição da rua)
street_condition(dry).
street_condition(wet).
street_condition(snow_covered).

% Probabilidades a priori (como no item c)
0.5::str(dry).
0.4::str(wet).
0.1::str(snow_covered).

0.15::fiw(t).  % Volante desgastado
0.85::fiw(f).  % Volante não desgastado

0.98::bulb(t). % Lâmpada ok
0.02::bulb(f). % Lâmpada queimada

0.95::cable(t). % Cabo ok
0.05::cable(f). % Cabo danificado

% Regras para R (deslizamento do dínamo)
0.3::r(t) :- str(dry), fiw(t).
0.1::r(t) :- str(dry), fiw(f).
0.6::r(t) :- str(wet), fiw(t).
0.2::r(t) :- str(wet), fiw(f).
0.8::r(t) :- str(snow_covered), fiw(t).
0.4::r(t) :- str(snow_covered), fiw(f).

% Regras para V (tensão do dínamo)
0.95::v(t) :- r(t).  % Se o dínamo está deslizando, alta probabilidade de tensão
0.1::v(t) :- r(f).   % Se não está deslizando, baixa probabilidade

% Regras para Li (luz ligada)
0.998::li(t) :- v(t), bulb(t), cable(t).
0.05::li(t) :- v(t), bulb(t), cable(f).
0.1::li(t) :- v(t), bulb(f), cable(t).
0.005::li(t) :- v(t), bulb(f), cable(f).
0.01::li(t) :- v(f), bulb(t), cable(t).
0.001::li(t) :- v(f), bulb(t), cable(f).
0.001::li(t) :- v(f), bulb(f), cable(t).
0.0::li(t) :- v(f), bulb(f), cable(f).

% Evidência para a consulta
evidence(str(snow_covered), true).

% Consulta para P(V | Str = snow_covered)
query(v(_)).
