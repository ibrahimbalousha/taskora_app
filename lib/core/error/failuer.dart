import 'package:equatable/equatable.dart';

abstract class Failuer extends Equatable {}

class OfflineFailuer extends Failuer{

  @override
  List<Object?> get props => [];
}

class ServerFailuer extends Failuer{
  
  @override
  List<Object?> get props => [];
}