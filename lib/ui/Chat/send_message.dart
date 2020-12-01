import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_manager/controllers/ChatController/send_message_controller.dart';
import 'package:expense_manager/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class SendMessage extends GetWidget<SendMessageController> {
  var sendM = Get.put(SendMessageController);

  //Usr receiver = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            //app bar title
            title: Text(
              controller.receiver.value.name,
              style: GoogleFonts.lobsterTwo(
                textStyle: TextStyle(letterSpacing: .2),
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: controller.receiver.value.photoUrl != null
                    ? CircleAvatar(
                        //Avator receiver profile image
                        backgroundColor: Colors.black,
                        backgroundImage: CachedNetworkImageProvider(
                            controller.receiver.value.photoUrl),
                      )
                    : CircleAvatar(
                        backgroundColor: Color(0xffE6E6E6),
                        radius: 30,
                        child: Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                      ),
              ),
            ],
          ),
          body: WillPopScope(
              child: Stack(
                children: [
                  Column(
                    children: [
                      createListMessage(),
                      //show stickers
                      //  controller.isEmojiOpen?createSticker():Container(),
                      createInput(),
                    ],
                  ),
                ],
              ),
              onWillPop: null)
          //_buildTextComposer(context),
          ),
    );
  }

  createInput() {
    return Container(
      child: Row(
        children: [
          //send image button
          Material(
            child: Container(
              child: IconButton(
                icon: Icon(Icons.image),
                color: Colors.lightBlueAccent,
                onPressed: () {
                  controller.getImage();
                },
              ),
            ),
            color: Colors.white,
          ),
          Flexible(
            child: Container(
              child: TextField(
                controller: controller.textEditingController.value,
                decoration: InputDecoration.collapsed(
                  hintText: 'type here',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
          Material(
            child: Container(
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  controller.onSendMessage(
                      controller.textEditingController.value.text, 0);
                },
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
      height: 50.0,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey,
            width: 0.7,
          ),
        ),
        color: Colors.white,
      ),
    );
  }

  createListMessage() {
    controller.setChatId();
    return Flexible(
        child: controller.chatId.value == ""
            ? Center(
                child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.lightBlueAccent)))
            : StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("messages")
                    .doc(controller.chatId.value)
                    .collection(controller.chatId.value)
                    .orderBy("timestamp", descending: true)
                    .limit(20)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                        child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.lightBlueAccent)));
                  } else {
                    controller.listMessages.value = snapshot.data.docs;
                    return ListView.builder(
                        itemCount: snapshot.data.docs.length, //check it out
                        padding: EdgeInsets.all(10.0),
                        itemBuilder: (BuildContext context, int index) =>
                            createItems(index, snapshot.data.docs[index]));
                  }
                }));
  }

  createSticker() {}

  createItems(int index, QueryDocumentSnapshot doc) {
    if (doc.data()["idFrom"] == this.controller.sender.value.id) {
      return Row(
        children: [
          doc.data()["type"] == 0
              ?
              //textMessages
              Container(
                  child: Text(doc.data()["content"],
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500)),
                  padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                  width: 200,
                  decoration: BoxDecoration(
                      color: Colors.lightBlueAccent,
                      borderRadius: BorderRadius.circular(8.0)),
                  margin: EdgeInsets.only(
                      bottom: isLastMsgRight(index) ? 20.0 : 10.0, right: 10.0))
              : doc.data()["type"] == 1
                  ? Container(
                      child: FlatButton(
                        onPressed: () {
                          //  Get.to(FullImageUi(),
                          //  arguments: doc.data()["content"];
                        },
                        child: Material(
                          child: CachedNetworkImage(
                            placeholder: (context, url) => Container(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Theme.of(context).primaryColor),
                              ),
                              width: 200,
                              height: 200,
                              padding: EdgeInsets.all(70),
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                              ),
                            ),
                            errorWidget: (context, url, error) => Material(
                              child: Image.asset(
                                  "images/image_not_available.png",
                                  fit: BoxFit.cover,
                                  width: 200,
                                  height: 200),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                              clipBehavior: Clip.hardEdge,
                            ),
                            imageUrl: doc.data()["content"],
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          clipBehavior: Clip.hardEdge,
                        ),
                      ),
                      margin: EdgeInsets.only(
                          bottom: isLastMsgRight(index) ? 20.0 : 10.0,
                          right: 10.0))
                  : Container(
                      child: Center(
                        child: Text('sticker is not implemented'),
                      ),
                    ),
        ],
        mainAxisAlignment: MainAxisAlignment.end,
      );
      //display receiver message left side
    } else {
      return Container(
        child: Column(
          children: [
            Row(
              children: [
                isLasMessageLef(index)
                    ? Material(
                        //display receiver profile image
                        child: CachedNetworkImage(
                          errorWidget: (context, url, _) => Material(
                            child: Icon(
                              Icons.account_circle,
                              size: 35,
                            ),
                          ),
                          imageUrl:
                              controller.receiver.value.photoUrl, //receiver url
                          placeholder: (context, url) => Container(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Theme.of(context).primaryColor),
                            ),
                            padding: EdgeInsets.all(10.0),
                            width: 35.0,
                            height: 35.0,
                          ),
                          width: 35.0,
                          height: 35.0,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)))
                    : Container(
                        width: 35,
                      ),
                //display messages

                doc.data()["type"] == 0
                    ?
                    //textMessages
                    Container(
                        child: Text(doc.data()["content"],
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400)),
                        padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                        width: 200,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8.0)),
                        margin: EdgeInsets.only(
                          left: 10.0,
                        ) //

                        ) /////////
                    : doc.data()["type"] == 1
                        ? Container(
                            child: FlatButton(
                              onPressed: () {
                                // Get.to(FullImageUi(),
                                //     arguments: doc.data()["content"]);
                              },
                              child: Material(
                                child: CachedNetworkImage(
                                  placeholder: (context, url) => Container(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Theme.of(context).primaryColor),
                                    ),
                                    width: 200,
                                    height: 200,
                                    padding: EdgeInsets.all(70),
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0)),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Material(
                                    child: Image.asset(
                                        "images/image_not_available.png",
                                        fit: BoxFit.cover,
                                        width: 200,
                                        height: 200),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0)),
                                    clipBehavior: Clip.hardEdge,
                                  ),
                                  imageUrl: doc.data()["content"],
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                clipBehavior: Clip.hardEdge,
                              ),
                            ),
                            margin: EdgeInsets.only(
                                bottom: isLastMsgRight(index) ? 20.0 : 10.0,
                                right: 10.0))
                        : Container(
                            child: Center(
                              child: Text('sticker is not implemented'),
                            ),
                          ),
                //textMessages
              ],
            ),
            isLasMessageLef(index)
                ? Container(
                    child: Text(
                      DateFormat("dd MMMM, yyyy - hh:mm:aa").format(
                          DateTime.fromMicrosecondsSinceEpoch(
                              int.parse(doc.data()["timestamp"]))),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    margin: EdgeInsets.only(left: 50, top: 50, bottom: 5.0),
                  )
                : Container()
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      );
    }
  }

  bool isLastMsgRight(int index) {
    if ((index > 0 &&
            controller.listMessages != null &&
            controller.listMessages[index - 1].data()["idFrom"] !=
                controller.sender.value.id) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  bool isLasMessageLef(int index) {
    if ((index > 0 &&
            controller.listMessages != null &&
            controller.listMessages[index - 1].data()["idFrom"] ==
                controller.sender.value.id) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }
}
