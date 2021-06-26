class MedianPriceInsights {

  final List<dynamic>? one_room ;
  final List<dynamic>? two_room ;
  final List<dynamic>? three_room ;
  final List<dynamic>? four_room ;
  final List<dynamic>? five_room ;
  final List<dynamic>? executive ;
  final List<dynamic>? multi_generation ;
  final List<dynamic>? labels ;


  MedianPriceInsights({ this.one_room, this.two_room,  this.three_room,  this.four_room,  this.five_room,  this.executive, this.multi_generation, this.labels,});

  factory MedianPriceInsights.fromJson(Map<String, dynamic> json) {
    return MedianPriceInsights(
      one_room: json['1 ROOM'],
      two_room: json['2 ROOM'],
      three_room: json['3 ROOM'],
      four_room: json['4 ROOM'],
      five_room: json['5 ROOM'],
      executive: json['EXECUTIVE'],
      multi_generation: json['MULTI-GENERATION'],
      labels: json['labels'],
    );
  }
}