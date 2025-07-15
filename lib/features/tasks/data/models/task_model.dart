import 'dart:convert';
import 'package:flutter_clean_architecture_tdd_template/core/utils/typedef.dart';
import 'package:flutter_clean_architecture_tdd_template/features/tasks/domain/entities/task_entity.dart';

class TaskModel extends TaskEntity {
  TaskModel({
    required super.id,
    required super.title,
    required super.tag,
    required super.createdAt,
  });

  TaskModel copyWith({
    String? title,
    String? tag,
    DateTime? createdAt,
    int? id,
  }) =>
      TaskModel(
        title: title ?? this.title,
        tag: tag ?? this.tag,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
      );

  factory TaskModel.fromMap(DataMap map) => TaskModel(
        title: map['title'] as String,
        tag: map['tag'] as String,
        createdAt: DateTime.parse(map['createdAt'] as String),
        id: int.parse(map['id'] as String),
      );

  DataMap toMap() => <String, dynamic>{
        'title': title,
        'tag': tag,
        'createdAt': createdAt.toIso8601String(),
        'id': id.toString(),
      };

  factory TaskModel.fromJson(String source) =>
      TaskModel.fromMap(json.decode(source) as DataMap);

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'TaskEntity(title: $title, tag: $tag, createdAt: $createdAt, id: $id)';
}
