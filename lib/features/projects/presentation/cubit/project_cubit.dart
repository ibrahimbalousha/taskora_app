import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taskora_app/features/projects/domain/entities/project_entity.dart';
import 'package:taskora_app/features/projects/domain/usecases/get_projects_use_case.dart';
import 'package:taskora_app/features/projects/domain/usecases/project_add_ues_case.dart';

part 'project_state.dart';

class ProjectCubit extends Cubit<ProjectState> {
  ProjectCubit({
    required this.projectAddUesCase,
    required this.getProjectsUseCase,
  }) : super(ProjectInitial());
  final GetProjectsUseCase getProjectsUseCase;
  final ProjectAddUesCase projectAddUesCase;

  Future<void> getProject() async {
    emit(ProjectsLoading());
    final result = await getProjectsUseCase();
    result.fold(
      (failure) {
        emit(ProjectsFailure(message: failure.message));
      },
      (projects) {
        projects.forEach((element) {
          print("PROJECTS id: ${element.id}");
        });
        emit(ProjectsLoaded(projects: projects));
      },
    );
  }

  Future<void> addProject({
    required String name,
    required String description,
    required String clientName,
    required String deadline,
  }) async {
    emit(ProjectAddLoading());

    final result = await projectAddUesCase(
      name: name,
      description: description,
      clientName: clientName,
      deadline: deadline,
    );

    result.fold(
      (failure) {
        emit(ProjectAddFailure(message: failure.message));
      },

      (project) async {
        emit(ProjectAddSuccess(project: project));
      },
    );
  }
}
