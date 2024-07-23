class Model {
  final String? id;
  final String title;
  final bool completed;

  Model({
    this.id,
    required this.title,
    required this.completed,
  });

  factory Model.fromJson(Map<String, dynamic> json) {
    return Model(
      id: json['_id'],
      title: json['title'],
      completed: json['completed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'completed': completed,
    };
  }
}
