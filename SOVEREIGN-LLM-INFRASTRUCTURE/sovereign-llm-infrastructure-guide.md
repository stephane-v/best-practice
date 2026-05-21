# Guide d'infrastructure LLM souveraine

Ce guide décrit comment construire et exploiter une infrastructure de
modèles de langage qui garde les données sensibles en Europe et sous le
contrôle de l'organisation. Il s'adresse aux équipes techniques qui doivent
livrer des fonctionnalités IA tout en respectant le RGPD, les attentes des
clients du secteur public et les contraintes des secteurs régulés.

Le ton est volontairement factuel. Les chiffres de prix et de consommation
sont indicatifs, autour de novembre 2026, et doivent être revérifiés avant
toute décision d'achat. Les domaines utilisés dans les exemples (par exemple
`example.com`) sont fictifs.

## Table des matières

1. Introduction et contexte réglementaire
2. Architecture de référence
3. LiteLLM comme passerelle et routage par classification
4. Mistral API contre Ollama auto-hébergé
5. Vector store souverain avec Qdrant
6. STT et TTS souverains
7. Sécurité de la chaîne LLM
8. Comparatif de coût total sur 36 mois
9. Pièges courants, conclusions et ressources

---

## 1. Introduction et contexte réglementaire

### 1.1 Pourquoi parler de souveraineté

La souveraineté numérique, dans le contexte de ce guide, signifie une chose
simple et vérifiable : savoir où sont traitées les données, sous quelle
juridiction, et garder la capacité de changer de fournisseur sans réécrire
toute l'application. Ce n'est pas un slogan, c'est une propriété mesurable
de l'architecture.

Quand une équipe ajoute une fonctionnalité IA, elle envoie en général du
texte à une API. Ce texte contient souvent des données client : extraits de
contrats, tickets de support, fiches RH, notes médicales, code source. Le
choix du fournisseur de modèle décide donc, concrètement, où ces données
transitent et où elles peuvent être conservées ou journalisées.

Une architecture souveraine ne veut pas dire tout auto-héberger. Elle veut
dire faire des choix explicites, documentés, et réversibles. Pour certaines
charges, une API européenne suffit. Pour d'autres, l'auto-hébergement est
nécessaire. Le reste de ce guide donne des critères pour trancher.

### 1.2 Le cadre réglementaire européen

Plusieurs textes encadrent le traitement des données et, indirectement, le
choix d'une infrastructure LLM.

Le RGPD (Règlement général sur la protection des données) reste la base. Il
impose une finalité, une minimisation des données, une base légale, et il
encadre les transferts hors de l'Union européenne. Envoyer des données
personnelles vers une API hébergée aux États-Unis est un transfert qui doit
être justifié et encadré, en pratique par des clauses contractuelles types
et une analyse d'impact sur les transferts.

La CNIL, en France, a publié des recommandations sur l'IA. Elles confirment
que l'entraînement et l'inférence sont des traitements comme les autres :
ils ont besoin d'une base légale, d'une information des personnes, et d'une
gestion des droits. La CNIL insiste aussi sur l'analyse d'impact relative à
la protection des données pour les usages à risque.

DORA (Digital Operational Resilience Act) concerne le secteur financier. Il
impose une gestion stricte des prestataires informatiques critiques, des
tests de résilience, et une capacité de sortie. Un fournisseur de LLM qui
porte une fonctionnalité critique entre dans ce périmètre.

NIS2 élargit les obligations de cybersécurité à un grand nombre de secteurs
dits essentiels et importants. Elle impose une gestion des risques, une
notification des incidents, et une responsabilité de la direction. Une
infrastructure LLM mal isolée devient une surface d'attaque qui entre dans
le périmètre NIS2.

L'AI Act européen ajoute une classification par niveau de risque. La plupart
des applications de type assistant interne ou recherche documentaire sont à
risque limité, avec surtout des obligations de transparence. Mais dès qu'un
système touche au recrutement, à la notation de personnes ou à des décisions
sensibles, il peut basculer en haut risque, avec des obligations lourdes de
documentation et de supervision humaine.

### 1.3 Classification de confidentialité des données

Avant de choisir une infrastructure, il faut classer les données. Une
classification simple en quatre niveaux suffit pour la plupart des
organisations.

| Niveau | Description | Exemple | Destination acceptable |
|--------|-------------|---------|------------------------|
| C0 | Donnée publique | Documentation publique, page marketing | API publique, modèle hébergé n'importe où |
| C1 | Donnée interne non sensible | Compte rendu de réunion interne | API européenne sous contrat |
| C2 | Donnée client ou personnelle | Ticket support, fiche client | API européenne sous contrat, ou auto-hébergé |
| C3 | Donnée sensible ou régulée | Donnée de santé, donnée RH, secret industriel | Auto-hébergé uniquement |

Cette grille est le coeur du routage décrit en section 3. Chaque requête
porte une classe, et la passerelle envoie la requête vers un modèle dont la
localisation est compatible avec cette classe.

### 1.4 Ce que ce guide ne traite pas

Ce guide ne couvre pas l'entraînement ou le fine-tuning de modèles de
fondation. Il se concentre sur l'inférence et sur le RAG (génération
augmentée par récupération), qui sont les usages les plus fréquents en
entreprise. Il ne couvre pas non plus la conformité métier de chaque
secteur, qui demande l'avis d'un juriste spécialisé.

---

## 2. Architecture de référence

### 2.1 Vue d'ensemble

L'architecture proposée sépare clairement les responsabilités. Chaque
composant fait une seule chose et peut être remplacé sans toucher au reste.

```
                          Utilisateur
                               |
                               v
                    +----------------------+
                    |   Reverse proxy      |
                    |   Traefik (TLS)      |
                    +----------------------+
                       |                |
            front  /   |                |  / api
                   v                    v
        +------------------+   +----------------------+
        |  Application     |   |  API applicative     |
        |  Next.js, Astro  |   |  FastAPI             |
        +------------------+   +----------------------+
                                          |
                                          v
                               +----------------------+
                               |  Passerelle LLM      |
                               |  LiteLLM             |
                               +----------------------+
                                  |        |        |
                      C0 C1 C2    |        |        |  C3
                                  v        v        v
                       +-----------+  +---------+  +-----------+
                       | Mistral   |  | Cache   |  | Ollama    |
                       | API (EU)  |  | Redis   |  | local GPU |
                       +-----------+  +---------+  +-----------+
                                  |
                                  v
                       +----------------------+
                       |  Vector store        |
                       |  Qdrant              |
                       +----------------------+
                                  |
                                  v
                       +----------------------+
                       |  Observabilite       |
                       |  logs, metriques     |
                       +----------------------+
```

Le point important de ce schéma : l'application ne parle jamais directement
à un fournisseur de modèle. Elle parle à la passerelle. C'est la passerelle
qui décide où va la requête, applique les quotas, journalise, et masque le
fournisseur réel derrière une interface stable.

### 2.2 Les composants

Le reverse proxy, ici Traefik, termine le TLS et route le trafic. Le front
est servi sur la racine du domaine, l'API applicative sur le préfixe `/api`.
Cette convention simple évite les problèmes de CORS et garde une seule
origine pour le navigateur.

L'API applicative, ici FastAPI, porte la logique métier. Elle authentifie
l'utilisateur, applique les droits, classe la requête (C0 à C3), construit
le contexte RAG, puis appelle la passerelle LLM.

La passerelle LLM, ici LiteLLM, expose une interface unique compatible avec
le format OpenAI. Elle route vers Mistral pour les classes C0 à C2 et vers
Ollama pour la classe C3. Elle gère aussi le cache, les quotas de jetons et
la journalisation.

Le vector store, ici Qdrant, stocke les embeddings du corpus documentaire.
Il est interrogé par l'API applicative pour récupérer les passages
pertinents avant chaque génération.

L'observabilité collecte les logs structurés et les métriques. Elle permet
de suivre les coûts, les temps de réponse et les tentatives d'injection.

### 2.3 Réseau et isolation

Chaque service tourne dans un conteneur. Seuls Traefik et, si besoin, un
service de monitoring exposent des ports vers l'extérieur. Les autres
services communiquent sur un réseau Docker interne et ne publient aucun
port sur l'hôte.

```
reseau "edge"      : Traefik
reseau "app"       : Traefik, application, API applicative
reseau "llm"       : API applicative, LiteLLM, Redis
reseau "data"      : LiteLLM, Qdrant, Ollama
```

Un service n'est joignable que par les services qui en ont besoin. Qdrant
n'est pas sur le réseau `edge`, il ne peut donc pas être atteint depuis
Internet, même en cas de mauvaise configuration de Traefik.

### 2.4 Hébergement

Pour les composants auto-hébergés, deux familles d'hébergeurs européens
reviennent souvent. Les serveurs dédiés ou VPS chez un hébergeur comme
Hetzner conviennent pour la passerelle, le vector store et l'API. Pour la
partie GPU nécessaire à Ollama, un serveur GPU chez un hébergeur européen,
ou une instance GPU à la demande, est nécessaire. Le stockage objet, par
exemple chez OVH à Gravelines, sert aux sauvegardes et aux exports.

Le choix de la région compte. Une région française ou européenne garde les
données sous juridiction européenne, ce qui simplifie l'analyse RGPD.

---

## 3. LiteLLM comme passerelle et routage par classification

### 3.1 Le rôle de la passerelle

LiteLLM expose une API compatible OpenAI et parle, derrière, à de nombreux
fournisseurs. Pour notre architecture, elle apporte quatre choses : une
interface stable pour l'application, un point unique de journalisation, un
contrôle des quotas, et un routage par classe de confidentialité.

L'application n'a donc qu'un seul client à configurer. Si demain Mistral
change de tarif ou si une nouvelle option européenne apparait, on modifie la
configuration de la passerelle, pas le code applicatif.

### 3.2 Déploiement de LiteLLM

Voici un exemple de service LiteLLM dans un fichier docker-compose, avec les
labels Traefik conformes à la convention front et API.

```yaml
services:
  litellm:
    image: ghcr.io/berriai/litellm:main-stable
    restart: unless-stopped
    read_only: true
    cap_drop:
      - ALL
    user: "1000:1000"
    mem_limit: 1g
    cpus: 1.0
    environment:
      - LITELLM_MASTER_KEY=${LITELLM_MASTER_KEY}
      - MISTRAL_API_KEY=${MISTRAL_API_KEY}
    volumes:
      - ./litellm-config.yaml:/app/config.yaml:ro
    command: ["--config", "/app/config.yaml", "--port", "4000"]
    networks:
      - llm
      - data
    healthcheck:
      test: ["CMD", "wget", "-q", "-O", "-", "http://127.0.0.1:4000/health"]
      interval: 30s
      timeout: 5s
      retries: 3
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.litellm.rule=Host(`llm.example.com`)"
      - "traefik.http.routers.litellm.entrypoints=websecure"
      - "traefik.http.routers.litellm.tls.certresolver=letsencrypt"
      - "traefik.http.services.litellm.loadbalancer.server.port=4000"

networks:
  llm:
    internal: true
  data:
    internal: true
```

Quelques points de durcissement sont déjà présents : système de fichiers en
lecture seule, capabilities retirées, utilisateur non root, limites de
mémoire et de CPU, healthcheck. Le réseau `data` est interne, il ne sort
pas vers Internet.

### 3.3 Configuration du routage

Le fichier de configuration de LiteLLM déclare les modèles disponibles.
L'idée est de définir un alias par classe de confidentialité plutôt que par
nom de modèle.

```yaml
model_list:
  - model_name: chat-c0
    litellm_params:
      model: mistral/mistral-small-latest
      api_key: os.environ/MISTRAL_API_KEY
  - model_name: chat-c1
    litellm_params:
      model: mistral/mistral-large-latest
      api_key: os.environ/MISTRAL_API_KEY
  - model_name: chat-c2
    litellm_params:
      model: mistral/mistral-large-latest
      api_key: os.environ/MISTRAL_API_KEY
  - model_name: chat-c3
    litellm_params:
      model: ollama/qwen3:14b
      api_base: http://ollama:11434

general_settings:
  master_key: os.environ/LITELLM_MASTER_KEY
  database_url: os.environ/DATABASE_URL

litellm_settings:
  drop_params: true
  request_timeout: 120
  cache: true
```

L'application ne demande jamais un modèle par son nom. Elle demande
`chat-c2` parce que la requête a été classée C2. Si l'organisation décide
plus tard que C2 doit aussi rester auto-hébergé, on change une seule ligne
de configuration, sans toucher au code.

### 3.4 Classer la requête côté application

La classification se fait dans l'API applicative, avant l'appel à la
passerelle. Une approche pragmatique combine des règles simples et le
contexte de l'utilisateur.

```python
def classify_request(user, document_tags, free_text):
    if "sante" in document_tags or "rh" in document_tags:
        return "c3"
    if "secret" in document_tags:
        return "c3"
    if user.handles_client_data and contains_personal_data(free_text):
        return "c2"
    if user.is_internal:
        return "c1"
    return "c0"

def model_for_class(level):
    return {"c0": "chat-c0", "c1": "chat-c1",
            "c2": "chat-c2", "c3": "chat-c3"}[level]
```

La fonction `contains_personal_data` peut s'appuyer sur des expressions
régulières simples (adresses, numéros, identifiants) et sur les étiquettes
posées lors de l'indexation du corpus. Il vaut mieux surclasser une requête
que la sous-classer : en cas de doute, on remonte d'un niveau.

### 3.5 Quotas et cache

LiteLLM permet d'attribuer des clés virtuelles par équipe ou par
application, avec un budget de jetons. Cela évite qu'un bug de boucle vide
le budget mensuel en une nuit. Le cache, activé dans la configuration,
renvoie une réponse déjà calculée pour une requête identique. Sur un
assistant documentaire interne, le taux de requêtes répétées est souvent
significatif, et le cache réduit la facture sans changer l'expérience.

---

## 4. Mistral API contre Ollama auto-hébergé

### 4.1 Deux modèles de déploiement

Mistral propose une API hébergée en Europe. Ollama permet de faire tourner
des modèles ouverts sur sa propre infrastructure GPU. Les deux ont leur
place. Le tableau suivant résume les différences.

| Critère | Mistral API (EU) | Ollama auto-hébergé |
|---------|------------------|---------------------|
| Localisation des données | Europe, sous contrat | Votre infrastructure |
| Mise en route | Quelques minutes | Quelques heures à quelques jours |
| Coût à faible volume | Faible, paiement à l'usage | Élevé, GPU à payer même à vide |
| Coût à fort volume | Croît avec le trafic | Stable, plafonné par le GPU |
| Qualité des modèles | Modèles propriétaires récents | Modèles ouverts, écart réduit mais réel |
| Confidentialité maximale | Bonne, sous contrat | Totale, rien ne sort |
| Charge d'exploitation | Faible | Réelle, mises à jour et supervision |

### 4.2 Quand choisir l'API européenne

L'API européenne convient pour les classes C0 à C2. Elle est le bon choix
quand le volume est modéré ou irrégulier, quand l'équipe est petite, et
quand le contrat avec le fournisseur couvre les exigences RGPD. Elle évite
d'immobiliser un GPU coûteux pour quelques milliers de requêtes par mois.

### 4.3 Quand choisir l'auto-hébergement

L'auto-hébergement avec Ollama est nécessaire pour la classe C3, quand
aucune donnée ne doit sortir de l'infrastructure. Il devient aussi
intéressant économiquement à fort volume, quand le coût fixe du GPU est
amorti par un grand nombre de requêtes. C'est enfin le bon choix quand un
client exige contractuellement que rien ne transite par un tiers.

### 4.4 Déployer Ollama

```yaml
services:
  ollama:
    image: ollama/ollama:latest
    restart: unless-stopped
    cap_drop:
      - ALL
    mem_limit: 24g
    environment:
      - OLLAMA_KEEP_ALIVE=30m
      - OLLAMA_MAX_LOADED_MODELS=1
    volumes:
      - ollama-models:/root/.ollama
    networks:
      - data
    healthcheck:
      test: ["CMD", "ollama", "list"]
      interval: 60s
      timeout: 10s
      retries: 3

volumes:
  ollama-models:
```

Ce service n'expose aucun port sur l'hôte et n'est pas sur le réseau
`edge`. Seule la passerelle LiteLLM, sur le réseau `data`, peut l'appeler.
Pour exploiter un GPU, l'hôte doit disposer des pilotes et du runtime
conteneur adapté, et le service doit demander l'accès au GPU.

### 4.5 Choisir un modèle ouvert

Pour un usage assistant et RAG en français, plusieurs familles de modèles
ouverts donnent de bons résultats. Un modèle de l'ordre de 14 milliards de
paramètres tient sur un GPU de 24 Go de mémoire et répond vite. Pour des
tâches de code, un modèle spécialisé comme Devstral est pertinent. Le bon
réflexe est de mesurer sur ses propres données, avec un jeu de questions
représentatif, plutôt que de se fier à un classement générique.

### 4.6 Architecture hybride

L'architecture recommandée est hybride. La majorité du trafic, classes C0 à
C2, passe par l'API européenne, économique et simple. La fraction sensible,
classe C3, passe par Ollama. La passerelle rend ce partage invisible pour
l'application. On obtient un coût maitrisé et une confidentialité forte là
où elle compte.

---

## 5. Vector store souverain avec Qdrant

### 5.1 Le rôle du vector store

Dans un système RAG, les documents sont découpés en passages, chaque passage
est transformé en vecteur par un modèle d'embedding, et les vecteurs sont
stockés dans une base spécialisée. À chaque question, la question est elle
aussi transformée en vecteur, et la base renvoie les passages les plus
proches. Ces passages forment le contexte envoyé au modèle de génération.

Le vector store contient donc une représentation du corpus. Si le corpus est
sensible, le vector store l'est aussi. Sa localisation compte autant que
celle du modèle.

### 5.2 Qdrant auto-hébergé

Qdrant est une base vectorielle ouverte, écrite en Rust, simple à
auto-héberger. Voici un service type.

```yaml
services:
  qdrant:
    image: qdrant/qdrant:latest
    restart: unless-stopped
    read_only: true
    cap_drop:
      - ALL
    mem_limit: 4g
    cpus: 2.0
    environment:
      - QDRANT__SERVICE__API_KEY=${QDRANT_API_KEY}
    volumes:
      - qdrant-data:/qdrant/storage
    networks:
      - data
    healthcheck:
      test: ["CMD", "wget", "-q", "-O", "-", "http://127.0.0.1:6333/healthz"]
      interval: 30s
      timeout: 5s
      retries: 3

volumes:
  qdrant-data:
```

La clé d'API est obligatoire, même sur un réseau interne. Le volume
`qdrant-data` doit être inclus dans la stratégie de sauvegarde, car
réindexer un grand corpus prend du temps et coûte des appels d'embedding.

### 5.3 Qdrant Cloud contre Qdrant auto-hébergé

| Critère | Qdrant Cloud | Qdrant auto-hébergé |
|---------|--------------|---------------------|
| Localisation | Région à choisir, vérifier l'offre EU | Votre infrastructure |
| Exploitation | Gérée par le fournisseur | À votre charge |
| Coût | Par Go et par dimension, croît avec le corpus | Coût du serveur, stable |
| Sauvegarde | Intégrée | À mettre en place |
| Adapté à | Démarrage rapide, petites équipes | Données C2 et C3, gros corpus |

Pour un corpus C3, l'auto-hébergement sur un serveur européen, par exemple
chez un hébergeur à Gravelines, est le choix cohérent. Pour un prototype ou
un corpus C0, Qdrant Cloud accélère le démarrage.

### 5.4 Choisir le modèle d'embedding

Le modèle d'embedding décide de la qualité de la recherche et de la taille
du stockage. Trois options reviennent souvent.

Un modèle d'API comme Mistral Embed est simple, hébergé en Europe, et facturé
au jeton. Un modèle ouvert comme BGE-M3, exécuté via Ollama, garde tout en
interne et gère bien le multilingue. Le choix d'un modèle américain comme
les embeddings d'OpenAI est à réserver aux corpus C0, car le texte des
passages part chez le fournisseur lors de l'indexation.

La dimension du vecteur, souvent entre 1024 et 1536, multiplie la taille du
stockage. Pour un corpus de plusieurs millions de passages, ce détail a un
effet réel sur la facture de stockage.

### 5.5 Stratégie de chunking

Le découpage en passages influence fortement la qualité. Un passage trop
court perd le contexte, un passage trop long dilue l'information. Une taille
de l'ordre de 500 à 800 jetons, avec un recouvrement de 10 à 15 pour cent,
est un bon point de départ. Il faut ensuite mesurer sur des questions
réelles et ajuster. L'outil d'estimation de coût RAG de ce dépôt aide à voir
l'effet du chunking sur le volume d'embeddings et donc sur le coût.

### 5.6 Cycle de réindexation

Un corpus vit. Des documents sont ajoutés, modifiés, supprimés. Il faut donc
prévoir une réindexation incrémentale plutôt que de tout recalculer. Une
approche simple consiste à stocker, pour chaque document, une empreinte de
son contenu. À chaque cycle, on ne réindexe que les documents dont
l'empreinte est différente. Cela réduit le coût d'embedding récurrent.

---

## 6. STT et TTS souverains

### 6.1 Pourquoi la voix mérite la même attention

La reconnaissance vocale (STT) et la synthèse vocale (TTS) traitent souvent
des données aussi sensibles que le texte : un enregistrement de réunion, un
appel client, une dictée médicale. Les mêmes règles de classification
s'appliquent. Une transcription C3 ne doit pas partir vers une API hors
Union européenne.

### 6.2 Reconnaissance vocale

Pour la transcription, les modèles de la famille Whisper sont une référence
ouverte. Ils s'exécutent localement, sur CPU pour de petits volumes, sur GPU
pour du temps réel ou du gros volume. Speaches est un projet qui expose ces
modèles derrière une API compatible avec le format OpenAI, ce qui simplifie
l'intégration. Speaches peut tourner sur un hébergeur européen, par exemple
une plateforme comme Koyeb avec une région européenne, ou directement sur
un serveur GPU.

| Option | Localisation | Adapté à |
|--------|--------------|----------|
| Whisper local sur CPU | Votre machine | Petits volumes, lots, données C3 |
| Whisper sur GPU via Speaches | Votre infrastructure ou plateforme EU | Volume moyen, quasi temps réel |
| API STT non européenne | Hors Union européenne | Données C0 uniquement |

### 6.3 Synthèse vocale

Pour la synthèse, des modèles ouverts permettent une voix de bonne qualité
en local. La qualité a beaucoup progressé et l'écart avec les services
propriétaires s'est réduit. Pour un usage C3, la synthèse locale est le seul
choix acceptable. Pour de la lecture de contenu public C0, une API peut
suffire si le contenu n'est pas sensible.

### 6.4 Intégration avec la passerelle

Comme pour le texte, il est utile de placer STT et TTS derrière la même
passerelle ou derrière un point d'entrée unique. L'application demande une
transcription sans savoir si elle est servie par Whisper local ou par
Speaches. Le routage par classe reste le même : une transcription C3 va
vers le moteur local, une transcription C0 peut aller vers une API.

### 6.5 Latence et expérience

La voix est sensible à la latence. Une transcription en temps réel demande
un GPU et un modèle de taille raisonnable. Pour un usage en lot, par exemple
transcrire des réunions la nuit, un traitement CPU suffit et coûte moins
cher. Le bon découpage entre temps réel et traitement différé évite de
surdimensionner l'infrastructure GPU.

---

## 7. Sécurité de la chaîne LLM

### 7.1 Le périmètre à protéger

Une chaîne LLM ajoute des surfaces d'attaque nouvelles : l'injection de
prompt, la fuite par la sortie du modèle, et l'empoisonnement du corpus RAG.
Les sections suivantes résument les défenses. Pour le détail, voir le guide
[Bonnes pratiques de sécurité LLM](reader-md.html?file=https://raw.githubusercontent.com/stephane-v/best-practice/main/SECURITY-AND_CYBER-HEALTHY-INFORMATION-SYSTEM-CONSULTANT-LEVEL/llm-security-best-practices.md).

### 7.2 Injection de prompt

L'injection de prompt consiste à glisser, dans une entrée utilisateur ou
dans un document récupéré, des instructions qui détournent le modèle. La
défense est en couches : un filtrage par motifs sur l'entrée, des
délimiteurs clairs entre instructions système et contenu utilisateur, et une
validation de la sortie. Le testeur d'injection de prompt de ce dépôt permet
de vérifier rapidement une entrée suspecte avant de l'envoyer au modèle.

L'injection indirecte est plus sournoise. Un document du corpus RAG peut
contenir des instructions cachées. Quand ce document est récupéré et placé
dans le contexte, le modèle peut les suivre. Il faut donc traiter le contenu
récupéré comme une donnée non fiable, jamais comme une instruction.

### 7.3 Validation de la sortie

La sortie du modèle ne doit pas être affichée ou exécutée sans contrôle. Si
la sortie est du JSON, elle doit être validée contre un schéma. Si elle
contient des liens, ils doivent être vérifiés, car un lien construit par le
modèle peut servir à exfiltrer des données via ses paramètres. Si la sortie
est du code, elle ne doit jamais être exécutée automatiquement.

### 7.4 Journalisation et audit

Chaque appel à la passerelle doit produire un log structuré : horodatage,
identifiant d'utilisateur pseudonymisé, classe de la requête, modèle utilisé,
nombre de jetons, verdict du filtre d'injection, durée. Ces logs servent à
trois choses : suivre les coûts, détecter les abus, et répondre aux
obligations d'audit de DORA et de NIS2.

Les logs ne doivent pas contenir le texte complet des requêtes C2 et C3. On
journalise des métadonnées, pas le contenu sensible. La durée de rétention
doit être définie et limitée.

### 7.5 Gestion des secrets

Les clés d'API, la clé maitre de la passerelle, la clé de Qdrant ne doivent
jamais être écrites en clair dans un fichier compose suivi par Git. Elles
vivent dans un fichier d'environnement ignoré par Git, ou dans un
gestionnaire de secrets. Le validateur Docker Compose de ce dépôt détecte
justement les secrets laissés en clair.

### 7.6 Isolation et durcissement

Les conteneurs suivent les bonnes pratiques décrites dans le
[guide de sécurité Docker](reader-md.html?file=https://raw.githubusercontent.com/stephane-v/best-practice/main/SECURITY-DOCKER.md) :
utilisateur non root, capabilities retirées, système de fichiers en lecture
seule quand c'est possible, limites de ressources, pas de montage du socket
Docker. Les réseaux internes empêchent qu'un service de données soit joint
depuis Internet.

### 7.7 Le facteur humain

Une infrastructure souveraine ne protège pas contre une mauvaise hygiène des
postes de travail. Un terminal compromis qui a accès à l'application a accès
aux réponses du modèle. Les recommandations du
[guide de sécurité mobile en entreprise](reader-md.html?file=https://raw.githubusercontent.com/stephane-v/best-practice/main/SECURITY-AND_CYBER-HEALTHY-INFORMATION-SYSTEM-CONSULTANT-LEVEL/enterprise-mobile-security-guide.md)
restent valables : gestion des appareils, sensibilisation, contrôle des
accès.

---

## 8. Comparatif de coût total sur 36 mois

### 8.1 Méthode

Le coût total de possession (TCO) doit inclure tout, pas seulement la
facture d'API : le matériel ou les serveurs, le stockage, le temps
d'exploitation, et le coût de sortie. La comparaison qui suit prend un cas
de référence : un assistant documentaire interne pour une organisation de
taille moyenne, environ 100 utilisateurs actifs, 60 questions par mois et
par utilisateur, un corpus de quelques milliers de documents.

Les montants sont indicatifs, en euros, et servent à comparer des ordres de
grandeur, pas à produire un devis. L'estimateur de coût RAG de ce dépôt
permet de rejouer le calcul avec ses propres chiffres.

### 8.2 Scénario A, tout API non européenne

Embeddings et génération via des API non européennes, vector store managé
hors Union européenne.

```
Coût mensuel estime         : facture d'API + stockage manage
Coût d'exploitation         : faible
Coût de mise en conformite  : eleve (transferts hors UE a encadrer)
Coût de sortie              : moyen (reindexation, changement de format)
```

Le poste qui n'apparait pas sur la facture est le coût de conformité :
clauses contractuelles, analyse d'impact sur les transferts, risque
juridique. Ce coût est réel même s'il est difficile à chiffrer.

### 8.3 Scénario B, hybride souverain

API européenne pour les classes C0 à C2, Ollama auto-hébergé pour la classe
C3, Qdrant auto-hébergé sur un serveur européen.

```
Coût mensuel estime         : facture API EU (volume C0-C2)
                              + serveur GPU (C3)
                              + serveur Qdrant et passerelle
Coût d'exploitation         : moyen (mises a jour, supervision)
Coût de mise en conformite  : faible (donnees en UE)
Coût de sortie              : faible (composants ouverts, portables)
```

### 8.4 Scénario C, tout auto-hébergé

Embeddings, génération et vector store entièrement auto-hébergés.

```
Coût mensuel estime         : serveurs GPU + serveurs CPU + stockage
Coût d'exploitation         : eleve (toute la chaine a maintenir)
Coût de mise en conformite  : tres faible
Coût de sortie              : tres faible
```

### 8.5 Lecture du comparatif

À faible volume, le scénario A semble le moins cher sur la facture
mensuelle, mais le coût de conformité et le risque juridique le rattrapent.
À fort volume, le scénario B et le scénario C deviennent compétitifs même
sur la seule facture, car le coût fixe des serveurs est amorti.

Le scénario B est le meilleur compromis pour la plupart des organisations de
taille moyenne. Il garde les données en Europe, limite le coût
d'exploitation en gardant l'API pour le gros du trafic, et réserve
l'auto-hébergement à la fraction réellement sensible.

Sur 36 mois, le facteur décisif n'est presque jamais la facture d'API. C'est
le coût d'exploitation, le coût de conformité, et la capacité à changer de
fournisseur sans tout réécrire. Une architecture qui passe par une
passerelle, comme celle de ce guide, garde cette capacité de sortie, ce qui
réduit le coût caché le plus important.

### 8.6 Le coût de sortie

Le coût de sortie mérite une ligne dédiée. Il mesure l'effort pour quitter
un fournisseur. Une architecture où l'application appelle directement une
API propriétaire a un coût de sortie élevé : il faut réécrire le code,
re-tester, parfois réindexer. Une architecture derrière une passerelle, avec
des composants ouverts, a un coût de sortie faible. DORA demande
explicitement cette capacité de sortie pour les prestataires critiques.

---

## 9. Pièges courants, conclusions et ressources

### 9.1 Pièges courants

Le premier piège est de tout auto-héberger par principe. L'auto-hébergement
a un coût d'exploitation réel. Pour un corpus C0 et un faible volume, une API
européenne est souvent le choix raisonnable. La souveraineté se décide par
classe de données, pas en bloc.

Le deuxième piège est d'appeler le fournisseur de modèle directement depuis
l'application. Cela rend tout changement coûteux et supprime le point unique
de journalisation et de quota. La passerelle n'est pas une couche inutile,
elle est ce qui rend l'architecture réversible.

Le troisième piège est d'oublier que le vector store contient une copie du
corpus. Sécuriser le modèle et laisser le vector store ouvert ne sert à
rien. Le vector store hérite de la classe de confidentialité du corpus.

Le quatrième piège est de négliger le coût de réindexation. Un changement de
modèle d'embedding oblige à tout réindexer. Choisir le modèle d'embedding
avec soin, dès le début, évite une facture surprise plus tard.

Le cinquième piège est de croire qu'une infrastructure souveraine dispense
d'une analyse RGPD. Héberger en Europe simplifie l'analyse des transferts,
mais la base légale, l'information des personnes et la gestion des droits
restent obligatoires.

Le sixième piège est de journaliser le contenu sensible. Les logs servent à
l'audit et au suivi des coûts, ils ne doivent pas devenir un second endroit
où le texte C3 est stocké en clair.

### 9.2 Une feuille de route progressive

Une organisation n'a pas besoin de tout construire d'un coup. Une
progression réaliste tient en quatre étapes. D'abord, mettre en place la
passerelle et router tout le trafic vers une API européenne, en classant
déjà les requêtes. Ensuite, ajouter le vector store auto-hébergé et le RAG.
Puis ajouter Ollama pour la classe C3, sans toucher au reste grâce à la
passerelle. Enfin, ajouter la voix si le besoin existe.

À chaque étape, l'architecture reste cohérente et la capacité de sortie est
préservée.

### 9.3 Conclusion

Une infrastructure LLM souveraine n'est pas un produit, c'est une suite de
choix explicites. Classer les données, router par classe, passer par une
passerelle, garder des composants ouverts et portables : ces décisions
gardent les données sensibles en Europe et sous contrôle, sans renoncer à la
vitesse de livraison.

Le bon réflexe est de mesurer plutôt que de supposer. Mesurer la qualité des
modèles sur ses propres données, mesurer les coûts avec ses propres
volumes, mesurer la latence dans son propre contexte. Les outils de ce dépôt,
le validateur Docker Compose, le testeur d'injection de prompt et
l'estimateur de coût RAG, sont faits pour aider à ces mesures.

### 9.4 Ressources

Documents de ce dépôt utiles en complément de ce guide :

- [Bonnes pratiques de sécurité LLM](reader-md.html?file=https://raw.githubusercontent.com/stephane-v/best-practice/main/SECURITY-AND_CYBER-HEALTHY-INFORMATION-SYSTEM-CONSULTANT-LEVEL/llm-security-best-practices.md)
- [Guide de sécurité Docker](reader-md.html?file=https://raw.githubusercontent.com/stephane-v/best-practice/main/SECURITY-DOCKER.md)
- [Comparatif Docker et Podman](reader-md.html?file=https://raw.githubusercontent.com/stephane-v/best-practice/main/DOCKER-VS-PODMAN.md)
- [Guide de sécurité mobile en entreprise](reader-md.html?file=https://raw.githubusercontent.com/stephane-v/best-practice/main/SECURITY-AND_CYBER-HEALTHY-INFORMATION-SYSTEM-CONSULTANT-LEVEL/enterprise-mobile-security-guide.md)

Textes réglementaires à connaitre : le RGPD, les recommandations de la CNIL
sur l'IA, le règlement DORA pour le secteur financier, la directive NIS2
pour les secteurs essentiels, et l'AI Act européen pour la classification
par niveau de risque. Ces textes évoluent, il faut suivre leur version en
vigueur et, pour les cas sensibles, prendre l'avis d'un juriste spécialisé.

---

Ce guide fait partie du dépôt Best Practice. Il est révisé au fil des
retours et des évolutions réglementaires.
