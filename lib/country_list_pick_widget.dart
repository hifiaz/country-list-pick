import 'package:country_list_pick/country_selection_theme.dart';
import 'package:country_list_pick/selection_list.dart';
import 'package:country_list_pick/support/code_countries_en.dart';
import 'package:country_list_pick/support/code_country.dart';
import 'package:country_list_pick/support/code_countrys.dart';
import 'package:flutter/material.dart';

import 'support/code_country.dart';

export 'support/code_country.dart';

export 'country_selection_theme.dart';

class CountryListPickWidget extends StatefulWidget {
  CountryListPickWidget({
    this.onChanged,
    this.initialSelection,
    this.appBar,
    this.pickerBuilder,
    this.countryBuilder,
    this.theme,
    this.useUiOverlay = true,
    this.isOverlay = false,
    this.useSafeArea = false,
    required this.onClose,
  });

  final String? initialSelection;
  final ValueChanged<CountryCode?>? onChanged;
  final PreferredSizeWidget? appBar;
  final Widget Function(BuildContext context, CountryCode? countryCode)?
      pickerBuilder;
  final CountryTheme? theme;
  final Widget Function(BuildContext context, CountryCode countryCode)?
      countryBuilder;
  final bool useUiOverlay;
  final bool useSafeArea;
  final bool isOverlay;
  final Function onClose;

  @override
  _CountryListPickState createState() {
    List<Map> jsonList =
        this.theme?.showEnglishName ?? true ? countriesEnglish : codes;

    List elements = jsonList
        .map((s) => CountryCode(
              name: s['name'],
              code: s['code'],
              dialCode: s['dial_code'],
              flagUri: 'flags/${s['code'].toLowerCase()}.png',
            ))
        .toList();
    return _CountryListPickState(elements);
  }
}

class _CountryListPickState extends State<CountryListPickWidget> {
  CountryCode? selectedItem;
  List elements = [];

  _CountryListPickState(this.elements);

  @override
  void initState() {
    if (widget.initialSelection != null) {
      selectedItem = elements.firstWhere(
          (e) =>
              (e.code.toUpperCase() ==
                  widget.initialSelection!.toUpperCase()) ||
              (e.dialCode == widget.initialSelection),
          orElse: () => elements[0] as CountryCode);
    } else {
      selectedItem = elements[0];
    }

    super.initState();
  }

  void _awaitFromSelectScreen(BuildContext context, PreferredSizeWidget? appBar,
      CountryTheme? theme) async {
    if (widget.isOverlay) {
      late OverlayEntry? entry;
      OverlayState? _overlayState = Overlay.of(context, rootOverlay: true);
      entry = OverlayEntry(
        builder: (BuildContext context) => SafeArea(
          child: SafeArea(
            top: true,
            bottom: true,
            child: Material(
              color: Colors.transparent,
              child: Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: Text("Country/Region"),
                  actions: [
                    IconButton(
                      onPressed: () {
                        entry!.remove();
                        entry = null;
                        widget.onClose();
                      },
                      icon: Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                body: SelectionList(
                  elements,
                  selectedItem,
                  theme: theme,
                  countryBuilder: widget.countryBuilder,
                  isOverlay: true,
                  onSuccessCallback: (countryCode) {
                    entry!.remove();
                    entry = null;
                    setState(() {
                      selectedItem = countryCode;
                    });
                  },
                  useUiOverlay: widget.useUiOverlay,
                  useSafeArea: widget.useSafeArea,
                ),
              ),
            ),
          ),
        ),
      );
      _overlayState!.insert(entry!);
    } else {
      final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SelectionList(
              elements,
              selectedItem,
              appBar: widget.appBar ??
                  AppBar(
                    backgroundColor: Theme.of(context).appBarTheme.color,
                    title: Text("Select Country"),
                  ),
              theme: theme,
              countryBuilder: widget.countryBuilder,
              useUiOverlay: widget.useUiOverlay,
              useSafeArea: widget.useSafeArea,
            ),
          ));
      setState(() {
        selectedItem = result ?? selectedItem;
        widget.onChanged!(result ?? selectedItem);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isOverlay) {
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          _awaitFromSelectScreen(context, widget.appBar, widget.theme);
        },
        child: widget.pickerBuilder!(context, selectedItem),
      );
    }
    return TextButton(
      onPressed: () {
        _awaitFromSelectScreen(context, widget.appBar, widget.theme);
      },
      child: widget.pickerBuilder != null
          ? widget.pickerBuilder!(context, selectedItem)
          : Flex(
              direction: Axis.horizontal,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (widget.theme?.isShowFlag ?? true == true)
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Image.asset(
                        selectedItem!.flagUri!,
                        package: 'country_list_pick',
                        width: 32.0,
                      ),
                    ),
                  ),
                if (widget.theme?.isShowCode ?? true == true)
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text(selectedItem.toString()),
                    ),
                  ),
                if (widget.theme?.isShowTitle ?? true == true)
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text(selectedItem!.toCountryStringOnly()),
                    ),
                  ),
                if (widget.theme?.isDownIcon ?? true == true)
                  Flexible(
                    child: Icon(Icons.keyboard_arrow_down),
                  )
              ],
            ),
    );
  }
}
