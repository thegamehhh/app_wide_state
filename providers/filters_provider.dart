import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Filter { glutenFree, lactoseFree, vegetarian, vegan }

class FiltersProviderNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersProviderNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegan: false,
          Filter.vegetarian: false
        });
  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    //state[filter] = isActive; //not allowed! => mutating state
    state = {...state, filter: isActive};
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersProviderNotifier, Map<Filter, bool>>(
        (ref) => FiltersProviderNotifier());
