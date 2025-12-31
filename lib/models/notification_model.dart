import 'package:flutter/material.dart';

class NotificationModel {
  final String title;
  final String description;
  final String time;
  final IconData type;
  final Color iconColor;

  NotificationModel({
    required this.title,
    required this.description,
    required this.time,
    required this.type,
    required this.iconColor,
  });
}
