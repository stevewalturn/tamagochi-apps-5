import 'package:equatable/equatable.dart';

class UserData extends Equatable {
  final int counter;

  const UserData({
    this.counter = 0,
  });

  Map<String, dynamic> toJson() => {
        'counter': counter,
      };

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        counter: json['counter'] as int? ?? 0,
      );

  UserData copyWith({
    int? counter,
  }) =>
      UserData(
        counter: counter ?? this.counter,
      );

  @override
  List<Object?> get props => [counter];
}
