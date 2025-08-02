# Plan : Navigation par barre inférieure avec recherche centrale

## Objectif
Mettre en place une barre de navigation inférieure (Bottom Navigation Bar) avec 4 sections : Aujourd'hui, 24H, Semaine, Paramètres, et un bouton central (loupe) pour la recherche de ville. Chaque section a un contenu dédié, la recherche reste accessible et mise en avant.

## Structure de navigation
- **Barre de navigation en bas de l'écran**
  - Icône "Aujourd'hui" (maison ou soleil)
  - Icône "24H" (horloge)
  - **Bouton central** (loupe, FloatingActionButton)
  - Icône "Semaine" (calendrier)
  - Icône "Paramètres" (engrenage)

## Contenu des sections
- **Aujourd'hui** :
  - Affiche la météo actuelle (sans la section prévisions)
- **24H** :
  - Affiche les prévisions horaires (+1h, +5h, +12h)
- **Semaine** :
  - Affiche les prévisions pour les 7 prochains jours (à implémenter)
- **Paramètres** :
  - Page de paramètres (mentions légales, préférences, etc.)
- **Recherche (loupe)** :
  - Ouvre la modal de recherche de ville (déjà existante)

## Étapes

### 1. UI/Navigation
- Créer un widget principal avec gestion de la Bottom Navigation Bar et du bouton central.
- Gérer la navigation entre les 4 sections (pages ou widgets).
- Intégrer le bouton central de recherche (FloatingActionButton ou équivalent).

### 2. Pages/Widgets
- Créer les widgets/pages pour Aujourd'hui, 24H, Semaine, Paramètres.
- Adapter le contenu de chaque page selon la description.
- Réutiliser la logique MVVM existante pour la météo.

### 3. Recherche
- Ouvrir la modal de recherche de ville au clic sur le bouton central.
- Mettre à jour la météo sur toutes les pages après sélection d'une ville.

### 4. UX/Design
- Icônes simples et explicites.
- Design épuré, cohérent avec le reste de l'app.
- Gérer le retour visuel sur l'onglet sélectionné.

### 5. Tests & Nettoyage
- Vérifier la navigation, l'ouverture de la recherche, la cohérence des données.
- Mettre à jour le plan à chaque étape.
- Archiver le plan à la fin.

---

## Tâches à réaliser
- [x] Créer la structure de navigation principale (Bottom Navigation Bar + bouton central)
- [ ] Créer les pages/widgets pour chaque section
- [ ] Adapter le contenu de chaque page
- [ ] Intégrer la recherche de ville via le bouton central
- [ ] Gérer la mise à jour de la météo sur tous les onglets
- [ ] Tests et UX
- [ ] Archivage du plan 