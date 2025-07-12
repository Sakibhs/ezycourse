import 'package:ezycourse/features/community/model/feed_input_model.dart';

abstract class FeedEvent {}

class LoadFeed extends FeedEvent {}

class AddPost extends FeedEvent {
  final FeedInputModel model;

  AddPost(this.model);
}

class ToggleLikePost extends FeedEvent {
  final String feedId;

  ToggleLikePost(this.feedId);
}
