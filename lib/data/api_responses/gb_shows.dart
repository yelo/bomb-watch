class GbShows {
  String error;
  int limit;
  int offset;
  int numberOfPageResults;
  int numberOfTotalResults;
  int statusCode;
  List<Show> results;
  String version;

  GbShows(
      {this.error,
      this.limit,
      this.offset,
      this.numberOfPageResults,
      this.numberOfTotalResults,
      this.statusCode,
      this.results,
      this.version});

  GbShows.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    limit = json['limit'];
    offset = json['offset'];
    numberOfPageResults = json['number_of_page_results'];
    numberOfTotalResults = json['number_of_total_results'];
    statusCode = json['status_code'];
    if (json['results'] != null) {
      results = new List<Show>();
      json['results'].forEach((v) {
        results.add(new Show.fromJson(v));
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

class Show {
  String deck;
  int id;
  String title;
  Image image;
  bool favorite = false;

  Show({this.deck, this.id, this.title, this.image});

  Show.fromJson(Map<String, dynamic> json) {
    deck = json['deck'];
    id = json['id'];
    title = json['title'];
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deck'] = this.deck;
    data['id'] = this.id;
    data['title'] = this.title;
    if (this.image != null) {
      data['image'] = this.image.toJson();
    }
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
