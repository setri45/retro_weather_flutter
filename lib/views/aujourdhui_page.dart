import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retro_weather_flutter/viewmodels/weather_viewmodel.dart';
import 'package:retro_weather_flutter/widgets/weather_icon_painter.dart';
import 'package:retro_weather_flutter/widgets/weather_info_tile.dart';

class AujourdHuiPage extends StatefulWidget {
  const AujourdHuiPage({Key? key}) : super(key: key);

  @override
  State<AujourdHuiPage> createState() => _AujourdHuiPageState();
}

class _AujourdHuiPageState extends State<AujourdHuiPage> {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WeatherViewModel>().loadWeather();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<WeatherViewModel>();
    double iconSize = MediaQuery.of(context).size.width * 0.8;
    iconSize = iconSize > 400 ? 400 : iconSize;

    return SingleChildScrollView(
      child:
          vm.error != null
              ? Text(vm.error!, style: const TextStyle(color: Colors.red))
              : vm.isLoading
              ? const CircularProgressIndicator()
              : vm.weatherData == null
              ? const CircularProgressIndicator()
              : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 32),
                  // Ville et pays
                  Column(
                    children: [
                      Text(
                        vm.weatherData!.city,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 22,
                          fontFamily: 'Audiowide',
                          letterSpacing: 1.5,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        vm.weatherData!.country,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'Audiowide',
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Section températures (min, actuelle, max)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Température minimale réelle
                      Column(
                        children: [
                          const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.black87,
                            size: 48,
                          ),
                          Text(
                            '${vm.weatherData!.minTempC.round()}°',
                            style: const TextStyle(
                              fontSize: 24,
                              fontFamily: 'Audiowide',
                              color: Colors.black87,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      // Température actuelle
                      Text(
                        '${vm.weatherData!.tempC.round()}°',
                        style: const TextStyle(
                          fontSize: 64,
                          fontFamily: 'Audiowide',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Température maximale réelle
                      Column(
                        children: [
                          const Icon(
                            Icons.keyboard_arrow_up,
                            color: Colors.black87,
                            size: 48,
                          ),
                          Text(
                            '${vm.weatherData!.maxTempC.round()}°',
                            style: const TextStyle(
                              fontSize: 24,
                              fontFamily: 'Audiowide',
                              color: Colors.black87,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Zone CustomPaint pour l'icône météo
                  Container(
                    width: iconSize,
                    height: iconSize * 0.7,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: CustomPaint(
                        painter: WeatherIconPainter(
                          code: vm.weatherData!.conditionCode,
                          isDay: vm.weatherData!.isDay,
                        ),
                        child: Container(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Carrousel d'infos météo
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24.0),
                    padding: const EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[400]!,
                          offset: const Offset(8, 8),
                          blurRadius: 15,
                          spreadRadius: 1,
                        ),
                        BoxShadow(
                          color: Colors.white,
                          offset: const Offset(-4, -4),
                          blurRadius: 15,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 140,
                          child: PageView(
                            controller: _pageController,
                            onPageChanged: (index) {
                              setState(() {
                                _currentPage = index;
                              });
                            },
                            children: [
                              // Page 1 : infos météo actuelles
                              Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Column(
                                  children: [
                                    Text(
                                      vm.weatherData!.conditionText,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'Audiowide',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        WeatherInfoTile(
                                          label: 'RESSENTI',
                                          value: '${vm.weatherData!.feelsLikeC.round()}°',
                                        ),
                                        WeatherInfoTile(
                                          label: 'VENT',
                                          value: '${vm.weatherData!.windKph.round()} KM/H',
                                        ),
                                        WeatherInfoTile(
                                          label: 'VISIBILITÉ',
                                          value: '${vm.weatherData!.visKm} KM',
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              // Page 2 : page vide pour extension
                              Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Center(
                                  child: Text(
                                    'À venir…',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Audiowide',
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Indicateurs de page (points)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(2, (index) =>
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: _currentPage == index ? 12 : 8,
                              height: _currentPage == index ? 12 : 8,
                              decoration: BoxDecoration(
                                color: _currentPage == index ? Colors.black87 : Colors.grey[400],
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
    );
  }
}
