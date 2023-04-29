import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({
    super.key,
    required this.meal,
    required this.onSelectMeal,
  });
  final Meal meal;
  final void Function(BuildContext context, Meal meal) onSelectMeal;

  String get complexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      // by only setting shape, we don't see the rounded edges, because the Stack ignores it
      // by setting ClipBehaviour as hardEdge, we ensure that any element displayed beyond the size is cut off
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () => onSelectMeal(context, meal),
        // Stack widget is used to render widgets directly above each other
        // Takes a list of widgets as children, first widget is bottom most, second on top of it...
        child: Stack(
          children: [
            // FadeInImage is a widget that is used to display an image in a cool way
            // the place holder image fades away gradually, while the actual image is being loaded
            // MemoryImage class loads images from memory
            // Network image loads image from the internet
            FadeInImage(
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                // BoxFit.cover ensures that the image fits properly, if the image is larger, then automatically cropped
                // if image is smaller, it's height or width is increased
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl)),
            // Positioned is used to set a widget on top of another
            Positioned(
              // these values set where the child starts or ends wrt it's bottom widget in the stack
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 44),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      // softWrap automatically fits the text within the available space
                      overflow: TextOverflow.ellipsis,
                      // in case of very long text, the text is cut off with ... at end
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTrait(
                            icon: Icons.schedule,
                            label: '${meal.duration} mins'),
                        // we are able to use row inside a row without using expanded because:
                        // this row is wrapped inside a column which is wrapped inside Positioned
                        // the positioned fixes the width, i.e. from where it starts and ends, hence expanded
                        //is not required
                        const SizedBox(
                          width: 12,
                        ),
                        MealItemTrait(icon: Icons.work, label: complexityText),
                        const SizedBox(
                          width: 12,
                        ),
                        MealItemTrait(
                            icon: Icons.attach_money, label: affordabilityText)
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
