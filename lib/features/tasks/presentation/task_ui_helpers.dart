import 'package:flutter/material.dart';
import 'package:taskora_app/core/config/constants/color_manager.dart';

const List<Map<String, String>> taskPriorities = [
  {'value': 'low', 'label': 'Low'},
  {'value': 'medium', 'label': 'Medium'},
  {'value': 'high', 'label': 'High'},
];

const List<Map<String, String>> taskStatuses = [
  {'value': 'to-do', 'label': 'To Do'},
  {'value': 'in-progress', 'label': 'In Progress'},
  {'value': 'done', 'label': 'Done'},
];

String taskLabelFor(List<Map<String, String>> options, String value) {
  return options
      .firstWhere((o) => o['value'] == value, orElse: () => {'label': value})['label']!;
}

Color taskPriorityColor(String priority) {
  switch (priority) {
    case 'high':
      return ColorManager.priorityHigh;
    case 'low':
      return ColorManager.priorityLow;
    default:
      return ColorManager.priorityMedium;
  }
}

Color taskStatusColor(String status) {
  switch (status) {
    case 'done':
      return ColorManager.success;
    case 'in-progress':
      return ColorManager.warning;
    default:
      return ColorManager.info;
  }
}
