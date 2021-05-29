class MessageModel {
  String senderId;
  String receiveId;
  String dateTime;
  String text;

  MessageModel({
    this.senderId,
    this.receiveId,
    this.dateTime,
    this.text,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    receiveId = json['receiveId'];
    text = json['text'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'receiveId': receiveId,
      'text': text,
      'dateTime': dateTime,
    };
  }
}
