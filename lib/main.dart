import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'constants.dart/app_contants.dart';
import 'viewmodels/news_view_model.dart';
import 'views/splash_screen.dart';

void main() async{ 
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NewsViewModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'NewsApp',
        theme: ThemeData(primarySwatch: Colors.blue,  scaffoldBackgroundColor: AppColors.white),
        home: const SplashScreen(),
      ),
    );
  }
}
