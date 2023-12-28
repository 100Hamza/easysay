import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../../utils/image_path.dart';

class CustomFAB extends StatefulWidget {
  String? text;
  CustomFAB({super.key, this.text});

  @override
  State<CustomFAB> createState() => _CustomFABState();
}

class _CustomFABState extends State<CustomFAB> {

  bool isListening = false;
  SpeechToText speechToText = SpeechToText();

  @override
  Widget build(BuildContext context) {
    return AvatarGlow(
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
              print('After IsListening = $isListening');
              bool isAvailable = await speechToText.initialize(
                onStatus: (status) {
                  print('Speech to text status: $status');
                },
                debugLogging: true,
              );
              print('before is Available = $isAvailable');
              if (isAvailable) {
                print('After is Available = $isAvailable');
                setState(() {
                  isListening = true;
                  // _startOrStopRecording(true);
                  // recorderController.record();
                  speechToText.listen(
                    listenMode: ListenMode.dictation,
                    onResult: (result) {
                      setState(() {
                        widget.text = result.recognizedWords;
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
    );
  }
}
