import 'package:flutter/material.dart';
import 'package:frontend/screens/add_category.dart';
import '../services/category.dart';

class DisplayCategory extends StatelessWidget {
  const DisplayCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Category")),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AddCategory.routeName);
              },
              icon: const Icon(Icons.ad_units))
        ],
      ),
      body: FutureBuilder(
          future: Category.getAllCategories(),
          builder: (context, AsyncSnapshot<List<Category>> snapshot) {
            List<Category>? categories = snapshot.data;
            if (snapshot.hasData) {
              return GridView.count(
                crossAxisCount: 2,
                children: categories!
                    .map((Category category) => Card(
                          child: ListTile(
                            title: Text(category.CategoryName!),
                            onTap: () {},
                          ),
                        ))
                    .toList(),
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
