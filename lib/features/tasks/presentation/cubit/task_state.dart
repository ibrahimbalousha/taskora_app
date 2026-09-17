part of 'task_cubit.dart';

sealed class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

final class TaskInitial extends TaskState {}

final class TasksLoading extends TaskState {}

class TasksLoaded extends TaskState {
  final List<TaskEntity> tasks;

  const TasksLoaded({required this.tasks});

  @override
  List<Object> get props => [tasks];
}

class TasksFailure extends TaskState {
  final String message;

  const TasksFailure({required this.message});

  @override
  List<Object> get props => [message];
}

final class TaskAddLoading extends TaskState {}

class TaskAddSuccess extends TaskState {
  final TaskEntity task;

  const TaskAddSuccess({required this.task});

  @override
  List<Object> get props => [task];
}

class TaskAddFailure extends TaskState {
  final String message;

  const TaskAddFailure({required this.message});

  @override
  List<Object> get props => [message];
}

final class TaskUpdateLoading extends TaskState {}

class TaskUpdateSuccess extends TaskState {
  final TaskEntity task;

  const TaskUpdateSuccess({required this.task});

  @override
  List<Object> get props => [task];
}

class TaskUpdateFailure extends TaskState {
  final String message;

  const TaskUpdateFailure({required this.message});

  @override
  List<Object> get props => [message];
}
