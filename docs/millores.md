# Millores implementades

## 1. Introducció

Durant el desenvolupament del projecte es van identificar i implementar diverses millores respecte a la
concepció inicial. Aquestes millores responen a problemes detectats durant les proves, a decisions de
disseny revisades o a l'ampliació de funcionalitats per millorar l'experiència de joc.

## 2. Registre de millores

### Millora 1: Safe Spawn System

**Descripció**: Implementació d'un sistema de validació de posicions d'aparició per a entitats.

**Motiu**: Durant les proves inicials, les entitats de recursos i enemics apareixien dins de geometria
sòlida o sobre el jugador, causant errors de col·lisió i comportaments inesperats.

**Implementació**:
- Fins a 10 intents de posicionament per entitat.
- Validació per raycast i traces del motor.
- Distància mínima de 120 unitats respecte al jugador.
- Bloqueig d'aparicions sota el jugador o dins de sòlids.

**Resultat**: Eliminació pràctica dels errors de col·lisió en l'aparició d'entitats.

---

### Millora 2: Recompensa de combat

**Descripció**: Afegit un sistema que reomple la munició del jugador en eliminar un enemic.

**Motiu**: Sense aquest sistema, el jugador podia quedar sense munició en fases avançades de la partida,
fent el joc injugable sense una font de munició al mapa.

**Implementació**:
- Detecció de la mort de NPCs enemics.
- Reompliment automàtic de tota la munició de les armes del jugador.

**Resultat**: Manteniment d'un ritme de combat continu i jugable en totes les fases de dificultat.

---

### Millora 3: Condicional d'aparició del botiquí

**Descripció**: Els botiquins militars només apareixen quan el jugador té menys del 50% de salut.

**Motiu**: Sense aquesta condició, els botiquins podien aparèixer quan el jugador tenia la salut plena,
fent-los inútils i desaprofitant recursos del mapa.

**Implementació**:
- Comprovació del percentatge de salut actual del jugador abans de generar un botiquí.
- Si la salut és ≥ 50%, el sistema genera un altre tipus de recurs o cap recurs.

**Resultat**: Els botiquins apareixen sempre en moments de necessitat real.

---

### Millora 4: Events basats en moviment (en lloc de timer fix)

**Descripció**: Substitució d'un possible sistema de timer per un sistema basat en la distància recorreguda.

**Motiu**: Un timer passiu permetia al jugador esperar sense moure's fins que apareixien recursos, reduint
la tensió del joc i eliminant la necessitat d'explorar.

**Implementació**:
- Monitoratge continu de la posició del jugador.
- Càlcul acumulatiu de la distància recorreguda.
- Activació d'events en assolir distàncies objectiu aleatòries.

**Resultat**: El jugador és obligat a moure's per generar contingut, augmentant el dinamisme del joc.

---

### Millora 5: HUD animat amb interpolació Lerp

**Descripció**: Les barres del HUD utilitzen interpolació lineal (Lerp) per animar els canvis de valor.

**Motiu**: Un HUD amb valors que canvien bruscament és visualment sorollós i dificulta la lectura de
l'estat del jugador.

**Implementació**:
- Aplicació de Lerp als valors de renderització de les barres.
- Actualització per frame del valor visual interpolat.

**Resultat**: Transicions visuals fluides que milloren la llegibilitat del HUD.

---

### Millora 6: Arquitectura modular

**Descripció**: Refactorització del codi en sis sistemes independents amb responsabilitats separades.

**Motiu**: Un fitxer de codi monolític és difícil de mantenir, debugar i ampliar.

**Implementació**:
- Separació en: Core Survival, Movement Events, Difficulty Manager, Safe Spawn, Combat Reward, Client HUD.
- Comunicació entre sistemes via hooks i el sistema `net` de GMod.

**Resultat**: Codi més mantenible, testejable per parts i escalable per a futures millores.
w