import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hdbpricermobile/Insights/insights_service.dart';
import 'package:hdbpricermobile/Models/median_price_insights.dart';

class InsightsRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Insights"),
      ),
      body: Insights(),
    );
  }
}

class Insights extends StatefulWidget {
  @override
  _InsightsState createState() => _InsightsState();
}

class _InsightsState extends State<Insights> {
  List<List<Color>> gradientColors = [
    [
      const Color(0xff5F4690),
      const Color(0xff824690),
    ],
    [
      const Color(0xff1D6996),
      const Color(0xff1d3796),
    ],
    [
      const Color(0xff38a6a5),
      const Color(0xff38a66b),
    ],
    [
      const Color(0xffedad08),
      const Color(0xffed6f08),
    ],
    [
      const Color(0xffcc503e),
      const Color(0xffcc3e3e),
    ],
    [
      const Color(0xffaba9a9),
      const Color(0xffd9d7d7),
    ],
    [
      const Color(0xfff52cdd),
      const Color(0xfff52c91),
    ],
  ];
  String town = 'SINGAPORE';
  Future<MedianPriceInsights> medianPriceInsights =
      getMedianPriceInsights('SINGAPORE');

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
            ),
            Container(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Color(0xFF234647),
              ),
              child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                value: town,
                icon: const Icon(Icons.add_location_outlined,
                    color: const Color(0xFF336869)),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.white70),
                onChanged: (String? newValue) {
                  setState(() {
                    town = newValue!;
                    medianPriceInsights = getMedianPriceInsights(town);
                  });
                },
                items: <String>[
                  'SINGAPORE',
                  'ANG MO KIO',
                  'BEDOK',
                  'BISHAN',
                  'BUKIT BATOK',
                  'BUKIT MERAH',
                  'BUKIT PANJANG',
                  'BUKIT TIMAH',
                  'CENTRAL AREA',
                  'CHOA CHU KANG',
                  'CLEMENTI',
                  'GEYLANG',
                  'HOUGANG',
                  'JURONG EAST',
                  'JURONG WEST',
                  'KALLANG/WHAMPOA',
                  'MARINE PARADE',
                  'PASIR RIS',
                  'PUNGGOL',
                  'QUEENSTOWN',
                  'SEMBAWANG',
                  'SENGKANG',
                  'SERANGOON',
                  'TAMPINES',
                  'TOA PAYOH',
                  'WOODLANDS',
                  'YISHUN'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              )),
            ),
            AspectRatio(
                aspectRatio: 1.0,
                child: Container(
                    child: FutureBuilder<MedianPriceInsights>(
                        future: medianPriceInsights,
                        builder: (BuildContext context,
                            AsyncSnapshot<MedianPriceInsights> snapshot) {
                          if (snapshot.hasData &&
                              snapshot.connectionState ==
                                  ConnectionState.done) {
                            //print(snapshot.data!.five_room);
                            return Stack(
                              children:[
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(0xFF336869),
                                          width: 15),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      color: Color(0xff232d37)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 18.0,
                                        left: 12.0,
                                        top: 24,
                                        bottom: 12),
                                    child: LineChart(
                                      mainData(snapshot.data), //showAvg ? avgData() : 
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Padding(padding: EdgeInsets.only(left:17, top:150)),
                                    Text('1 ROOM', style: TextStyle(backgroundColor: const Color(0xff5F4690), )),
                                    Padding(padding: EdgeInsets.only(left:5)),
                                    Text('2 ROOM', style: TextStyle(backgroundColor: const Color(0xff1D6996), )),
                                    Padding(padding: EdgeInsets.only(left:5)),
                                    Text('3 ROOM', style: TextStyle(backgroundColor: const Color(0xff38a6a5), color: Colors.black)),
                                    Padding(padding: EdgeInsets.only(left:5)),
                                    Text('4 ROOM', style: TextStyle(backgroundColor: const Color(0xffedad08), color: Colors.black)),
                                    Padding(padding: EdgeInsets.only(left:5)),
                                    Text('5 ROOM ', style: TextStyle(backgroundColor: const Color(0xffcc503e), )),
                                    Padding(padding: EdgeInsets.only(left:5)),
                                    Text('EXEC', style: TextStyle(backgroundColor: const Color(0xffaba9a9), color: Colors.black)),
                                    Padding(padding: EdgeInsets.only(left:5)),
                                    Text('MULTI-GEN', style: TextStyle(backgroundColor: const Color(0xfff52cdd), color: Colors.black)),
                                    Padding(padding: EdgeInsets.only(left:5)),
                                  ],

                                ),
                              ]
                            );
                          } else if (snapshot.hasError) {
                            return Container(
                              child: Text(
                                  'Could not load chart due to Error: ${snapshot.error}'),
                            );
                          } else {
                            return Container(
                              padding: const EdgeInsets.all(30.0),
                              child: const SizedBox(
                                child: LinearProgressIndicator(
                                  backgroundColor: Color(0xFF234647),
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Color(0xFF336869)),
                                ),
                                width: 10,
                                height: 10,
                              ),
                            );
                          }
                        }))),
            /*SizedBox(
          width: 60,
          height: 34,
          child: TextButton(
            onPressed: () {/*
              setState(() {
                showAvg = !showAvg;
              });*/
            },
            child: Text(
              'Median Resale Price',
              style: TextStyle(
                  fontSize: 12,
                  color:
                      showAvg ? Colors.white.withOpacity(0.5) : Colors.white),
            ),
          ),
        ),*/
          ],
        )
      ],
    );
  }

  LineChartData mainData(MedianPriceInsights? medianPriceInsights) {
    if (medianPriceInsights != null) {
      List<int> labels = medianPriceInsights.labels!.cast<int>();

      List<LineChartBarData> linechartbardataList = [];

      

      for (var i = 0; i <7; i++) {
        List<FlSpot> spotList = [];
        List<double> medianPriceList = [];
        switch (i) {
          case 0: 
            if(medianPriceInsights.one_room!=null){
              medianPriceList = medianPriceInsights.one_room!.cast<double>();
            }
            break;
          case 1: 
            if(medianPriceInsights.two_room!=null){
            medianPriceList = medianPriceInsights.two_room!.cast<double>();
            }
            break;
          case 2: 
            if(medianPriceInsights.three_room!=null){
              medianPriceList = medianPriceInsights.three_room!.cast<double>();
            }
            break;
          case 3: 
            if(medianPriceInsights.four_room!=null){
              medianPriceList = medianPriceInsights.four_room!.cast<double>();
            }
            break;
          case 4: 
            if(medianPriceInsights.five_room!=null){
              medianPriceList = medianPriceInsights.five_room!.cast<double>();
            }
            break;
          case 5: 
            if(medianPriceInsights.executive!=null){
              medianPriceList = medianPriceInsights.executive!.cast<double>();
            }
            break;
          case 6: 
            if(medianPriceInsights.multi_generation!=null){
              medianPriceList = medianPriceInsights.multi_generation!.cast<double>();
            }
            break;
        }

        if(medianPriceList.length >0){
        
          var labelCounter = 0;
          for (var label in labels) {
              spotList.add(FlSpot(label.toDouble(),medianPriceList[labelCounter]));
              labelCounter++;
          }

          linechartbardataList.add(
            LineChartBarData(
              spots: spotList,
              isCurved: true,
              colors: gradientColors[i],
              barWidth: 4,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: true,
                
              ),
              belowBarData: BarAreaData(
                show: false,
                colors: gradientColors[i]
                    .map((color) => color.withOpacity(0.3))
                    .toList(),
              ),
            ),
          );
        }
      }

      return LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: const Color(0xff37434d),
              strokeWidth: 1,
            );
          },
          getDrawingVerticalLine: (value) {
            return FlLine(
              color: const Color(0xff37434d),
              strokeWidth: 1,
            );
          },
        ),
        axisTitleData: FlAxisTitleData(
          topTitle: AxisTitle(
              titleText: 'Median Resale Price (S\$)' ,
              showTitle: true,
              margin: 20,
              textStyle: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: SideTitles(
            showTitles: true,
            reservedSize: 22,
            getTextStyles: (value) => const TextStyle(
                color: Color(0xff68737d),
                fontWeight: FontWeight.bold,
                fontSize: 16),
            getTitles: (value) {
              return value.toInt().toString();
            },
            margin: 8,
          ),
          leftTitles: SideTitles(
            showTitles: true,
            getTextStyles: (value) => const TextStyle(
              color: Color(0xff67727d),
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
            getTitles: (value) {
              switch (value.toInt()) {
                case 200000:
                  return '200k';
                case 400000:
                  return '400k';
                case 600000:
                  return '600k';
                case 800000:
                  return '800k';
                case 1000000:
                  return '1m';
              }
              return '';
            },
            reservedSize: 28,
            margin: 12,
          ),
        ),
        borderData: FlBorderData(
            show: true,
            border: Border.all(color: const Color(0xff37434d), width: 1)),
        minX: (labels[0]).toDouble(),
        maxX: (labels[labels.length-1]).toDouble(),
        minY: 150000,
        maxY: 1100000,
        lineBarsData: linechartbardataList,
      );
    } else {
      return LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: const Color(0xff37434d),
              strokeWidth: 1,
            );
          },
          getDrawingVerticalLine: (value) {
            return FlLine(
              color: const Color(0xff37434d),
              strokeWidth: 1,
            );
          },
        ),
        axisTitleData: FlAxisTitleData(
          topTitle: AxisTitle(
              titleText: 'Median Resale Price (S\$)',
              showTitle: true,
              margin: 20,
              textStyle: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: SideTitles(
            showTitles: true,
            reservedSize: 22,
            getTextStyles: (value) => const TextStyle(
                color: Color(0xff68737d),
                fontWeight: FontWeight.bold,
                fontSize: 16),
            getTitles: (value) {
              switch (value.toInt()) {
                case 2:
                  return 'MAR';
                case 5:
                  return 'JUN';
                case 8:
                  return 'SEP';
              }
              return '';
            },
            margin: 8,
          ),
          leftTitles: SideTitles(
            showTitles: true,
            getTextStyles: (value) => const TextStyle(
              color: Color(0xff67727d),
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
            getTitles: (value) {
              switch (value.toInt()) {
                case 1:
                  return '10k';
                case 3:
                  return '30k';
                case 5:
                  return '50k';
              }
              return '';
            },
            reservedSize: 28,
            margin: 12,
          ),
        ),
        borderData: FlBorderData(
            show: false,
            border: Border.all(color: const Color(0xff37434d), width: 1)),
        minX: 0,
        maxX: 11,
        minY: 0,
        maxY: 6,
        lineBarsData: [
          LineChartBarData(
            spots: [
            ],
            isCurved: true,
            colors: gradientColors[0],
            barWidth: 5,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: false,
            ),
            belowBarData: BarAreaData(
              show: true,
              colors: gradientColors[0]
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ],
      );
    }
  }
  /*
  LineChartData avgData() {
    return LineChartData(
      lineTouchData: LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'MAR';
              case 5:
                return 'JUN';
              case 8:
                return 'SEP';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '10k';
              case 3:
                return '30k';
              case 5:
                return '50k';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 3.44),
          ],
          isCurved: true,
          colors: [
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)!,
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)!,
          ],
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(show: true, colors: [
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)!
                .withOpacity(0.1),
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)!
                .withOpacity(0.1),
          ]),
        ),
      ],
    );
  }*/
}
