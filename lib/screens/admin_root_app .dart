import 'package:flutter/material.dart';
import 'package:frontend/screens/account.dart';
import 'package:frontend/screens/chat.dart';
import 'package:frontend/screens/display_category.dart';
import 'package:frontend/screens/display_contact.dart';
import 'package:frontend/screens/display_course.dart';
import 'package:frontend/screens/display_payment.dart';
import 'package:frontend/screens/display_user.dart';
import 'package:frontend/theme/color.dart';
import 'package:frontend/utils/constant.dart';
import 'package:frontend/widgets/bottombar_item.dart';



class AdminRootApp extends StatefulWidget {
  const AdminRootApp({ Key? key }) : super(key: key);

  @override
  _AdminRootAppState createState() => _AdminRootAppState();
}

class _AdminRootAppState extends State<AdminRootApp>  with TickerProviderStateMixin{
  int activeTab = 0;
  List barItems = [
    {
      "icon" : "assets/icons/home.svg",
      "active_icon" : "assets/icons/home.svg",
      "page" : CourseDisplay(),
    },
    {
      "icon" : "assets/icons/shield.svg",
      "active_icon" : "assets/icons/search.svg",
      "page" : DisplayCategory(),
    },
    {
      "icon" : "assets/icons/play.svg",
      "active_icon" : "assets/icons/play.svg",
      "page" : UserDisplay(),
    },
    {
      "icon" : "assets/icons/chat.svg",
      "active_icon" : "assets/icons/chat.svg",
      "page" : DisplayPayment(),
    }
    ,
    {
      "icon" : "assets/icons/chat.svg",
      "active_icon" : "assets/icons/chat.svg",
      "page" : DisplayContact(),
    }

  ];

//====== set animation=====
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: ANIMATED_BODY_MS),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void initState() {
    super.initState();
     _controller.forward();
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    super.dispose();
  }

  animatedPage(page){
    return FadeTransition(
      child: page,
      opacity: _animation
    );
  }

  void onPageChanged(int index) {
    _controller.reset();
    setState(() {
      activeTab = index;
    });
    _controller.forward();
  }

//====== end set animation=====

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      bottomNavigationBar: getBottomBar(),
      body: getBarPage()
    );
  }

  Widget getBarPage(){
    return 
      IndexedStack(
        index: activeTab,
        children: 
          List.generate(barItems.length, 
            (index) => animatedPage(barItems[index]["page"])
          )
      );
  }

  Widget getBottomBar() {
    return Container(
      height: 75,
      width: double.infinity,
      decoration: BoxDecoration(
        color: bottomBarColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25), 
          topRight: Radius.circular(25)
        ), 
        boxShadow: [
          BoxShadow(
            color: shadowColor.withOpacity(0.1),
            blurRadius: 1,
            spreadRadius: 1,
            offset: Offset(1, 1)
          )
        ]
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, bottom: 15,),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(barItems.length, 
            (index) => BottomBarItem(barItems[index]["icon"], isActive: activeTab == index, activeColor: primary,
              onTap: (){
                onPageChanged(index);
              },
            )
          )
        )
      ),
    );
  }

}