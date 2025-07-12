// Main Feed Model
class Feed {
  final int id;
  final int schoolId;
  final int userId;
  final int? courseId;
  final int communityId;
  final int? groupId;
  final String feedTxt;
  final String status;
  final String slug;
  final String title;
  final String activityType;
  final int isPinned;
  final String fileType;
  final List<FeedFile> files;
  int likeCount;
  final int commentCount;
  final int shareCount;
  final int shareId;
  final Map<String, dynamic> metaData;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String feedPrivacy;
  final int isBackground;
  final String? bgColor;
  final int? pollId;
  final int? lessonId;
  final int spaceId;
  final int? videoId;
  final int? streamId;
  final int? blogId;
  final DateTime? scheduleDate;
  final String? timezone;
  final int? isAnonymous;
  final int? meetingId;
  final int? sellerId;
  final DateTime publishDate;
  final int? coachingFeedId;
  final bool isFeedEdit;
  final String name;
  final String pic;
  final int uid;
  final int isPrivateChat;
  final dynamic group;
  final List<LikeType> likeType;
  final dynamic follow;
  final User user;
  final Like? like;
  final dynamic savedPosts;
  final Poll? poll;
  final List<Comment> comments;
  final FeedMeta meta;
  int? likes;        // mutable   // mutable if needed
  bool? isLiked;

  Feed({
    required this.id,
    required this.schoolId,
    required this.userId,
    this.courseId,
    required this.communityId,
    this.groupId,
    required this.feedTxt,
    required this.status,
    required this.slug,
    required this.title,
    required this.activityType,
    required this.isPinned,
    required this.fileType,
    required this.files,
    required this.likeCount,
    required this.commentCount,
    required this.shareCount,
    required this.shareId,
    required this.metaData,
    required this.createdAt,
    required this.updatedAt,
    required this.feedPrivacy,
    required this.isBackground,
    this.bgColor,
    this.pollId,
    this.lessonId,
    required this.spaceId,
    this.videoId,
    this.streamId,
    this.blogId,
    this.scheduleDate,
    this.timezone,
    this.isAnonymous,
    this.meetingId,
    this.sellerId,
    required this.publishDate,
    this.coachingFeedId,
    required this.isFeedEdit,
    required this.name,
    required this.pic,
    required this.uid,
    required this.isPrivateChat,
    this.group,
    required this.likeType,
    this.follow,
    required this.user,
    this.like,
    this.savedPosts,
    this.poll,
    required this.comments,
    required this.meta,
    this.likes,
    this.isLiked
  });

  factory Feed.fromJson(Map<String, dynamic> json) {
    return Feed(
      likes: json['likes'],
      isLiked: json['isLiked'],
      id: json['id'],
      schoolId: json['school_id'],
      userId: json['user_id'],
      courseId: json['course_id'],
      communityId: json['community_id'],
      groupId: json['group_id'],
      feedTxt: json['feed_txt'] ?? '',
      status: json['status'] ?? '',
      slug: json['slug'] ?? '',
      title: json['title'] ?? '',
      activityType: json['activity_type'] ?? '',
      isPinned: json['is_pinned'] ?? 0,
      fileType: json['file_type'] ?? '',
      files: (json['files'] as List<dynamic>?)
          ?.map((file) => FeedFile.fromJson(file))
          .toList() ?? [],
      likeCount: json['like_count'] ?? 0,
      commentCount: json['comment_count'] ?? 0,
      shareCount: json['share_count'] ?? 0,
      shareId: json['share_id'] ?? 0,
      metaData: json['meta_data'] ?? {},
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      feedPrivacy: json['feed_privacy'] ?? '',
      isBackground: json['is_background'] ?? 0,
      bgColor: json['bg_color'],
      pollId: json['poll_id'],
      lessonId: json['lesson_id'],
      spaceId: json['space_id'] ?? 0,
      videoId: json['video_id'],
      streamId: json['stream_id'],
      blogId: json['blog_id'],
      scheduleDate: json['schedule_date'] != null
          ? DateTime.parse(json['schedule_date'])
          : null,
      timezone: json['timezone'],
      isAnonymous: json['is_anonymous'],
      meetingId: json['meeting_id'],
      sellerId: json['seller_id'],
      publishDate: DateTime.parse(json['publish_date']),
      coachingFeedId: json['coaching_feed_id'],
      isFeedEdit: json['is_feed_edit'] ?? false,
      name: json['name'] ?? '',
      pic: json['pic'] ?? '',
      uid: json['uid'] ?? 0,
      isPrivateChat: json['is_private_chat'] ?? 0,
      group: json['group'],
      likeType: (json['likeType'] as List<dynamic>?)
          ?.map((like) => LikeType.fromJson(like))
          .toList() ?? [],
      follow: json['follow'],
      user: User.fromJson(json['user']),
      like: json['like'] != null ? Like.fromJson(json['like']) : null,
      savedPosts: json['savedPosts'],
      poll: json['poll'] != null ? Poll.fromJson(json['poll']) : null,
      comments: (json['comments'] as List<dynamic>?)
          ?.map((comment) => Comment.fromJson(comment))
          .toList() ?? [],
      meta: FeedMeta.fromJson(json['meta']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'school_id': schoolId,
      'user_id': userId,
      'course_id': courseId,
      'community_id': communityId,
      'group_id': groupId,
      'feed_txt': feedTxt,
      'status': status,
      'slug': slug,
      'title': title,
      'activity_type': activityType,
      'is_pinned': isPinned,
      'file_type': fileType,
      'files': files.map((file) => file.toJson()).toList(),
      'like_count': likeCount,
      'comment_count': commentCount,
      'share_count': shareCount,
      'share_id': shareId,
      'meta_data': metaData,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'feed_privacy': feedPrivacy,
      'is_background': isBackground,
      'bg_color': bgColor,
      'poll_id': pollId,
      'lesson_id': lessonId,
      'space_id': spaceId,
      'video_id': videoId,
      'stream_id': streamId,
      'blog_id': blogId,
      'schedule_date': scheduleDate?.toIso8601String(),
      'timezone': timezone,
      'is_anonymous': isAnonymous,
      'meeting_id': meetingId,
      'seller_id': sellerId,
      'publish_date': publishDate.toIso8601String(),
      'coaching_feed_id': coachingFeedId,
      'is_feed_edit': isFeedEdit,
      'name': name,
      'pic': pic,
      'uid': uid,
      'is_private_chat': isPrivateChat,
      'group': group,
      'likeType': likeType.map((like) => like.toJson()).toList(),
      'follow': follow,
      'user': user.toJson(),
      'like': like?.toJson(),
      'savedPosts': savedPosts,
      'poll': poll?.toJson(),
      'comments': comments.map((comment) => comment.toJson()).toList(),
      'meta': meta.toJson(),
      'likes': likes,
      'isLiked': isLiked,
    };
  }
}

// Feed File Model
class FeedFile {
  final String? playLink;
  final String? hlsLink;
  final String? thumbnailLink;
  final String fileLoc;
  final String originalName;
  final String extname;
  final int size;
  final String type;
  final String? videoID;

  FeedFile({
    this.playLink,
    this.hlsLink,
    this.thumbnailLink,
    required this.fileLoc,
    required this.originalName,
    required this.extname,
    required this.size,
    required this.type,
    this.videoID,
  });

  factory FeedFile.fromJson(Map<String, dynamic> json) {
    return FeedFile(
      playLink: json['play_link'],
      hlsLink: json['hls_link'],
      thumbnailLink: json['thumbnail_link'],
      fileLoc: json['fileLoc'] ?? '',
      originalName: json['originalName'] ?? '',
      extname: json['extname'] ?? '',
      size: json['size'] ?? 0,
      type: json['type'] ?? '',
      videoID: json['videoID'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'play_link': playLink,
      'hls_link': hlsLink,
      'thumbnail_link': thumbnailLink,
      'fileLoc': fileLoc,
      'originalName': originalName,
      'extname': extname,
      'size': size,
      'type': type,
      'videoID': videoID,
    };
  }
}

// User Model
class User {
  final int id;
  final String fullName;
  final String profilePic;
  final int isPrivateChat;
  final DateTime? expireDate;
  final String? status;
  final DateTime? pauseDate;
  final String userType;
  final Map<String, dynamic> meta;

  User({
    required this.id,
    required this.fullName,
    required this.profilePic,
    required this.isPrivateChat,
    this.expireDate,
    this.status,
    this.pauseDate,
    required this.userType,
    required this.meta,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullName: json['full_name'] ?? '',
      profilePic: json['profile_pic'] ?? '',
      isPrivateChat: json['is_private_chat'] ?? 0,
      expireDate: json['expire_date'] != null
          ? DateTime.parse(json['expire_date'])
          : null,
      status: json['status'],
      pauseDate: json['pause_date'] != null
          ? DateTime.parse(json['pause_date'])
          : null,
      userType: json['user_type'] ?? '',
      meta: json['meta'] ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'profile_pic': profilePic,
      'is_private_chat': isPrivateChat,
      'expire_date': expireDate?.toIso8601String(),
      'status': status,
      'pause_date': pauseDate?.toIso8601String(),
      'user_type': userType,
      'meta': meta,
    };
  }
}

// Like Type Model
class LikeType {
  final String reactionType;
  final int feedId;
  final Map<String, dynamic> meta;

  LikeType({
    required this.reactionType,
    required this.feedId,
    required this.meta,
  });

  factory LikeType.fromJson(Map<String, dynamic> json) {
    return LikeType(
      reactionType: json['reaction_type'] ?? '',
      feedId: json['feed_id'] ?? 0,
      meta: json['meta'] ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reaction_type': reactionType,
      'feed_id': feedId,
      'meta': meta,
    };
  }
}

// Like Model
class Like {
  final int id;
  final int feedId;
  final int userId;
  final String reactionType;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int isAnonymous;
  final Map<String, dynamic> meta;

  Like({
    required this.id,
    required this.feedId,
    required this.userId,
    required this.reactionType,
    required this.createdAt,
    required this.updatedAt,
    required this.isAnonymous,
    required this.meta,
  });

  factory Like.fromJson(Map<String, dynamic> json) {
    return Like(
      id: json['id'],
      feedId: json['feed_id'],
      userId: json['user_id'],
      reactionType: json['reaction_type'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      isAnonymous: json['is_anonymous'] ?? 0,
      meta: json['meta'] ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'feed_id': feedId,
      'user_id': userId,
      'reaction_type': reactionType,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'is_anonymous': isAnonymous,
      'meta': meta,
    };
  }
}

// Poll Model
class Poll {
  final int id;
  final int isMultipleSelected;
  final int allowUserAddOption;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String voteByAnyOne;
  final dynamic isVotedOne;
  final List<PollOption> pollOptions;

  Poll({
    required this.id,
    required this.isMultipleSelected,
    required this.allowUserAddOption,
    required this.createdAt,
    required this.updatedAt,
    required this.voteByAnyOne,
    this.isVotedOne,
    required this.pollOptions,
  });

  factory Poll.fromJson(Map<String, dynamic> json) {
    return Poll(
      id: json['id'],
      isMultipleSelected: json['is_multiple_selected'] ?? 0,
      allowUserAddOption: json['allow_user_add_option'] ?? 0,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      voteByAnyOne: json['vote_by_any_one'] ?? '',
      isVotedOne: json['isVotedOne'],
      pollOptions: (json['pollOptions'] as List<dynamic>?)
          ?.map((option) => PollOption.fromJson(option))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'is_multiple_selected': isMultipleSelected,
      'allow_user_add_option': allowUserAddOption,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'vote_by_any_one': voteByAnyOne,
      'isVotedOne': isVotedOne,
      'pollOptions': pollOptions.map((option) => option.toJson()).toList(),
    };
  }
}

// Poll Option Model
class PollOption {
  final int id;
  final int userId;
  final int pollId;
  final String text;
  final int totalVote;
  final DateTime createdAt;
  final DateTime updatedAt;
  final User user;
  final List<dynamic> voteOption;
  final dynamic isVoted;

  PollOption({
    required this.id,
    required this.userId,
    required this.pollId,
    required this.text,
    required this.totalVote,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.voteOption,
    this.isVoted,
  });

  factory PollOption.fromJson(Map<String, dynamic> json) {
    return PollOption(
      id: json['id'],
      userId: json['user_id'],
      pollId: json['poll_id'],
      text: json['text'] ?? '',
      totalVote: json['total_vote'] ?? 0,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      user: User.fromJson(json['user']),
      voteOption: json['voteOption'] ?? [],
      isVoted: json['isVoted'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'poll_id': pollId,
      'text': text,
      'total_vote': totalVote,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'user': user.toJson(),
      'voteOption': voteOption,
      'isVoted': isVoted,
    };
  }
}

// Comment Model (placeholder - extend as needed)
class Comment {
  final int id;
  final String content;
  final DateTime createdAt;

  Comment({
    required this.id,
    required this.content,
    required this.createdAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'] ?? 0,
      content: json['content'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

// Feed Meta Model
class FeedMeta {
  final int views;

  FeedMeta({
    required this.views,
  });

  factory FeedMeta.fromJson(Map<String, dynamic> json) {
    return FeedMeta(
      views: json['views'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'views': views,
    };
  }
}

// Helper class to parse the entire feed list
class FeedResponse {
  final List<Feed> feeds;

  FeedResponse({required this.feeds});

  factory FeedResponse.fromJson(List<dynamic> json) {
    return FeedResponse(
      feeds: json.map((feed) => Feed.fromJson(feed)).toList(),
    );
  }

  List<Map<String, dynamic>> toJson() {
    return feeds.map((feed) => feed.toJson()).toList();
  }
}

// Usage example:
/*
// To parse the JSON:
String jsonString = '...'; // Your JSON string
List<dynamic> jsonList = json.decode(jsonString);
FeedResponse feedResponse = FeedResponse.fromJson(jsonList);

// To convert back to JSON:
List<Map<String, dynamic>> jsonData = feedResponse.toJson();
String jsonString = json.encode(jsonData);
*/