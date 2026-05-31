# Casos de prova

## 1. Introducció

Aquest document recull els casos de prova definits per verificar el funcionament correcte de tots els
sistemes del projecte. Les proves es van realitzar manualment dins de l'entorn de Garry's Mod en mode
de partida local.

## 2. Taula de casos de prova

| ID  | Sistema               | Acció realitzada                                              | Resultat esperat                                               | Resultat obtingut                                              | Estat     |
|-----|-----------------------|---------------------------------------------------------------|----------------------------------------------------------------|----------------------------------------------------------------|-----------|
| CP01 | Core Survival        | Esperar sense moure's ni interactuar                          | La gana disminueix 1 punt cada 2 segons                        | La gana disminueix al ritme correcte                           | ✅ Correcte |
| CP02 | Core Survival        | Esperar sense moure's ni interactuar                          | L'energia disminueix 1 punt cada 4 segons                      | L'energia disminueix al ritme correcte                         | ✅ Correcte |
| CP03 | Core Survival        | Deixar que la gana arribi a 0                                 | El jugador mor i la partida finalitza                          | El jugador mor correctament                                    | ✅ Correcte |
| CP04 | Core Survival        | Deixar que l'energia arribi a 0                               | El jugador mor i la partida finalitza                          | El jugador mor correctament                                    | ✅ Correcte |
| CP05 | Core Survival        | Rebre dany d'un NPC fins a salut 0                            | El jugador mor i la partida finalitza                          | El jugador mor correctament                                    | ✅ Correcte |
| CP06 | Movement Events      | Moure el jugador per l'escenari                               | S'activa un event en assolir la distància objectiu             | L'event s'activa correctament                                  | ✅ Correcte |
| CP07 | Movement Events      | Romandre quiet sense moure's                                  | No s'activa cap event                                          | No s'activa cap event                                          | ✅ Correcte |
| CP08 | Recursos             | Moure el jugador fins a generar un event de menjar            | Apareix una entitat de menjar al món                           | Apareix correctament                                           | ✅ Correcte |
| CP09 | Recursos             | Interactuar amb el menjar amb la tecla E                      | La gana augmenta +35                                           | La gana augmenta correctament                                  | ✅ Correcte |
| CP10 | Recursos             | Interactuar amb un llit/matalàs amb la tecla E                | L'energia augmenta +30                                         | L'energia augmenta correctament                                | ✅ Correcte |
| CP11 | Recursos             | Generar un botiquí amb salut > 50%                            | El botiquí no apareix                                          | El botiquí no apareix                                          | ✅ Correcte |
| CP12 | Recursos             | Generar un botiquí amb salut < 50%                            | El botiquí apareix i recupera salut                            | El botiquí apareix correctament                                | ✅ Correcte |
| CP13 | Safe Spawn           | Forçar una aparició en una zona propera a una paret           | L'entitat no apareix dins de geometria                         | L'entitat apareix en una posició vàlida                        | ✅ Correcte |
| CP14 | Safe Spawn           | Verificar la distància mínima d'aparició                      | L'entitat apareix a ≥ 120 unitats del jugador                  | La distància és correcta                                       | ✅ Correcte |
| CP15 | Difficulty Manager   | Esperar 1 minut de partida                                    | La dificultat augmenta; nous enemics disponibles               | L'escalat s'activa correctament                                | ✅ Correcte |
| CP16 | Difficulty Manager   | Esperar 2 minuts de partida                                   | Zombie Fast disponible com a enemic                            | Zombie Fast apareix a partir del minut 2                       | ✅ Correcte |
| CP17 | Difficulty Manager   | Esperar 3 minuts de partida                                   | Poison Zombie disponible                                       | Poison Zombie apareix a partir del minut 3                     | ✅ Correcte |
| CP18 | Combat Reward        | Eliminar un enemic NPC                                        | La munició de totes les armes es reomple                       | La munició es reomple correctament                             | ✅ Correcte |
| CP19 | HUD                  | Observar les barres durant el joc                             | Les barres reflecteixen els valors actuals amb animació Lerp   | Les barres s'animen correctament                               | ✅ Correcte |
| CP20 | HUD                  | Observar les notificacions en rebre dany o recuperar recursos | Apareixen notificacions de color Rainbow                       | Les notificacions apareixen correctament                       | ✅ Correcte |

> **Nota**: Els resultats obtinguts marcats com ✅ Correcte reflecteixen el comportament esperat