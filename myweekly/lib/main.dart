import 'package:flutter/material.dart';
import 'models/task_provider.dart';
import 'models/db_model.dart';
import 'screens/home_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // If you want to fix the orientation to portrait mode only, then un-comment following:
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);

  var db = DatabaseConnect();
  await db.getTodo();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => TaskData(),
      child: MaterialApp(
        title: 'MyWeekly',
        theme: ThemeData.from(
          colorScheme: const ColorScheme.highContrastLight(),
          textTheme: ThemeData.light().textTheme.apply(
                fontFamily: 'Quicksand',
              ),
        ),
        home: const MyHomePage(),
      ),
    );
  }
}
