import 'package:flutter/material.dart';
import 'package:meals/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/category_grid_item.dart';
import 'package:meals/models/category.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.availableMeals});
  final List<Meal> availableMeals;

  //this is a function that decides what will happen when a category on the category screen is tapped
  void _selectCategory(BuildContext context, Category category) {
    // we get a category in this function as an argument, and search dummyMeals for meals of that category:
    final filteredMeals = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    // The screens are arranged in a stack, and the user is only able to see the top element of the screen stack
    // when something is pushed into the screen stack, then that becomes the top element of the screen
    // route represents a screen or a page on the app, used to navigate between different pages
    // MaterialPageRoute creates a route that can be pushed into the screen stack
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MealsScreen(
              title: category.title,
              meals: filteredMeals,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(24),
      // gridDelegate controls the layout of the widgets in the grid
      // crossAxis-from left to right
      // childAspectRatio: determines relative width wrt height of child in the app
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      children: [
        // this is an alternative of using categories.map method
        for (final category in availableCategories)
          CategoryGridItem(
              category: category,
              onSelectCategory: () => _selectCategory(context, category))
      ],
    );
  }
}
