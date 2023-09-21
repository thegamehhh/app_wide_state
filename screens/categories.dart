import 'package:flutter/material.dart';
import 'package:app_wide_state/data/dummy_data.dart';
import 'package:app_wide_state/models/category.dart';
import 'package:app_wide_state/models/meal.dart';
import 'package:app_wide_state/screens/meals.dart';
import 'package:app_wide_state/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen(
      {super.key,
      required this.onToggleFavorite,
      required this.availableMeals});
  final void Function(Meal meal) onToggleFavorite;
  final List<Meal> availableMeals;
  void _selectCategory(BuildContext context, Category category) {
    final filterdMeals = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    // Navigator.of(context).push(route)
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => MealsScreen(
            title: category.title,
            meals: filterdMeals,
            onToggleFavorite: onToggleFavorite,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return //Scaffold(
        //appBar: AppBar(title: const Text('Please pick a category')),
        //body:
        GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      children: [
        //availableCategories.map((catergory) => CategoryGridItem(category: category)).toList()
        for (final category in availableCategories)
          CategoryGridItem(
            category: category,
            onSelectCategory: () {
              _selectCategory(context, category);
            },
          )
      ],
    );
  }
}
