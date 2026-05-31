# Entorn de desenvolupament

## 1. Tecnologies utilitzades

### 1.1 Plataforma principal: Garry's Mod

**Garry's Mod** (GMod) és un sandbox de física desenvolupat per Facepunch Studios sobre el motor Source
Engine de Valve. No és un joc amb objectius predefinits, sinó una plataforma que permet als usuaris crear
mods, minijocs i addons personalitzats mitjançant Lua.

Per a aquest projecte, Garry's Mod actua com a:
- Entorn d'execució del codi Lua.
- Plataforma de renderització (Source Engine).
- Proveïdor de NPCs natius (Half-Life 2).
- Sistema de gestió d'entitats físiques i de jugador.

### 1.2 Llenguatge de programació: Lua

**Lua** és un llenguatge de scripting lleuger, d'alt nivell i interpretat. Garry's Mod utilitza una versió
estesa anomenada **GLua (Garry's Lua)**, que incorpora:

- Accés a l'API completa de Garry's Mod.
- Sistema de hooks per respondre a esdeveniments del motor.
- Xarxa client-servidor amb el sistema `net`.
- Funcions per crear i manipular entitats del món.

### 1.3 Motor gràfic: Source Engine

El **Source Engine** (Valve, 2004) és el motor subjacent de Garry's Mod. Proporciona:

- Renderització 3D en primera persona.
- Sistema de física (Havok).
- Sistema de col·lisions i traçats de raigs (raycasts).
- IA bàsica per als NPCs de Half-Life 2.

### 1.4 Sistema de xarxa: Net de GMod

El sistema `net` de Garry's Mod permet la comunicació entre el servidor i els clients dins d'una partida.
Encara que el projecte no té suport multijugador actiu, l'arquitectura client-servidor de GMod obliga a
separar el codi en:

- **Serverside**: lògica de joc (estadístiques, esdeveniments, spawn d'entitats).
- **Clientside**: HUD, notificacions visuals.

### 1.5 Entorn de desenvolupament: Visual Studio Code

**Visual Studio Code** (Microsoft) va ser l'editor de codi principal utilitzat durant el desenvolupament.
Extensions rellevants:

- Suport de sintaxi Lua.
- Configuració de workspace (`.vscode/`).
- Integració amb Git per al control de versions.

### 1.6 Control de versions: GitHub

El projecte es va allotjar a **GitHub** amb control de versions Git. El repositori és públic i conté:

- Codi font Lua (`lua/`).
- Documentació (`docs/`).
- Configuració de workspace (`.vscode/`).
- README principal amb documentació de la interfície.

## 2. Estructura tècnica del projecte
VibeCoding-GMod-Add-on-/
├── .vscode/                    # Configuració de l'editor
├── docs/                       # Documentació del projecte
├── lua/                        # Codi font Lua de l'addon
│   ├──autorun
│   |   ├── client
|   |   ├── server
│   ├──entities
│   |   ├── ent_survival_bed   
|   |   ├── ent_survival_food
|   |   ├── ent_survival_medkit
├── .gitattributes              # Configuració de Git
└── README.md                   # Documentació principal
> **Nota**: L'estructura interna de la carpeta `lua/` segueix les convencions d'addons de Garry's Mod.
> Els fitxers del servidor s'executen automàticament des de la ruta `lua/autorun/server/` i els del client
> des de `lua/autorun/client/`.

## 3. Requisits del sistema

| Requisit          | Detall                              |
|-------------------|-------------------------------------|
| Garry's Mod       | Versió actualitzada (Steam)         |
| Steam             | Client actualitzat                  |
| Sistema operatiu  | Windows                             |


## 4. Instal·lació de l'entorn

1. Instal·lar Garry's Mod a través de Steam.
2. Clonar o descarregar el repositori del projecte.
3. Copiar la carpeta de l'addon a: garrysmod/addons/VibeCoding-GMod-Add-on-/
4. Iniciar Garry's Mod i crear una partida local.
5. Verificar que l'addon es carrega sense errors a la consola.