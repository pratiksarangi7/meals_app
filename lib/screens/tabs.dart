import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/filters.dart';
import 'package:meals/widgets/main_drawer.dart';
import 'package:meals/providers/favourites_provider.dart';
import 'package:meals/providers/fliters_provider.dart';

// global variables start with k in flutter(convention)
const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegeterian: false,
  Filter.vegan: false,
};

// ConsumerStatefulWidget is a stateful widget, with some added functionalities
// that allow us to listen to provider and make changes in the provider values

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key});

  @override
  ConsumerState<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends ConsumerState<TabScreen> {
  int _selectedPageIndex = 0;
  // we set all the initial values to false, should be updated whenever we recieve new information from filters screen:

  void _selectPage(int index) {
    // flutter automatically passes the reqd index
    setState(() {
      _selectedPageIndex = index;
    });
  }
// async is used to declare the function as asynchronous, which means that it won't execute right away
// asynchronous functions are split off from the main function, and executed separately
// (because it needs to wait for something to complete, or do some operation that takes a long time)

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    // we perform the above pop to close the drawer in any case, whether the filters is chosen or not
    if (identifier == 'filters') {
      // push returns a future object
      // result is only set when push returns something(we are able to achieve this using await)
      // although the result here is of dynamic type, we know that the push method returns
      // a map <Filter, bool>, and so we set the return value of push as that, and so the result is
      // also set as that
      await Navigator.of(context)
          .push<Map<Filter, bool>>(MaterialPageRoute(builder: (context) {
        // By making it const, the properties of the FiltersScreen can't be changed, but state can be modified
        return const FiltersScreen();
      }));
      // if result is null, then the selectedFilters is set to a default
      // we call the setState method here so that when the _selectedFilters is set,
      // the build method is called, so that the screen is rebuilt
    }
  }

  // toggleMealStatus can't be passed into meal_details directly
  // it has to be first passed into meals screen or the categories screen, which then pass it into meal_details

  @override
  Widget build(BuildContext context) {
    // ref is provided by riverPod, which allows us to create listeners to providers
    // ref.read used to set up a listener that listens the provider data once
    // ref.watch used to set up a listener that calls build method when ever the provider data is changed
    // recommended to always use watch, even if you are reading data once
    final availableMeals = ref.watch(filteredMealsProvider);

    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
    );
    var activePageTitle = "Categories";
    if (_selectedPageIndex == 1) {
      final favouriteMeals = ref.watch(favouriteMealsProvider);
      activePage = MealsScreen(
        meals: favouriteMeals,
      );
      activePageTitle = " Your Favourites";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        // onTap function receives an int value as index, which is the index value of the icon that is tapped
        //currentIndex is used to tell the navigation bar which index is selected, so that it is highlighted
        currentIndex: _selectedPageIndex,
        onTap: _selectPage,
        items: const [
          // Icon takes in icon data(and other stuffs), and renders it as a widget on screen
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favourites'),
        ],
      ),
    );
  }
}
