import 'package:flutter/material.dart';
import 'package:frontend/screens/add_category.dart';
import 'package:frontend/screens/side_bar.dart';
import 'package:provider/provider.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import '../components/category_tile.dart';
import '../providers/category_provider.dart';
import '../services/category.dart';

class DisplayCategory extends StatefulWidget {
  const DisplayCategory({Key? key}) : super(key: key);

  @override
  State<DisplayCategory> createState() => _DisplayCategoryState();
}

class _DisplayCategoryState extends State<DisplayCategory> {
  bool isDeleted = false;

  @override
  void didChangeDependencies() {
       super.didChangeDependencies();
    Provider.of<CategoryProvider>(context).getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("283B71"),
        title: Expanded(
          child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Category",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              )),
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
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemCount: Provider.of<CategoryProvider>(context).categories.length,
          itemBuilder: (context, index) {
            return CategoryTile(
                category: Provider.of<CategoryProvider>(context)
                    .categories
                    .elementAt(index));
          },
        ),
      ),
    );
  }
}
