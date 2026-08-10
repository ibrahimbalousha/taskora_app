import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskora_app/core/config/constants/color_manager.dart';
import 'package:taskora_app/features/projects/presentation/cubit/project_cubit.dart';
import 'package:taskora_app/features/projects/presentation/pages/empty_projects_widget.dart';
import 'package:taskora_app/features/projects/presentation/pages/project_card.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  @override
  void initState() {
    super.initState();

    context.read<ProjectCubit>().getProject();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, state) {
        if (state is ProjectsLoading) {
          return const Center(
            child: CircularProgressIndicator(color: ColorManager.primary),
          );
        }

        if (state is ProjectsLoaded) {
          if (state.projects.isEmpty) {
            return const EmptyProjectsWidget();
          }

          return ProjectCard(project: state.projects);
        }

        if (state is ProjectsFailure) {
          return Center(child: Text(state.message));
        }

        return const EmptyProjectsWidget();
      },
    );
  }
}
