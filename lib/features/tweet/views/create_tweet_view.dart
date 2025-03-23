import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone_riverpod/commons/loader.dart';
import 'package:twitter_clone_riverpod/core/utils.dart';
import 'package:twitter_clone_riverpod/features/auth/controllers/auth_controller.dart';

// image provider
final imagesProvider = StateProvider<List<File>>((ref) => []);

class CreateTweetView extends ConsumerWidget {
  const CreateTweetView({super.key});

  void onPickImage(WidgetRef ref) async {
    final pickedImages = await pickImages();
    ref.read(imagesProvider.notifier).update((state) => pickedImages);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserDetailsProvider).value;
    final images = ref.watch(imagesProvider);

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
                  // ----- CHILD 1 -----
                  // Tweet input box
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // profile pic
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              currentUser.profilePic,
                            ),
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
                      if (images.isNotEmpty)
                        CarouselSlider(
                          items:
                              images
                                  .map(
                                    (file) => Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 5,
                                        vertical: 5,
                                      ),
                                      child: Image.file(file),
                                    ),
                                  )
                                  .toList(),
                          options: CarouselOptions(
                            height: 300,
                            enableInfiniteScroll: false,
                          ),
                        ),
                    ],
                  ),

                  // ----- CHILD 2 -----
                  // Images, gif and smilies
                  Column(
                    children: [
                      const Divider(height: 1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () => onPickImage(ref),
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
