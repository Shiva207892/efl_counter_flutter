import 'package:efl_counter/controllers/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Drawer Header',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text('Home'),
            onTap: () {
              Get.find<AppController>().setCurrentPageIndex(0);
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            title: Text('Profile'),
            onTap: () {
              Get.find<AppController>().setCurrentPageIndex(1);
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            title: Text('Contact Us'),
            onTap: () {
              Get.find<AppController>().setCurrentPageIndex(2);
              Navigator.of(context).pop();
            },
          ),
          // Add more list tiles for additional items in the drawer
        ],
      ),
    );
  }
}