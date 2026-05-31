# 02_informe_proves_i_ajusts.md

# Informe de Proves i Ajustos

## 1. Introducció

Aquest document recull el procés de validació, detecció d'errors i aplicació de correccions realitzat durant el desenvolupament de l'addon de supervivència per a Garry's Mod.

L'objectiu principal de les proves ha estat verificar el correcte funcionament del sistema d'esdeveniments aleatoris, la generació d'entitats, la interacció amb objectes recuperables, el comportament dels NPCs enemics i la qualitat visual de les notificacions mostrades al jugador.

Durant les diferents sessions de test s'han identificat diversos problemes relacionats amb la generació d'entitats, la lògica condicional del sistema de supervivència i la seguretat dels punts d'aparició. Cada incidència ha estat analitzada, diagnosticada i resolta mitjançant modificacions específiques del codi.

---

## 2. Historial de Bugs i Diagnòstics

### 2.1. Entitats invisibles durant la generació aleatòria

#### Descripció del problema

Durant les primeres proves de camp es va detectar que només apareixien físicament els llits de descans (`ent_survival_bed`) i els NPCs enemics. Les entitats de menjar (`ent_survival_food`) i els botiquins no es generaven de forma visible al mapa.

#### Diagnòstic tècnic

Es van identificar dues causes independents:

##### Botiquins

El sistema incorporava una protecció que bloquejava completament la seva aparició quan la salut del jugador era igual o superior a 50 punts. Això provocava que, durant les proves realitzades amb la salut completa, la probabilitat efectiva de generació fos del 0%.

##### Menjar

Es van detectar dues possibles fonts del problema:

- Percentatge de generació massa baix dins de la taula RNG.
- Desvinculació o corrupció dels fitxers de l'entitat:
  - `shared.lua`
  - `init.lua`
  - `cl_init.lua`

En aquesta situació, el sistema seleccionava correctament l'esdeveniment, però no podia crear físicament l'objecte al món.

---

### 2.2. Bloqueig del jugador per aparicions incorrectes

#### Descripció del problema

Durant desplaçaments prolongats pel mapa, alguns objectes i NPCs apareixien exactament sota el jugador o massa a prop de la seva posició. Aquesta situació provocava:

- Col·lisions immediates.
- Bloquejos del moviment.
- Encallament dins de la geometria del mapa.

#### Diagnòstic tècnic

La funció original `FindSpawnPoint()` presentava diverses limitacions:

- No validava una distància mínima respecte al jugador.
- Acceptava punts excessivament propers després del `TraceHull`.
- El vector de reserva (*fallback*) conservava la component vertical de la mirada del jugador.

Com a conseqüència, alguns objectes podien aparèixer parcialment enterrats o directament sota els peus del jugador.

---

### 2.3. Visibilitat insuficient de les notificacions

#### Descripció del problema

Les notificacions inicials utilitzaven:

```lua
PrintMessage(HUD_PRINTTALK)
```

Aquest sistema mostrava els avisos exclusivament al xat lateral.

Durant situacions amb molts enemics o esdeveniments simultanis, els missatges passaven fàcilment desapercebuts.

#### Diagnòstic tècnic

La limitació no estava relacionada amb la xarxa ni amb el sistema d'esdeveniments, sinó amb el canal visual utilitzat per comunicar informació crítica al jugador.

---

## 3. Proves de Consola Realitzades

### 3.1. Verificació del sistema de botiquins

Per comprovar el funcionament dels condicionals de salut sense esperar una situació real de combat, es va utilitzar una prova controlada mitjançant la consola del joc.

#### Comanda executada

```lua
lua_run Entity(1):SetHealth(30)
```

#### Objectiu

Reduir artificialment la salut del jugador per sota del llindar dels 50 punts i verificar que la lògica de generació dels botiquins s'activava correctament.

#### Resultat

La prova va confirmar que:

- El bloqueig anterior desapareixia.
- El sistema tornava a permetre la generació de botiquins.
- Es reproduïa correctament el so:

```text
items/suitchargeok1.wav
```

- L'entitat apareixia al món de forma funcional.

#### Conclusió

La lògica de generació era correcta i el problema estava exclusivament relacionat amb el llindar de salut configurat.

---

## 4. Solucions Tècniques Aplicades

### 4.1. Reequilibri del sistema RNG

Per augmentar la freqüència de proves i validar correctament el comportament del sistema, es va modificar la taula de probabilitats de `sv_survival_events.lua`.

#### Ajustos realitzats

- Increment de la probabilitat de menjar fins al 30%.
- Repartiment més agressiu dels esdeveniments.
- Millora de la capacitat de test durant sessions curtes.

---

### 4.2. Reconstrucció de l'entitat de menjar

Es van reconstruir completament els fitxers associats a:

```text
lua/entities/ent_survival_food/
```

#### Fitxers revisats

```text
shared.lua
init.lua
cl_init.lua
```

#### Millores implementades

- Restauració del registre correcte de l'entitat.
- Generació física funcional.
- Model visual *Takeout Carton*.
- Sistema d'etiqueta 3D2D informativa.
- Compatibilitat amb el sistema de supervivència.

---

### 4.3. Redisseny de l'algoritme de Spawn

Per eliminar els bloquejos i encallaments es va modificar completament el sistema de cerca de posicions vàlides.

#### Canvis aplicats

##### Increment d'intents

Es va augmentar el nombre de comprovacions a:

```text
10 intents de cerca
```

##### Distància mínima de seguretat

Qualsevol punt situat a menys de:

```text
120 unitats
```

del jugador és descartat immediatament.

#### Nova regla

```lua
continue
```

si la distància mínima no es compleix.

##### Correcció del vector de reserva

Es va anul·lar la component vertical:

```lua
forward.z = 0
```

Això garanteix que els objectes apareguin sempre en un pla horitzontal respecte al jugador.

#### Resultat

- Eliminació dels objectes enterrats.
- Eliminació dels NPCs sota el jugador.
- Reducció significativa dels encallaments.
- Major estabilitat durant les sessions de joc.

---

### 4.4. Sistema avançat de notificacions HUD

Es va substituir el sistema basat en xat per una comunicació client-servidor específica.

#### Implementació

Creació del canal de xarxa:

```lua
Survival_RainbowMsg
```

#### Característiques

- Posicionament superior central.
- Tipografia personalitzada:

```text
SurvivalHUD_3D
```

- Colors Rainbow dinàmics.
- Animació basada en HSV.
- Actualització contínua amb:

```lua
CurTime()
```

- Ombra negra de contrast.
- Efecte *Fade-Out* progressiu.

#### Verificació

Durant les proves es va confirmar el correcte funcionament dels avisos en:

- Eliminació d'enemics.
- Aparició de menjar.
- Activació d'emboscades.
- Esdeveniments de supervivència.

Els missatges apareixen de forma clara, visible i desapareixen automàticament sense interferir amb la jugabilitat.

---

## 5. Resum Executiu

| Problema | Causa Arrel | Solució Aplicada |
|-----------|-------------|------------------|
| Menjar no visible | Probabilitat baixa i possibles fitxers desvinculats | Reconstrucció de l'entitat i augment del RNG |
| Botiquins inexistents | Restricció de salut ≥ 50 | Validació amb proves controlades i confirmació del flux |
| Jugador encallat | Spawn massa proper o sota el jugador | Distància mínima de 120 unitats i nou algoritme de cerca |
| Notificacions poc visibles | Dependència del xat lateral | Sistema HUD Rainbow amb Net Messages |

---

## 6. Conclusions

Les proves realitzades han permès validar i estabilitzar els sistemes principals de l'addon de supervivència. Les incidències detectades han estat corregides mitjançant modificacions específiques en la generació d'entitats, la validació de posicions de spawn i la comunicació visual amb el jugador.

Després dels ajustos aplicats, el sistema presenta un comportament considerablement més robust, una experiència de joc més estable i una millor capacitat de comunicació dels esdeveniments de supervivència en temps real.