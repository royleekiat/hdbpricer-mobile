class Transaction {

  final int? id;
  final String month;
  final String town;
  final String flat_type;
  final String block;
  final String street_name;
  final String storey_range;
  final double? floor_area_sqm;
  final String flat_model;
  final String lease_commence_date;
  final String remaining_lease;
  final double? resale_price;

  Transaction({required this.id, required this.month, required this.town, required this.flat_type, required this.block, required this.street_name,required this.storey_range,required this.floor_area_sqm,required this.flat_model,required this.lease_commence_date,required this.remaining_lease,required this.resale_price});

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['_id'],
      month: json['month'],
      town: json['town'],
      flat_type: json['flat_type'],
      block: json['block'],
      street_name: json['street_name'],
      storey_range: json['storey_range'],
      floor_area_sqm: double.parse(json['floor_area_sqm']),
      flat_model: json['flat_model'],
      lease_commence_date: json['lease_commence_date'],
      remaining_lease: json['remaining_lease'],
      resale_price: double.parse(json['resale_price']),
    );
  }
}