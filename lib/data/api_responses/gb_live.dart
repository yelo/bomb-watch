class GbLive {
  int success;
  Video video;

  GbLive({this.success, this.video});

  GbLive.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    video = json['video'] != null ? new Video.fromJson(json['video']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.video != null) {
      data['video'] = this.video.toJson();
    }
    return data;
  }
}

class Video {
  String title;
  String image;
  String stream;

  Video({this.title, this.image, this.stream});

  Video.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    image = json['image'];
    stream = json['stream'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['image'] = this.image;
    data['stream'] = this.stream;
    return data;
  }
}
