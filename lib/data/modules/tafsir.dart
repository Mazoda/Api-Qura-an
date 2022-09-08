class Tafsirs {
  List<Tafsir>? tafsir;
  Meta? meta;

  Tafsirs({this.tafsir, this.meta});

  Tafsirs.fromJson(Map<String, dynamic> json) {
    if (json['tafsirs'] != null) {
      tafsir = <Tafsir>[];
      json['tafsirs'].forEach((v) {
        tafsir!.add(new Tafsir.fromJson(v));
      });
    }
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tafsir != null) {
      data['tafsirs'] = this.tafsir!.map((v) => v.toJson()).toList();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}

class Tafsir {
  int? resourceId;
  String? text;

  Tafsir({this.resourceId, this.text});

  Tafsir.fromJson(Map<String, dynamic> json) {
    resourceId = json['resource_id'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resource_id'] = this.resourceId;
    data['text'] = this.text;
    return data;
  }
}

class Meta {
  String? tafsirName;
  String? authorName;
  Filters? filters;

  Meta({this.tafsirName, this.authorName, this.filters});

  Meta.fromJson(Map<String, dynamic> json) {
    tafsirName = json['tafsir_name'];
    authorName = json['author_name'];
    filters =
        json['filters'] != null ? new Filters.fromJson(json['filters']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tafsir_name'] = this.tafsirName;
    data['author_name'] = this.authorName;
    if (this.filters != null) {
      data['filters'] = this.filters!.toJson();
    }
    return data;
  }
}

class Filters {
  String? verseKey;
  String? chapterNumber;

  Filters({this.verseKey, this.chapterNumber});

  Filters.fromJson(Map<String, dynamic> json) {
    verseKey = json['verse_key'];
    chapterNumber = json['chapter_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['verse_key'] = this.verseKey;
    data['chapter_number'] = this.chapterNumber;
    return data;
  }
}
