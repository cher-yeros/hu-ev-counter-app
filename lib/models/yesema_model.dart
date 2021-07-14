class Yesema {
  int id;
  int sebakiId;
  int campusId;
  int number;
  int isSent;
  String date;

  // int set(id) => id;

  setId(int id) {
    this.id = id;
  }

  setIsSent(int isSent) {
    this.isSent = isSent;
  }

  Yesema({this.sebakiId, this.campusId, this.isSent, this.number, this.date});

  Yesema.withId(
      {this.id, this.number, this.sebakiId, this.campusId, this.date});

  Yesema.toObject(Map<String, dynamic> map) {
    if (map['id'] != null) {
      id = map['id'];
    }

    number = map['number'];
    sebakiId = map['sebaki_id'];
    campusId = map['campus_id'];
    isSent = map['is_sent'];
    date = map['date'];
  }

  Map<String, dynamic> toJson() {
    var map = Map<String, dynamic>();
    if (this.id != null) {
      map['id'] = this.id;
    }

    map['number'] = this.number;
    map['sebaki_id'] = this.sebakiId;
    map['campus_id'] = this.campusId;
    map['is_sent'] = this.isSent;
    map['date'] = this.date;

    return map;
  }

  Map<String, dynamic> toBeSent() {
    var map = Map<String, dynamic>();

    map['number'] = this.number;
    map['sebaki_id'] = this.sebakiId;
    map['campus_id'] = this.campusId;

    return map;
  }
}

enum TeseBakiType {
  yetekeble,
}
