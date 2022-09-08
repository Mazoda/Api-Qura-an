class AudioResponse {
  AudioFile? audioFile;

  AudioResponse({this.audioFile});

  AudioResponse.fromJson(Map<String, dynamic> json) {
    audioFile = json['audio_file'] != null
        ? AudioFile.fromJson(json['audio_file'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (audioFile != null) {
      data['audio_file'] = audioFile!.toJson();
    }
    return data;
  }
}

class AudioFile {
  int? id;
  int? chapterId;
  double? fileSize;
  String? format;
  String? audioUrl;

  AudioFile(
      {this.id, this.chapterId, this.fileSize, this.format, this.audioUrl});

  AudioFile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    chapterId = json['chapter_id'];
    fileSize = json['file_size'];
    format = json['format'];
    audioUrl = json['audio_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['chapter_id'] = chapterId;
    data['file_size'] = fileSize;
    data['format'] = format;
    data['audio_url'] = audioUrl;
    return data;
  }
}
