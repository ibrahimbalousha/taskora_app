import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskora_app/core/config/constants/app_sizes.dart';
import 'package:taskora_app/core/config/constants/color_manager.dart';
import 'package:taskora_app/core/config/widgets/app_bars/custom_app_bar.dart';
import 'package:taskora_app/core/config/widgets/buttons/app_elevated_button.dart';
import 'package:taskora_app/core/config/widgets/buttons/custom_text_button.dart';
import 'package:taskora_app/core/config/widgets/inputs/app_text_field.dart';
import 'package:taskora_app/features/projects/presentation/cubit/project_cubit.dart';

class CreateProject extends StatefulWidget {
  const CreateProject({super.key});

  @override
  State<CreateProject> createState() => _CreateProjectState();
}

class _CreateProjectState extends State<CreateProject> {
  final TextEditingController _projectName = TextEditingController();

  final TextEditingController _projectDescription = TextEditingController();

  final TextEditingController _client = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DateTime? selectedDate;

  String? get deadline {
    if (selectedDate == null) return null;

    return selectedDate!.toIso8601String();
  }

  @override
  void dispose() {
    _projectName.dispose();
    _projectDescription.dispose();
    _client.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, state) {
        final isNotBack = state is ProjectAddLoading;

        return PopScope(
          canPop: !isNotBack,
          child: Scaffold(
            appBar: CustomAppBar(
              title: 'Create Project',
              actions: [CustomTextButton(label: 'Save', onPressed: () {})],
            ),

            body: BlocListener<ProjectCubit, ProjectState>(
              listener: (context, state) {
                if (state is ProjectAddSuccess) {
                  Navigator.pop(context, true);
                }

                if (state is ProjectAddFailure) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                }
              },

              child: SafeArea(
                child: Padding(
                  padding: AppPadding.horizontalPagePaddingAndTop,

                  child: Form(
                    key: _formKey,

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        const Text('Setup a new Project to track your work'),

                        AppTextField(
                          hint: 'e.g Mobile App Redesign',
                          label: 'Project Name',
                          controller: _projectName,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Project name is required';
                            }

                            if (value.trim().length < 3) {
                              return 'Project name must be at least 3 characters';
                            }

                            return null;
                          },
                          suffixIcon: const Icon(Icons.edit_rounded),
                        ),

                        AppTextField(
                          hint: 'Add project details...',
                          label: 'Project Description',
                          controller: _projectDescription,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Description is required';
                            }

                            if (value.trim().length < 3) {
                              return 'Description must be at least 3 characters';
                            }

                            return null;
                          },
                          maxLines: 5,
                        ),

                        AppTextField(
                          hint: 'Client name',
                          label: 'Client',
                          controller: _client,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Client is required';
                            }

                            if (value.trim().length < 3) {
                              return 'Client must be at least 3 characters';
                            }

                            return null;
                          },
                          suffixIcon: const Icon(Icons.person_outline),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 28.0),
                          child: ListTile(
                            onTap: () async {
                              final DateTime? pickedDate = await showDatePicker(
                                context: context,

                                initialDate: DateTime.now(),

                                firstDate: DateTime.now(),

                                lastDate: DateTime(2030),
                              );

                              if (pickedDate != null) {
                                setState(() {
                                  selectedDate = pickedDate;
                                });
                              }
                            },

                            title: Text(
                              selectedDate == null
                                  ? 'Delivery date'
                                  : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',

                              style: TextStyle(color: ColorManager.primary),
                            ),

                            leading: const Icon(Icons.date_range_rounded),

                            trailing: const Icon(
                              Icons.arrow_forward_ios_rounded,
                            ),

                            shape: Border.all(
                              color: ColorManager.primary,
                              width: 0.5,
                            ),
                          ),
                        ),

                        const Spacer(),

                        BlocBuilder<ProjectCubit, ProjectState>(
                          builder: (context, state) {
                            return AppElevatedButton(
                              label: 'Create Project',

                              isLoading: state is ProjectAddLoading,
                              onPressed: state is ProjectAddLoading
                                  ? null
                                  : () {
                                      if (!_formKey.currentState!.validate()) {
                                        return;
                                      }

                                      if (deadline == null) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Please select delivery date',
                                            ),
                                          ),
                                        );

                                        return;
                                      }

                                      context.read<ProjectCubit>().addProject(
                                        name: _projectName.text,

                                        description: _projectDescription.text,

                                        clientName: _client.text,

                                        deadline: deadline!,
                                      );
                                    },
                            );
                          },
                        ),

                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
