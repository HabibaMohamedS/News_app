import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/category_card.dart';
import 'package:news_app/category_details.dart';

import 'dart:async';

import 'package:news_app/drawer.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/settings_screen.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SecondScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).brightness == Brightness.light
          ? Colors.white
          : Color(0xFF141A2E),
      child: Image.asset('assets/logo.png'),
    );
  }
}

class SecondScreen extends StatefulWidget {
  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  // int index = 0;
  // List<CategoryModel> list = [
  //   CategoryModel(color: Colors.red, title: 'Sports', image: 'ball.png'),
  //   CategoryModel(color: Colors.blue, title: 'Politics', image: 'Politics.png'),
  //   CategoryModel(color: Colors.pink, title: 'Health', image: 'health.png'),
  //   CategoryModel(
  //       color: Colors.orange, title: 'Business', image: 'bussines.png'),
  //   CategoryModel(
  //       color: Colors.blueAccent,
  //       title: 'Enviroment',
  //       image: 'environment.png'),
  //   CategoryModel(color: Colors.yellow, title: 'Science', image: 'science.png')
  // ];
  // List<Widget> tabs = [];
  drawerItem selected = drawerItem.categories;
  String? selectedID;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        drawer: Drawer(child: CustomDrawer(
          onSelect: (p0) {
            selectedID = null;
            selected = p0;
            setState(() {});
          },
        )),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          foregroundColor: Colors.transparent,
          backgroundColor: Colors.green,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25)),
          ),
          title: Center(
            child: Text(
              "News App",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        body: selectedID != null
            ? category_details(viewID: selectedID!)
            : selected == drawerItem.categories
                ? Categories(
                    onSelect: (p0) {
                      selectedID = p0;
                      setState(() {});
                    },
                  )
                : Settings_Screen(),
      ),
    );
  }
}

class Categories extends StatelessWidget {
  Categories({super.key, required this.onSelect});
  final int index = 0;
  final List<CategoryModel> list = [
    CategoryModel(
        ID: 'sports', color: Colors.red, title: 'Sports', image: 'ball.png'),
    // CategoryModel(
    //     ID: '2', color: Colors.blue, title: 'Politics', image: 'Politics.png'),
    CategoryModel(
        ID: 'health', color: Colors.pink, title: 'Health', image: 'health.png'),
    CategoryModel(
        ID: 'business',
        color: Colors.orange,
        title: 'Business',
        image: 'bussines.png'),
    // CategoryModel(
    //     ID: '5',
    //     color: Colors.blueAccent,
    //     title: 'Enviroment',
    //     image: 'environment.png'),
    CategoryModel(
        ID: 'science',
        color: Colors.yellow,
        title: 'Science',
        image: 'science.png')
  ];
  final List<Widget> tabs = [];
  final Function(String) onSelect;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover, image: AssetImage('pattern.png'))),
      child: Column(
        children: [
          Text("Pick your category of interest"),
          Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 20.w),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 20.w,
                  crossAxisSpacing: 25.h,
                  crossAxisCount: 2),
              itemBuilder: (context, index) => GestureDetector(
                  onTap: () => onSelect(list[index].ID),
                  child: Category_Card(index: index, model: list[index])),
              itemCount: list.length,
            ),
          ))
        ],
      ),
    );
  }
}
