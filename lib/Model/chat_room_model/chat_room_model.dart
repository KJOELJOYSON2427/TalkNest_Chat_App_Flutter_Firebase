import 'package:my_project/Model/ChatModel.dart';
import 'package:my_project/Model/UserModel.dart';


class ChatRoomModel {
  String? id;
  UserModel? sender;
  UserModel? receiver;
  List<ChatModel>? messages;
  int? unReadMessNo;
 
  String? lastMessage;
  String? lastMessageTimestamp;
  String? timestamp;

  ChatRoomModel(
      {this.id,
      this.sender,
      this.receiver,
      this.messages,
      this.unReadMessNo,
      
      this.lastMessage,
      this.lastMessageTimestamp,
      this.timestamp});

  ChatRoomModel.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["sender"] is Map) {
      sender =
          json["sender"] == null ? null : UserModel.fromJson(json["sender"]);
    }
    if (json["receiver"] is Map) {
      receiver = json["receiver"] == null
          ? null
          : UserModel.fromJson(json["receiver"]);
    }
    if (json["messages"] is List) {
      messages = json["messages"] ?? [];
    }
    if (json["unReadMessNo"] is int) {
      unReadMessNo = json["unReadMessNo"];
    }
   
    if (json["lastMessage"] is String) {
      lastMessage = json["lastMessage"];
    }
    if (json["lastMessageTimestamp"] is String) {
      lastMessageTimestamp = json["lastMessageTimestamp"];
    }
    if (json["timestamp"] is String) {
      timestamp = json["timestamp"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    if (sender != null) {
      _data["sender"] = sender?.toJson();// amap
    }
    if (receiver != null) {
      _data["receiver"] = receiver?.toJson(); //amap
    }
    if (messages != null) {
      _data["messages"] = messages;
    }
    _data["unReadMessNo"] = unReadMessNo;
    
    
    _data["lastMessage"] = lastMessage;
    _data["lastMessageTimestamp"] = lastMessageTimestamp;
    _data["timestamp"] = timestamp;
    return _data;
  }
}