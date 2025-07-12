import 'dart:developer';

import 'package:ezycourse/data/local/shared_prefs.dart';
import 'package:ezycourse/features/auth/view/login_page.dart';
import 'package:ezycourse/features/community/repository/feed_repository.dart';
import 'package:ezycourse/features/community/view/community_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/constants/string_constant.dart';
import 'features/auth/bloc/auth_bloc.dart';
import 'features/auth/repository/auth_repository.dart';
import 'features/community/bloc/feed_bloc.dart';
import 'features/community/bloc/feed_event.dart';
import 'features/community/model/community_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.init();
  log("Token: ${SharedPrefs.getString('token')}");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  Future<bool> isLoggedIn() async {
    final token = SharedPrefs.getString(StringConstants.token);
    log("Token: $token");
    return token.isNotEmpty;

  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider<AuthBloc>(
        create: (_) => AuthBloc(AuthRepository()),
      ),
        BlocProvider<FeedBloc>(
          create: (_) => FeedBloc(FeedRepository())..add(LoadFeed()),
        ),],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'EzyCourse',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: FutureBuilder<bool>(
          future: isLoggedIn(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData && snapshot.data == true) {
              return CommunityPage();
            } else {
              return LoginPage();
            }
          },
         )
      ),
    );
  }
}
