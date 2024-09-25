import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:memes/routes/app_routes.dart';
import 'package:memes/routes/routes.dart';
import 'bindings/general_bindings.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/constants/app_colors.dart';
import 'presentation/screens/meme_list_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      getPages: AppRoutes.pages,
      initialBinding: GeneralBindings(),
      initialRoute: RouteStrings.memeList,
    );
  }
}

