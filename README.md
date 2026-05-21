# Best Practice, base de connaissances professionnelle

**Version Web** : [https://stephane-v.github.io/best-practice/](https://stephane-v.github.io/best-practice/)

## Présentation

**Best Practice** est une base de connaissances conçue pour les professionnels : consultants, entrepreneurs, managers et passionnés de technologie. Ce dépôt rassemble des bonnes pratiques, des guides détaillés et des outils interactifs couvrant plusieurs domaines du monde professionnel moderne.

## Contenu du dépôt

### Documentation

| Domaine | Description |
|---------|-------------|
| **Systèmes d'information** | Framework complet pour évaluer et améliorer la santé des SI en entreprise |
| **Docker et conteneurisation** | Comparatif Docker vs Podman, bonnes pratiques de sécurité |
| **Marketing digital** | Stratégies d'acquisition client, optimisation des conversions, processus de vente |
| **Cybersécurité** | Checklists d'audit, plans de réponse aux incidents, guides de sécurité mobile |
| **IA souveraine** | Guide d'infrastructure LLM souveraine, hébergée en Europe et sous contrôle |

### Outils interactifs

- **Lecteur Markdown** : visualisez et naviguez dans la documentation
- **Persona Builder** : créez des personas marketing détaillés
- **Marketing Tracker** : suivez vos métriques d'acquisition et de conversion
- **Ishikawa Editor** : créez des diagrammes causes-effets (fishbone) avec la méthode 6M
- **Color Wheel** : explorez les harmonies de couleurs et les valeurs HEX, RGB, HSL
- **Docker Compose Security Validator** : analysez un fichier docker-compose et obtenez un score de sécurité
- **LLM Prompt Injection Tester** : évaluez le risque d'injection d'un prompt, entièrement hors ligne
- **RAG Cost Estimator** : estimez le coût mensuel d'un système RAG et comparez souverain EU et cloud US

### Navigation et internationalisation

- Header et footer globaux injectés sur toutes les pages via des Web Components
- Recherche client-side sur l'ensemble des ressources
- Filtres par thème et temps de lecture estimé sur la page d'accueil
- Interface disponible en français et en anglais, bascule sans rechargement

### Scripts et automatisation

- Scripts d'audit de sécurité Docker
- Helpers pour l'exécution sécurisée de conteneurs

## Structure du projet

```
best-practice/
├── index.html                          # Page d'accueil
├── reader-md.html                       # Lecteur de documentation Markdown
├── stack.html                           # Page Stack et convictions
├── DESIGN.md                            # Guide du système de design
├── CHANGELOG.md                         # Historique des évolutions
├── HEALTHY-INFORMATION-SYSTEM-CONSULTANT-LEVEL.md
├── DOCKER-VS-PODMAN.md
├── SECURITY-DOCKER.md
├── assets/                              # Web Components, i18n, recherche
├── i18n/                                # Dictionnaires français et anglais
├── TOOLS/                               # Outils interactifs autonomes
├── MARKETING-STRATEGY/                  # Guides et outils marketing
├── SECURITY-AND_CYBER-.../              # Ressources cybersécurité
├── SECURITY-DOCKER/                     # Scripts de sécurité Docker
└── SOVEREIGN-LLM-INFRASTRUCTURE/         # Guide d'infrastructure LLM souveraine
```

## Technologies utilisées

- **HTML, CSS, JavaScript** : interfaces web interactives avec thème clair et sombre
- **Web Components** : header et footer partagés, sans étape de build
- **Markdown** : documentation structurée et lisible
- **Bash** : scripts d'automatisation et d'audit
- **JSON** : données structurées pour la recherche et l'i18n

## Philosophie

Ce dépôt suit quelques principes fondamentaux :

1. **Accessibilité** : contenu clair, bien structuré, utilisable immédiatement
2. **Pragmatisme** : des solutions testées sur le terrain, pas de théorie abstraite
3. **Évolution** : un projet vivant qui grandit avec les contributions et les retours
4. **Légèreté** : design épuré, pas d'effets superflus, performance soignée

## Contribution

Les contributions sont les bienvenues. Que ce soit pour corriger une erreur, proposer une amélioration ou ajouter de nouvelles ressources, n'hésitez pas à ouvrir une *issue* ou une *pull request*.

## Licence

Ce projet est partagé dans un esprit d'ouverture et de partage de connaissances.
