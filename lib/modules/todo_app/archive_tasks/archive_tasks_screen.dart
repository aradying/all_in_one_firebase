import 'package:all_in_one/shared/components/components.dart';
import 'package:all_in_one/shared/cubit/cubit.dart';
import 'package:all_in_one/shared/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArchiveScreen extends StatelessWidget {
  const ArchiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).archivetasks;
        return tasksBuilder(
          tasks: tasks,
        );
      },
    );
  }
}
