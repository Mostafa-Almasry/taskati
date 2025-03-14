import 'dart:io';

import 'package:flutter/material.dart';
import 'package:taskati_task/core/services/local_helper.dart';
import 'package:taskati_task/core/utils/app_colors.dart';
import 'package:taskati_task/core/utils/text_styles.dart';
import 'package:taskati_task/feature/profile/profile_screen.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
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
                'hello, ${AppLocalStorage.getCachedData('name')}',
                style:
                    getTitleTextStyle(context, color: AppColors.primaryColor),
              ),
              Text(
                'Have a nice day',
                style: getBodyTextStyle(
                  context,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileScreen(),
              ),
            );

            // Trigger a rebuild after returning from ProfileScreen
            (context as Element).markNeedsBuild();
          },
          child: CircleAvatar(
            radius: 24,
            backgroundImage:
                FileImage(File(AppLocalStorage.getCachedData('image'))),
          ),
        )
      ],
    );
  }
}
