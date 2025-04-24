import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tyba_university/services/models/university.dart';

class ApiProvider {
  Future<List<University>> fetchUniversities(
      {required int page, int limit = 20}) async {
    final url = Uri.parse(
        'https://tyba-assets.s3.amazonaws.com/FE-Engineer-test/universities.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final start = (page - 1) * limit;
      final paginated = data.skip(start).take(limit).toList();

      return paginated.map((e) => University.fromJson(e)).toList();
    } else {
      throw Exception('Error al cargar la data: ${response.statusCode}');
    }
  }
}
