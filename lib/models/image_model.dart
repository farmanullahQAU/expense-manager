import 'package:cloud_firestore/cloud_firestore.dart';

class Images {
  String imageUrl;
  DateTime date;
  String projectId;
  String uploadedBy;
  DocumentReference reference;
  Images({this.imageUrl, this.date, this.projectId, this.uploadedBy});
  Images.fromMap(Map<String, dynamic> map, {this.reference}) {
    this.imageUrl = map['imageUrl'];
    this.date = map['date'].toDate();
    this.projectId = map['projectId'];
    this.uploadedBy=map['uploadedBy'];
  }

  Map<String, dynamic> toMap() => {
        'imageUrl': imageUrl,
        'date': Timestamp.fromDate(date),
        'projectId': projectId,
        'uploadedBy':uploadedBy
      };
}
