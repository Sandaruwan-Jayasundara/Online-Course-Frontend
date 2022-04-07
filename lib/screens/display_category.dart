import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/add_category.dart';
import 'package:frontend/screens/side_bar.dart';
import 'package:google_fonts/google_fonts.dart';
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
     backgroundColor: Colors.orange,
     title: Expanded(
          child: Container(
              alignment: Alignment.centerLeft,
              child: Center(
                child: Text(
                  "Category",
                  style: GoogleFonts.oswald(fontSize: 25),
                ),
              )),
        ),
        actions: [
          Tooltip(
            waitDuration: Duration(seconds: 1),
            showDuration: Duration(seconds: 2),
            message: 'Add New Category',
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AnimatedSplashScreen(
                          splash: Icons.add_sharp,
                          splashTransition: SplashTransition.fadeTransition,
                          duration: 3000,
                          nextScreen: AddCategory())));
                },
                icon: const Icon(Icons.add_sharp)),
          )
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
