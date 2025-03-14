import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taskati_task/core/services/local_helper.dart';
import 'package:taskati_task/core/utils/app_colors.dart';
import 'package:taskati_task/core/utils/text_styles.dart';
import 'package:taskati_task/core/widgets/dialogs.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? path;
  String? name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
              onPressed: () {
                bool isDarkTheme = AppLocalStorage.getCachedData(
                        AppLocalStorage.isDarkTheme) ??
                    false;
                AppLocalStorage.cacheData(
                    AppLocalStorage.isDarkTheme, !isDarkTheme);
              },
              icon: const Icon(Icons.dark_mode))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                  onTap: () {
                    showPfpBottomSheet(context, (String imagePath) {
                      setState(() {
                        path = imagePath;
                        AppLocalStorage.cacheData(
                            AppLocalStorage.imageKey, path);
                      });
                    });
                  },
                  child: CircleAvatar(
                      radius: 40,
                      backgroundImage: FileImage(
                          File(AppLocalStorage.getCachedData('image'))))),
              const Gap(20),
              Divider(
                color: AppColors.primaryColor,
              ),
              const Gap(10),
              Row(
                children: [
                  Text(
                    '${AppLocalStorage.getCachedData('name')}',
                    style: getTitleTextStyle(context,
                        color: AppColors.primaryColor),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () async {
                      String? newName = await showNameBottomSheet(
                          context); // Await the result
                      if (newName != null && newName.isNotEmpty) {
                        setState(() {
                          name = newName;
                          AppLocalStorage.cacheData(
                              AppLocalStorage.nameKey, newName);
                        });
                      }
                    },
                    icon: Icon(
                      Icons.edit,
                      color: AppColors.primaryColor,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
