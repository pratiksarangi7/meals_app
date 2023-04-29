import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/dummy_data.dart';

final mealsProvider = Provider(
    // Provider takes a positional parameter, i.e., a function
    // the function takes in a ProviderRef(of dynamic type), provided by the package internally
    (ref) {
  return dummyMeals;
  // when we do ref.watch(mealsProvider) outside somewhere, the mealsProvider is passed into this function internally
  // and dummyMeals is returned
});
