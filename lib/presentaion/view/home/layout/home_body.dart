import 'package:easy_say/utils/image_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeBody extends StatelessWidget {
  String? text;

  HomeBody({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 30),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: const Offset(0.0, 4), //(x,y)
                    blurRadius: 20.0,
                    spreadRadius: 0.0),
              ]),
          height: size.height * 0.78,
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image(
                    image: const AssetImage(ImagePath.kAppBarLogo),
                    height: size.height * 0.04,
                  ),
                  InkWell(
                    onTap: () async {
                      Clipboard.setData(ClipboardData(text: text.toString()))
                          .then(
                        (value) {
                          return ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Text Copied'),
                            ),
                          );
                        },
                      );
                    },
                    child: Row(
                      children: [
                        Text('Copy Text',
                            style: GoogleFonts.urbanist(
                                fontSize: 16,
                                color: Colors.grey.withOpacity(0.6),
                                fontWeight: FontWeight.bold)),
                        const SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.copy,
                          color: Colors.grey.withOpacity(0.6),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Divider(
                color: Colors.grey.withOpacity(0.1),
                thickness: 2,
                height: 0,
              ),
              const SizedBox(
                height: 10,
              ),
              SelectableText(
                text.toString(),
                style: GoogleFonts.urbanist(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
