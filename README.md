# Refonte du CV 
Projet de refonte de CV initialisé en décembre 2024

Objectif : Avoir une page web synthétisant différent projet. 

Todo : 
- Passer en I18n pour les texts
- Ajouter les tests unitaire
- Ajouter un konami code qui change l'interface

Production ici  : [https://florient.fr/](https://florient.fr/)
## Setup
Manière classique

```bash
# npm
npm install

# pnpm
pnpm install

# yarn
yarn install

# bun
bun install
```

ou via docker 

```bash 
make init
```

Pense a config le .env en definissant l'url et la clef supabase. 

## Development Server

Le serveur se lance sur `http://localhost:3000`:

Tu peux au choix lancer 
```bash
# npm
npm run dev

# pnpm
pnpm dev

# yarn
yarn dev

# bun
bun run dev
```

ou passer par docker en faisant la commande make

```bash 
make dev
```

## Production
Utilise la commande make
```bash 
make server-prod 
```
