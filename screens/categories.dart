import 'package:flutter/material.dart';
import 'package:app_wide_state/data/dummy_data.dart';
import 'package:app_wide_state/models/category.dart';
import 'package:app_wide_state/models/meal.dart';
import 'package:app_wide_state/screens/meals.dart';
import 'package:app_wide_state/widgets/category_grid_item.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.availableMeals});

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationCreation;
  @override
  void initState() {
    super.initState();
    _animationCreation = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
        lowerBound: 0, //default no need to add lower and upper bound
        upperBound: 1);
    _animationCreation.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationCreation.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filterdMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    // Navigator.of(context).push(route)
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => MealsScreen(
            title: category.title,
            meals: filterdMeals,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return //Scaffold(
        //appBar: AppBar(title: const Text('Please pick a category')),
        //body:
        AnimatedBuilder(
            animation: _animationCreation,
            child: GridView(
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
            ),
            builder: (context, child) => SlideTransition(
                  position: Tween(
                          begin: const Offset(0, 0.3), end: const Offset(0, 0))
                      .animate(CurvedAnimation(
                          parent: _animationCreation, curve: Curves.easeInOut)),
                  child: child,
                ));
  }
}
