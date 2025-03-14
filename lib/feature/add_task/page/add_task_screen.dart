import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:taskati_task/core/extentions/extentions.dart';
import 'package:taskati_task/core/models/task_model.dart';
import 'package:taskati_task/core/services/local_helper.dart';
import 'package:taskati_task/core/utils/app_colors.dart';
import 'package:taskati_task/core/utils/text_styles.dart';
import 'package:taskati_task/core/widgets/custom_button.dart';
import 'package:taskati_task/feature/home/page/home_screen.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  var formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();

  int selectedColor = 0;

  @override
  void initState() {
    super.initState();
    dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    startTimeController.text = DateFormat('hh:mm a').format(DateTime.now());
    endTimeController.text = DateFormat('hh:mm a').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                titleField(),
                const Gap(12),
                descriptionField(),
                const Gap(12),
                dateField(context),
                const Gap(12),
                timeFields(context),
                const Gap(12),
                Row(
                  children: [
                    prioritiesWidget(),
                    const Spacer(),
                    CustomButton(
                        text: 'Create Task',
                        width: 145,
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            var key = DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString() +
                                titleController.text;
                            await AppLocalStorage.cacheTask(
                                key,
                                TaskModel(
                                    id: key,
                                    title: titleController.text,
                                    description: descriptionController.text,
                                    date: dateController.text,
                                    startTime: startTimeController.text,
                                    endTime: endTimeController.text,
                                    color: selectedColor,
                                    isCompleted: false));

                            context.pushReplacement(HomeScreen());
                          }
                        })
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row prioritiesWidget() {
    return Row(
        children: List.generate(3, (index) {
      return Padding(
        padding: const EdgeInsets.all(2),
        child: GestureDetector(
          onTap: () {
            setState(() {
              selectedColor = index;
            });
          },
          child: CircleAvatar(
            backgroundColor: index == 0
                ? AppColors.primaryColor
                : index == 1
                    ? const Color.fromARGB(255, 255, 135, 70)
                    : AppColors.redColor,
            child: (selectedColor == index)
                ? Icon(
                    Icons.check,
                    color: AppColors.whiteColor,
                  )
                : null,
          ),
        ),
      );
    }));
  }

  Column titleField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Title',
          style: getBodyTextStyle(context, fontWeight: FontWeight.w500),
        ),
        const Gap(7),
        TextFormField(
          controller: titleController,
          decoration: const InputDecoration(hintText: 'Enter title'),
          validator: (value) {
            if (value!.isEmpty) {
              return '*Required';
            }
            return null;
          },
        ),
      ],
    );
  }

  Column descriptionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: getBodyTextStyle(context, fontWeight: FontWeight.w500),
        ),
        const Gap(7),
        TextFormField(
          controller: descriptionController,
          maxLines: 3,
          decoration: const InputDecoration(hintText: 'Enter description'),
        ),
      ],
    );
  }

  Column dateField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Date',
          style: getBodyTextStyle(context, fontWeight: FontWeight.w500),
        ),
        const Gap(7),
        TextFormField(
          readOnly: true,
          controller: dateController,
          onTap: () async {
            var pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2030));
            if (pickedDate != null) {
              dateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
            }
          },
          decoration: const InputDecoration(
              suffixIcon: Icon(
            Icons.calendar_month_outlined,
            color: AppColors.primaryColor,
          )),
        ),
      ],
    );
  }

  Row timeFields(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Start Time',
                style: getBodyTextStyle(context, fontWeight: FontWeight.w500),
              ),
              const Gap(7),
              TextFormField(
                controller: startTimeController,
                readOnly: true,
                onTap: () async {
                  var pickedTime = await showTimePicker(
                      context: context, initialTime: TimeOfDay.now());
                  if (pickedTime != null) {
                    startTimeController.text = pickedTime.format(context);
                  }
                },
                decoration: InputDecoration(
                    hintText: 'Enter Time',
                    suffixIcon: Icon(
                      Icons.access_time_rounded,
                      color: AppColors.primaryColor,
                    )),
              )
            ],
          ),
        ),
        const Gap(10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'End Time',
                style: getBodyTextStyle(context, fontWeight: FontWeight.w500),
              ),
              const Gap(7),
              TextFormField(
                readOnly: true,
                controller: endTimeController,
                onTap: () async {
                  var pickedTime = await showTimePicker(
                      context: context, initialTime: TimeOfDay.now());
                  if (pickedTime != null) {
                    endTimeController.text = pickedTime.format(context);
                  }
                },
                decoration: InputDecoration(
                    hintText: 'Enter Time',
                    suffixIcon: Icon(
                      Icons.access_time_rounded,
                      color: AppColors.primaryColor,
                    )),
              )
            ],
          ),
        )
      ],
    );
  }
}
