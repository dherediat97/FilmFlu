import 'package:film_flu/app/constants/app_colors.dart';
import 'package:film_flu/app/routes/app_routes.dart';
import 'package:film_flu/domain/enums/settings_tab.dart';
import 'package:film_flu/env/env.dart';
import 'package:film_flu/main.dart';
import 'package:film_flu/presentation/features/auth/auth_screen.dart';
import 'package:film_flu/presentation/notifiers/settings_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_button/sign_button.dart';

class AppBarActions extends ConsumerStatefulWidget {
  const AppBarActions({super.key, required this.isMainMenu});

  final bool isMainMenu;

  @override
  ConsumerState<AppBarActions> createState() => _AppBarActionsState();
}

class _AppBarActionsState extends ConsumerState<AppBarActions> {
  @override
  void initState() {
    super.initState();
    if (auth.currentUser != null) {
      _signInFlow(auth.currentUser!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final settingsNotifier = ref.read(settingsProvider.notifier);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Row(
        spacing: 16,
        children: [
          IconButton(
            onPressed: () => {},
            // () => auth.currentUser == null ? _openSignInDialogBox() : {},
            icon: CircleAvatar(
              backgroundColor: Color(0xffE6E6E6),
              radius: 20,
              child:
                  auth.currentUser == null
                      ? Icon(Icons.person, color: Color(0xffCCCCCC))
                      : Image.network(auth.currentUser!.photoURL!),
            ),
          ),
          IconButton(
            icon: Icon(Icons.settings, color: AppColors.backgroundColorLight),
            onPressed: () {
              settingsNotifier.setTabSelected(SettingsTab.general);
              SettingsRoute().push(context);
            },
          ),
        ],
      ),
    );
  }

  _openSignInDialogBox() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Join to FilmFlu'),
            content: AuthScreen(),
            actions: [
              FilledButton(onPressed: () => _signIn(), child: Text('Sign in')),
              SignInButton(
                buttonType: ButtonType.google,
                onPressed: () async {
                  await _googleSignIn();
                  // if (result?.user != null) {
                  //   Navigator.pop(context, result);
                  // }
                },
              ),
            ],
          ),
    );
  }

  Future<UserCredential?> _googleSignIn() async {
    const List<String> scopes = <String>['email'];

    final googleInstance = GoogleSignIn(
      signInOption: SignInOption.standard,
      scopes: scopes,
      clientId: Env.googleClientId,
    );
    if (await googleInstance.isSignedIn()) return null;

    final googleAccount = await googleInstance.signIn();

    final googleAuthentication = await googleAccount?.authentication;

    final AuthCredential authCredential = GoogleAuthProvider.credential(
      idToken: googleAuthentication?.idToken,
      accessToken: googleAuthentication?.accessToken,
    );

    UserCredential result = await FirebaseAuth.instance.signInWithCredential(
      authCredential,
    );
    _signInFlow(result.user!);
    return result;
  }

  _signIn() {}

  _signInFlow(User user) {
    // final profileNotifier = ref.read(profileProvider);
  }
}
