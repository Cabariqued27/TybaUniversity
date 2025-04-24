import 'dart:convert';

class University {
  final String name;
  final String country;
  final String? stateProvince;
  final List<String> domains;
  final List<String> webPages;

  University({
    required this.name,
    required this.country,
    required this.stateProvince,
    required this.domains,
    required this.webPages,
  });

  factory University.fromRawJson(String str) =>
      University.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory University.fromJson(Map<String, dynamic> json) => University(
      name: json["name"],
      country: json["country"],
      stateProvince: json["state-province"], 
      domains: List<String>.from(json["domains"]),
      webPages: List<String>.from(json["web_pages"]),
    );


  Map<String, dynamic> toJson() => {
        "id": name,
        "country": country,
        "state-province": stateProvince,
        "domains": domains,
        "web_pages": webPages,
      };
}
