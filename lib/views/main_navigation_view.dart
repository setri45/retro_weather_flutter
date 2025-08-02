import 'package:flutter/material.dart';
import 'package:retro_weather_flutter/views/aujourdhui_page.dart';
import 'package:retro_weather_flutter/views/vingtquatreh_page.dart';
import 'package:retro_weather_flutter/views/semaine_page.dart';
import 'package:retro_weather_flutter/views/parametres_page.dart';
import 'package:retro_weather_flutter/views/city_search_modal.dart';
import 'package:retro_weather_flutter/models/city_suggestion.dart';
import 'package:provider/provider.dart';
import 'package:retro_weather_flutter/viewmodels/weather_viewmodel.dart';

class MainNavigationView extends StatefulWidget {
  const MainNavigationView({Key? key}) : super(key: key);

  @override
  State<MainNavigationView> createState() => _MainNavigationViewState();
}

class _MainNavigationViewState extends State<MainNavigationView> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onSearchPressed() async {
    final vm = context.read<WeatherViewModel>();
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => CitySearchModal(
        onCitySelected: (CitySuggestion suggestion) async {
          Navigator.of(context).pop();
          await vm.loadWeatherByCoordinates(
            latitude: suggestion.lat,
            longitude: suggestion.lon,
          );
        },
        onGeolocSelected: () async {
          Navigator.of(context).pop();
          await vm.loadWeather();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color background = const Color(0xFFF5F5F5); // fond clair
    final Color shadowLight = Colors.white;
    final Color shadowDark = Colors.black12;
    final Color iconSelected = Colors.black;
    final Color iconUnselected = Colors.grey;

    return Scaffold(
      backgroundColor: background,
      body: Column(
        children: [
          // Barre du haut avec la loupe à droite
          Padding(
            padding: const EdgeInsets.only(top: 32, left: 16, right: 16, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (_selectedIndex != 3)
                  IconButton(
                    icon: Icon(Icons.search, color: iconSelected, size: 28),
                    onPressed: _onSearchPressed,
                    tooltip: 'Rechercher une ville',
                  ),
              ],
            ),
          ),
          // Contenu principal
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: const [
                AujourdHuiPage(),
                VingtQuatreHPage(),
                SemainePage(),
                ParametresPage(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: background,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: shadowLight,
              offset: const Offset(-4, -4),
              blurRadius: 12,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: shadowDark,
              offset: const Offset(4, 4),
              blurRadius: 12,
              spreadRadius: 1,
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: iconSelected,
          unselectedItemColor: iconUnselected,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.wb_sunny_outlined),
              label: "Aujourd'hui",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.access_time),
              label: "24H",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: "Semaine",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Paramètres",
            ),
          ],
        ),
      ),
    );
  }
} 