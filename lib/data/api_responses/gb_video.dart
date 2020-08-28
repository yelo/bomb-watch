class GbVideo {
  String error;
  int limit;
  int offset;
  int numberOfPageResults;
  int numberOfTotalResults;
  int statusCode;
  Video results;
  String version;

  GbVideo(
      {this.error,
      this.limit,
      this.offset,
      this.numberOfPageResults,
      this.numberOfTotalResults,
      this.statusCode,
      this.results,
      this.version});

  GbVideo.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    limit = json['limit'];
    offset = json['offset'];
    numberOfPageResults = json['number_of_page_results'];
    numberOfTotalResults = json['number_of_total_results'];
    statusCode = json['status_code'];
    results =
        json['results'] != null ? new Video.fromJson(json['results']) : null;
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
      data['results'] = this.results.toJson();
    }
    data['version'] = this.version;
    return data;
  }
}

class Video {
  String apiDetailUrl;
  List<Associations> associations;
  String deck;
  String embedPlayer;
  String guid;
  int id;
  int lengthSeconds;
  String name;
  bool premium;
  String publishDate;
  String siteDetailUrl;
  Image image;
  String user;
  dynamic hosts;
  dynamic crew;
  String videoType;
  VideoShow videoShow;
  List<VideoCategories> videoCategories;
  String savedTime;
  dynamic youtubeId;
  String lowUrl;
  String highUrl;
  String hdUrl;
  String url;

  Video(
      {this.apiDetailUrl,
      this.associations,
      this.deck,
      this.embedPlayer,
      this.guid,
      this.id,
      this.lengthSeconds,
      this.name,
      this.premium,
      this.publishDate,
      this.siteDetailUrl,
      this.image,
      this.user,
      this.hosts,
      this.crew,
      this.videoType,
      this.videoShow,
      this.videoCategories,
      this.savedTime,
      this.youtubeId,
      this.lowUrl,
      this.highUrl,
      this.hdUrl,
      this.url});

  Video.fromJson(Map<String, dynamic> json) {
    apiDetailUrl = json['api_detail_url'];
    if (json['associations'] != null) {
      associations = new List<Associations>();
      json['associations'].forEach((v) {
        associations.add(new Associations.fromJson(v));
      });
    }
    deck = json['deck'];
    embedPlayer = json['embed_player'];
    guid = json['guid'];
    id = json['id'];
    lengthSeconds = json['length_seconds'];
    name = json['name'];
    premium = json['premium'];
    publishDate = json['publish_date'];
    siteDetailUrl = json['site_detail_url'];
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    user = json['user'];
    hosts = json['hosts'];
    crew = json['crew'];
    videoType = json['video_type'];
    /*videoShow = json['video_show'] != null
        ? new VideoShow.fromJson(json['video_show'])
        : null;*/
    if (json['video_categories'] != null) {
      videoCategories = new List<VideoCategories>();
      json['video_categories'].forEach((v) {
        videoCategories.add(new VideoCategories.fromJson(v));
      });
    }
    savedTime = json['saved_time'];
    youtubeId = json['youtube_id'];
    lowUrl = json['low_url'];
    highUrl = json['high_url'];
    hdUrl = json['hd_url'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['api_detail_url'] = this.apiDetailUrl;
    if (this.associations != null) {
      data['associations'] = this.associations.map((v) => v.toJson()).toList();
    }
    data['deck'] = this.deck;
    data['embed_player'] = this.embedPlayer;
    data['guid'] = this.guid;
    data['id'] = this.id;
    data['length_seconds'] = this.lengthSeconds;
    data['name'] = this.name;
    data['premium'] = this.premium;
    data['publish_date'] = this.publishDate;
    data['site_detail_url'] = this.siteDetailUrl;
    if (this.image != null) {
      data['image'] = this.image.toJson();
    }
    data['user'] = this.user;
    data['hosts'] = this.hosts;
    data['crew'] = this.crew;
    data['video_type'] = this.videoType;
    if (this.videoShow != null) {
      data['video_show'] = this.videoShow.toJson();
    }
    if (this.videoCategories != null) {
      data['video_categories'] =
          this.videoCategories.map((v) => v.toJson()).toList();
    }
    data['saved_time'] = this.savedTime;
    data['youtube_id'] = this.youtubeId;
    data['low_url'] = this.lowUrl;
    data['high_url'] = this.highUrl;
    data['hd_url'] = this.hdUrl;
    data['url'] = this.url;
    return data;
  }
}

class Associations {
  String apiDetailUrl;
  String guid;
  int id;
  String name;
  String siteDetailUrl;

  Associations(
      {this.apiDetailUrl, this.guid, this.id, this.name, this.siteDetailUrl});

  Associations.fromJson(Map<String, dynamic> json) {
    apiDetailUrl = json['api_detail_url'];
    guid = json['guid'];
    id = json['id'];
    name = json['name'];
    siteDetailUrl = json['site_detail_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['api_detail_url'] = this.apiDetailUrl;
    data['guid'] = this.guid;
    data['id'] = this.id;
    data['name'] = this.name;
    data['site_detail_url'] = this.siteDetailUrl;
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

class VideoShow {
  String apiDetailUrl;
  int id;
  String title;
  int position;
  String siteDetailUrl;
  Image image;
  Null logo;

  VideoShow(
      {this.apiDetailUrl,
      this.id,
      this.title,
      this.position,
      this.siteDetailUrl,
      this.image,
      this.logo});

  VideoShow.fromJson(Map<String, dynamic> json) {
    apiDetailUrl = json['api_detail_url'];
    id = json['id'];
    title = json['title'];
    position = json['position'];
    siteDetailUrl = json['site_detail_url'];
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['api_detail_url'] = this.apiDetailUrl;
    data['id'] = this.id;
    data['title'] = this.title;
    data['position'] = this.position;
    data['site_detail_url'] = this.siteDetailUrl;
    if (this.image != null) {
      data['image'] = this.image.toJson();
    }
    data['logo'] = this.logo;
    return data;
  }
}

class VideoCategories {
  String apiDetailUrl;
  int id;
  String name;
  String siteDetailUrl;

  VideoCategories({this.apiDetailUrl, this.id, this.name, this.siteDetailUrl});

  VideoCategories.fromJson(Map<String, dynamic> json) {
    apiDetailUrl = json['api_detail_url'];
    id = json['id'];
    name = json['name'];
    siteDetailUrl = json['site_detail_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['api_detail_url'] = this.apiDetailUrl;
    data['id'] = this.id;
    data['name'] = this.name;
    data['site_detail_url'] = this.siteDetailUrl;
    return data;
  }
}
