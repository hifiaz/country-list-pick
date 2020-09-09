import 'package:country_list_pick/support/code_country.dart';
import 'package:flutter/material.dart';

class SelectionList extends StatefulWidget {
  SelectionList(
    this.elements,
    this.initialSelection, {
    Key key,
  }) : super(key: key);

  final List<CountryCode> elements;
  final CountryCode initialSelection;

  @override
  _SelectionListState createState() => _SelectionListState();
}

class _SelectionListState extends State<SelectionList> {
  List<CountryCode> countries;
  final TextEditingController _controller = TextEditingController();
  ScrollController _controllerScroll;
  var diff = 0.0;

  var posSelected = 0;
  var height = 0.0;
  var _sizeheightcontainer;
  var _heightscroller;
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
    _controller.addListener(_scrollListener);
    super.initState();
  }

  void _sendDataBack(BuildContext context, CountryCode initialSelection) {
    Navigator.pop(context, initialSelection);
  }

  List _alphabet = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z'
  ];

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Country"),
        centerTitle: true,
      ),
      body: Container(
        color: Color(0xfff4f4f4),
        child: LayoutBuilder(builder: (context, contrainsts) {
          diff = height - contrainsts.biggest.height;
          _heightscroller = (contrainsts.biggest.height) / _alphabet.length;
          _sizeheightcontainer = (contrainsts.biggest.height);
          return Stack(
            children: <Widget>[
              ListView(
                controller: _controllerScroll,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text('SEARCH'),
                  ),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(20.0),
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration.collapsed(
                        hintText: "Search...",
                      ),
                      onChanged: _filterElements,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text('LAST PICK'),
                  ),
                  Container(
                    color: Colors.white,
                    child: ListTile(
                      leading: Image.asset(
                        widget.initialSelection.flagUri,
                        package: 'country_list_pick',
                        width: 32.0,
                      ),
                      title: Text(widget.initialSelection.name),
                      trailing: Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Icon(Icons.check, color: Colors.green),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                ]..addAll(
                    countries.map(
                      (e) => getListCountry(e),
                    ),
                  ),
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
  }

  Widget getListCountry(CountryCode e) {
    return Container(
      height: 50,
      color: Colors.white,
      child: ListTile(
        leading: Image.asset(
          e.flagUri,
          package: 'country_list_pick',
          width: 30.0,
        ),
        title: Text(e.name),
        onTap: () {
          _sendDataBack(context, e);
        },
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
                  _controllerScroll.jumpTo((i * _itemsizeheight) + 10);
                  break;
                }
              }
              _oldtext = _text;
            }
          });
        },
        child: Container(
          width: 40,
          height: 20,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: index == posSelected ? Colors.blue : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: Text(
            _alphabet[index],
            textAlign: TextAlign.center,
            style: (index == posSelected)
                ? TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)
                : TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
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
              _controllerScroll.jumpTo((i * _itemsizeheight) + 15);
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
    if ((_controllerScroll.offset) >=
        (_controllerScroll.position.maxScrollExtent)) {}
    if (_controllerScroll.offset <=
            _controllerScroll.position.minScrollExtent &&
        !_controllerScroll.position.outOfRange) {}
  }
}
