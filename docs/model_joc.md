# Model de joc

## 1. Descripció general

**Survival Decision Game: Minimal Life Loop (Progressive Chaos Edition)** és un microvideojoc de
supervivència en primera persona desenvolupat com a addon per a Garry's Mod. El joc no té una narrativa
explícita: el jugador apareix en un mapa i ha de sobreviure el màxim temps possible mentre les condicions
empitjoren progressivament.

## 2. Mecàniques principals

### 2.1 Sistema de supervivència (Core Survival System)

El jugador disposa de tres estadístiques que es degraden automàticament:

| Estadística | Rang  | Degradació                                      |
|-------------|-------|-------------------------------------------------|
| Salut       | 0–100 | No es degrada sola; es redueix per combat       |
| Gana        | 0–100 | -1 punt cada 2 segons                           |
| Energia     | 0–100 | -1 punt cada 4 segons                           |

Si qualsevol de les tres estadístiques arriba a 0, el jugador mor i la partida finalitza.

### 2.2 Exploració basada en moviment (Movement Event System)

El sistema monitoritza contínuament la distància recorreguda pel jugador. Quan s'assoleix una distància
objectiu aleatòria, s'activa un nou esdeveniment que pot generar:

- Recursos interactius (menjar, llits, botiquins).
- Aparició d'enemics.

Aquesta mecànica elimina la necessitat de menús o accions manuals per generar contingut, i incentiva
l'exploració constant del mapa.

### 2.3 Recursos interactius

Tots els recursos apareixen com a entitats físiques dins del món. Per interactuar-hi s'utilitza la tecla `E`.

| Recurs              | Efecte                        | Condició d'aparició                   |
|---------------------|-------------------------------|---------------------------------------|
| Menjar              | +35 de gana                   | Sense condició específica             |
| Llit / Matalàs      | +30 d'energia                 | Sense condició específica             |
| Botiquí militar     | Recupera salut                | Només si el jugador té < 50% de salut |

### 2.4 Sistema Safe Spawn Anti-Stuck

Per evitar errors de col·lisió en l'aparició d'entitats:

- Fins a 10 intents de posicionament automàtic.
- Comprovació de posicions vàlides amb traces i raycasts.
- Distància mínima de 120 unitats respecte al jugador.
- Bloqueig d'aparicions dins de geometria sòlida o sota el jugador.

### 2.5 Combat i dificultat progressiva (Difficulty Manager)

La dificultat augmenta automàticament cada minut de partida:

| Temps de partida | Enemics disponibles                    |
|------------------|----------------------------------------|
| Minut 0          | Headcrab, Zombie                       |
| Minut 1          | Variants addicionals                   |
| Minut 2          | Zombie Fast                            |
| Minut 3          | Poison Zombie                          |
| Minut 4+         | Caps i combinacions avançades          |
| Partides llargues| Antlion Guard i variants escalades     |

Cada minut:
- Augmenta el nivell global de dificultat.
- Incrementa la salut dels enemics.
- Augmenta el nombre d'enemics simultanis permesos.
- Es desbloquegen tipus d'enemics més avançats.

### 2.6 Recompensa de combat (Combat Reward System)

Quan el jugador elimina un enemic, es reomple tota la munició de les seves armes. Això garanteix un ritme
de combat continu sense necessitat de buscar munició al mapa.

### 2.7 HUD (Client HUD System)

El HUD mostra en tot moment les tres estadístiques del jugador mitjançant barres animades amb interpolació
(Lerp). Inclou un sistema de notificacions visuals de color progressiu (Rainbow) per indicar estats
importants.

## 3. Interacció del jugador

| Tecla          | Acció                              |
|----------------|------------------------------------|
| W / A / S / D  | Moviment del personatge            |
| Espai          | Saltar                             |
| Ratolí         | Controlar la càmera / apuntar      |
| Clic esquerre  | Atacar / disparar                  |
| E              | Interactuar amb recursos           |

## 4. Condicions de victòria i derrota

### Victòria
No existeix una condició de victòria formal. El rendiment del jugador es mesura per:

- Temps total de supervivència.
- Nombre de minuts superats.
- Nivell de dificultat assolit.

### Derrota
La partida finalitza quan qualsevol de les estadístiques bàsiques (salut, gana o energia) arriba a 0.

## 5. Arquitectura de sistemes

El projecte segueix una arquitectura modular amb sis sistemes independents:

| Sistema                  | Responsabilitat                                              |
|--------------------------|--------------------------------------------------------------|
| Core Survival System     | Gestió de salut, gana, energia i mort del jugador            |
| Movement Event System    | Mesura de distància i activació d'esdeveniments              |
| Difficulty Manager       | Escalat de dificultat, oleades i selecció de NPCs            |
| Safe Spawn System        | Validació de posicions d'aparició amb raycasts               |
| Combat Reward System     | Detecció de baixes enemigues i reompliment de munició        |
| Client HUD System        | Representació visual d'estadístiques i notificacions         |