class Message {
  String senderId;
  String receiverId;
  String message;
  String senderType;

  Message({
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.senderType,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      message: json['message'],
      senderType: json['senderType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'senderType': senderType,
    };
  }
}