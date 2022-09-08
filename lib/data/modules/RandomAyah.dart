class Randomized {
  Verse? verse;

  Randomized({this.verse});

  Randomized.fromJson(Map<String, dynamic> json) {
    verse = json['verse'] != null ? new Verse.fromJson(json['verse']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.verse != null) {
      data['verse'] = this.verse!.toJson();
    }
    return data;
  }
}

class Verse {
  int? id;
  int? verseNumber;
  String? verseKey;
  int? hizbNumber;
  int? rubElHizbNumber;
  int? rukuNumber;
  int? manzilNumber;
  Null? sajdahNumber;
  int? pageNumber;
  int? juzNumber;

  Verse(
      {this.id,
      this.verseNumber,
      this.verseKey,
      this.hizbNumber,
      this.rubElHizbNumber,
      this.rukuNumber,
      this.manzilNumber,
      this.sajdahNumber,
      this.pageNumber,
      this.juzNumber});

  Verse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    verseNumber = json['verse_number'];
    verseKey = json['verse_key'];
    hizbNumber = json['hizb_number'];
    rubElHizbNumber = json['rub_el_hizb_number'];
    rukuNumber = json['ruku_number'];
    manzilNumber = json['manzil_number'];
    sajdahNumber = json['sajdah_number'];
    pageNumber = json['page_number'];
    juzNumber = json['juz_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['verse_number'] = this.verseNumber;
    data['verse_key'] = this.verseKey;
    data['hizb_number'] = this.hizbNumber;
    data['rub_el_hizb_number'] = this.rubElHizbNumber;
    data['ruku_number'] = this.rukuNumber;
    data['manzil_number'] = this.manzilNumber;
    data['sajdah_number'] = this.sajdahNumber;
    data['page_number'] = this.pageNumber;
    data['juz_number'] = this.juzNumber;
    return data;
  }
}
