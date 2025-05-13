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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff10223d),
      appBar: AppBar(
        title: Text("Language Translator"),
        centerTitle: true,
        backgroundColor: Color(0xff10223d),
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton<String>(
                    value: originLanguage,
                    hint: Text("From", style: TextStyle(color: Colors.white)),
                    dropdownColor: Colors.white,
                    items:
                        languagesMap.keys.map((String language) {
                          return DropdownMenuItem(
                            value: language,
                            child: Text(language),
                          );
                        }).toList(),
                    onChanged: (value) {
                      setState(() {
                        originLanguage = value;
                      });
                    },
                  ),
                  SizedBox(width: 30),
                  Icon(
                    Icons.arrow_right_alt_outlined,
                    color: Colors.white,
                    size: 40,
                  ),
                  SizedBox(width: 30),
                  DropdownButton<String>(
                    value: destinationLanguage,
                    hint: Text("To", style: TextStyle(color: Colors.white)),
                    dropdownColor: Colors.white,
                    items:
                        languagesMap.keys.map((String language) {
                          return DropdownMenuItem(
                            value: language,
                            child: Text(language),
                          );
                        }).toList(),
                    onChanged: (value) {
                      setState(() {
                        destinationLanguage = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 30),
              TextField(
                controller: languageController,
                style: TextStyle(color: Colors.white),
                maxLines: null,
                decoration: InputDecoration(
                  labelText: 'Enter your text...',
                  labelStyle: TextStyle(color: Colors.white70),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: translate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff2b3c5a),
                ),
                child: Text("Translate"),
              ),
              SizedBox(height: 30),
              Text(
                output,
                style: TextStyle(color: Colors.white, fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
