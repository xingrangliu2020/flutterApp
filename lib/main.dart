import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BSG Games',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      //home: const MyHomePage(title: 'BSG Raffle'),
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _MyStatefulWidgetState extends State<MyStatefulWidget>
    with TickerProviderStateMixin {
  late TabController _tabController;
  String? _readCodesString = "";

  bool _camState = false;

  _qrCallbackliu(String? code) {
    setState(() {
      _camState = false;
      _readCodesString = code;
    });
  }

  _scanCode() {
    setState(() {
      _camState = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    _scanCode();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
/*    // TODO: implement build
    throw UnimplementedError();*/
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(

/*        indicatorColor: Colors.amberAccent,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorWeight: 10 ,*/
            controller: _tabController,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.greenAccent,
            ),
            isScrollable: true,
            tabs: [
              Tab(icon: Icon(Icons.qr_code_scanner)),
              Tab(icon: Icon(Icons.shopping_cart)),
              Tab(icon: Icon(Icons.check_circle_outline)),
              Tab(icon: Icon(Icons.directions_car)),
              Tab(icon: Icon(Icons.directions_boat)),
              Tab(icon: Icon(Icons.directions_transit)),
            ]),
        title: const Text("BSG Games"),
      ),
      body: TabBarView(controller: _tabController, children: [
        //Icon(Icons.qr_code_scanner,size: 350,)

        Column(
          children: [
            _camState
                ? Center(
                    child: SizedBox(
                      height: 300,
                      width: 150,
                      child: QRBarScannerCamera(
                        onError: (context, error) => Text(
                          error.toString(),
                          style: TextStyle(color: Colors.red),
                        ),
                        qrCodeCallback: (code) {
                          _qrCallbackliu(code);
                        },
                      ),
                    ),
                  )
                : Center(
                    //child: Text(_qrInfor!),
                    ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Text(
                '$_readCodesString',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: TextButton(
                      child: Text(
                        'Copy to Clipboard',
                        style: TextStyle(fontSize: 11.0),
                      ),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: '$_readCodesString'));
                      },
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  side: BorderSide(color: Colors.red))))),
                ),
                SizedBox(width: 25),
                Container(
                  child: TextButton(
                      child: Text(
                        'Scan Again',
                        style: TextStyle(fontSize: 11.0),
                      ),
                      onPressed: () {
                        //Clipboard.setData(ClipboardData(text: '$_readCodesString'));
                        _readCodesString = "";
                        _scanCode();

                      },
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  side: BorderSide(color: Colors.red))))),
                ),
/*                Container(
                  child: TextButton(
                      child: Text(
                        'Capture and Save Image',
                        style: TextStyle(fontSize: 11.0),
                      ),
                      onPressed: () {
                        //Clipboard.setData(ClipboardData(text: '$_readCodesString'));
                        //_readCodesString = "";
                        //_scanCode();




                      },
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  side: BorderSide(color: Colors.red))))),
                ),*/
              ],
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: TextFormField(
                minLines: 1,
                maxLines: 10,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Captured codes:',
                ),
              ),
            ),
          ],
        ),

        Icon(Icons.shopping_cart, size: 350),
        Icon(Icons.check_circle_outline, size: 350),
        Icon(Icons.directions_car, size: 350),
        Icon(Icons.directions_boat, size: 350),
        Icon(Icons.directions_transit, size: 350),
      ]),
    );
  }
}

/*class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}*/
