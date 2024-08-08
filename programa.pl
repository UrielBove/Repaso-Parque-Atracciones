% Aquí va el código.

% Personas Parques y Atracciones
%Altura esta en centimetros

tiene(nina, 22, 160).
tiene(marcos, 8, 132).
tiene(osvaldo, 13, 129).


atraccion(trenFantasma, Requisito(Edad)):-
    tiene(Persona, Edad, _),
    Edad >= 12.

atraccion(montaniaRusa, Requisito(Altura)):-
    tiene(Persona, _, Altura),
    Altura > 130 .

atraccion(maquinaTiquetera, Requisito(_)).

%Parque acuatico

% atraccion(NombreAtra, Persona).

atraccion(toboganGigante, Requisito(Altura)):-
    tiene(Persona, _, Altura),
    Altura >= 150.

atraccion(rioLento, Requisito(_)).

atraccion(piscinaDeOlas, Requisito(Edad)):-
    tiene(Persona, Edad, _),
    Edad >= 5.

% parque(Atraccion)

parqueDeLaCosta(atraccionNom(trenFantasma, montaniaRusa, maquinaTiquetera), Persona).
parqueAcuatico(atraccionNom(toboganGigante, rioLento, piscinaDeOlas), Persona).


% Requerimientos

% Punto 1
puedeSubir(Persona, Atraccion):-
    tiene(Persona, _, _),
    atraccion(Atraccion, Persona).

% Punto 2

esParaElle(Parque, Persona):-
    tiene(Persona, _, _),
    forall(Parque(_, Persona), puedeSubir(Persona, _)).