class Hdb {
  String town='';
  final String flat_type;
  final String storey_range;
  final int floor_area_sqm;
  final String lease_commence_date;
  final int? resale_price;

  Hdb({required this.town, required this.flat_type, required this.storey_range,required this.floor_area_sqm,required this.lease_commence_date,this.resale_price=0});

  factory Hdb.fromJson(Map<String, dynamic> json) {
    return Hdb(
      town: json['town'],
      flat_type: json['flat_type'],
      storey_range: json['storey_range'],
      floor_area_sqm: json['floor_area_sqm'],
      lease_commence_date: json['lease_commence_date'],
      resale_price: json['resale_price'],
    );
  }
}