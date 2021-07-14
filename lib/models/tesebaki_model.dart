class Tesebaki {
  int id;
  String name;
  String phone;
  String type;
  String gender;
  int sebakiId;
  int campusId;
  String date;
  int isSent;

  // int set(id) => id;

  setId(int id) {
    this.id = id;
  }

  setIsSent(int isSent) {
    this.isSent = isSent;
  }

  Tesebaki(
      {this.name,
      this.phone,
      this.type,
      this.gender,
      this.sebakiId,
      this.campusId,
      this.date,
      this.isSent});

  Tesebaki.withId(
      {this.id,
      this.name,
      this.phone,
      this.type,
      this.gender,
      this.sebakiId,
      this.campusId});

  Tesebaki.toObject(Map<String, dynamic> map) {
    if (map['id'] != null) {
      id = map['id'];
    }
    name = map['name'];
    phone = map['phone'];
    type = map['type'];
    gender = map['gender'];
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
    map['name'] = this.name;
    map['phone'] = this.phone;
    map['type'] = this.type;
    map['gender'] = this.gender;
    map['sebaki_id'] = this.sebakiId;
    map['campus_id'] = this.campusId;
    map['is_sent'] = this.isSent;
    map['date'] = this.date;

    return map;
  }

  Map<String, dynamic> toBeSent() {
    var map = Map<String, dynamic>();

    map['name'] = this.name;
    map['phone'] = this.phone;
    map['type'] = this.type;
    map['gender'] = this.gender;
    map['sebaki_id'] = this.sebakiId;
    map['campus_id'] = this.campusId;

    return map;
  }
}

enum TeseBakiType {
  yetekeble,
}
