import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String email;
  final int code;

  const User({required this.email, required this.code});
  @override
  List<Object?> get props => [email, code];
}
