import 'package:equatable/equatable.dart';

class UserData extends Equatable {
  final int counter;

  const UserData({this.counter = 0});

  Map<String, dynamic> toJson() {
    return {
      'counter': counter,
    };
  }

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      counter: json['counter'] as int? ?? 0,
    );
  }

  UserData copyWith({
    int? counter,
  }) {
    return UserData(
      counter: counter ?? this.counter,
    );
  }

  @override
  List<Object?> get props => [counter];
}