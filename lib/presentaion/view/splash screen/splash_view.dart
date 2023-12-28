import 'package:easy_say/presentaion/view/splash%20screen/layout/splash_body.dart';
import 'package:easy_say/utils/image_path.dart';
import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
          height: MediaQuery.sizeOf(context).height * 1,
          width: MediaQuery.sizeOf(context).width * 1,
          decoration: const BoxDecoration(
            color: Colors.greenAccent,
            image: DecorationImage(
              image: AssetImage(ImagePath.kSplashBg),
              fit: BoxFit.cover,
            ),
          ),
          child: const SplashBody()),
    );
  }
}
