import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tickoyakovendors/core/colors.dart';
import 'package:tickoyakovendors/features/events/data/repositories/events_repository.dart';
import 'package:tickoyakovendors/features/events/presentation/widgets/add_event_dialog_widget.dart';

class CustomFAB extends StatelessWidget {
  final VoidCallback onPressed;
  final EventsRepository repository;

  const CustomFAB({
    super.key,
    required this.onPressed,
    required this.repository,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => _showAddEventDialog(context),
      elevation: 15,
      backgroundColor: AppColors.primaryColor,
      icon: const Icon(Icons.add),
      label: const Text('Create Event'),
    );
  }

  void _showAddEventDialog(BuildContext context) async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AddEventDialog();
      },
    );

    if (result != null) {
      try {
        await repository.addEvent(result);
        // Show success message
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Event created successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        }
        // Refresh the events list
        onPressed();
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to create event: ${e.toString()}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }
}
