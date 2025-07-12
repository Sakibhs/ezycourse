import 'package:ezycourse/features/auth/view/login_page.dart';
import 'package:ezycourse/features/community/model/community_model.dart';
import 'package:ezycourse/features/community/model/feed_input_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../auth/bloc/auth_bloc.dart';
import '../../auth/bloc/auth_event.dart';
import '../../auth/bloc/auth_state.dart';
import '../bloc/feed_bloc.dart';
import '../bloc/feed_event.dart';
import '../bloc/feed_state.dart';
import '../repository/feed_repository.dart';

class CommunityPage extends StatelessWidget {
  CommunityPage({super.key});

  final postController = TextEditingController();

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FeedBloc(FeedRepository())..add(LoadFeed()),
      child: Scaffold(
        backgroundColor: const Color(0xFFEDEDED),
        appBar: AppBar(
          backgroundColor: const Color(0xFF0A5F66),
          elevation: 0,
          leading: const Icon(Icons.menu, color: Colors.white),
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Python Developer Community",
                  style: TextStyle(color: Colors.white, fontSize: 16)),
              Text("#General",
                  style: TextStyle(color: Colors.white70, fontSize: 12)),
            ],
          ),
          actions: const [SizedBox(width: 12)],
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<FeedBloc, FeedState>(
              listener: (context, state) {
                if (state is PostAddSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.green,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                } else if (state is FeedError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
            ),
            BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is LogoutSuccess) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => LoginPage()), // change to your next screen
                  );
                } else if (state is LogoutFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message), backgroundColor: Colors.red),
                  );
                }
              },
            ),
          ], child: BlocBuilder<FeedBloc, FeedState>(
          builder: (context, state) {
            if (state is FeedLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FeedLoaded) {
              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _postInput(context),
                  const SizedBox(height: 16),
                  ...state.feeds
                      .map((post) => _postCard(post, context))
                      .toList(),
                ],
              );
            } else if (state is FeedError) {
              return Center(child: Text(state.message));
            } else {
              return const SizedBox();
            }
          },
        ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 0, // Keep track of selected tab if needed
          selectedItemColor: const Color(0xFF0A5F66),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.groups), label: 'Community'),
            BottomNavigationBarItem(icon: Icon(Icons.logout), label: 'Logout'),
          ],
          onTap: (index) {
            if (index == 1) {
              // Dispatch logout event
              context.read<AuthBloc>().add(LogoutRequested());
            }
            // Optional: handle index 0 (Community) if needed
          },
        ),
      ),
    );
  }

  Widget _postInput(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            const CircleAvatar(
                radius: 22,
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, color: Colors.white)),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: postController,
                decoration: InputDecoration(
                  hintText: 'Write Something here...',
                  border: InputBorder.none,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0A5F66),
                padding: const EdgeInsets.symmetric(horizontal: 18),
              ),
              onPressed: () {
                final content = postController.text.trim();
                FeedInputModel model = FeedInputModel(
                  feedTxt: content,
                  communityId: '2914',
                  spaceId: '5883',
                  activityType:
                      'group', // Assuming no image upload for simplicity
                );
                if (content.isNotEmpty) {
                  context.read<FeedBloc>().add(AddPost(model));
                  postController.clear();
                }
              },
              child: const Text(
                "Post",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _postCard(Feed post, BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Container(
        color: post.isBackground != 0 ? const Color(0xFF333844) : Colors.white,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Info Row
            Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.grey.shade300,
                  child: ClipOval(
                    child: post.user.profilePic != null &&
                            post.user.profilePic.isNotEmpty
                        ? Image.network(
                            post.user.profilePic,
                            width: 44,
                            height: 44,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Icon(Icons.person, color: Colors.grey[700]),
                          )
                        : Icon(Icons.person, color: Colors.grey[700]),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(post.user.fullName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: false ? Colors.white : Colors.black,
                        )),
                    Text(timeago.format(post.createdAt),
                        style: TextStyle(
                          fontSize: 12,
                          color: post.isBackground != 0
                              ? Colors.white70
                              : Colors.grey,
                        )),
                  ],
                ),
                const Spacer(),
                const Icon(Icons.more_vert, color: Colors.grey),
              ],
            ),
            const SizedBox(height: 12),
            // Post Text
            RichText(
              text: TextSpan(
                style: TextStyle(
                  color: post.isBackground != 0 ? Colors.white : Colors.black,
                ),
                children: [
                  TextSpan(text: post.feedTxt),
                ],
              ),
            ),
            if (post.pic != null) ...[
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(post.pic),
              ),
            ],
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.favorite, size: 18, color: Colors.red),
                const SizedBox(width: 4),
                Text(
                  post.likeCount.toString() ?? '',
                  style: TextStyle(
                    fontSize: 12,
                    color:
                        post.isBackground != 0 ? Colors.white70 : Colors.black,
                  ),
                ),
                const Spacer(),
                if (post.commentCount != null)
                  Row(
                    children: [
                      const Icon(Icons.comment, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        "${post.commentCount} Comments",
                        style: TextStyle(
                          fontSize: 12,
                          color: post.isBackground != 0
                              ? Colors.white70
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                TextButton.icon(
                  onPressed: () {
                    context
                        .read<FeedBloc>()
                        .add(ToggleLikePost(post.id.toString()));
                  },
                  icon: const Icon(Icons.favorite, size: 18),
                  label: const Text('Like'),
                ),
                const SizedBox(width: 8),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.comment_outlined, size: 18),
                  label: const Text('Comment'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
