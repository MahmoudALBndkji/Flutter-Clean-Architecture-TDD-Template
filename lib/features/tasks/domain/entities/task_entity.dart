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

  factory TaskEntity.test() => TaskEntity(
        id: 1,
        title: 'title',
        tag: 'tag',
        createdAt: DateTime(2025, 07, 16),
      );

  @override
  List<Object?> get props => [id, title, tag, createdAt];
}
