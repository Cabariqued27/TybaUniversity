import 'dart:convert';

class University {
  final String name;
  final String country;
  final String? stateProvince;
  final List<String> domains;
  final List<String> webPages;
  String? imagePath; 

  University({
    required this.name,
    required this.country,
    required this.stateProvince,
    required this.domains,
    required this.webPages,
    this.imagePath,
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
        imagePath: json["image_path"], 
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "country": country,
        "state-province": stateProvince,
        "domains": domains,
        "web_pages": webPages,
        "image_path": imagePath, 
      };
}

