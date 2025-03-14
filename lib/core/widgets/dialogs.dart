import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taskati_task/core/services/image_helper.dart';
import 'package:taskati_task/core/utils/app_colors.dart';
import 'package:taskati_task/core/utils/text_styles.dart';
import 'package:taskati_task/core/widgets/custom_button.dart';

showErrorToast(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 2),
      backgroundColor: AppColors.redColor,
      content: Text(
        message,
        style: getSmallTextStyle(color: AppColors.whiteColor),
      )));
}

showPfpBottomSheet(BuildContext context, Function(String) onImageSelected) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    isDismissible: true,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomButton(
              text: 'Upload From Camera',
              width: double.infinity,
              onPressed: () async {
                final navigator = Navigator.of(context);
                String? imagePath = await ImageHelper.pickImage(true);
                if (imagePath != null) {
                  onImageSelected(imagePath);
                }
                navigator.pop();
              },
            ),
            const SizedBox(height: 15),
            CustomButton(
              text: 'Upload From Gallery',
              width: double.infinity,
              onPressed: () async {
                final navigator = Navigator.of(context);
                String? imagePath = await ImageHelper.pickImage(false);
                if (imagePath != null) {
                  onImageSelected(imagePath);
                }
                navigator.pop();
              },
            ),
            const Gap(5)
          ],
        ),
      );
    },
  );
}

final TextEditingController nameController = TextEditingController();

Future<String?> showNameBottomSheet(BuildContext context) async {
  return await showModalBottomSheet<String>(
    context: context,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    isDismissible: true,
    isScrollControlled: true,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Enter new name'),
              ),
              const SizedBox(height: 10),
              CustomButton(
                text: 'Update Your Name',
                width: double.infinity,
                onPressed: () {
                  Navigator.pop(context, nameController.text);
                },
              ),
              const Gap(10)
            ],
          ),
        ),
      );
    },
  );
}
