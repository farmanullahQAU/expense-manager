import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_manager/controllers/ChatController/search_user_controller.dart';
import 'package:expense_manager/controllers/ChatController/send_message_controller.dart';
import 'package:expense_manager/controllers/user_controller.dart';
import 'package:expense_manager/db_services/database.dart';
import 'package:expense_manager/models/user_model.dart';
import 'package:expense_manager/ui/Chat/send_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class SearchUsr extends GetWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('serach'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: SelectUsr());
            },
          ),
        ],
      ),
      body: slideToUnlockPage(context),
    ));
  }
}

class SelectUsr extends SearchDelegate {
  var selectUsrController = Get.put(SelectUsrController());
  var sendMessageController = Get.put(SendMessageController());
  var usrController = Get.put(UsrController());

  @override
  Widget buildLeading(BuildContext context) {
    return SafeArea(
      child: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            close(context, null);
          }),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var userList = query.isEmpty
        ? selectUsrController.allUserList
        : selectUsrController.allUserList
            .where((usr) => usr.name == query)
            .toList();

    // return query.isEmpty
    //     ? Text('no data found')
    //     : ListView.builder(
    //         itemCount: searchUsrController.allUserList.length,
    //         itemBuilder: (BuildContext context, int indx) {
    //           return ListTile(
    //               onTap: () {
    //                 showResults(context);
    //               },
    //               title: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Text(searchUsrController.allUserList[indx].name),
    //                 ],
    //               ));
    //         });

    var res = selectUsrController.allUserList
        .where((usr) => usr.name.startsWith(query))
        .toList();

    return res.isEmpty
        ? Text('no data fount')
        : StreamBuilder(
            stream: FirebaseFirestore.instance.collection("users").snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children: snapshot.data.docs.map((usrObj) {
                    var receivers = Usr.fromMap(usrObj.data());

                    return ListTile(
                        leading: receivers.photoUrl != null
                            ? CachedNetworkImage(
                                width: 50,
                                height: 50,
                                placeholder: (BuildContext context, _) =>
                                    CircularProgressIndicator(
                                  strokeWidth: 2.0,
                                ),
                                imageUrl: receivers.photoUrl,
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.account_circle, size: 80),
                                imageBuilder: (context, imageProvider) =>
                                    CircleAvatar(
                                  backgroundColor: Colors.white,
                                  backgroundImage: imageProvider,
                                ),
                              )
                            : CircleAvatar(
                                backgroundColor: Color(0xffE6E6E6),
                                child: Icon(
                                  Icons.person,
                                  color: Color(0xffCCCCCC),
                                ),
                              ),

                        /*date account created*/
                        trailing: Text(
                            DateFormat.yMMMd().format(
                              FirebaseAuth
                                  .instance.currentUser.metadata.creationTime,
                            ),
                            style: TextStyle(
                              fontSize: 10,
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.3),
                            )),
                        subtitle: Text(
                          receivers.userType,
                          style: GoogleFonts.lobsterTwo(
                            textStyle: TextStyle(
                                color: Colors.blue, letterSpacing: .2),
                          ),
                        ),
                        //  leading:
                        onTap: () {
                          print(receivers.id);
                          //tap on listTile of all get receivers profile
                          query = receivers.name;
                          //set receiver and sender in  controller
                          sendMessageController.receiver.value = receivers;
                          sendMessageController.sender.value =
                              usrController.currLoggedInUsr.value;

                          Get.toNamed('/sendMessageUi');

                          query = ""; //when user back search bar wilk be empty
                        },
                        title: Text(receivers.name));
                  }).toList(),
                );
              }
              return CircularProgressIndicator();
            });
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }
}

Widget slideToUnlockPage(context) {
  return Container(
    width: Get.context.width,
    height: Get.context.height,
    child: Stack(
      fit: StackFit.expand,
      children: [
        CircleAvatar(
          backgroundColor: Colors.blue,
          backgroundImage: AssetImage('images/chatBackLogo.png'),
        ),
        Positioned(
            bottom: Get.context.height * 0.4,
            left: 0.0,
            right: 0.0,
            child: Center(
              child: Opacity(
                opacity: 0.8,
                child: Shimmer.fromColors(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.0),
                      ),
                      const Text(
                        'CHAT MODULE',
                        style: TextStyle(
                          fontSize: 19.0,
                        ),
                      )
                    ],
                  ),
                  baseColor: Colors.black12,
                  highlightColor: Colors.white,
                ),
              ),
            )),
        // Image.asset(
        //   'images/chatBackground.jpg',
        //   fit: BoxFit.cover,
        // ),
        // Positioned(
        //   top: 48.0,
        //   right: 0.0,
        //   left: 0.0,
        //   child: Center(
        //     child: Column(
        //       children: <Widget>[
        //         Text(
        //           '${hour < 10 ? '0$hour' : '$hour'}:${minute < 10 ? '0$minute' : '$minute'}',
        //           style: TextStyle(
        //             fontSize: 60.0,
        //             color: Colors.white,
        //           ),
        //         ),
        //         const Padding(
        //           padding: EdgeInsets.symmetric(vertical: 4.0),
        //         ),
        //         Text(
        //           '${days[day - 1]}, ${months[month - 1]} $dayInMonth',
        //           style: TextStyle(fontSize: 24.0, color: Colors.white),
        //         )
        //       ],
        //     ),
        //   ),
        // ),
      ],
    ),
    // decoration: BoxDecoration(
    //     gradient: LinearGradient(
    //         begin: Alignment.topRight,
    //         end: Alignment.bottomLeft,
    //         colors: [Colors.blue, Colors.green]))
  );
}
