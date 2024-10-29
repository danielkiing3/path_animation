import 'package:flutter/material.dart';
import 'package:path_animation/presentation/animation_page_container.dart';

class PathTabContainer extends StatefulWidget {
  const PathTabContainer({super.key});

  @override
  State<PathTabContainer> createState() => _PathTabContainerState();
}

class _PathTabContainerState extends State<PathTabContainer> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: const Text('Path Animation'),
            // centerTitle: false,
            bottom: const TabBar(
              tabs: [
                Tab(child: Text('Fill')),
                Tab(child: Text('Travel')),
              ],
            ),
          ),
          body: const TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              AnimationPageContainer(isFill: true),
              AnimationPageContainer(isFill: false),
            ],
          ),
        ));
  }
}
