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
        // to show or hide flag
        isShowFlag: true,
        // true to show  title country or false to code phone country
        isShowTitle: true,
        // to show or hide down icon
        isDownIcon: true,
        // to initial code number countrey
        initialSelection: '+62',
        // to get feedback data from picker
        onChanged: (CountryCode code) {
            // name of country
            print(code.name);
            // code of country
            print(code.code);
            // code phone of country
            print(code.dialCode);
            // path flag of country
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
        ),
        body: Center(
          child: CountryListPick(
            isShowFlag: true,
            isShowTitle: true,
            isDownIcon: true,
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
