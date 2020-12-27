import 'package:cached_network_image/cached_network_image.dart';
import 'package:expense_manager/controllers/pm_hom_botom_Nav_controller.dart';
import 'package:expense_manager/controllers/pm_home_controller.dart';
import 'package:expense_manager/controllers/authController/auth_controller.dart';
import 'package:expense_manager/controllers/profileController/profile_controller.dart';
import 'package:expense_manager/controllers/user_controller.dart';
import 'package:expense_manager/ui/pm_uis/report_tab.dart';
import 'package:expense_manager/ui/pm_uis/viewTab.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:expense_manager/models/project_model.dart';
import 'package:expense_manager/controllers/select_project_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

import 'add_new_tab.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:expense_manager/ui/selectProject.dart';

class PmHomeBottomNav extends GetWidget<PmHomeBottomNavController> {
  var usrController = Get.put(UsrController());
  var profileController = Get.put(ProfileController());
  var selectProjectController = Get.find<SelectProjectController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                // child: Text(
                //   'Drawer Header',
                //   style: TextStyle(
                //     color: Colors.white,
                //     fontSize: 24,
                //   ),
                // ),

                child: Obx(
                  () => Stack(
                    children: [
                      SingleChildScrollView(
                          child: Column(
                        children: [
                          Container(
                            child: Stack(
                              children: [
                                usrController.currentUsr.value.photoUrl != null
                                    ? Obx(
                                        () => Material(
                                          child: CachedNetworkImage(
                                            width: 100,
                                            height: 100,
                                            imageUrl: usrController
                                                .currentUsr.value.photoUrl,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                Center(
                                              child: Container(
                                                  width: 100,
                                                  height: 100,
                                                  padding: EdgeInsets.all(10),
                                                  child:
                                                      CircularProgressIndicator(
                                                    strokeWidth: 2.0,
                                                    valueColor:
                                                        AlwaysStoppedAnimation(
                                                            Theme.of(context)
                                                                .primaryColor),
                                                  )),
                                            ),
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(125.0)),
                                          clipBehavior: Clip.hardEdge,
                                        ),
                                      )
                                    : Icon(
                                        Icons.account_circle,
                                        size: 100,
                                        // color: Colors.grey
                                      ),
                                IconButton(
                                    onPressed: () {
                                      profileController.choseImage();
                                    },
                                    padding: EdgeInsets.only(top: 20),
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.grey,
                                    iconSize: 40,
                                    icon: Icon(Icons.camera_alt,
                                        color:
                                            Colors.white54.withOpacity(0.4))),
                              ],
                            ),
                            width: 105,
                            margin: EdgeInsets.all(10),
                          ),
                          Text(usrController.currentUsr.value.email,
                              style: TextStyle(color: Colors.white))
                        ],
                      )),
                    ],
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
          //if curret user is admin or project manager the bottomm nav bar will not show
          () => usrController.currentUsr.value.userType == "Admin" ||
                  usrController.currentUsr.value.userType == "Customer"
              ? Container(width: 0.0, height: 0.0)
              : BottomNavigationBar(
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
                      icon: Icon(Icons.message),
                      label: 'Messages',
                    ),
                  ],
                  currentIndex: controller.getBottomNavSeleIndex,
                  onTap: (int index) {
                    //  print(controller.getBottomNavSeleIndex);
                    controller.setBottomNavSeleIndex = index;
                  },
                ),
        ),
        floatingActionButton: Obx(() {
          if (usrController.currentUsr.value.userType == "Project manager") {
            return FloatingActionButton(
                child: Icon(Icons.business),
                onPressed: () {
                  Get.toNamed('addProject');
                  // Get.defaultDialog(title: 'Add new user', actions: [AddCustomer()]);
                });
          } else if (usrController.currentUsr.value.userType == "Customer") {
            return FloatingActionButton(
                child: Icon(Icons.payment),
                onPressed: () {
                  //  Get.toNamed('addProject');
                  // Get.defaultDialog(title: 'Add new user', actions: [AddCustomer()]);
                });
          }

//if current user is admin
          else
            return Container(width: 0.0, height: 0.0);
        }));
  }
}

class PmHomeTabNav extends GetWidget<PmHomeTabNavController> {
  TabController _tabController;
  var selectProjectController = Get.find<SelectProjectController>();
  var usrController = Get.put(UsrController());

  List<Map<String, dynamic>> _tabs = [
    {'name': 'Add new', 'Icon': Icon(Icons.add_box)},
    {'name': 'Reports', 'Icon': Icon(Icons.report)},
    {'name': 'View', 'Icon': Icon(Icons.fact_check)}
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => usrController.currentUsr.value.userType == "Customer"
          ? customerSliver(context)
          : DefaultTabController(
              length: _tabs.length,
              child: NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverAppBar(
                        actions: [
                          Obx(() {
                            if (selectProjectController.currentProject.value !=
                                null) {
                              return Row(
                                children: [
                                  Text(
                                    selectProjectController
                                        .currentProject.value.customer.email,
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.check_box_outlined),
                                    onPressed: () {
                                      Obx(() {
                                        if (usrController
                                                .currentUsr.value.userType ==
                                            "Admin") {
                                          return SelectProject()
                                              .showAdminSelectProjectDialog(
                                                  context, '', true);
                                        } else {
                                          return SelectProject()
                                              .showPmSelectProjectDialog(
                                                  context, '',true);
                                        }
                                      });
                                    },
                                  ),
                                ],
                              );
                            } else {
                              return Row(
                                children: [
                                  Text('Select Project'),
                                  IconButton(
                                    icon: Icon(
                                        Icons.check_box_outline_blank_rounded),
                                    onPressed: () {

                                       Obx(() {
                                        if (usrController
                                                .currentUsr.value.userType ==
                                            "Admin") {
                                          return SelectProject()
                                              .showAdminSelectProjectDialog(
                                                  context, '',false);
                                        } else {
                                          return SelectProject()
                                              .showPmSelectProjectDialog(
                                                  context, '',false);
                                        }
                                      });
                                      
                                    },
                                  ),
                                ],
                              );
                            }
                          }),
                          IconButton(
                              icon: Icon(Icons.exit_to_app),
                              onPressed: () {
                                Get.find<AuthController>().logout();
                              }),
                        ],
                        forceElevated: innerBoxIsScrolled,
                        expandedHeight: 150.0,
                        floating: false,
                        pinned: true,
                        flexibleSpace: FlexibleSpaceBar(
                            // centerTitle: true,
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
                  body:

                      //if current user is admin or project manager then show three tabs
                      TabBarView(
                    /* tabB bar view */
                    controller: _tabController,
                    physics: BouncingScrollPhysics(),
                    children: [AddNew(), Reports(), ViewTab()],
                  )),
            ),
    );
  }

//   selectProjectDialog(BuildContext context, String message) {
//     showDialog(
//       useSafeArea: true,
//       barrierDismissible: false, //enable and disable outside click
//       context: context,
//       builder: (BuildContext context) => AlertDialog(
//         actions: <Widget>[
//           Row(
//             children: [
//               RaisedButton(
//                 color: Theme.of(context).primaryColor,
//                 elevation: 5.0,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20.0),
//                 ),
//                 onPressed: () {
//                   if (selectProjectController
//                       .selectProjectFormKey.value.currentState
//                       .validate()) {
//                     selectProjectController
//                         .selectProjectFormKey.value.currentState
//                         .save();
//                     Fluttertoast.showToast(msg: message);
//                     Get.back();
//                     //navigate to upload picuture ui
//                   }
//                 },
//                 child: Text(
//                   "Ok",
//                 ),
//               ),
//               RaisedButton(
//                 color:
//                     Get.isDarkMode ? Theme.of(context).accentColor : Colors.red,

//                 //  color: Theme.of(context).primaryColor,
//                 elevation: 5.0,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20.0),
//                 ),
//                 onPressed: () {
//                   Get.back();
//                 },
//                 child: Text(
//                   "Cancel",
//                   style: TextStyle(
//                     color: Get.isDarkMode ? null : Colors.white,
//                     letterSpacing: 1.5,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         title: Text('Projects Pannel'),
//         content: SingleChildScrollView(
//           child: Form(
//               key: selectProjectController.selectProjectFormKey.value,
//               child: Column(
//                 children: [
//                   Obx(() {

//                     if(usrController.currentUsr.value.userType=="Admin")
//                     return adminProjects();
//                     else if(usrController.currentUsr.value.userType=="Project manager")
//                     return pmProjects();
//                     else
//                   return  customerProjects();

//                   }),
//                 ],
//               )),
//         ),
//       ),
//     );
//   }
// Widget customerProjects(){

//   //return customer project dropdown
//   print('customer projects');

//    if (selectProjectController.projectListCustomer != null) {
//                       return DropdownButtonFormField(
//                           isExpanded: true,
//                           validator: (val) => val == null
//                               ? "Select project to perform action  "
//                               : null,
//                           isDense: true,
//                           decoration: InputDecoration(
//                             /* enabledBorder: InputBorder.none that will remove the border and also the upper left
//               and right cut corner  */
//                             contentPadding: EdgeInsets.only(left: 4),
//                             /*

//               border: OutlineInputBorder(
//                 borderSide: BorderSide.none,
//               ),
//               */
//                             filled: true,
//                           ),
//                           hint: Text('Select Project'),
//                           items: selectProjectController.projectListCustomer
//                               .map((projectObj) => DropdownMenuItem<Project>(
//                                   value: projectObj,
//                                   child: Column(
//                                     children: [
//                                       SizedBox(
//                                         height: 20,
//                                         child: new Text(
//                                             projectObj.id.substring(0, 4),
//                                             overflow: TextOverflow.ellipsis),
//                                       ),
//                                     ],
//                                   )))
//                               .toList(),
//                           onChanged: (project) {
//                             selectProjectController.currentProject.value =
//                                 project;
//                           });
//                     }
//                     return Center(child: CircularProgressIndicator());
// }

// Widget pmProjects(){
//   print('Pm projects');

//    if (selectProjectController.projectListPm != null) {
//                       return DropdownButtonFormField(
//                           isExpanded: true,
//                           validator: (val) => val == null
//                               ? "Select project to perform action  "
//                               : null,
//                           isDense: true,
//                           decoration: InputDecoration(
//                             /* enabledBorder: InputBorder.none that will remove the border and also the upper left
//               and right cut corner  */
//                             contentPadding: EdgeInsets.only(left: 4),
//                             /*

//               border: OutlineInputBorder(
//                 borderSide: BorderSide.none,
//               ),
//               */
//                             filled: true,
//                           ),
//                           hint: Text('Select Project'),
//                           items: selectProjectController.projectListPm
//                               .map((projectObj) => DropdownMenuItem<Project>(
//                                   value: projectObj,
//                                   child: Column(
//                                     children: [
//                                       SizedBox(
//                                         height: 20,
//                                         child: new Text(
//                                             projectObj.id.substring(0, 4),
//                                             overflow: TextOverflow.ellipsis),
//                                       ),
//                                     ],
//                                   )))
//                               .toList(),
//                           onChanged: (project) {
//                             selectProjectController.currentProject.value =
//                                 project;
//                           });
//                     }
//                     return Center(child: CircularProgressIndicator());
// }

// Widget adminProjects(){
//   print('admin projects');
//    if (selectProjectController.projectListAdmin != null) {
//                       return DropdownButtonFormField(
//                           isExpanded: true,
//                           validator: (val) => val == null
//                               ? "Select project to perform action  "
//                               : null,
//                           isDense: true,
//                           decoration: InputDecoration(
//                             /* enabledBorder: InputBorder.none that will remove the border and also the upper left
//               and right cut corner  */
//                             contentPadding: EdgeInsets.only(left: 4),
//                             /*

//               border: OutlineInputBorder(
//                 borderSide: BorderSide.none,
//               ),
//               */
//                             filled: true,
//                           ),
//                           hint: Text('Select Project'),
//                           items: selectProjectController.projectListAdmin
//                               .map((projectObj) => DropdownMenuItem<Project>(
//                                   value: projectObj,
//                                   child: Column(
//                                     children: [
//                                       SizedBox(
//                                         height: 20,
//                                         child: new Text(
//                                             projectObj.id.substring(0, 4),
//                                             overflow: TextOverflow.ellipsis),
//                                       ),
//                                     ],
//                                   )))
//                               .toList(),
//                           onChanged: (project) {
//                             selectProjectController.currentProject.value =
//                                 project;
//                           });
//                     }
//                     return Center(child: CircularProgressIndicator());
// }

  customerSliver(BuildContext context) {
    return Container(
      child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                actions: [
                  Obx(() {
                    if (selectProjectController.currentProject.value != null) {
                      return Row(
                        children: [
                          Text(
                            selectProjectController
                                .currentProject.value.customer.email,
                          ),
                          IconButton(
                            icon: Icon(Icons.check_box_outlined),
                            onPressed: () {
                            SelectProject().showCustomerSelectProjectDialog(context, '',true );
                            },
                          ),
                        ],
                      );
                    } else {
                      return Row(
                        children: [
                          Text('Select Project'),
                          IconButton(
                            icon: Icon(Icons.check_box_outline_blank_rounded),
                            onPressed: () {
                            SelectProject().showCustomerSelectProjectDialog(context, '',false);
                            
                              
                            },
                          ),
                        ],
                      );
                    }
                  }),
                  IconButton(
                      icon: Icon(Icons.exit_to_app),
                      onPressed: () {
                        Get.find<AuthController>().logout();
                      }),
                ],
                forceElevated: innerBoxIsScrolled,
                expandedHeight: 150.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                    // centerTitle: true,
                    title: Obx(() => Text(controller.tabTitle.value)),
                    background: Image.network(
                      "https://propakistani.pk/wp-content/uploads/2020/08/Construction.jpg",
                      fit: BoxFit.cover,
                    )),
              ),

              //    SliverPersistentHeader(
              //   delegate: CustomerSliverPersistentHeaderDeligate(),
              //   pinned: false,
              // ),
            ];
          },
          body: customerHomePage(context)),
    );
  }

  customerHomePage(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(20),
        // color: Get.isDarkMode ? Colors.grey[700] : Colors.greenAccent,
        child: GridView.count(
          crossAxisCount: context.isLandscape ? 2 : 3,
          children: [
            InkWell(
              child: addCustomerHomePageCard(
                  context, Colors.green, 'Project Report', Icons.person),
              onTap: () {
                selectProjectController.currentProject.value == null
                    ? SelectProject().showCustomerSelectProjectDialog(
                        context, "projectReportUi",false)
                    : Get.toNamed('projectReportUi');
              },
            ),
            InkWell(
              child: addCustomerHomePageCard(context, Colors.green[400],
                  ' Payment Report ', Icons.account_balance_wallet),
              onTap: () {
                selectProjectController.currentProject.value == null
                    ? SelectProject().showCustomerSelectProjectDialog(
                        context, "paymentReportUi",false)
                    : Get.toNamed('paymentReportUi');
              },
            ),
            InkWell(
              child: addCustomerHomePageCard(
                  context, Colors.green, 'Project', Icons.business_sharp),
              onTap: () {
                selectProjectController.currentProject.value == null
                    ? SelectProject().showCustomerSelectProjectDialog(
                        context, 'projectReportUi',false)
                    : Get.toNamed('projectReportUi');
              },
            ),
            InkWell(
              child: addCustomerHomePageCard(
                  context, Colors.deepOrangeAccent, 'Picture', Icons.photo),
              onTap: () {
                selectProjectController.currentProject.value == null
                    ? SelectProject().showCustomerSelectProjectDialog(
                        context, 'fetchImagesUi',false)
                    : Get.toNamed('fetchImagesUi');
                //  showSelectProjectDialog(context);
              },
            )
          ],
        ));
  }

  addCustomerHomePageCard(
      BuildContext context, Color color, String title, IconData icon) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      borderOnForeground: true,
      semanticContainer: false,
      margin: EdgeInsets.all(5),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Icon(
              icon,
              color: Get.isDarkMode ? Theme.of(context).accentColor : color,
              size: context.isLandscape ? 20 : 40,
            ),
          ),
          Text(
            title,
            style: GoogleFonts.lobsterTwo(
              textStyle: TextStyle(color: color, letterSpacing: .2),
            ),
          )
        ],
      )),
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
