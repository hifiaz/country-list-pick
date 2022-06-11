// ignore: depend_on_referenced_packages
import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
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
              backgroundColor: Colors.amber,
              title: const Text('Pick your country'),
            ),
            // if you need custom picker use this
            // pickerBuilder: (context, CountryCode countryCode) {
            //   return Row(
            //     children: [
            //       Image.asset(
            //         countryCode.flagUri,
            //         package: 'country_list_pick',
            //       ),
            //       Text(countryCode.code),
            //       Text(countryCode.dialCode),
            //     ],
            //   );
            // },
            theme: CountryTheme(
              isShowFlag: true,
              isShowTitle: true,
              isShowCode: true,
              isDownIcon: true,
              showEnglishName: false,
              labelColor: Colors.blueAccent,
            ),
            initialSelection: '+62',
            // or
            // initialSelection: 'US'
            onChanged: (CountryCode code) {
              // print(code.name);
              // print(code.code);
              // print(code.dialCode);
              // print(code.flagUri);
            },
          ),
        ),
      ),
    );
  }
}
