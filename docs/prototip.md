# Evolució del prototip

## 1. Idea inicial

La idea de partida era crear un joc de supervivència minimal dins de Garry's Mod. Les premisses inicials
eren senzilles:

- El jugador ha de mantenir-se viu.
- Hi ha estadístiques que es degraden amb el temps.
- El jugador pot morir de diverses maneres.

En la seva versió més bàsica, el prototip inicial consistia en un sistema de salut i un timer
de degradació, sense events ni enemics escalats.

## 2. Decisions de disseny fonamentals

### 2.1 Moviment com a motor de joc

La decisió més rellevant de disseny va ser basar tot el sistema d'events en el **moviment real del jugador**
en lloc d'un sistema de timer passiu o de menús d'acció.

Aquesta decisió va tenir les implicacions següents:
- El jugador és recompensat per explorar activament.
- El joc manté el ritme sense necessitat d'interacció de menú.
- S'elimina la possibilitat d'esperar passivament per recuperar estadístiques sense cost.

### 2.2 Arquitectura modular

En lloc d'un fitxer únic, es va optar per separar el codi en sistemes independents amb responsabilitats
clarament definides. Això va permetre:

- Debugar cada sistema per separat.
- Modificar un sistema sense afectar els altres.
- Escalar el projecte afegint nous mòduls.

### 2.3 Safe Spawn System

Durant les proves inicials, es va detectar que les entitats podien aparèixer dins de geometria sòlida o
sobreposades al jugador, causant errors de col·lisió. Això va derivar en el disseny del sistema Safe Spawn
amb fins a 10 intents de posicionament i validació per raycast.

### 2.4 Recompensa de combat

Per evitar que el jugador quedés sense munició i el joc es tornés injugable, es va afegir la mecànica de
reompliment de munició en eliminar un enemic. Aquesta decisió prioritza el ritme de combat per sobre del
realisme.

### 2.5 HUD amb Lerp i notificacions Rainbow

Es va optar per animar les barres del HUD amb interpolació (Lerp) per donar una sensació visual fluida.
Les notificacions amb colors progressius (efecte rainbow) aporten feedback visual immediat sense necessitat
de text emergent.

## 3. Evolució per fases

| Fase | Contingut                                                                 |
|------|---------------------------------------------------------------------------|
| 1    | Sistema bàsic de salut i degradació temporal                              |
| 2    | Afegida estadística de gana i energia                                     |
| 3    | Implementació del Movement Event System                                   |
| 4    | Aparició d'entitats de recursos (menjar, llits, botiquins)                |
| 5    | Integració d'enemics amb NPCs natius de Half-Life 2                       |
| 6    | Implementació del Difficulty Manager amb escalat per temps                |
| 7    | Disseny i implementació del Safe Spawn System                             |
| 8    | Afegida la recompensa de combat (reompliment de munició)                  |
| 9    | Implementació del HUD amb barres animades i notificacions                 |
| 10   | Refactorització, documentació i preparació per a l'entrega                |

> **Nota**: L'ordre i el contingut exactes de cada fase poden variar respecte al desenvolupament real.
## 4. Canvis importants respecte a la idea inicial

| Canvi                              | Motiu                                                        |
|------------------------------------|--------------------------------------------------------------|
| Eliminació del suport multijugador | Complexitat tècnica fora de l'abast del projecte             |
| Eliminació de l'inventari          | Simplificació del model de joc per mantenir el focus         |
| Afegit Safe Spawn System           | Necessitat detectada durant les proves de col·lisió          |
| Canvi a events per moviment        | Millora del ritme de joc respecte als events per timer       |
| Botiquí condicional (<50% salut)   | Evitar que el jugador acumuli salut innecessàriament         |