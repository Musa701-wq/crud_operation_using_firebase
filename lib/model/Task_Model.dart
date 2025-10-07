class TaskModel {
  final String id;
  final String uid;
  final String title;
  final String description;

  var created;

  var isCompleted;

  TaskModel({
    required this.id,
    required this.uid,
    required this.title,
    required this.description,
    this.created,
    this.isCompleted
  });

  factory TaskModel.fromMap(Map<String, dynamic> map, String docId) {
    return TaskModel(
      id: docId,
      uid: map['uid'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'title': title,
      'description': description,
    };
  }
}
