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

  Icon icon = Icon(Icons.search);

  @override
  void initState() {
    countries = widget.elements;
    super.initState();
  }

  void _sendDataBack(BuildContext context, CountryCode initialSelection) {
    Navigator.pop(context, initialSelection);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBarTitle,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: icon,
            onPressed: () {
              setState(() {
                if (this.icon.icon == Icons.search) {
                  this.icon = Icon(
                    Icons.close,
                    color: Theme.of(context).secondaryHeaderColor,
                  );
                  this.appBarTitle = TextField(
                    controller: _controller,
                    style: TextStyle(
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                    decoration: InputDecoration.collapsed(
                        hintText: "Search...",
                        hintStyle: TextStyle(
                          color: Theme.of(context).secondaryHeaderColor,
                        )),
                    onChanged: _filterElements,
                  );
                  // _handleSearchStart();
                } else {
                  _handleSearchEnd();
                }
              });
            },
          )
        ],
      ),
      body: Container(
        color: Color(0xfff4f4f4),
        child: ListView(
            children: [
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
              trailing: Icon(Icons.check, color: Colors.green),
            ),
          ),
          SizedBox(height: 15),
        ]..addAll(
                countries.map(
                  (e) => getListCountry(e),
                ),
              )),
      ),
    );
  }

  Widget getListCountry(CountryCode e) {
    return Container(
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

  Widget appBarTitle = Text("Select Country");

  void _handleSearchEnd() {
    setState(() {
      this.icon = Icon(
        Icons.search,
        color: Theme.of(context).secondaryHeaderColor,
      );
      this.appBarTitle = Text("Select Country");
      _controller.clear();
    });
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
}
