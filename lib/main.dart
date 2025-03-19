import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'providers/game_provider.dart';
import 'providers/language_provider.dart';
import 'providers/bible_course_provider.dart';
import 'screens/language_selection_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar SQLite solo para plataformas de escritorio (no web)
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    // Inicializar para desktop
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    debugPrint('SQLite inicializado para desktop');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690), // Tamaño de diseño base
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => LanguageProvider()),
            ChangeNotifierProxyProvider<LanguageProvider, GameProvider>(
              create: (context) => GameProvider(),
              update: (context, languageProvider, previousGameProvider) {
                if (previousGameProvider != null) {
                  previousGameProvider.setLanguage(
                    languageProvider.currentLanguage,
                  );
                  return previousGameProvider;
                }
                return GameProvider();
              },
            ),
            ChangeNotifierProvider(create: (context) => BibleCourseProvider()),
          ],
          child: MaterialApp(
            title: 'Teolingo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
              useMaterial3: true,
              fontFamily: 'Times New Roman',
              // Aplicar Times New Roman a todos los estilos de texto
              textTheme: Typography.material2018().black.apply(
                fontFamily: 'Times New Roman',
              ),
            ),
            home: child,
          ),
        );
      },
      child: const LanguageSelectionScreen(),
    );
  }
}
