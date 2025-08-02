# Plan : Prévisions sur 7 jours dans l'onglet "Semaine"

## Objectif
Afficher dans l'onglet Semaine les prévisions météo pour les 7 prochains jours, avec pour chaque jour :
- le nom du jour
- l'icône météo
- la température minimale (avec flèche bas)
- la température maximale (avec flèche haut)

## Étapes

- [x] **Créer le modèle `DailyForecast`**
   - Champs : date, minTempC, maxTempC, conditionCode, isDay
- [x] **Adapter le parsing dans `WeatherData`**
   - Ajouter une liste de `DailyForecast` dans WeatherData
   - Adapter le factory `fromJson` pour remplir cette liste à partir de l'API
- [x] **Adapter le service API**
   - Modifier la requête pour demander 7 jours (`days=7`)
   - S'assurer que la ViewModel transmet bien la liste des 7 jours à la vue
- [x] **Créer un widget d'affichage pour une prévision journalière**
   - Afficher le nom du jour, l'icône, min et max côte à côte avec flèches
- [x] **Afficher la liste des 7 jours dans l'onglet Semaine**
   - Utiliser une ListView ou une grille verticale
   - Style cohérent avec le reste de l'app (neumorphique, minimaliste)
- [x] **Tests et ajustements UI/UX**
   - Vérifier le rendu, l'espacement, la lisibilité
   - Adapter si besoin pour mobile

---

Chaque étape sera cochée et le plan archivé une fois terminé. 