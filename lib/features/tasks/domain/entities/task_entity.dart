import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  final int id;
  final String title, tag;
  final DateTime createdAt;

  const TaskEntity({
    required this.id,
    required this.title,
    required this.tag,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, title, tag, createdAt];
}
