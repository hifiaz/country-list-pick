import 'package:country_list_pick/country_selection_theme.dart';
import 'package:country_list_pick/support/code_country.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'country_list_pick.dart';

class SelectionList extends StatefulWidget {
  SelectionList(
    this.elements,
    this.initialSelection, {
    Key? key,
    this.appBar,
    this.theme,
    this.countryBuilder,
    this.useUiOverlay = true,
    this.useSafeArea = false,
    this.useDarkMode = false,
  }) : super(key: key);

  final PreferredSizeWidget? appBar;
  final List elements;
  final CountryCode? initialSelection;
  final CountryTheme? theme;
  final Widget Function(BuildContext context, CountryCode)? countryBuilder;
  final bool useUiOverlay;
  final bool useSafeArea;
  final bool useDarkMode;

  @override
  _SelectionListState createState() => _SelectionListState();
}

class _SelectionListState extends State<SelectionList> {
  late List countries;
  final TextEditingController _controller = TextEditingController();
  ScrollController? _controllerScroll;
  var diff = 0.0;

  var posSelected = 0;
  var height = 0.0;
  late var _sizeheightcontainer;
  late var _heightscroller;
  var _text;
  var _oldtext;
  var _itemsizeheight = 50.0;
  double _offsetContainer = 0.0;

  bool isShow = true;
  @override
  void initState() {
    countries = widget.elements;
    countries.sort((a, b) {
      return a.name.toString().compareTo(b.name.toString());
    });
    _controllerScroll = ScrollController();
    _controllerScroll!.addListener(_scrollListener);
    super.initState();
  }

  void _sendDataBack(BuildContext context, CountryCode initialSelection) {
    Navigator.pop(context, initialSelection);
  }

  List _alphabet =
      List.generate(26, (i) => String.fromCharCode('A'.codeUnitAt(0) + i));

  @override
  Widget build(BuildContext context) {
    if (widget.useUiOverlay)
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarBrightness: !kIsWeb ? Brightness.dark : Brightness.light,
      ));
    height = MediaQuery.of(context).size.height;
    Widget scaffold = Scaffold(
      appBar: widget.appBar,
      body: Container(
        color: widget.useDarkMode ? Color(0xff1e1d2b) : Colors.white,
        child: LayoutBuilder(builder: (context, contrainsts) {
          diff = height - contrainsts.biggest.height;
          _heightscroller = (contrainsts.biggest.height) / _alphabet.length;
          _sizeheightcontainer = (contrainsts.biggest.height);
          return Stack(
            children: <Widget>[
              CustomScrollView(
                controller: _controllerScroll,
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            widget.theme?.searchText ?? 'SEARCH',
                            style: TextStyle(
                                color: widget.useDarkMode
                                    ? Colors.white70
                                    : Colors.black),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 15.0, right: 45.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: widget.useDarkMode
                                  ? Color(0xff2f3042)
                                  : Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: TextField(
                              style: TextStyle(
                                color: widget.useDarkMode ? Colors.white70 : Colors.black,
                              ),
                              controller: _controller,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    left: 15, bottom: 0, top: 0, right: 15),
                                hintText:
                                    widget.theme?.searchHintText ?? "Search...",
                                hintStyle: widget.useDarkMode
                                    ? TextStyle(color: Colors.white70)
                                    : TextStyle(color: Colors.black),
                              ),
                              onChanged: _filterElements,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            widget.theme?.lastPickText ?? 'LAST PICK',
                            style: TextStyle(
                                color: widget.useDarkMode
                                    ? Colors.white70
                                    : Colors.black),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15.0, right: 45.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: widget.useDarkMode
                                  ? Color(0xff2f3042)
                                  : Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: ListTile(
                                leading: Image.asset(
                                  widget.initialSelection!.flagUri!,
                                  package: 'country_list_pick',
                                  width: 32.0,
                                ),
                                title: Text(
                                  widget.initialSelection!.name!,
                                  style: TextStyle(
                                      color: widget.useDarkMode
                                          ? Colors.white70
                                          : Colors.black),
                                ),
                                trailing: Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: Icon(Icons.check,
                                      color: Color(0xff009788)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            widget.theme?.lastPickText ?? 'COUNTRIES',
                            style: TextStyle(
                                color: widget.useDarkMode
                                    ? Colors.white70
                                    : Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return widget.countryBuilder != null
                          ? widget.countryBuilder!(
                              context, countries.elementAt(index))
                          : getListCountry(countries.elementAt(index));
                    }, childCount: countries.length),
                  )
                ],
              ),
              if (isShow == true)
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onVerticalDragUpdate: _onVerticalDragUpdate,
                    onVerticalDragStart: _onVerticalDragStart,
                    child: Container(
                      height: 20.0 * 30,
                      color: Colors.transparent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: []..addAll(
                            List.generate(_alphabet.length,
                                (index) => _getAlphabetItem(index)),
                          ),
                      ),
                    ),
                  ),
                ),
            ],
          );
        }),
      ),
    );
    return widget.useSafeArea ? SafeArea(child: scaffold) : scaffold;
  }

  Widget getListCountry(CountryCode e) {
    return Padding(
      padding: EdgeInsets.only(left: 15.0, right: 45.0),
      child: Container(
        padding: EdgeInsets.only(bottom: 10.0),
        height: 65,
        decoration: BoxDecoration(
          color: widget.useDarkMode ? Color(0xff1e1d2b) : Colors.white,
        ),
        child: Container(
          decoration: BoxDecoration(
            color:
                widget.useDarkMode ? Color(0xff2f3042) : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: ListTile(
            leading: Image.asset(
              e.flagUri!,
              package: 'country_list_pick',
              width: 30.0,
            ),
            title: Text(
              e.name!,
              style: TextStyle(
                  color: widget.useDarkMode ? Colors.white70 : Colors.black),
            ),
            onTap: () {
              _sendDataBack(context, e);
            },
          ),
        ),
      ),
    );
  }

  _getAlphabetItem(int index) {
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            posSelected = index;
            _text = _alphabet[posSelected];
            if (_text != _oldtext) {
              for (var i = 0; i < countries.length; i++) {
                if (_text.toString().compareTo(
                        countries[i].name.toString().toUpperCase()[0]) ==
                    0) {
                  _controllerScroll!.jumpTo((i * _itemsizeheight) + 10);
                  break;
                }
              }
              _oldtext = _text;
            }
          });
        },
        child: Padding(
          padding: EdgeInsets.only(bottom: 5.0),
          child: Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: index == posSelected
                  ? widget.theme?.alphabetSelectedBackgroundColor ??
                      Color(0xff009788)
                  : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Text(
              _alphabet[index],
              textAlign: TextAlign.center,
              style: (index == posSelected)
                  ? TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: widget.theme?.alphabetSelectedTextColor ??
                          Colors.white)
                  : TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color:
                          widget.useDarkMode ? Colors.white54 : Colors.black),
            ),
          ),
        ),
      ),
    );
  }

  void _filterElements(String s) {
    s = s.toUpperCase();
    setState(() {
      countries = widget.elements
          .where((e) =>
              e.code.contains(s) ||
              e.dialCode.contains(s) ||
              e.name.toUpperCase().contains(s))
          .toList();
    });
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    setState(() {
      if ((_offsetContainer + details.delta.dy) >= 0 &&
          (_offsetContainer + details.delta.dy) <=
              (_sizeheightcontainer - _heightscroller)) {
        _offsetContainer += details.delta.dy;
        posSelected =
            ((_offsetContainer / _heightscroller) % _alphabet.length).round();
        _text = _alphabet[posSelected];
        if (_text != _oldtext) {
          for (var i = 0; i < countries.length; i++) {
            if (_text
                    .toString()
                    .compareTo(countries[i].name.toString().toUpperCase()[0]) ==
                0) {
              _controllerScroll!.jumpTo((i * _itemsizeheight) + 15);
              break;
            }
          }
          _oldtext = _text;
        }
      }
    });
  }

  void _onVerticalDragStart(DragStartDetails details) {
    _offsetContainer = details.globalPosition.dy - diff;
  }

  _scrollListener() {
    int scrollPosition =
        (_controllerScroll!.position.pixels / _itemsizeheight).round();
    if (scrollPosition < countries.length) {
      String? countryName = countries.elementAt(scrollPosition).name;
      setState(() {
        posSelected =
            countryName![0].toUpperCase().codeUnitAt(0) - 'A'.codeUnitAt(0);
      });
    }

    if ((_controllerScroll!.offset) >=
        (_controllerScroll!.position.maxScrollExtent)) {}
    if (_controllerScroll!.offset <=
            _controllerScroll!.position.minScrollExtent &&
        !_controllerScroll!.position.outOfRange) {}
  }
}
