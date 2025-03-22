import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone_riverpod/commons/loader.dart';
import 'package:twitter_clone_riverpod/features/auth/controllers/auth_controller.dart';

class CreateTweetView extends ConsumerWidget {
  const CreateTweetView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserDetailsProvider).value;
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.close),
        actions: [ElevatedButton(onPressed: () {}, child: Text("Tweet"))],
      ),
      body:
          currentUser == null
              ? const Loader()
              : Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Tweet input box
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // profile pic
                      CircleAvatar(
                        backgroundImage: NetworkImage(currentUser.profilePic),
                      ),
                      const SizedBox(width: 15),
                      // input field
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Whats in your mind!",
                          ),
                          maxLines: null,
                        ),
                      ),
                    ],
                  ),

                  // Images, gif and smilies
                  Column(
                    children: [
                      const Divider(height: 1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.image_outlined,
                              color: Colors.blueGrey,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.gif_box_outlined,
                              color: Colors.blueGrey,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.insert_emoticon,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ],
              ),
    );
  }
}
