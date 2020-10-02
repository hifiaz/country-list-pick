# country list pick

Flutter plugin to pick country with output name, code, dialcode and flag of country

<div style="text-align:center">
<img src="https://raw.githubusercontent.com/hifiaz/country-list-pick/master/screenshot/screenrecord.gif" width="240"/>
</div>
<img src="https://raw.githubusercontent.com/hifiaz/country-list-pick/master/screenshot/flutter_01.png" width="240"/>
<img src="https://raw.githubusercontent.com/hifiaz/country-list-pick/master/screenshot/flutter_02.png" width="240"/>
<img src="https://raw.githubusercontent.com/hifiaz/country-list-pick/master/screenshot/flutter_03.png" width="240"/>

## Usage

To use this plugin, add `country_list_pick` as a [dependency in your pubspec.yaml](https://flutter.io/platform-plugins/).

```dart
    CountryListPick(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text('Choisir un pays'),
        ),
        
        // if you need custome picker use this
        pickerBuilder: (context, CountryCode countryCode){
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

        // To disable option set to false
        theme: CountryTheme(
          isShowFlag: true,
          isShowTitle: true,
          isShowCode: true,
          isDownIcon: true,
          showEnglishName: true,
        ),
        // Set default value
        initialSelection: '+62',
          onChanged: (CountryCode code) {
            print(code.name);
            print(code.code);
            print(code.dialCode);
            print(code.flagUri);
          },
        ),
```

To call feedback or getting data from this widget, you can make function in onChanged

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
          ),
        ),
      ),
    );
  }
}
```

### Special Thanks

- Salvatore Giordano, CountryCodePicker [CountryCodePicker](https://github.com/imtoori/CountryCodePicker)
- @tomrozb and @dev-fema for changelog 1.0.0+3
- @giaotuancse for changelog 1.0.0+4
- @joshuachinemezu for changelog 1.0.0+6 - 1.0.0+8
- @u-gin for chaangelog 1.0.0+9
- @imurnane for chaangelog 1.0.1+1
- @jpainam for chaangelog 1.0.1+2