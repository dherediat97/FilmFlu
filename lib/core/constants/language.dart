class Language {
  final String name;
  final String languageCode;

  Language(this.name, this.languageCode);

  static List<Language> languageList() {
    return <Language>[
      Language("French", "fr"),
      Language("English", "en"),
      Language("Español", "es"),
      Language("Italian", "it")
    ];
  }
}
