# Plan : Adapter l'onglet Semaine à une interface en grille (style 24H)

## Objectif
Avoir un affichage des prévisions sur 7 jours dans l'onglet Semaine, sous forme de grille moderne et compacte, similaire à l'onglet 24H.

## Étapes

- [x] **Analyser la structure de l'onglet 24H**
   - Relever le widget principal utilisé (GridView, tuiles, etc.)
   - Noter le style et la disposition
2. **Adapter l'onglet Semaine**
   - Remplacer le ListView par un GridView.builder
   - Utiliser le widget DailyForecastTile ou l'adapter pour un rendu compact
   - Afficher 2 ou 3 colonnes selon la largeur de l'écran
3. **Harmoniser le style**
   - S'assurer que les tuiles météo semaine ont le même look (fond, ombre, coins arrondis, etc.)
   - Ajuster la taille des icônes et textes pour la grille
4. **Tests et ajustements**
   - Vérifier le rendu sur mobile
   - Ajuster l'espacement, la lisibilité, la réactivité

---

Chaque étape sera cochée et le plan archivé une fois terminé. 