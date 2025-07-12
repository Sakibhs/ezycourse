import '../model/community_model.dart';

abstract class FeedState {}

class FeedInitial extends FeedState {}

class FeedLoading extends FeedState {}

class FeedLoaded extends FeedState {
  final List<Feed> feeds;

  FeedLoaded(this.feeds);
}

class FeedError extends FeedState {
  final String message;

  FeedError(this.message);
}
class PostAddSuccess extends FeedState {
  final String message;

  PostAddSuccess(this.message);
}