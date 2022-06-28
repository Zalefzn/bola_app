class ClubModel {
  late String nameClub;
  late String bornClub;
  late String nameLeague;
  late String stadiumName;
  late String keywords;
  late String imageStadium;
  late String descStadium;
  late String locationStadium;
  late String capacityStadium;
  late String facebookClub;
  late String twitterClub;
  late String instagramClub;
  late String descClub;
  late String logoClub;
  late String jerseyClub;
  late String pictClub2;
  late String pictClub1;
  late String pictTeam2;
  late String youtubeClub;

  ClubModel({
    required this.bornClub,
    required this.capacityStadium,
    required this.descClub,
    required this.descStadium,
    required this.facebookClub,
    required this.imageStadium,
    required this.instagramClub,
    required this.jerseyClub,
    required this.youtubeClub,
    required this.keywords,
    required this.locationStadium,
    required this.logoClub,
    required this.nameClub,
    required this.nameLeague,
    required this.pictClub1,
    required this.pictClub2,
    required this.pictTeam2,
    required this.stadiumName,
    required this.twitterClub,
  });

  ClubModel.fromJson(Map<String, dynamic> json) {
    nameClub = json['strTeam'];
    bornClub = json['intFormedYear'];
    nameLeague = json['strLeague'];
    stadiumName = json['strStadium'];
    keywords = json['strKeywords'];
    imageStadium = json['strStadiumThumb'];
    descStadium = json['strStadiumDescription'];
    locationStadium = json['strStadiumLocation'];
    capacityStadium = json['intStadiumCapacity'];
    facebookClub = json['strFacebook'];
    twitterClub = json['strTwitter'];
    instagramClub = json['strInstagram'];
    descClub = json['strDescriptionEN'];
    logoClub = json['strTeamBadge'];
    jerseyClub = json['strTeamJersey'];
    pictClub1 = json['strTeamFanart2'];
    pictClub2 = json['strTeamFanart4'];
    pictTeam2 = json['strTeamFanart3'];
    youtubeClub = json['strYoutube'];
  }

  Map<String, dynamic> toJson() {
    return {
      'strTeam': nameClub,
      'intFormedYear': bornClub,
      'strLeague': nameLeague,
      'strStadium': stadiumName,
      'strKeywords': keywords,
      'strStadiumThumb': imageStadium,
      'strStadiumDescription': descStadium,
      'strStadiumLocation': locationStadium,
      'intStadiumCapacity': capacityStadium,
      'strFacebook': facebookClub,
      'strTwitter': twitterClub,
      'strInstagram': instagramClub,
      'strDescriptionEN': descClub,
      'strTeamBadge': logoClub,
      'strTeamJersey': jerseyClub,
      'strTeamFanart2': pictClub1,
      'strTeamFanart3': pictTeam2,
      'strTeamFanart4': pictClub2,
      'strYoutube': youtubeClub,
    };
  }
}
