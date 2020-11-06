class PostOffice {
  final String name;
  final String address;
  final String gov;
  final String postal_code;
  final String lat;
  final String long;
  final List offices;

  PostOffice(
      {
        this.name, this.address, this.gov, this.postal_code, this.lat, this.long, this.offices
      }
      );

  factory PostOffice.fromJson(Map<String, dynamic> json) {
    return PostOffice(
        name: json['name'] as String,
        address: json['address'] as String,
        gov: json['gov'] as String,
        postal_code: json['postal_code'] as String,
        lat: json['lat'] as String,
        long: json['long'] as String
    );
  }
}