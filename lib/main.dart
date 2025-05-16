import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:taskati_task/core/models/task_model.dart';
import 'package:taskati_task/core/services/local_helper.dart';
import 'package:taskati_task/core/utils/app_colors.dart';
import 'package:taskati_task/core/utils/text_styles.dart';
import 'package:taskati_task/feature/intro/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(TaskModelAdapter());

  await Hive.openBox('userBox');
  await Hive.openBox<TaskModel>('taskBox');

  AppLocalStorage.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: AppLocalStorage.userBox!.listenable(),
      builder: (BuildContext context, dynamic value, Widget? child) {
        bool isDarkTheme =
            AppLocalStorage.getCachedData(AppLocalStorage.isDarkTheme) ?? false;
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: isDarkTheme ? ThemeMode.dark : ThemeMode.light,
          theme: ThemeData(
              appBarTheme: AppBarTheme(
                  backgroundColor: AppColors.whiteColor,
                  elevation: 0,
                  titleTextStyle: TextStyle(
                    color: AppColors.darkColor,
                    fontSize: 18,
                  ),
                  iconTheme:
                      const IconThemeData(color: AppColors.primaryColor)),
              colorScheme: ColorScheme.fromSeed(
                  seedColor: AppColors.primaryColor,
                  onSurface: AppColors.darkColor),
              scaffoldBackgroundColor: AppColors.whiteColor,
              inputDecorationTheme: InputDecorationTheme(
                  hintStyle: getSmallTextStyle(),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          const BorderSide(color: AppColors.primaryColor)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          const BorderSide(color: AppColors.primaryColor)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: AppColors.redColor)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          const BorderSide(color: AppColors.redColor)))),
          darkTheme: ThemeData(
            appBarTheme: AppBarTheme(
              backgroundColor: AppColors.darkColor,
              elevation: 0,
              titleTextStyle: TextStyle(
                color: AppColors.whiteColor,
                fontSize: 18,
              ),
              iconTheme: const IconThemeData(color: AppColors.primaryColor),
            ),
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.primaryColor,
              onSurface: AppColors.whiteColor, // Make all text white
              brightness: Brightness.dark,
            ),
            scaffoldBackgroundColor: AppColors.darkColor,
            inputDecorationTheme: InputDecorationTheme(
              hintStyle: getSmallTextStyle(),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: AppColors.primaryColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: AppColors.primaryColor),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: AppColors.redColor),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: AppColors.redColor),
              ),
            ),
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: AppColors.primaryColor,
              selectionColor: AppColors.primaryColor.withOpacity(0.4),
              selectionHandleColor: AppColors.primaryColor,
            ),
            popupMenuTheme: const PopupMenuThemeData(
              color: Colors.grey, // dark background for popup
              textStyle: TextStyle(color: Colors.white), // white text
            ),
          ),
          home: const SplashScreen(),
        );
      },
    );
  }
}
