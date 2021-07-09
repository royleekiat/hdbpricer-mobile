import 'package:flutter/material.dart';
import 'package:hdbpricermobile/Models/hdb.dart';
import 'Pricer/pricing.dart';
import 'Transactions/transactions_table.dart';
import 'About/about.dart';
import 'Insights/insights.dart';
import 'utils.dart';

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
          // is not restarted.5
          primarySwatch: generateMaterialColor(Palette.primary),
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
          canvasColor: const Color(0xFF234647),
 
          /*
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
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (_selectedIndex) {
      case 0:
        //do nothing
        break;
      case 1:
        setState(() {
          _selectedIndex = 0;
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TransactionsTableRoute()),
        );

        break;
      case 2:
        setState(() {
          _selectedIndex = 0;
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => InsightsRoute()),
        );
        break;

      case 3:
        setState(() {
          _selectedIndex = 0;
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AboutPageRoute()),
        );
        break;
      default:
    }
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
        child: Stack(
          alignment: Alignment.center,
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
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            /*(hdb.resale_price == 0)
              ? Image.asset('images/hdbpricer.png', scale: 1)
              : Positioned(
                child: Image.asset('images/hdbpricer.png', scale: 2.0)
              ),*/
            (hdb.resale_price == 0)
                ? Card(
                  color: Colors.black12,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    elevation: 5,
                    margin: EdgeInsets.all(50),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child:
                          Image.asset('images/hdbpricer.png')
                        ),
                        ListTile(
                          tileColor: Colors.black12,
                          title: Text(
                            'Price an HDB',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                          ),
                          subtitle: Text('Click on the "+" button below', style: TextStyle(
                                color: Colors.white70),
                                textAlign: TextAlign.center,),
                        ),
                        /*Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'This flat was built in ' +
                                hdb.lease_commence_date +
                                ' and is situated in the storey range of ' +
                                hdb.storey_range +
                                ' ' +
                                'with a total floor area size of ' +
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
                              child:
                                  Text('S\$ ' + priceformatter.format(hdb.resale_price!).toString()),
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                  textStyle: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(width: 8),
                          ],
                        ),*/
                      ],
                    ),
                  )/*Text(
                    'Click on the "+" button below to price an HDB',
                    style: TextStyle(height: 4, fontSize: 18),
                  )*/
                : Card(
                  color: Colors.white70,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                    margin: EdgeInsets.all(10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child:
                          Image.asset('images/hdbskyline.jpg')
                        ),
                        ListTile(
                          leading: Icon(Icons.house),
                          title: Text(
                            hdb.town,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(hdb.flat_type),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'This flat was built in ' +
                                hdb.lease_commence_date +
                                ' and is situated in the storey range of ' +
                                hdb.storey_range +
                                ' ' +
                                'with a total floor area size of ' +
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
                              child:
                                  Text('Approx. S\$ ' + priceformatter.format((hdb.resale_price!-20000)).toString() + ' ~ ' + priceformatter.format((hdb.resale_price!+20000)).toString()),
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                  textStyle: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
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
      ),

      bottomNavigationBar: BottomNavigationBar(
        //fixedColor: Colors.white30,
        unselectedItemColor: Colors.white30,
        showUnselectedLabels: true,
        backgroundColor: generateMaterialColor(Palette.primary),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Transactions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insights),
            label: 'Insights',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.handyman),
            label: 'About',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
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





class AboutPageRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About this app"),
      ),
      body: Center(
        child: AboutPage(),
      ),
    );
  }
}
