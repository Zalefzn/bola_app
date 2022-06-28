import 'package:flutter/foundation.dart';
import 'package:soccer_app/api/clubApi.dart';
import 'package:soccer_app/model/clubModel.dart';

class ClubProvider with ChangeNotifier {
  List<ClubModel> _clubModel = [];
  List<ClubModel> get clubs => _clubModel;
  set clubs(List<ClubModel> clubs) {
    notifyListeners();
  }

  Future<void> getClub() async {
    try {
      List<ClubModel> clubs = await ClubApi().getClubs();
      _clubModel = clubs;
    } catch (error) {
      print(error);
    }
  }

  List<ClubModel> _searchClub = [];

  List<ClubModel> get search => _searchClub;
  set search(List<ClubModel> search) {
    notifyListeners();
  }

  Future<void> getSeacrh() async {
    try {
      List<ClubModel> search = await ClubApi().getClubs();
      _searchClub = search;
    } catch (error) {
      print(error);
    }
  }
}
