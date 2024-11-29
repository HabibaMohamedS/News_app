import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key, required this.onSelect});
  final Function(drawerItem) onSelect;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320.w,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(0),
            height: 110.h,
            width: 320.w,
            color: Colors.green,
            child: Text("News App"),
          ),
          Container(
            child: Column(children: [
              ListTile(
                onTap: () => onSelect(drawerItem.categories),
                leading: Icon(Icons.list),
                title: Text("Categories"),
              ),
              ListTile(
                onTap: () => onSelect(drawerItem.settings),
                leading: Icon(Icons.settings),
                title: Text("Settings"),
              ),
            ]),
          )
        ],
      ),
    );
  }
}

enum drawerItem { settings, categories }
