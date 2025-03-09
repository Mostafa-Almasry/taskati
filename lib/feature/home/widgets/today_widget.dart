import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:taskati_task/core/extentions/extentions.dart';
import 'package:taskati_task/core/utils/text_styles.dart';
import 'package:taskati_task/core/widgets/custom_button.dart';
import 'package:taskati_task/feature/add_task/page/add_task_screen.dart';

class TodayWidget extends StatelessWidget {
  const TodayWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMEd().format(DateTime.now()),
                style: getTitleTextStyle(context, fontWeight: FontWeight.w600),
              ),
              Text(
                'Today',
                style: getBodyTextStyle(context, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        const Gap(10),
        CustomButton(
            text: '+Add Task',
            width: 138,
            onPressed: () {
              context.pushTo(AddTaskScreen());
            })
      ],
    );
  }
}
