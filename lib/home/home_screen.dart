import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do_app1/home/home_list/list_tab.dart';
import 'package:to_do_app1/home/home_settings/settings_tab.dart';

import 'home_list/addtaskbottom.dart';

class HomeScreen extends StatefulWidget {
  static const String routename = "Home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.15,
        title: Text(
          selectedindex == 0
              ? AppLocalizations.of(context)!.app_title
              : AppLocalizations.of(context)!.settings,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: BottomNavigationBar(
          currentIndex: selectedindex,
          onTap: (index) {
            selectedindex = index;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.list,
                  size: 40,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                  size: 40,
                ),
                label: ""),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddTaskBottom();
        },
        child: Icon(
          Icons.add,
          size: 35,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: selectedindex == 0 ? TaskTab() : SettingsTab(),
    );
  }

  void showAddTaskBottom() {
    showModalBottomSheet(
        context: context, builder: (context) => AddTaskBottom());
  }
}
