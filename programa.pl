% Aquí va el código.

% Personas Parques y Atracciones
%Altura esta en centimetros

tiene(nina, joven, 22, 160).
tiene(marcos, ninio, 8, 132).
tiene(osvaldo, adolescente, 13, 129).

persona(nina, 22, 160).
persona(marcos, 8, 132).
persona(osvaldo, 13, 129).

perteneceAGrupoEtario(Persona, Grupo):-
    persona(Persona, Edad, _),
    grupoEtario(Grupo, Min, Max),
    between(Min, Max, Edad).
    

grupoEtario(ninio, 0, 12).
grupoEtario(adolescente, 13, 18).
grupoEtario(joven, 19, 30).
grupoEtario(adulto, 31, 100).

% Parque de la Costa

requisitos(trenFantasma, edad(12)).
requisitos(montaniaRusa, altura(130)).
% atraccion(maquinaTiquetera, altura(0)).

%Parque acuatico

% atraccion(NombreAtra, Persona).

requisitos(toboganGigante, altura(150)).
requisitos(piscinaDeOlas, edad(5)).
% atraccion(rioLento, Requisito(_)).



% parque(Atraccion)

tieneAtraccion(parqueDeLaCosta, trenFantasma).
tieneAtraccion(parqueDeLaCosta, montaniaRusa).
tieneAtraccion(parqueDeLaCosta, maquinaTiquetera).
tieneAtraccion(parqueAcuatico, toboganGigante).
tieneAtraccion(parqueAcuatico, piscinaDeOlas).
tieneAtraccion(parqueAcuatico, rioLento).

% Requerimientos

% Punto 1
puedeSubir(Persona, Atraccion):-
    tiene(Persona, _,_, _),
    tieneAtraccion(_, Atraccion),
    requisitos(Atraccion, Requisito),
    cumpleRequisitos(Persona, Requisito).
puedeSubir(Persona, Atraccion):-
    tiene(Persona, _,_, _),
    tieneAtraccion(_, Atraccion),
    not(requisitos(Atraccion, _)).
puedeSubir(Persona, Atraccion):-
    tiene(Persona, _,_, _),
    tieneAtraccion(_, Atraccion),
    forall(requisitos(Atraccion, Requisito), cumpleRequisitos(Persona, Requisito)).

cumpleRequisitos(Persona, altura(UnaAltura)):-
    tiene(Persona, _,_, Altura),
    Altura >= UnaAltura.
cumpleRequisitos(Persona, edad(EMinima)):-
    tiene(Persona, _,Edad, _),
    Edad >= EMinima.

% Punto 2

esParaElle(Parque, Persona):-
    tiene(Persona, _,_, _),
    tieneAtraccion(Parque, _),
    forall(tieneAtraccion(Parque, Atracciones), puedeSubir(Persona, Atracciones)).

% Punto 3


malaIdea(Grupo, Parque):-
    grupoEtario(Grupo, _, _),
    tieneAtraccion(Parque, _),
    forall(tieneAtraccion(Parque, Atracciones), algunoSeLaPierde(Grupo, Atracciones)).

juegoParaTodos(Grupo, Parque):-
   grupoEtario(Grupo, _, _),
    tieneAtraccion(Parque, Atraccion),
    not(algunoSeLaPierde(Grupo, Atraccion)).
    

algunoSeLaPierde(Grupo, Atraccion):-
    perteneceAGrupoEtario(Persona, Grupo),
    not(puedeSubir(Persona, Atraccion)).

% Punto 4 

programaLogico(Programa):-
    estanEnMismoParque(Programa),
    noHayRepetidos(Programa).

estanEnMismoParque(Programa):-
    tieneAtraccion(Parque,Atracciones),
    forall(member(Atraccion,Programa),member(Atraccion,Atracciones)).

noHayRepetidos([]).
noHayRepetidos([Cabeza|Cola]):-
    not(member(Cabeza, Cola)),
    noHayRepetidos(Cola).

% Alternativa
programaLogico2(Programa):-
    estanEnMismoParque(Programa),
    not(hayRepetidos(Programa)).

hayRepetidos([X|XS]):- member(X,XS).
hayRepetidos([_|XS]):- hayRepetidos(XS).