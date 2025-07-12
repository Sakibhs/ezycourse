

import 'dart:developer';
import 'package:ezycourse/features/community/model/community_model.dart';
import 'package:ezycourse/services/api_services.dart';

class FeedRepository {
  final apiService = APIServices();

  Future<List<Feed>> fetchFeed() async {
    String endPoint = "teacher/community/getFeed?status=feed&";
    Map<String, dynamic> body = {
      "community_id": "2914",
      "space_id": "5883"
    };
    final data = await apiService.post(endPoint, body);
    return (data as List).map((e) => Feed.fromJson(e)).toList();
  }

  Future<dynamic> addFeed(Map<String, dynamic> body) async {
    String endPoint = "teacher/community/createFeedWithUpload";
    final data = await apiService.post(endPoint, body);
    log("DATASSS: $data");
    if(data != null) return true;
  }


  Future<dynamic> toggleLike(String postId) async {
    final response = await apiService.post(
      "teacher/community/createLike",
       {
        "feed_id": postId,
        "reaction_type": "LIKE",
        "action": "deleteOrCreate",
        "reactionSource": "COMMUNITY",
      },
    );

    if(response!= null){
      return true;
    }
    return false;
  }


}
