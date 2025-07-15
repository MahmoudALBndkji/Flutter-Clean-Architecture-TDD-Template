class CreateTaskParams {
  final String title, tag;
  final DateTime createdAt;

  CreateTaskParams({
    required this.title,
    required this.tag,
    required this.createdAt,
  });
}
