//Core Packages
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//My Packages
import 'package:FilmFlu/network/client_api.dart';

// ignore: must_be_immutable
class ScaffoldPage extends StatefulWidget {
  ScaffoldPage(
      {super.key,
      required this.containerChild,
      this.floatingActionButton,
      this.isLightsOn});
  bool? isLightsOn = false;
  Widget? floatingActionButton = null;
  final Widget containerChild;

  @override
  State<ScaffoldPage> createState() => _ScaffoldPageState();
}

class _ScaffoldPageState extends State<ScaffoldPage> {
  final TextEditingController _searchController = TextEditingController();
  final today = new DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).colorScheme.onBackground,
        appBar: widget.isLightsOn == true
            ? AppBar(
                automaticallyImplyLeading: false,
                toolbarHeight: 100,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Center(
                    child: SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 4,
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
                                    color:
                                        Theme.of(context).colorScheme.primary,
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
                      Navigator.pushNamed(context, "/");
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
                  ])
            : null,
        body: widget.containerChild,
        bottomNavigationBar: widget.isLightsOn == true
            ? Container(
                padding: EdgeInsets.all(16),
                height: kBottomNavigationBarHeight,
                alignment: Alignment.center,
                color: Colors.white,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Made with much",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      Icon(Icons.favorite, color: Colors.red),
                      Spacer(flex: 1),
                      Icon(Icons.copyright, color: Colors.black),
                      Center(
                        child: Text("${today.year} @dherediat97",
                            style: TextStyle(fontSize: 12)),
                      )
                    ]),
              )
            : null,
        floatingActionButton: widget.floatingActionButton);
  }

  List<Widget> _appBarActions(BuildContext context) {
    List<Widget> actions = [];
    List<String> languages = [];
    // String languageChosen = Localizations.localeOf(context).languageCode;
    for (var locale in MaterialApp().supportedLocales) {
      languages.add("assets/icons/${locale.languageCode}_flag.svg");
    }
    //debugPrint(languages.toString());

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
