class Task {
  static const String collectionName = "tasks";

  String ID;

  String Title;

  String Description;

  DateTime dateTime;

  bool isdone;

  Task(
      {this.ID = '',
      required this.Title,
      required this.Description,
      required this.dateTime,
      this.isdone = false});

  ///json => object
  Task.fromFireStore(Map<String, dynamic> data)
      : this(
            ID: data['id'],
            Title: data['title'],
            Description: data['description'],
            dateTime: DateTime.fromMicrosecondsSinceEpoch(data['DateTime']),
            isdone: data['isDone']);

  /// object => json
  Map<String, dynamic> toFireStore() {
    return {
      'id': ID,
      'title': Title,
      'description': Description,
      'DateTime': dateTime.microsecondsSinceEpoch,
      'isDone': isdone
    };
  }
}
