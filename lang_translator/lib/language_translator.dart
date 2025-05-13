import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class LanguageTranslationPage extends StatefulWidget {
  const LanguageTranslationPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LanguageTranslationPageState createState() =>
      _LanguageTranslationPageState();
}

class _LanguageTranslationPageState extends State<LanguageTranslationPage> {
  final Map<String, String> languagesMap = {
    'English': 'en',
    'Hindi': 'hi',
    'Arabic': 'ar',
    'Urdu': 'ur',
    'French': 'fr',
    'Spanish': 'es',
    'Chinese': 'zh-cn',
    'Japanese': 'ja',
    'German': 'de',
    'Turkish': 'tr',
  };

  String? originLanguage;
  String? destinationLanguage;
  String output = "";
  TextEditingController languageController = TextEditingController();

  void translate() async {
    if (originLanguage == null || destinationLanguage == null) {
      setState(() {
        output = "Please select both languages.";
      });
      return;
    }

    if (languageController.text.trim().isEmpty) {
      setState(() {
        output = "Please enter text to translate.";
      });
      return;
    }

    if (originLanguage == destinationLanguage) {
      setState(() {
        output = "Source and target languages are the same.";
      });
      return;
    }

    final translator = GoogleTranslator();

    try {
      var translation = await translator.translate(
        languageController.text.trim(),
        from: languagesMap[originLanguage]!,
        to: languagesMap[destinationLanguage]!,
      );

      setState(() {
        output = translation.text;
      });
    } catch (e) {
      setState(() {
        output = "Translation failed: $e";
      });
    }
  }

  Container buildLanguageDropdown(
    String? selectedLang,
    String hint,
    Function(String?) onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white70),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white24,
      ),
      child: DropdownButton<String>(
        value: selectedLang,
        hint: Text(hint, style: const TextStyle(color: Colors.white70)),
        dropdownColor: Colors.white,
        iconEnabledColor: Colors.white,
        underline: const SizedBox(), // removes underline
        items:
            languagesMap.keys.map((String language) {
              return DropdownMenuItem(
                value: language,
                child: Text(
                  language,
                  style: const TextStyle(color: Colors.black),
                ),
              );
            }).toList(),
        onChanged: onChanged,
        style: const TextStyle(color: Colors.white), // selected item
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff10223d),
      appBar: AppBar(
        title: const Text(
          "🌐 Language Translator",
          style: TextStyle(color: Colors.white), // <-- Set title color to white
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff0f1a2d),
        elevation: 2,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ), // <-- Optional: icons like back arrow
      ),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Select Languages",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: buildLanguageDropdown(originLanguage, "From", (
                      value,
                    ) {
                      setState(() => originLanguage = value);
                    }),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Icon(
                      Icons.compare_arrows,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  Expanded(
                    child: buildLanguageDropdown(destinationLanguage, "To", (
                      value,
                    ) {
                      setState(() => destinationLanguage = value);
                    }),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              TextField(
                controller: languageController,
                style: const TextStyle(color: Colors.white),
                maxLines: null,
                decoration: InputDecoration(
                  labelText: 'Enter your text...',
                  labelStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: const Color(0xff1b2a49),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white70),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: translate,
                icon: const Icon(Icons.translate),
                label: const Text("Translate"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff2b3c5a),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 12,
                  ),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xff1b2a49),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  output,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
