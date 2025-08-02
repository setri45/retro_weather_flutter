# retro_weather_flutter

# Application Météo Flutter – Plan d'action

## Checklist de développement

- [x] Ajouter les packages nécessaires dans pubspec.yaml (http, geolocator, flutter_typeahead)
- [x] Mettre en place la structure de l'UI (ville, température, CustomPaint, infos complémentaires)
- [x] Créer le widget CustomPaint pour dessiner l'icône météo façon "pixel art"
- [x] Intégrer la géolocalisation pour obtenir la position de l'utilisateur
- [x] Faire les appels à l'API WeatherAPI.com pour récupérer la météo selon la position ou la ville recherchée
- [ ] Ajouter la recherche de ville
- [x] Peaufiner le design pour coller au maximum à l'exemple

## Packages Flutter à utiliser
- [x] http : pour les requêtes API
- [x] geolocator ou location : pour la géolocalisation
- [x] flutter_typeahead ou TextField : pour la recherche de ville
- [ ] provider ou riverpod (optionnel) : pour la gestion d'état

---

L'API utilisée pour la météo est désormais https://weatherapi.com.
Ce plan sera mis à jour au fur et à mesure de l'avancement du projet.

---

### 🏛️ Plan de Migration vers une Architecture MVVM

L'objectif est de faire évoluer l'application d'un simple `StatefulWidget` vers une architecture MVVM (Model-View-ViewModel) robuste, testable et maintenable, en utilisant le pattern Repository pour l'accès aux données.

#### Phase 1 : Refactoring et Organisation du Code
- [ ] **Créer la structure de dossiers** : `models`, `services`, `viewmodels`, `views`, `widgets`.
- [ ] **Déplacer les widgets existants** :
  - `WeatherInfoTile` → `lib/widgets/weather_info_tile.dart`
  - `ForecastTile` → `lib/widgets/forecast_tile.dart`
  - `WeatherIconPainter` (et ses matrices) → `lib/widgets/weather_icon_painter.dart`
- [ ] **Déplacer la vue principale** :
  - Renommer `WeatherHomePage` en `WeatherHomePageView`.
  - Déplacer la vue dans `lib/views/weather_home_page_view.dart`.

#### Phase 2 : Extraction de la Logique Métier (Services et Modèles)
- [ ] **Créer les Modèles de Données** :
  - `lib/models/weather_data.dart` pour encapsuler toutes les données relatives à la météo (actuelle, prévisions, etc.).
  - `lib/models/location_data.dart` pour les données de localisation.
- [ ] **Créer les Services (Repository Pattern)** :
  - `lib/services/location_service.dart` pour toute la logique de géolocalisation.
  - `lib/services/weather_api_service.dart` pour gérer les appels à WeatherAPI.com.

#### Phase 3 : Implémentation du MVVM avec `provider`
- [ ] **Ajouter le package `provider`** au fichier `pubspec.yaml`.
- [ ] **Créer le `WeatherViewModel`** :
  - Créer `lib/viewmodels/weather_viewmodel.dart` qui étendra `ChangeNotifier`.
  - Il exposera l'état de l'UI (`isLoading`, `weatherData`, `error`).
  - Il utilisera les services créés en Phase 2 pour charger les données.
- [ ] **Connecter la Vue au ViewModel** :
  - Remplacer `setState()` par des appels aux méthodes du `WeatherViewModel`.
  - Utiliser `ChangeNotifierProvider`, `Consumer` ou `context.watch` dans la vue pour réagir aux changements d'état.

#### Phase 4 : Finalisation et Fonctionnalités
- [ ] **Utiliser les vraies données de prévisions** :
  - Modifier l'appel API pour utiliser l'endpoint `forecast.json`.
  - Mettre à jour le `WeatherViewModel` et le `WeatherData` model.
  - Afficher les **vraies températures min/max** et les **vraies prévisions horaires**.
- [ ] **Nettoyer `main.dart`** pour ne laisser que le strict minimum (lancement de l'app et injection du provider).
- [ ] **Améliorer la gestion des erreurs** et les indicateurs de chargement dans l'UI.