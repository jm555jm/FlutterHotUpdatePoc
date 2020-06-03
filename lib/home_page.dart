import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:sky/increment_button_listener.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  String genJsonString() {
    final colors = ["#23467E", "#467E23", "#7E2346"];
    // RaisedButton has parser provided by lib
    // FlatButton has parser by custom from flat_button_parser.dart
    final widgets = ["RaisedButton", "FlatButton"];
    final color = colors[_counter % 3];
    final useWidget = widgets[_counter % 2];
    final raisedButtonJson ='''
    {
      "type": "Container",
      "alignment": "center",
      "child": {
        "type": "$useWidget",
        "color": "$color",
        "padding": "8,8,8,8",
        "textColor": "#FFFFFF",
        "elevation" : 8.0,
        "splashColor" : "#00FF00",
        "click_event" : "route://productDetail?goods_id=123",
        "child" : {
          "type": "Text",
          "data": "I am a $useWidget"
        }
      }
    }
    ''';
    return raisedButtonJson;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
            FutureBuilder<Widget>(
              future: _buildWidgetFromJsonString(context),
              builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                }
                if (snapshot.hasData) {
                  final Widget parsedFromJson = snapshot.data;
                  return parsedFromJson;
                }
                return Text("Loading...");
              },
            )
          ],
        ),
      ),
    );
  }
  Future<Widget> _buildWidgetFromJsonString(BuildContext context) async {
    final jsonString = genJsonString();
    return DynamicWidgetBuilder.build(jsonString, context, new IncrementButtonListener(_incrementCounter));
  }
}
