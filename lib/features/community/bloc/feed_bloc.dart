import 'package:ezycourse/features/community/model/feed_input_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/community_model.dart';
import '../repository/feed_repository.dart';
import 'feed_event.dart';
import 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final FeedRepository repository;
  
  List<Feed> _currentPosts = [];
  FeedBloc(this.repository) : super(FeedInitial()) {
    on<LoadFeed>(_onLoadFeed);
    on<AddPost>(_onAddPost);
    on<ToggleLikePost>(_onToggleLikePost);
  }

  void _onToggleLikePost(ToggleLikePost event, Emitter<FeedState> emit) async {
    final index = _currentPosts.indexWhere((post) => post.id.toString() == event.feedId);
    if (index == -1) return;

    final post = _currentPosts[index];

    // Optimistic UI update
    post.isLiked = !(post.isLiked ?? false);
    post.likeCount = (post.likeCount) + (post.isLiked! ? 1 : -1);
    emit(FeedLoaded(List.from(_currentPosts)));

    try {
      await repository.toggleLike(post.id.toString());

      // Then reload correct data from server
      final updatedPosts = await repository.fetchFeed();
      _currentPosts = updatedPosts;
      emit(FeedLoaded(_currentPosts));
    } catch (e) {
      emit(FeedError("Failed to sync like with server"));
    }
  }

  // This is the second version of the toggle like event handler
  void _onToggleLikePost2(ToggleLikePost event, Emitter<FeedState> emit) async {
    final index = _currentPosts.indexWhere((post) => post.id.toString() == event.feedId);
    if (index == -1) return;

    // Optional: flip isLiked just for instant visual feedback (optional)
    final post = _currentPosts[index];
    post.isLiked = !(post.isLiked ?? false);

    emit(FeedLoaded(List.from(_currentPosts)));

    try {
      await repository.toggleLike(post.id.toString());

      // Now load the latest feed (with correct like count)
      emit(FeedLoading()); // Optional: show loader
      final updatedPosts = await repository.fetchFeed();
      _currentPosts = updatedPosts;
      emit(FeedLoaded(_currentPosts));
    } catch (e) {
      emit(FeedError("Failed to update like"));
    }
  }



  void _onLoadFeed(LoadFeed event, Emitter<FeedState> emit) async {
    emit(FeedLoading());
    try {
      final posts = await repository.fetchFeed();
      _currentPosts = posts;
      emit(FeedLoaded(_currentPosts));
    } catch (e) {
      emit(FeedError(e.toString()));
    }
  }

  // void _onAddPost(AddPost event, Emitter<FeedState> emit) async {
  //   repository.addFeed(event.model.toJson());
  //   emit(FeedLoaded(List.from(_currentPosts)));
  // }


  void _onAddPost(AddPost event, Emitter<FeedState> emit) async {
    try {
      final success = await repository.addFeed(event.model.toJson());

      if (success) {
        final updatedPosts = await repository.fetchFeed();
        _currentPosts = updatedPosts;
        emit(PostAddSuccess("Post added successfully"));
        emit(FeedLoaded(_currentPosts));
      } else {
        emit(FeedError("Failed to add post"));
      }
    } catch (e) {
      emit(FeedError("Something went wrong: ${e.toString()}"));
    }
  }


}
