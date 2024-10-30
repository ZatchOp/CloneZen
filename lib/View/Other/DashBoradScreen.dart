import 'dart:developer';

import 'package:fitzenapp/Utils/ReUsibleWidgets/drawer_text.dart';
import 'package:fitzenapp/Utils/ReUsibleWidgets/searchBarWidget.dart';
import 'package:flutter/material.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

//TextEditing Controller
TextEditingController textEditingController = TextEditingController();
bool isDrawerOpen = false;

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawerScrimColor: Colors.white,
      // onDrawerChanged: (value) {
      //isDrawerOpen ? Colors.white :
      //   log("Drawer is Open");
      //   setState(() {
      //     isDrawerOpen = !isDrawerOpen;
      //   });
      // },
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true, // Centers the content in the AppBar
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Builder(
              builder: (context) {
                return IconButton(
                  splashColor: Colors.deepOrange,
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.deepOrange,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ),
            const SizedBox(
              width: 5,
            ),
            const Flexible(
              flex: 2,
              child: CustomSearchBar(
                  hintText: "Search by Events, Location, Activities etc..."),
            ),
            const SizedBox(
              width: 5,
            ),
          ],
        ),
      ),
      drawer: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 20),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.transparent, // Background color of the drawer
              boxShadow: [
                BoxShadow(
                  color: Colors.deepOrange.shade400, // Shadow color
                  spreadRadius: 2,
                  blurRadius: 5,     
                  offset:
                      const Offset(-1, 0), // Position the shadow to the left
                ),
              ],
            ),
            child: Drawer(
              surfaceTintColor: Colors.deepOrange,
              elevation: 2.0,
              // shadowColor: Colors.deepOrange.shade400,
              width: MediaQuery.of(context).size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.deepOrange.withOpacity(0.5),
                            offset: const Offset(0, 3),
                            blurRadius: 0.5,
                            spreadRadius: 0.3)
                      ],
                    ),
                    child: Image.asset(
                      "assets/Images/fitzenlogo.png",
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                  const SizedBox(height: 10),
                  DrawerText(
                      icons: Icons.event,
                      borderColor: Colors.deepOrange,
                      iconColor: Colors.deepOrange,
                      textColor: Colors.grey.shade800,
                      title: "Event"),
                  DrawerText(
                      icons: Icons.list,
                      borderColor: Colors.deepOrange,
                      iconColor: Colors.deepOrange,
                      textColor: Colors.grey.shade800,
                      title: "List an Events + "),
                  DrawerText(
                      icons: Icons.login,
                      borderColor: Colors.deepOrange,
                      iconColor: Colors.deepOrange,
                      textColor: Colors.grey.shade800,
                      title: "Login"),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SizedBox(
        height: 200,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 0,
          itemBuilder: (context, index) {
            return Container(
              // margin: const EdgeInsets.all(10),
              // padding: const EdgeInsets.all(10),
              width: 150,
              color: Colors.red,
              child: Center(child: Text("$index")),
            );
          },
        ),
      ),
    );
  }
}
