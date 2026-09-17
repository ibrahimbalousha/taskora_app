import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taskora_app/features/tasks/domain/entities/task_entity.dart';
import 'package:taskora_app/features/tasks/domain/usecases/add_task_use_case.dart';
import 'package:taskora_app/features/tasks/domain/usecases/delete_task_use_case.dart';
import 'package:taskora_app/features/tasks/domain/usecases/get_tasks_use_case.dart';
import 'package:taskora_app/features/tasks/domain/usecases/update_task_use_case.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit({
    required this.getTasksUseCase,
    required this.addTaskUseCase,
    required this.updateTaskUseCase,
    required this.deleteTaskUseCase,
  }) : super(TaskInitial());

  final GetTasksUseCase getTasksUseCase;
  final AddTaskUseCase addTaskUseCase;
  final UpdateTaskUseCase updateTaskUseCase;
  final DeleteTaskUseCase deleteTaskUseCase;

  Future<void> getTasks(String projectId) async {
    emit(TasksLoading());
    final result = await getTasksUseCase(projectId: projectId);
    result.fold(
      (failure) => emit(TasksFailure(message: failure.message)),
      (tasks) => emit(TasksLoaded(tasks: tasks)),
    );
  }

  Future<void> addTask({
    required String projectId,
    required String name,
    required String description,
    required String priority,
    required num totalHours,
    required String status,
  }) async {
    emit(TaskAddLoading());

    final result = await addTaskUseCase(
      projectId: projectId,
      name: name,
      description: description,
      priority: priority,
      totalHours: totalHours,
      status: status,
    );

    result.fold(
      (failure) => emit(TaskAddFailure(message: failure.message)),
      (task) => emit(TaskAddSuccess(task: task)),
    );
  }

  Future<void> updateTask({
    required String id,
    String? name,
    String? description,
    String? priority,
    num? totalHours,
    String? status,
  }) async {
    emit(TaskUpdateLoading());

    final result = await updateTaskUseCase(
      id: id,
      name: name,
      description: description,
      priority: priority,
      totalHours: totalHours,
      status: status,
    );

    result.fold(
      (failure) => emit(TaskUpdateFailure(message: failure.message)),
      (task) => emit(TaskUpdateSuccess(task: task)),
    );
  }

  Future<void> getAllTasksAcrossProjects(List<String> projectIds) async {
    if (projectIds.isEmpty) {
      emit(const TasksLoaded(tasks: []));
      return;
    }

    emit(TasksLoading());

    final allTasks = <TaskEntity>[];
    for (final projectId in projectIds) {
      final result = await getTasksUseCase(projectId: projectId);
      result.fold((_) {}, (tasks) => allTasks.addAll(tasks));
    }

    emit(TasksLoaded(tasks: allTasks));
  }

  Future<void> deleteTask(String id, String projectId) async {
    final result = await deleteTaskUseCase(id: id);

    result.fold((failure) {
      emit(TasksFailure(message: failure.message));
    }, (_) => getTasks(projectId));
  }
}
