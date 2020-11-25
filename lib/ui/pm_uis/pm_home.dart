import 'package:expense_manager/controllers/pm_hom_botom_Nav_controller.dart';
import 'package:expense_manager/controllers/pm_home_controller.dart';
import 'package:expense_manager/controllers/authController/auth_controller.dart';
import 'package:expense_manager/controllers/user_controller.dart';
import 'package:expense_manager/db_services/database.dart';
import 'package:expense_manager/ui/add_customer.dart';
import 'package:expense_manager/ui/pm_uis/reports_tab_.dart';
import 'package:expense_manager/ui/sliver.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

import 'add_new_tab.dart';
import 'add_project.dart';
import 'vendor_chart.dart';

class PmHomeBottomNav extends GetWidget<PmHomeBottomNavController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.add_a_photo),
              title: Text('Upload Images'),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ],
        ),
      ),
      body: Obx(
        () => controller.getBottomNavigationPage
            .elementAt(controller.getBottomNavSeleIndex),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          selectedFontSize: 15,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Add Project',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.school,
              ),
              label: 'School',
            ),
          ],
          currentIndex: controller.getBottomNavSeleIndex,
          onTap: (int index) {
            //  print(controller.getBottomNavSeleIndex);
            controller.setBottomNavSeleIndex = index;
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.person_add),
          onPressed: () {
            Get.toNamed('uploadPictureUi');
            // Get.defaultDialog(title: 'Add new user', actions: [AddCustomer()]);
          }),
    );
  }
}

class PmHomeTabNav extends GetWidget<PmHomeTabNavController> {
  TabController _tabController;

  List<Map<String, dynamic>> _tabs = [
    {'name': 'Add new', 'Icon': Icon(Icons.add_box)},
    {'name': 'Reports', 'Icon': Icon(Icons.report)},
    {'name': 'Message', 'Icon': Icon(Icons.add_alert)}
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              actions: [
                IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      Get.toNamed('addProject');
                    }),
                IconButton(
                    icon: Icon(Icons.add_to_home_screen),
                    onPressed: () {
                      Get.to(SliverTabView());
                    }),
                IconButton(
                    icon: Icon(Icons.theaters),
                    onPressed: () {
                      Get.isDarkMode
                          ? Get.changeTheme(ThemeData.light())
                          : Get.changeTheme(ThemeData.dark());
                    }),
                IconButton(
                    icon: Icon(Icons.exit_to_app),
                    onPressed: () {
                      Get.find<AuthController>().logout();
                    }),
              ],
              forceElevated: innerBoxIsScrolled,
              expandedHeight: 100.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Obx(() => Text(controller.tabTitle.value)),
                  background: Image.network(
                    "https://propakistani.pk/wp-content/uploads/2020/08/Construction.jpg",
                    fit: BoxFit.cover,
                  )),
            ),
            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(
                TabBar(
                  onTap: (int index) {
                    controller.tabTitle.value = _tabs[index]['name'];
                  },
                  labelColor: Theme.of(context).accentColor,
                  unselectedLabelColor: Colors.grey,

                  // indicatorColor: Colors.red[100],
                  tabs: _tabs.map((nme) {
                    return Tab(icon: nme['Icon'], text: nme['name']);
                  }).toList(),
                ),
              ),
              pinned: false,
            ),
          ];
        },
        body: TabBarView(
          /* tabB bar view */
          controller: _tabController,
          physics: BouncingScrollPhysics(),
          children: [AddNew(), Reports(), LineChartSample2()],
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this.tabBar);

  final TabBar tabBar;

  @override
  double get minExtent => tabBar.preferredSize.height;
  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

/*
Widget makeCard(BuildContext context) {
  return Column(
    children: <Widget>[
      Text(
        "Add:",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      GetX(builder: (UsrController sController) {
        if (sController.getUserList.length != null) {
          return Expanded(
            child: ListView.builder(
              itemCount: sController.getUserList.length,
              itemBuilder: (_, index) {
                return Card(
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.arrow_drop_down_circle),
                        title: Text(sController.getUserList[index].name),
                        subtitle: Text(
                          'Secondary Text',
                          // style: TextStyle(
                          //     color: Colors.black.withOpacity(0.6)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
                        ),
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.start,
                        children: [
                          FlatButton(
                            textColor: Theme.of(context).accentColor,
                            onPressed: () {
                              // Perform some action
                            },
                            child: const Text('ACTION 1'),
                          ),
                          FlatButton(
                            onPressed: () {
                              Get.bottomSheet(
                                Container(
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      IconButton(
                                          icon:
                                              Icon(Icons.vertical_align_bottom),
                                          onPressed: () {}),
                                      Text(
                                        'gggg',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Theme.of(context).accentColor,
                                          fontSize: 24.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                              // Perform some action
                            },
                            child: const Text('ACTION 2'),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        } else
          return Center(
              child: Column(
            children: [Text('loading..'), CircularProgressIndicator()],
          ));
      }),
    ],
  );
}
*/
