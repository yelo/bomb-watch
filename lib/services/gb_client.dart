import 'dart:convert';

import 'package:bomb_watch/data/api_responses/gb_access_token.dart';
import 'package:bomb_watch/data/api_responses/gb_shows.dart';
import 'package:bomb_watch/data/api_responses/gb_video.dart';
import 'package:bomb_watch/data/api_responses/gb_videos.dart';
import 'package:http/http.dart' as http;

class GbClient {
  String apiKey;

  void setKey(String apiKey) {
    this.apiKey = apiKey;
  }

  void clearKey() {
    this.apiKey = null;
  }

  Future<GbAccessToken> fetchApiKey(String regCode) async {
    final response = await http.get(
        'https://www.giantbomb.com/app/bombwatch/get-result?regCode=${regCode}&format=json');
    if (response.statusCode == 200) {
      return GbAccessToken.fromJson(json.decode(response.body));
    } else {
      throw Exception('Unable to fetch access token');
    }
  }

  Future<GbShows> fetchShows() async {
    final response = await http.get(
        'https://www.giantbomb.com/api/video_shows/?api_key=${this.apiKey}&field_list=title,image,deck,id&sort=title:asc&format=JSON');
    if (response.statusCode == 200) {
      return GbShows.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch shows');
    }
  }

  Future<GbVideos> fetchVideos(int offset, int limit, int showId) async {
    // var url = 'https://www.giantbomb.com/api/videos/?api_key=${this.apiKey}&offset=${offset}&sort=publish_date%3Adesc&field_list=saved_time,name,deck,hd_url,high_url,low_url,guid,publish_date,image,user,length_seconds,url&format=JSON&limit=${limit}';
    var url = 'https://www.giantbomb.com/api/videos/?api_key=${this.apiKey}&sort=publish_date%3Adesc&field_list=saved_time,name,deck,hd_url,high_url,low_url,guid,publish_date,image,user,length_seconds,url&format=JSON';
    if (showId != 0) url = '${url}&filter=video_show:${showId}';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return GbVideos.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch videos');
    }
  }

  Future<GbVideo> fetchVideo(String guid) async {
    final response = await http.get(
        'https://www.giantbomb.com/api/video/${guid}/?api_key=${this.apiKey}&format=json');
    if (response.statusCode == 200) {
      return GbVideo.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch specific video with guid: $guid');
    }
  }
}
