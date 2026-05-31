# Metodologia de proves

## 1. Enfocament general

Les proves del projecte es van realitzar de forma manual dins de l'entorn d'execució de Garry's Mod,
donat que no existeix un framework de testing automatitzat per a addons de Lua en aquesta plataforma.

Cada sistema es va provar de forma independent abans d'integrar-lo amb la resta de mòduls.

## 2. Entorn de proves

| Paràmetre          | Valor                                      |
|--------------------|--------------------------------------------|
| Plataforma         | Garry's Mod (partida local, mode sandbox)  |
| Mode de joc        | Un jugador (singleplayer)                  |
| Eines de debug     | Consola de Garry's Mod, prints de Lua      |

## 3. Sistemes provats

### 3.1 Core Survival System
- Verificació que les tres estadístiques es degraden als ritmes correctes.
- Comprovació que la mort s'activa quan qualsevol estadística arriba a 0.
- Prova de totes les combinacions de derrota (mort per salut, per gana, per energia).

### 3.2 Movement Event System
- Comprovació que la distància es mesura correctament.
- Verificació que els events s'activen en assolir la distància objectiu.
- Prova de generació d'events consecutius sense errors.

### 3.3 Safe Spawn System
- Verificació que les entitats no apareixen dins de geometria sòlida.
- Prova de la distància mínima de 120 unitats respecte al jugador.
- Comprovació que el sistema reintenta fins a 10 vegades en posicions invàlides.

### 3.4 Difficulty Manager
- Verificació de l'escalat de dificultat per minuts.
- Comprovació que els enemics correctes apareixen en cada fase de temps.
- Prova que la salut dels enemics augmenta correctament amb el nivell.

### 3.5 Combat Reward System
- Verificació que la munició es reomple en eliminar un enemic.
- Comprovació que el sistema detecta correctament la mort dels NPCs.

### 3.6 Client HUD System
- Verificació que les barres reflecteixen correctament els valors actuals.
- Comprovació de l'animació Lerp de les barres.
- Prova del sistema de notificacions Rainbow.

## 4. Problemes detectats durant les proves

| ID  | Sistema afectat     | Problema detectat                                              |
|-----|---------------------|----------------------------------------------------------------|
| E01 | Safe Spawn System   | Entitats apareixien dins de geometria sòlida                   |
| E02 | Safe Spawn System   | Entitats s'instanciaven sobre el jugador causant empentes      |

## 5. Resultats obtinguts

- El sistema de supervivència funciona de forma estable en partides de durada estàndard.
- El Safe Spawn System resol correctament els problemes de col·lisió en la gran majoria de casos.
- La dificultat progressiva genera una corba de pressió creixent que manté l'interès del jugador.
- El HUD es mostra correctament i reflecteix l'estat del jugador en temps real.