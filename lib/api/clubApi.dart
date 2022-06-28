import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:soccer_app/model/clubModel.dart';

//api tableService
class ClubApi {
  Future<List<ClubModel>> getClubs() async {
    var baseUrl =
        'https://www.thesportsdb.com/api/v1/json/2/search_all_teams.php?l=English%20Premier%20League';

    var headers = {
      'Content-Type': 'application/json',
    };

    var response = await http.get(Uri.parse(baseUrl), headers: headers);
    print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['teams'];

      List<ClubModel> clubs = [];

      for (var item in data) {
        clubs.add(ClubModel.fromJson(item));
      }
      return clubs;
    } else {
      throw Exception('Gagal Get Club');
    }
  }
}
