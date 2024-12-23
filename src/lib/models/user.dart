import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  final String id;
  final String name;
  final int counter;

  const User({
    required this.id,
    required this.name,
    this.counter = 0,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith({
    String? id,
    String? name,
    int? counter,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      counter: counter ?? this.counter,
    );
  }

  @override
  List<Object?> get props => [id, name, counter];
}
