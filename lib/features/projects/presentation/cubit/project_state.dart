part of 'project_cubit.dart';

sealed class ProjectState extends Equatable {
  const ProjectState();

  @override
  List<Object> get props => [];
}

final class ProjectInitial extends ProjectState {}

final class ProjectsLoading extends ProjectState {}

class ProjectsLoaded extends ProjectState {

  final List<ProjectEntity> projects;

  const ProjectsLoaded({
    required this.projects,
  });

  @override
  List<Object> get props => [
    projects,
  ];
}


class ProjectsFailure extends ProjectState {
  final String message;

  const ProjectsFailure({required this.message});
}

final class ProjectAddLoading extends ProjectState {}

class ProjectAddSuccess extends ProjectState {
  final ProjectEntity project;

  const ProjectAddSuccess({required this.project});

  @override
  List<Object> get props => [project];
}

class ProjectAddFailure extends ProjectState {
  final String message;

  const ProjectAddFailure({required this.message});

  @override
  List<Object> get props => [message];
}
