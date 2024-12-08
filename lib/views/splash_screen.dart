import 'package:flutter/material.dart';
import 'package:newsnow/views/main_screen.dart';
import '../constants.dart/app_contants.dart';

class SplashScreen extends StatefulWidget { 
  const SplashScreen({super.key}); 
 
  @override 
  _SplashScreenState createState() => _SplashScreenState(); 
} 
 
class _SplashScreenState extends State<SplashScreen> 
    with SingleTickerProviderStateMixin { 
  late AnimationController animationController; 
  late Animation<double> textfade; 
 
  @override 
  void initState() { 
    super.initState(); 
     animationController = AnimationController( 
      duration: const Duration(seconds: 2), 
      vsync: this, 
    ); 
 
    textfade = Tween<double>(begin: 0.0, end: 1.0).animate( 
      CurvedAnimation( 
        parent: animationController, 
        curve: Curves.easeIn, 
      ), 
    ); 
 
    animationController.forward(); 

  } 
 
  @override 
  void dispose() { 
    animationController.dispose(); 
    super.dispose(); 
  }
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const MainScreen()));
    });

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          SizedBox(height: MediaQuery.of(context).size.height*0.09,),
           Center(
            child: FadeTransition( 
                opacity: textfade, 
            child: Text(
              'NEWS NOW',
              style: AppTextStyle.title.copyWith( 
                    fontSize: 50, 
                    color: AppColors.hotRed, 
                    letterSpacing: 1.5, 
                  ), 
            ),
          ),),
          const SizedBox(height: 20),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Text(
              'Powered by NewsAPI',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.black.withOpacity(0.6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
