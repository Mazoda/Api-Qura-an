class Translations {
  List<Translation>? translations;
  Meta? meta;

  Translations({this.translations, this.meta});

  Translations.fromJson(Map<String, dynamic> json) {
    if (json['translations'] != null) {
      translations = <Translation>[];
      json['translations'].forEach((v) {
        translations!.add(Translation.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (translations != null) {
      data['translations'] = translations!.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

class Translation {
  int? resourceId;
  String? text;

  Translation({this.resourceId, this.text});

  Translation.fromJson(Map<String, dynamic> json) {
    resourceId = json['resource_id'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['resource_id'] = resourceId;
    data['text'] = text;
    return data;
  }
}

class Meta {
  String? translationName;
  String? authorName;
  Filters? filters;

  Meta({this.translationName, this.authorName, this.filters});

  Meta.fromJson(Map<String, dynamic> json) {
    translationName = json['translation_name'];
    authorName = json['author_name'];
    filters =
        json['filters'] != null ?  Filters.fromJson(json['filters']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['translation_name'] = translationName;
    data['author_name'] = authorName;
    if (filters != null) {
      data['filters'] =filters!.toJson();
    }
    return data;
  }
}

class Filters {
  String? verseKey;
  int? resourceId;
  String? chapterNumber;

  Filters({this.verseKey, this.resourceId, this.chapterNumber});

  Filters.fromJson(Map<String, dynamic> json) {
    verseKey = json['verse_key'];
    resourceId = json['resource_id'];
    chapterNumber = json['chapter_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['verse_key'] = verseKey;
    data['resource_id'] = resourceId;
    data['chapter_number'] = chapterNumber;
    return data;
  }
}
