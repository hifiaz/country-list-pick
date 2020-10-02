import 'dart:io';

import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Country Code Pick'),
          backgroundColor: Colors.amber,
        ),
        body: Center(
          child: CountryListPick(
            appBar: AppBar(
              backgroundColor: Colors.blue,
              title: Text('Choisir un pays'),
            ),
            pickerBuilder: (context, CountryCode countryCode) {
              return Row(
                children: [
                  Image.asset(
                    countryCode.flagUri,
                    package: 'country_list_pick',
                  ),
                  Text(countryCode.code),
                  Text(countryCode.dialCode),
                ],
              );
            },
            theme: CountryTheme(
              isShowFlag: true,
              isShowTitle: true,
              isShowCode: true,
              isDownIcon: true,
              systemUiOverlayStyle: () =>
                  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark,
                systemNavigationBarColor: Colors.white,
                systemNavigationBarIconBrightness: Brightness.dark,
                statusBarBrightness:
                    Platform.isAndroid ? Brightness.dark : Brightness.light,
              )),
              showEnglishName: true,
            ),
            initialSelection: '+62',
            onChanged: (CountryCode code) {
              print(code.name);
              print(code.code);
              print(code.dialCode);
              print(code.flagUri);
            },
          ),
        ),
      ),
    );
  }
}
