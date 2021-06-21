import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hdbpricermobile/Models/hdb.dart';
import 'Pricer/pricing.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'hdbpricer',
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
        primarySwatch: Colors.blueGrey,
        scaffoldBackgroundColor: const Color(0xFF336869),
        textTheme: TextTheme(
          bodyText1: TextStyle(),
          bodyText2: TextStyle(),
          subtitle1: TextStyle(),
        ).apply(
          bodyColor: Colors.white70, 
          displayColor: Colors.white70, 
          decorationColor: Colors.white70,
        ),
        canvasColor: Colors.black/*
        colorScheme: ThemeData().colorScheme.copyWith(
          secondary: Colors.blue,
        ),*/
      ),
      home: const MyHomePage(title: 'hdbpricer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
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
  Hdb hdb = Hdb(
      flat_type: '',
      town: '',
      lease_commence_date: '',
      resale_price: 0,
      storey_range: '',
      floor_area_sqm: 0);
  
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
            Image.asset('images/hdbpricer.png'),
            (hdb.resale_price == 0)
                ? Text('Click on the "+" button below to price an HDB', style: TextStyle(height: 4, fontSize: 18),)
                : Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),

                    ),
                    elevation: 5,
                    margin: EdgeInsets.all(10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      
                      children: <Widget>[
                        Image.asset('images/hdbskyline.jpg'),
                        ListTile(
                          leading: Icon(Icons.house),
                          title: Text(hdb.town),
                          subtitle: Text(hdb.flat_type),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'This flat was built in '+ hdb.lease_commence_date +' and is situated in the storey range of ' +
                                hdb.storey_range +
                                ' ' + 'with a total floor area size of ' +
                                hdb.floor_area_sqm.toString() +
                                ' sqm.',
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.6)),
                          ),
                          
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            TextButton(
                              child:  Text('S\$ ' + hdb.resale_price!.toString() ),
                              onPressed: (){},
                              style:
                                TextButton.styleFrom(textStyle: TextStyle( fontSize: 18, fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(width: 8),
                            
                          ],
                        ),
                        
                      ],
                    ),
                  ),
                
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final pricedHDB = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PricingFormRoute()),
          ) as Hdb;

          setState(() {
            hdb = pricedHDB;
          });
        },
        tooltip: 'Price HDB',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}



class PricingFormRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Price an HDB"),
        
      ),
      body: Center(
        
        child: PricingForm(),
      ),
    );
  }
}
