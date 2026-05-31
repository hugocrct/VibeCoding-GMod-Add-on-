# Errors trobats

## 1. Introducció

Aquest document recull les incidències detectades durant el desenvolupament i les sessions de prova del
projecte, indicant la causa probable i la solució aplicada en cada cas.

## 2. Registre d'errors

### Error E01: Entitats apareixent dins de geometria sòlida

| Camp              | Descripció                                                                 |
|-------------------|----------------------------------------------------------------------------|
| **Sistema**       | Safe Spawn System / Movement Event System                                  |
| **Descripció**    | Les entitats de recursos i enemics apareixien incrustades en parets, terres o altres superfícies sòlides del mapa. |
| **Causa probable**| La posició d'aparició es generava de forma aleatòria sense validació de col·lisions amb la geometria del mapa. |
| **Solució aplicada** | Implementació del Safe Spawn System amb validació per raycast i traces, fins a 10 intents de reposicionament. |
| **Estat**         | ✅ Resolt                                                                  |

---

### Error E02: Entitats apareixent sobre el jugador

| Camp              | Descripció                                                                 |
|-------------------|----------------------------------------------------------------------------|
| **Sistema**       | Safe Spawn System                                                          |
| **Descripció**    | Les entitats podien aparèixer en la mateixa posició que el jugador o molt a prop, causant empentes involuntàries o comportaments anòmals. |
| **Causa probable**| Absència d'una distància mínima d'exclusió al voltant del jugador en el càlcul de la posició d'aparició. |
| **Solució aplicada** | Afegida una comprovació de distància mínima de 120 unitats respecte al jugador. Bloqueig explícit d'aparicions sota el jugador. |
| **Estat**         | ✅ Resolt                                                                  |
---