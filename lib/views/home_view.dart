import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone_riverpod/features/tweet/views/create_tweet_view.dart';

// index provider
final pageIndex = StateProvider((ref) => 0);

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(pageIndex);
    return SafeArea(
      child: Scaffold(
        body: IndexedStack(
          index: selectedIndex,
          children: [Text("Home"), Text("Search"), Text("Notifcation")],
        ),
        floatingActionButton: FloatingActionButton.small(
          onPressed:
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreateTweetView(),
                ),
              ),
          child: Icon(Icons.add, size: 30),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap:
              (value) =>
                  ref.read(pageIndex.notifier).update((prevState) => value),
          items: [
            BottomNavigationBarItem(
              icon:
                  selectedIndex == 0
                      ? Icon(Icons.home, color: Colors.white)
                      : Icon(Icons.home, color: Colors.grey),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon:
                  selectedIndex == 1
                      ? Icon(Icons.search, color: Colors.white)
                      : Icon(Icons.search, color: Colors.grey),
              label: "Search",
            ),
            BottomNavigationBarItem(
              icon:
                  selectedIndex == 2
                      ? Icon(Icons.notifications, color: Colors.white)
                      : Icon(Icons.notifications, color: Colors.grey),
              label: "Notification",
            ),
          ],
        ),
      ),
    );
  }
}
