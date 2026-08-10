import 'package:equatable/equatable.dart';

class AuthToken extends Equatable {
  final String token;
  final int watchCost;

  const AuthToken({required this.token, required this.watchCost});

  @override
  List<Object?> get props => [token];
}
