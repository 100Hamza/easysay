import 'package:avatar_glow/avatar_glow.dart';
import 'package:easy_say/presentaion/view/home/layout/home_body.dart';
import 'package:easy_say/utils/front_end_config.dart';
import 'package:easy_say/utils/image_path.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  String text = 'Hold the Mic Button';
  bool isListening = false;
  SpeechToText speechToText = SpeechToText();
  bool isAvailable = false;
  // late SpeechToText speechToText;
  // late final RecorderController recorderController;

  bool isRecording = false;
  bool isRecordingCompleted = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    initSpeech();
    // speechToText = SpeechToText();
    // recorderController = RecorderController();
    // _initialiseControllers();
  }

  void initSpeech() async {
    isAvailable = await speechToText.initialize(
      onStatus: (status) {
        print('Speech to text status: $status');
      },
      debugLogging: true,
    );
  }
  // @override
  // void dispose() {
  //   recorderController.dispose();
  //   super.dispose();
  // }


  @override
  Widget build(BuildContext context) {
    debugPrint('In Build isRecording: $isRecording');
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: FrontEndConfig.kScaffoldBgColor,
      // appBar: AppBar(
      //   title: Image(
      //     image: const AssetImage(ImagePath.kAppBarLogo),
      //     height: size.height * 0.055,
      //   ),
      //   centerTitle: true,
      //   automaticallyImplyLeading: false,
      // ),
      body: HomeBody(text: text),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child:AvatarGlow(
          animate: isListening,
          repeat: true,
          glowShape: BoxShape.circle,
          duration: const Duration(milliseconds: 2000),
          glowRadiusFactor: 0.4,
          startDelay: Duration(milliseconds: 100),
          curve: Curves.fastOutSlowIn,
          glowColor: Colors.blue,
          child: GestureDetector(
            onTapDown: (details) async {
              print('before IsListening = $isListening');
              if (!isListening) {
                try {
                  if (isAvailable) {
                    setState(() {
                      text = '';
                      isListening = true;
                      // _startOrStopRecording(true);
                      // recorderController.record();
                      speechToText.listen(
                        listenMode: ListenMode.dictation,
                        onResult: (result) {
                          setState(() {
                            text = result.recognizedWords;
                          });
                        },
                      );
                    });
                  }
                } catch (e) {
                  print('Error Message: ${e.toString()}');
                }
              }
            },
            onTapUp: (details) {
              setState(() {
                isListening = false;
                // recorderController.stop();
                speechToText.stop();
                // _startOrStopRecording(false);
              });

            },
            child: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(isListening
                  ? ImagePath.kTappedImage
                  : ImagePath.kUntappedImage),
            ),
          ),
        ) ,
      ),
    );
  }

}
