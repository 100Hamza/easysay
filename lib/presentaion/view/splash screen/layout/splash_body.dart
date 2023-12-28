import 'dart:async';

import 'package:easy_say/presentaion/view/home/home_view.dart';
import 'package:easy_say/utils/image_path.dart';
import 'package:flutter/material.dart';


class SplashBody extends StatefulWidget {
  const SplashBody({super.key});

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 5), () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeView(),)),);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.8,
          width: MediaQuery.sizeOf(context).width * 0.7,
          child: const Image(image: AssetImage(ImagePath.kLogo))),
    );
  }
}
