import 'package:flutter/material.dart';
import 'package:meals/providers/fliters_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// When FiltersScreen is called, if it is set const, then the properties of
// FiltersScreen can't be changed, but the properties of _FiltersScreenState can be changed
//i.e. the state of the widget can be changed

// the above contents of the enum are being used as keys in list

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({
    super.key,
  });
  // we store the current values of the filters in the following:

  @override
  // initState is used to initialize the state of a stateful widget, such as initializing the variables, etc
  // we use this because we can't get access to widget property directly
  // we have access to widget inside initState

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(
        flitersProvider); // this re executes the build method whenever the filterProvider value is changed
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your filters'),
      ),
      // WillPopScope allows us to tell flutter what to do when the current screen is popped
      // out of screen stack
      body: Column(
        children: [
          // SwitchListTile is optimised to be presented in a List full of switches
          SwitchListTile(
            // value controls whether the switch is on or off:
            value: activeFilters[Filter.glutenFree]!,
            // function that receives a boolean, and is triggered when the switch is pressed
            onChanged: (isChecked) {
              // when the onChanged is tapped, whether the icon checked or not is passed by onPressed function as a boolean
              // the value of _glutenFreeFilterSet is set accordingly, and hence the icon displayed also is set accordingly
              ref
                  .read(flitersProvider.notifier)
                  .setFilter(Filter.glutenFree, isChecked);
            },
            // title: label that is shown next to the switch
            title: Text(
              'Gluten-Free',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            subtitle: Text(
              'Only include Gluten-Free meals',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            // value controls whether the switch is on or off:
            value: activeFilters[Filter.lactoseFree]!,
            // function that receives a boolean, and is triggered when the switch is pressed
            onChanged: (isChecked) {
              // when the onChanged is tapped, whether the icon checked or not is passed by onPressed function as a boolean
              // the value of _glutenFreeFilterSet is set accordingly, and hence the icon displayed also is set accordingly
              ref
                  .read(flitersProvider.notifier)
                  .setFilter(Filter.lactoseFree, isChecked);
            },
            // title: label that is shown next to the switch
            title: Text(
              'Lactose-Free',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            subtitle: Text(
              'Only include Lactose-Free meals',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            // value controls whether the switch is on or off:
            value: activeFilters[Filter.vegeterian]!,
            // function that receives a boolean, and is triggered when the switch is pressed
            onChanged: (isChecked) {
              // when the onChanged is tapped, whether the icon checked or not is passed by onPressed function as a boolean
              // the value of _glutenFreeFilterSet is set accordingly, and hence the icon displayed also is set accordingly
              ref
                  .read(flitersProvider.notifier)
                  .setFilter(Filter.vegeterian, isChecked);
            },
            // title: label that is shown next to the switch
            title: Text(
              'Vegeterian',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            subtitle: Text(
              'Only include Vegeterian meals',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            // value controls whether the switch is on or off:
            value: activeFilters[Filter.vegan]!,
            // function that receives a boolean, and is triggered when the switch is pressed
            onChanged: (isChecked) {
              // when the onChanged is tapped, whether the icon checked or not is passed by onPressed function as a boolean
              // the value of _glutenFreeFilterSet is set accordingly, and hence the icon displayed also is set accordingly
              ref
                  .read(flitersProvider.notifier)
                  .setFilter(Filter.vegan, isChecked);
            },
            // title: label that is shown next to the switch
            title: Text(
              'Vegan',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            subtitle: Text(
              'Only include Vegan meals',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
        ],
      ),
    );
  }
}
