//Core Packages
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//My Packages
import 'package:FilmFlu/network/api.dart';

class ScaffoldPage extends StatefulWidget {
  const ScaffoldPage({super.key, required this.containerChild});
  final Widget containerChild;

  @override
  State<ScaffoldPage> createState() => _ScaffoldPageState();
}

class _ScaffoldPageState extends State<ScaffoldPage> {
  final TextEditingController _searchController = TextEditingController();
  final now = new DateTime.now();

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).colorScheme.onBackground,
        appBar: AppBar(
            toolbarHeight: 75,
            flexibleSpace: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Center(
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: TextField(
                          autocorrect: true,
                          controller: _searchController,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 20,
                              fontFamily: "YsabeauInfant"),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)!
                                  .search_film_hint,
                              hintStyle: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 20,
                                  fontFamily: "YsabeauInfant"),
                              prefixIcon: Icon(
                                Icons.search,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              border: InputBorder.none),
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            title: InkWell(
                child: Image.asset('assets/images/transparent_logo.png',
                    height: 60),
                onTap: () {
                  Navigator.pop(context);
                }),
            elevation: 48,
            backgroundColor: Theme.of(context).colorScheme.background,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: _appBarActions(context),
                ),
              )
            ]),
        body: widget.containerChild,
        bottomNavigationBar: Container(
          padding: EdgeInsets.all(12),
          height: 50.0,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text("Made with much",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              ),
              Icon(Icons.favorite, color: Colors.red),
              Spacer(flex: 1),
              Icon(Icons.copyright, color: Colors.black),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text("${now.year} @dherediat97 All Rights Reserved",
                    style: TextStyle(fontSize: 12)),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _appBarActions(BuildContext context) {
    List<Widget> actions = [];
    List<String> languages = [];
    // String languageChosen = Localizations.localeOf(context).languageCode;
    for (var locale in MaterialApp().supportedLocales) {
      languages.add("assets/icons/${locale.languageCode}_flag.svg");
    }

    // actions.add(DropdownButton<String>(
    //     onChanged: (value) {
    //       setState(() {
    //         languageChosen = value!;
    //       });
    //     },
    //     icon: SvgPicture.asset(languageChosen),
    //     value: languages.first,
    //     items: languages.map<DropdownMenuItem<String>>((String value) {
    //       return DropdownMenuItem<String>(
    //         value: value,
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //           children: [
    //             SvgPicture.asset(value),
    //           ],
    //         ),
    //       );
    //     }).toList()));
    if (kIsWeb) {
      actions.add(IconButton(
        onPressed: () async {
          PackageInfo packageInfo = await PackageInfo.fromPlatform();
          version = packageInfo.version;
          //Descargar App Android
          final Uri url = Uri.parse(appDownloadBaseUrl);
          launchUrl(url);
        },
        icon: Icon(
          Icons.android,
          color: Theme.of(context).colorScheme.primary,
        ),
      ));
    }
    actions.add(IconButton(
      onPressed: () => Navigator.pushNamed(context, '/settings'),
      icon: Icon(
        Icons.settings,
        color: Theme.of(context).colorScheme.primary,
      ),
    ));
    return actions;
  }
}
