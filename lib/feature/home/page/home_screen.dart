import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:taskati_task/core/utils/app_colors.dart';
import 'package:taskati_task/core/utils/text_styles.dart';
import 'package:taskati_task/feature/home/widgets/home_header.dart';
import 'package:taskati_task/feature/home/widgets/tasks_list_builder.dart';
import 'package:taskati_task/feature/home/widgets/today_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              HomeHeader(),
              Gap(15),
              TodayWidget(),
              Gap(15),
              DatePicker(
                DateTime.now(),
                width: 70,
                height: 90,
                initialSelectedDate: DateTime.now(),
                dayTextStyle: getBodyTextStyle(context, fontSize: 14),
                monthTextStyle: getBodyTextStyle(context, fontSize: 14),
                dateTextStyle: getBodyTextStyle(context),
                selectionColor: AppColors.primaryColor,
                selectedTextColor: Colors.white,
                onDateChange: (date) {
                  // New date selected
                  setState(() {
                    selectedDate = DateFormat('dd/MM/yyyy').format(date);
                  });
                },
              ),
              const Gap(15),
              TasksListBuilder(
                selectedDate: selectedDate,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
