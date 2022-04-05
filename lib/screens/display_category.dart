import 'package:flutter/material.dart';
import 'package:frontend/screens/add_category.dart';
import 'package:frontend/screens/side_bar.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import '../services/category.dart';

class DisplayCategory extends StatelessWidget {
  const DisplayCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            backgroundColor: HexColor("283B71"),
             title:Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text("Category", 
                      style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600)
                    ,)
                  ),
                ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AddCategory.routeName);
              },
              icon: const Icon(Icons.ad_units))
        ],
      ),
         drawer: SideBar(),
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
