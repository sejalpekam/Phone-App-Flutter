//import 'dart:math';
import 'package:flutter/material.dart';
import 'package:phone_app/data/contacts.dart';
import 'package:phone_app/services/call_and_message_services.dart';
import 'package:phone_app/services/locator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CallsAndMessageService _service = getIt<CallsAndMessageService>();
  int _selectedIndex = -1;
  bool _selected = false;
  String number = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Phone App')),
        body: Container(
          child: Column(children: [
            Expanded(
              child: ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      elevation: 10.0,
                      child: ListTile(
                        title: Text(contacts[index]['name']),
                        subtitle: Text(contacts[index]['number']),
                        leading: CircleAvatar(
                          child: Text(contacts[index]['name'][0]),
                          // backgroundColor: Colors.primaries[
                          //     Random().nextInt(Colors.primaries.length)],
                        ),
                        selected: index == _selectedIndex && _selected == true,
                        //selectedTileColor: Colors.blue.withOpacity(0.2),
                        onTap: () {
                          setState(() {
                            if (_selected == false || _selectedIndex != index) {
                              _selectedIndex = index;
                              _selected = true;
                              number = contacts[index]['number'];
                            } else {
                              _selectedIndex = -1;
                              _selected = false;
                            }
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 15, 10, 20),
              child: new ButtonBar(
                alignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new ElevatedButton(
                    child: new Text('Call'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (_selected) return Colors.green;
                        return Colors.black12;
                      }),
                    ),
                    onPressed: _selected ? () => _service.call(number) : null,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  new ElevatedButton(
                    child: new Text('Message'),
                    onPressed:
                        _selected ? () => _service.sendSms(number) : null,
                  ),
                ],
              ),
            ),
          ]),
        ));
  }
}
