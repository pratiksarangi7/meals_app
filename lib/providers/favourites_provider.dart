// To store all the favourite meals in a list
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';

// StateNotifierProvider is a special type of Provider that is optimised for data that can change

// we create our own notifier by extending stateNotifier

//StateNotifier<Type_of_data_managed_in_StateNotifier>

class FavouriteMealsNotifier extends StateNotifier<List<Meal>> {
  // setting up the initial data:
  // super is used to reach out to the parent class(stateNotifier)
  // we pass in our initial data to super(initial data: empty list)
  // when it is initialized for parent, automatically initialized for child

  FavouriteMealsNotifier() : super([]);
  // method to change the favourite List:

  bool toggleMealFavouriteStatus(Meal meal) {
    // inside StateNotifier, we can't edit the current data
    // we must always create new data, and replace the old data entirely
    // so we cant do .add() or .remove()
    // state is a globally available property which holds your data(here, a list of meals)
    final mealIsFavourite = state.contains(meal);
    // check if meal is present or not in the favourite list
    if (mealIsFavourite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      // we first pull out all the elements from the initial list and store it in [], and also store the new meal in it as well
      // here we are not modifying, but creating an entirely new list
      return true;
    }
  }
}

//StateNotifierProvider<_from_which_notifier_the_data_will_be_yielded, _what_data_will_be_yielded>
final favouriteMealsProvider =
    StateNotifierProvider<FavouriteMealsNotifier, List<Meal>>((ref) {
  return FavouriteMealsNotifier();
});
