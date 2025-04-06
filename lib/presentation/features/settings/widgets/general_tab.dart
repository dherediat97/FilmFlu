import 'dart:io';
import 'package:feedback/feedback.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

class GeneralTab extends StatefulWidget {
  const GeneralTab({super.key});

  @override
  State<GeneralTab> createState() => _GeneralTabState();
}

class _GeneralTabState extends State<GeneralTab> {
  PackageInfo? _packageInfo;

  @override
  void initState() {
    super.initState();
    _setPackageInfo();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(title: Text('App version: ${_packageInfo?.version ?? ''}')),
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

  Future<void> _setPackageInfo() async => PackageInfo.fromPlatform().then(
    (PackageInfo packageInfo) => setState(() => _packageInfo = packageInfo),
  );

  Future<String> writeImageToStorage(Uint8List feedbackScreenshot) async {
    final Directory output = await getTemporaryDirectory();
    final String screenshotFilePath = '${output.path}/feedback.png';
    final File screenshotFile = File(screenshotFilePath);
    await screenshotFile.writeAsBytes(feedbackScreenshot);
    return screenshotFilePath;
  }
}
