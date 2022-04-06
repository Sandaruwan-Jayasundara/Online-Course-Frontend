import 'package:flutter/material.dart';

import '../screens/update_category.dart';
import '../services/category.dart';

class CategoryTile extends StatelessWidget {
  final Category category;
  const CategoryTile({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Card(
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: Image.asset(category.CategoryImage!)),
            Text(
              category.CategoryName!,
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => UpdateCategory(
                                category: category,
                              )));
                    },
                    icon: Icon(Icons.update)),
                SizedBox(
                  width: 20,
                ),
                IconButton(
                    onPressed: () {
                      _delete(context);
                    },
                    icon: Icon(Icons.delete)),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _delete(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('Please Confirm'),
            content: const Text('Are you sure to remove the category ?'),
            actions: [
              // The "Yes" button
              TextButton(
                  onPressed: () {
                    // Remove the course

                    Category.removeCategory(category.categoryId!);
                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: const Text('Yes')),
              TextButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: const Text('No'))
            ],
          );
        });
  }
}
