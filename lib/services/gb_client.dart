import 'dart:convert';

import 'package:bomb_watch/data/api_responses/gb_shows.dart';
import 'package:bomb_watch/data/api_responses/gb_video.dart';
import 'package:bomb_watch/data/api_responses/gb_videos.dart';
import 'package:http/http.dart' as http;

class GbClient {
  Future<GbShows> fetchShows(String apiKey) async {
    final response = await http.get('https://www.giantbomb.com/api/video_shows/?field_list=title,image,deck,id&sort=title:asc&api_key=269ef98cdcae8532b1e58ebcad23edda54deedfb&format=JSON');
    if (response.statusCode == 200) {
      return GbShows.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch shows');
    }
  }

  Future<GbVideos> fetchVideos(String apiKey, int offset, int limit, int showId) async {
    final response = await http.get('https://www.giantbomb.com/api/videos/?api_key=269ef98cdcae8532b1e58ebcad23edda54deedfb&offset=0&sort=publish_date%3Adesc&field_list=saved_time,name,deck,hd_url,high_url,low_url,guid,publish_date,image,user,length_seconds,url&format=JSON&limit=3&filter=video_show:${showId}');
    if (response.statusCode == 200) {
      return GbVideos.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch videos');
    }
  }

  Future<GbVideo> fetchVideo(String apiKey, String guid) async {
    final response = await http.get('https://www.giantbomb.com/api/video/2300-15145/?api_key=269ef98cdcae8532b1e58ebcad23edda54deedfb&format=json');
    if (response.statusCode == 200) {
      return GbVideo.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch specific video with guid: $guid');
    }
  }
}