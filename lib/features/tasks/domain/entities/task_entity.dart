class TaskEntity {
  final int id;
  final String title, tag;
  final DateTime createdAt;

  TaskEntity({
    required this.id,
    required this.title,
    required this.tag,
    required this.createdAt,
  });
}
