class Recitations {
  List<Recitation>? recitations;

  Recitations({this.recitations});

  Recitations.fromJson(Map<String, dynamic> json) {
    if (json['recitations'] != null) {
      recitations = <Recitation>[];
      json['recitations'].forEach((v) {
        recitations!.add(new Recitation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.recitations != null) {
      data['recitations'] = this.recitations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Recitation {
  int? id;
  String? reciterName;
  String? style;
  TranslatedName? translatedName;

  Recitation({this.id, this.reciterName, this.style, this.translatedName});

  Recitation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reciterName = json['reciter_name'];
    style = json['style'];
    translatedName = json['translated_name'] != null
        ? new TranslatedName.fromJson(json['translated_name'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reciter_name'] = this.reciterName;
    data['style'] = this.style;
    if (this.translatedName != null) {
      data['translated_name'] = this.translatedName!.toJson();
    }
    return data;
  }
}

class TranslatedName {
  String? name;
  String? languageName;

  TranslatedName({this.name, this.languageName});

  TranslatedName.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    languageName = json['language_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['language_name'] = this.languageName;
    return data;
  }
}
