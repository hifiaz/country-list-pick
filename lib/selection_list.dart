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
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(null),
        ),
        title: Text('Select Country'),
        centerTitle: true,
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
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[Text(e.name), Divider()],
        ),
        onTap: () {
          _sendDataBack(context, e);
        },
      ),
    );
  }
}
