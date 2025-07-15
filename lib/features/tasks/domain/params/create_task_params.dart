import 'package:equatable/equatable.dart';

class CreateTaskParams extends Equatable {
  final String title, tag;
  final DateTime createdAt;

  const CreateTaskParams({
    required this.title,
    required this.tag,
    required this.createdAt,
  });

  factory CreateTaskParams.test() => CreateTaskParams(
        title: 'title',
        tag: 'tag',
        createdAt: DateTime.now(),
      );

  @override
  List<Object?> get props => [title, tag, createdAt];
}
