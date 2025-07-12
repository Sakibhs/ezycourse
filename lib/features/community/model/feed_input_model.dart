class FeedInputModel {
  final String feedTxt;
  final String communityId;
  final String spaceId;
  final String activityType;

  FeedInputModel({
    required this.feedTxt,
    required this.communityId,
    required this.spaceId,
    required this.activityType,
  });

  Map<String, dynamic> toJson() {
    return {
      'feed_txt': feedTxt,
      'community_id': communityId,
      'space_id': spaceId,
      'activity_type': activityType,
    };
  }

  factory FeedInputModel.fromJson(Map<String, dynamic> json) {
    return FeedInputModel(
      feedTxt: json['feed_txt'],
      communityId: json['community_id'],
      spaceId: json['space_id'],
      activityType: json['activity_type'],
    );
  }
}
