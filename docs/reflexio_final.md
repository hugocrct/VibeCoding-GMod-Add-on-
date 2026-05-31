# Reflexió final

## 1. Valoració personal del projecte

El projecte **Survival Decision Game: Minimal Life Loop (Progressive Chaos Edition)** ha representat un
repte tècnic i creatiu significatiu. Desenvolupar un videojoc funcional com a addon de Garry's Mod implica
treballar dins d'un entorn poc convencional, amb una API específica i una arquitectura client-servidor que
no és habitual en el desenvolupament de videojocs tradicionals.

El resultat final és un producte jugable que compleix els objectius inicials: un sistema de supervivència
minimal, mecàniques de joc coherents i una dificultat progressiva que genera tensió creixent.

[PENDENT: afegir valoració personal més específica sobre el procés i el resultat]

## 2. Dificultats trobades

### 2.1 Entorn de desenvolupament atípic

Garry's Mod no és un motor de videojocs convencional. La documentació oficial és incompleta en molts
aspectes i gran part del coneixement es troba en fòrums de la comunitat i en el codi font d'altres addons.
Adaptar-se a la filosofia de GLua i als hooks del motor va requerir un temps d'aprenentatge inicial
considerable.

### 2.2 Arquitectura client-servidor obligatòria

GMod separa obligatòriament el codi en parts de servidor i client. Gestionar la comunicació entre ambdues
parts, especialment per al HUD i les notificacions, va requerir entendre el sistema `net` i la seva
forma de passar dades entre contextos d'execució.

### 2.3 Problemes de col·lisió en l'aparició d'entitats

La generació d'entitats en posicions vàlides va ser un dels problemes tècnics més complexos. El
resultat va ser el disseny del Safe Spawn System, que va requerir comprendre el sistema de traces i
raycasts del Source Engine.

### 2.4 Escalat de dificultat equilibrat

Trobar el ritme adequat d'escalat perquè el joc sigui desafiador però no injust va requerir diverses
iteracions i sessions de prova.

[PENDENT: afegir altres dificultats específiques trobades durant el desenvolupament]

## 3. Coneixements adquirits

- Programació en **Lua** i **GLua** (API de Garry's Mod).
- Comprensió de l'arquitectura client-servidor de Source Engine.
- Ús del sistema de hooks de GMod per respondre a esdeveniments del motor.
- Implementació de sistemes de raycasting per a validació de posicions.
- Disseny modular de sistemes de joc independents.
- Gestió de projectes amb control de versions Git i GitHub.
- Documentació tècnica de projectes de programació.
- Ús d'eines d'IA com a suport al desenvolupament (veure `evidencies/us_ia.md`).

## 4. Possibles millores futures

| Millora                         | Descripció                                                         |
|---------------------------------|--------------------------------------------------------------------|
| Suport multijugador             | Adaptar els sistemes per funcionar en servidors amb múltiples jugadors |
| Inventari tradicional           | Afegir un sistema d'inventari per gestionar recursos recollits     |
| Nous tipus de recursos          | Ampliar la varietat d'objectes interactius al mapa                 |
| Sistema de puntuació persistent | Guardar el millor temps de supervivència entre sessions            |
| Mapes personalitzats            | Dissenyar mapes propis optimitzats per al sistema d'events         |
| IA enemiga personalitzada       | Substituir els NPCs natius per comportaments propis                |
| Sistema de so ambiental         | Afegir efectes de so que reforcin la tensió progressiva            |
| Pantalla de resultats           | Mostrar estadístiques detallades en acabar la partida              |

## 5. Conclusió

Aquest projecte ha demostrat que és possible construir un videojoc complet i coherent dins d'una plataforma
no convencional com Garry's Mod, aprofitant les seves capacitats de scripting. La combinació de mecàniques
simples però ben integrades ha donat lloc a un producte amb una identitat pròpia i una experiència de joc
reconeixible.

Durant aquest projecte m'he adonat de com canvia la forma de programació quan treballes sobre un joc, ja que complica molt les coses. A diferència del que havia fet fins ara, aquí cada decisió afecta directament l'experiència del jugador en temps real, cosa que fa que els errors es notin de forma immediata i siguin difícils d'ignorar. Això m'ha obligat a ser més meticulós i a pensar no només en si el codi funciona, sinó en com se sent quan l'executes.