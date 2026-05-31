# Idea del projecte

## 1. Idea original

La idea original del projecte va sorgir de la voluntat de crear un microvideojoc de supervivència funcional
dins de l'entorn de **Garry's Mod**, aprofitant les capacitats de scripting en **Lua** que ofereix la
plataforma i els recursos natius del motor **Source Engine** (NPCs, entitats físiques, sistema de jugador).

La proposta partia d'un concepte senzill però exigent: un joc de supervivència sense menús, sense inventari
tradicional i sense victòria formal, on el jugador havia de mantenir-se viu el màxim temps possible
gestionant tres estadístiques bàsiques (salut, gana i energia) alhora que explorava el mapa per generar
esdeveniments.

El nom complet del projecte és **Survival Decision Game: Minimal Life Loop (Progressive Chaos Edition)**,
títol que reflecteix les dues mecàniques centrals: el bucle minimal de vida i la dificultat que augmenta
progressivament.

## 2. Objectius del projecte

- Implementar un sistema de supervivència funcional dins de Garry's Mod com a addon de Lua.
- Dissenyar una mecànica d'exploració basada en el moviment real del jugador, sense menús ni botons.
- Crear un sistema de dificultat progressiva que augmenti automàticament amb el temps de partida.
- Integrar els NPCs natius de Half-Life 2 com a sistema d'enemics escalat.
- Aprendre a estructurar un projecte Lua modular amb sistemes independents comunicats.
- Aplicar bones pràctiques de documentació tècnica i control de versions amb GitHub.

## 3. Abast previst

El projecte es va delimitar en els aspectes següents:

### Dins de l'abast
- Sistema de gestió de tres estadístiques: salut, gana i energia.
- Degradació automàtica de les estadístiques amb temporitzadors.
- Sistema d'events activats per la distància recorreguda pel jugador.
- Aparició d'entitats de recursos (menjar, llits, botiquins) dins del món del joc.
- Sistema Safe Spawn per evitar aparicions dins de geometria.
- Combat amb NPCs natius de Half-Life 2.
- Escalat de dificultat per temps de partida.
- HUD amb barres animades i notificacions visuals.
- Arquitectura modular amb sistemes separats per responsabilitat.

### Fora de l'abast
- Suport multijugador.
- Inventari tradicional.
- Sistema de progressió RPG (experiència, nivells de personatge).
- IA enemiga personalitzada.
- Múltiples mapes o escenaris propis.