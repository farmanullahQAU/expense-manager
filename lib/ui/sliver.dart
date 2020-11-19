import 'package:expense_manager/controllers/pm_home_controller.dart';
import 'package:expense_manager/controllers/authController/auth_controller.dart';
import 'package:expense_manager/controllers/user_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class SliverTabView extends GetWidget<AuthController> {
  List<String> _tabs = ['One', 'Two', 'Three'];
  final TextEditingController _todoController = TextEditingController();
  final UsrController _studentController = Get.put(UsrController());

  //admin home

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: DefaultTabController(
        length: _tabs.length,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                forceElevated: innerBoxIsScrolled,
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text(
                      "Collapsing Toolbar",
                      // style: TextStyle(
                      //   color: Colors.white,
                      //   fontSize: 16.0,
                      // )
                    ),
                    background: Image.network(
                      "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                      fit: BoxFit.cover,
                    )),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    labelColor: Theme.of(context).accentColor,
                    unselectedLabelColor: Colors.grey,
                    tabs: _tabs.map((String name) => Tab(text: name)).toList(),
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(
            children: [
              First(),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    ));
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

class First extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text('First page'),
      ),
    );
  }
}
