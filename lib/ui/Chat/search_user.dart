import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_manager/controllers/ChatController/search_user_controller.dart';
import 'package:expense_manager/controllers/ChatController/send_message_controller.dart';
import 'package:expense_manager/controllers/user_controller.dart';
import 'package:expense_manager/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class SearchUsr extends GetWidget {
  var usrController = Get.put(UsrController());
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

  Widget slideToUnlockPage(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        usrController.currentUsr.value.photoUrl != null
            ? Material(
                child: CachedNetworkImage(
                  width: 150,
                  height: 150,
                  imageUrl: usrController.currentUsr.value.photoUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(
                    child: Container(
                        width: 150,
                        height: 150,
                        padding: EdgeInsets.all(10),
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                          valueColor: AlwaysStoppedAnimation(
                              Theme.of(context).primaryColor),
                        )),
                  ),
                ),
                borderRadius: BorderRadius.all(Radius.circular(125.0)),
                clipBehavior: Clip.hardEdge,
              )
            : Icon(
                Icons.chat,
                size: 150,
                // color: Colors.grey
              ),
        Center(
          child: Opacity(
            opacity: 0.8,
            child: Shimmer.fromColors(
              loop: 4,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.0),
                  ),
                  const Text(
                    'CHAT MODULE',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              baseColor: Colors.black12,
              highlightColor: Colors.white,
            ),
          ),
        ),
      ],
    );
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
          //get all usrs except current logged in usr
            stream: FirebaseFirestore.instance.collection("users").where('id',isNotEqualTo:usrController.currentUsr.value.id ).snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children: snapshot.data.docs.map((usrObj) {
                    var receivers = Usr.fromMap(usrObj.data());

                   // return Obx((){

                      //if current usr is customer than it will not send message to admin or other customers
                    ////  if(usrController.currentUsr.value.userType=="Customer"&&receivers.userType=="Admin"||receivers.userType=="Customer")
                  //  return Container(width: 0.0,height: 0.0,);
                      // // else
                      // // //admin can't send message to customers
                       if(usrController.currentUsr.value.userType=="Admin"&&receivers.userType=="Customer")
                       return Container(width: 0.0,height: 0.0);
                       else
                                         return  ListTile(
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
                                      // CircleAvatar(
                                      //   backgroundColor: Colors.green,
                                      //   child: Icon(
                                      //   Icons.account_circle, size: 50)
                                        
                                      //   ),
                                        CircleAvatar(
                                        backgroundColor: Colors.blue,
                                        child: Text(
                                        
                                          receivers.name.substring(0,2).toUpperCase(), style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0),
                                        )
                                        
                                        ),
                                  imageBuilder: (context, imageProvider) =>
                                      CircleAvatar(
                                    backgroundColor: Colors.white,
                                    backgroundImage: imageProvider,
                                  ),
                                )
                              : Container(width: 0.0,height: 0.0,),

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
                                usrController.currentUsr.value;

                            Get.toNamed('/sendMessageUi');

                            query = ""; //when user back search bar wilk be empty
                          },
                          title: Text(receivers.name));
                  //  }
                   // );
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
