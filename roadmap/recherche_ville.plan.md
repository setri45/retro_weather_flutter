# Plan : Recherche de ville avec suggestions et géolocalisation

## Objectif
Permettre à l'utilisateur de rechercher une ville en cliquant sur le nom de la ville ou du pays, ouvrant une page modale avec une barre de recherche et un bouton de géolocalisation. Les suggestions de villes apparaissent dynamiquement. La validation se fait uniquement via une suggestion ou la géolocalisation.

## Étapes

### 1. UI/UX
- Rendre le nom de la ville/pays cliquable dans `WeatherHomePageView`.
- Créer une page modale `CitySearchModal` avec :
  - Un champ de recherche en haut
  - Un bouton de géolocalisation à droite du champ
  - Une liste de suggestions dynamiques

### 2. Service/API
- Ajouter une méthode d'autocomplétion de ville dans `WeatherApiService` utilisant l'endpoint `/search.json` de WeatherAPI.
- Créer un modèle léger pour les suggestions de ville (nom, pays, lat, lon).

### 3. ViewModel
- Ajouter la gestion de la recherche de ville et des suggestions dans un nouveau `CitySearchViewModel`.
- Gérer l'état de chargement, la liste des suggestions, la sélection d'une suggestion ou la géolocalisation.

### 4. Intégration
- Ouvrir le modal à partir du clic sur la ville/pays.
- Lors de la sélection d'une suggestion ou du bouton géolocalisation, fermer le modal et mettre à jour la météo.

### 5. Tests & UX
- Vérifier le bon affichage des suggestions et la sélection.
- Vérifier la gestion des erreurs (pas de résultat, erreur réseau, etc).

### 6. Nettoyage
- Mettre à jour le plan à chaque étape.
- Déplacer le plan dans `plan_archive` à la fin.

---

## Tâches à réaliser
- [x] Rendre le nom de la ville/pays cliquable
- [x] Créer la page modale de recherche
- [x] Ajouter l'autocomplétion côté service
- [x] Créer le modèle de suggestion de ville
- [x] Créer le ViewModel de recherche
- [x] Intégrer la logique dans la vue principale
- [x] Gérer la sélection et la géolocalisation
- [ ] Tests et UX
- [ ] Archivage du plan 