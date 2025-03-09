import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lottie/lottie.dart';
import 'package:taskati_task/core/models/task_model.dart';
import 'package:taskati_task/core/services/local_helper.dart';
import 'package:taskati_task/core/utils/app_colors.dart';
import 'package:taskati_task/core/utils/text_styles.dart';

class TasksListBuilder extends StatelessWidget {
  const TasksListBuilder({
    super.key,
    required this.selectedDate,
  });
  final String selectedDate;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder(
        valueListenable: AppLocalStorage.taskBox!.listenable(),
        builder: (BuildContext context, box, Widget? child) {
          List<TaskModel> tasks =
              box.values.where((e) => e.date == selectedDate).toList();
          if (tasks.isEmpty) {
            return Center(
              child: Lottie.asset('assets/images/empty.json'),
            );
          }
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                  key: UniqueKey(),
                  background: Container(
                    padding: EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        Icon(
                          Icons.done,
                          color: AppColors.whiteColor,
                        ),
                        Text(
                          'Complete',
                          style: getSmallTextStyle(color: AppColors.whiteColor),
                        )
                      ],
                    ),
                  ),
                  secondaryBackground: Container(
                    padding: EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.delete,
                          color: AppColors.whiteColor,
                        ),
                        Text(
                          'Delete',
                          style: getSmallTextStyle(color: AppColors.whiteColor),
                        )
                      ],
                    ),
                  ),
                  onDismissed: (direction) {
                    if (direction == DismissDirection.endToStart) {
                      box.delete(tasks[index].id);
                    } else {
                      box.put(tasks[index].id,
                          tasks[index].copyWith(isCompleted: true));
                    }
                  },
                  child: TaskItem(task: tasks[index]));
            },
          );
        },
      ),
    );
  }
}

class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
    required this.task,
  });
  final TaskModel task;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: task.isCompleted == true
            ? Colors.green
            : task.color == 0
                ? AppColors.primaryColor
                : task.color == 1
                    ? const Color.fromARGB(255, 255, 135, 70)
                    : AppColors.redColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: getBodyTextStyle(context,
                      color: AppColors.whiteColor, fontWeight: FontWeight.w600),
                ),
                const Gap(5),
                Row(
                  children: [
                    Icon(
                      Icons.watch_later_outlined,
                      color: AppColors.whiteColor,
                      size: 18,
                    ),
                    const Gap(5),
                    Text(
                      '${task.startTime} - ${task.endTime}',
                      style: getSmallTextStyle(
                          color: AppColors.whiteColor, fontSize: 12),
                    ),
                  ],
                ),
                const Gap(5),
                Text(
                  task.description,
                  style: getSmallTextStyle(color: AppColors.whiteColor),
                ),
              ],
            ),
          ),
          Container(
            width: .5,
            height: 60,
            color: AppColors.whiteColor,
          ),
          const Gap(8),
          RotatedBox(
            quarterTurns: 3,
            child: Text(
              task.isCompleted ? 'COMPLETED' : 'TODO',
              style: getSmallTextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.whiteColor),
            ),
          )
        ],
      ),
    );
  }
}
