class GbVideos {
  String error;
  int limit;
  int offset;
  int numberOfPageResults;
  int numberOfTotalResults;
  int statusCode;
  List<Videos> results;
  String version;

  GbVideos(
      {this.error,
      this.limit,
      this.offset,
      this.numberOfPageResults,
      this.numberOfTotalResults,
      this.statusCode,
      this.results,
      this.version});

  GbVideos.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    limit = json['limit'];
    offset = json['offset'];
    numberOfPageResults = json['number_of_page_results'];
    numberOfTotalResults = json['number_of_total_results'];
    statusCode = json['status_code'];
    if (json['results'] != null) {
      results = new List<Videos>();
      json['results'].forEach((v) {
        results.add(new Videos.fromJson(v));
      });
    }
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['limit'] = this.limit;
    data['offset'] = this.offset;
    data['number_of_page_results'] = this.numberOfPageResults;
    data['number_of_total_results'] = this.numberOfTotalResults;
    data['status_code'] = this.statusCode;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    data['version'] = this.version;
    return data;
  }
}

class Videos {
  String deck;
  String guid;
  int lengthSeconds;
  String name;
  String publishDate;
  Image image;
  String user;
  String savedTime;
  String lowUrl;
  String highUrl;
  String hdUrl;
  String url;
  bool premium;

  Videos(
      {this.deck,
      this.guid,
      this.lengthSeconds,
      this.name,
      this.publishDate,
      this.image,
      this.user,
      this.savedTime,
      this.lowUrl,
      this.highUrl,
      this.hdUrl,
      this.url,
      this.premium});

  Videos.fromJson(Map<String, dynamic> json) {
    deck = json['deck'];
    guid = json['guid'];
    lengthSeconds = json['length_seconds'];
    name = json['name'];
    publishDate = json['publish_date'];
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    user = json['user'];
    savedTime = json['saved_time'];
    lowUrl = json['low_url'];
    highUrl = json['high_url'];
    hdUrl = json['hd_url'];
    url = json['url'];
    premium = json['premium'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deck'] = this.deck;
    data['guid'] = this.guid;
    data['length_seconds'] = this.lengthSeconds;
    data['name'] = this.name;
    data['publish_date'] = this.publishDate;
    if (this.image != null) {
      data['image'] = this.image.toJson();
    }
    data['user'] = this.user;
    data['saved_time'] = this.savedTime;
    data['low_url'] = this.lowUrl;
    data['high_url'] = this.highUrl;
    data['hd_url'] = this.hdUrl;
    data['url'] = this.url;
    data['premium'] = this.premium;
    return data;
  }
}

class Image {
  String iconUrl;
  String mediumUrl;
  String screenUrl;
  String screenLargeUrl;
  String smallUrl;
  String superUrl;
  String thumbUrl;
  String tinyUrl;
  String originalUrl;
  String imageTags;

  Image(
      {this.iconUrl,
      this.mediumUrl,
      this.screenUrl,
      this.screenLargeUrl,
      this.smallUrl,
      this.superUrl,
      this.thumbUrl,
      this.tinyUrl,
      this.originalUrl,
      this.imageTags});

  Image.fromJson(Map<String, dynamic> json) {
    iconUrl = json['icon_url'];
    mediumUrl = json['medium_url'];
    screenUrl = json['screen_url'];
    screenLargeUrl = json['screen_large_url'];
    smallUrl = json['small_url'];
    superUrl = json['super_url'];
    thumbUrl = json['thumb_url'];
    tinyUrl = json['tiny_url'];
    originalUrl = json['original_url'];
    imageTags = json['image_tags'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['icon_url'] = this.iconUrl;
    data['medium_url'] = this.mediumUrl;
    data['screen_url'] = this.screenUrl;
    data['screen_large_url'] = this.screenLargeUrl;
    data['small_url'] = this.smallUrl;
    data['super_url'] = this.superUrl;
    data['thumb_url'] = this.thumbUrl;
    data['tiny_url'] = this.tinyUrl;
    data['original_url'] = this.originalUrl;
    data['image_tags'] = this.imageTags;
    return data;
  }
}
