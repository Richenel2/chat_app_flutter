class Message {
  int id;
  String message;
  int creatorId;
  DateTime creationDate;

  Message(
      {required this.id,
      required this.message,
      required this.creatorId,
      required this.creationDate});

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
        id: map['id'],
        message: map['message'],
        creatorId: map['creator_id'],
        creationDate: DateTime.parse(map['creation_date']));
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'message': message,
      'creatior_id': creatorId,
      'creation_date': creationDate
    };
  }
}
