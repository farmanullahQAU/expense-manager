import 'package:cloud_firestore/cloud_firestore.dart';

class Images {
  String imageUrl;
  String date;
  String projectId;
  DocumentReference reference;

  Images({this.imageUrl, this.date, this.projectId});
  Images.fromMap(Map<String, dynamic> map, {this.reference}) {
    this.imageUrl = map['imageUrl'];
    this.date = map['date'];
    this.projectId = map['projectId'];
  }

  Map<String, dynamic> toMap() => {
        'imageUrl': imageUrl,
        'date': date,
        'projectId': projectId,
      };
}
