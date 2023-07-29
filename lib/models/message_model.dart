import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String? senderId;
  String? receiverId;
  String? message;
  Timestamp? timestamp;


  MessageModel({this.senderId, this.receiverId, this.message, this.timestamp});

  MessageModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    receiverId= json['receiverId'];
    message = json['message'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'timestamp': timestamp,
    };
  }

}
