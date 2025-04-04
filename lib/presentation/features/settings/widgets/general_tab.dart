import 'dart:io';
import 'package:feedback/feedback.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:path_provider/path_provider.dart';

class GeneralTab extends StatelessWidget {
  const GeneralTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) ...[
            GestureDetector(
              onTap:
                  () => BetterFeedback.of(context).show((feedback) async {
                    final screenshotFilePath = await writeImageToStorage(
                      feedback.screenshot,
                    );

                    final Email email = Email(
                      body: feedback.text,
                      subject: 'App Feedback',
                      recipients: ['filmflu.team@gmail.com'],
                      attachmentPaths: [screenshotFilePath],
                      isHTML: false,
                    );
                    await FlutterEmailSender.send(email);
                  }),
              child: Text(
                'Help',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Future<String> writeImageToStorage(Uint8List feedbackScreenshot) async {
    final Directory output = await getTemporaryDirectory();
    final String screenshotFilePath = '${output.path}/feedback.png';
    final File screenshotFile = File(screenshotFilePath);
    await screenshotFile.writeAsBytes(feedbackScreenshot);
    return screenshotFilePath;
  }
}
