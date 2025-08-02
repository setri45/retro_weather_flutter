import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retro_weather_flutter/viewmodels/city_search_viewmodel.dart';
import 'package:retro_weather_flutter/models/city_suggestion.dart';

class CitySearchModal extends StatelessWidget {
  final void Function(CitySuggestion)? onCitySelected;
  final void Function()? onGeolocSelected;

  const CitySearchModal({Key? key, this.onCitySelected, this.onGeolocSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CitySearchViewModel(),
      child: Consumer<CitySearchViewModel>(
        builder: (context, vm, _) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 16,
              right: 16,
              top: 24,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: 'Rechercher une ville',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                        onChanged: (value) => vm.searchCity(value),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.my_location),
                      tooltip: 'Utiliser ma position',
                      onPressed: () async {
                        if (onGeolocSelected != null) onGeolocSelected!();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                if (vm.isLoading) const CircularProgressIndicator(),
                if (vm.error != null) Text(vm.error!, style: const TextStyle(color: Colors.red)),
                if (!vm.isLoading && vm.suggestions.isEmpty && vm.error == null)
                  const Text('Aucune suggestion'),
                if (vm.suggestions.isNotEmpty)
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: 300, // max ~6 suggestions visibles
                    ),
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: vm.suggestions.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final suggestion = vm.suggestions[index];
                        return ListTile(
                          title: Text('${suggestion.name}, ${suggestion.country}'),
                          subtitle: suggestion.region != null ? Text(suggestion.region!) : null,
                          onTap: () {
                            if (onCitySelected != null) onCitySelected!(suggestion);
                          },
                        );
                      },
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
} 