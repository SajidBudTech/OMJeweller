class OMLive{
  int videoID;
  String title;
  String videoUrl;
  String createdAt;
  String updatedAt;

  OMLive(
      {this.videoID,
        this.title,
        this.videoUrl,
        this.createdAt,
        this.updatedAt});

  OMLive.fromJson(Map<String, dynamic> json) {
    videoID = json['videoID'];
    title = json['title'];
    videoUrl = json['video_url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['videoID'] = this.videoID;
    data['title'] = this.title;
    data['video_url'] = this.videoUrl;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}