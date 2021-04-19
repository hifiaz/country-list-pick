# Country List Pick Example

Demonstrates how to use the country_list_pick plugin.

### Example

```dart
import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';

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
            // if you need custome picker use this
            // pickerBuilder: (context, CountryCode countryCode){
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
              showEnglishName: true,
            ),
            initialSelection: '+62',
            onChanged: (CountryCode code) {
              print(code.name);
              print(code.code);
              print(code.dialCode);
              print(code.flagUri);
            },
            // Whether to allow the widget to set a custom UI overlay
            useUiOverlay: true,
            // Whether the country list should be wrapped in a SafeArea
            useSafeArea: false,
             // Whether to use Dark mode in Country Selection Screen
            useDarkMode: true,
            ),
          ),
        ),
      ),
    );
  }
}
```