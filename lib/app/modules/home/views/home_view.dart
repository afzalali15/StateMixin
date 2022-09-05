import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeView'),
        centerTitle: true,
      ),
      body: Center(
        child: controller.obx(
          (comments) {
            return ListView.builder(
              itemCount: comments?.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(radius: 20),
                  title: Text(comments![index]),
                );
              },
            );
          },
          onEmpty: buildEmptyView(),
          onLoading: buildLoadingView(),
          onError: (error) => buildErrorView(error),
        ),
      ),
    );
  }

  //Views
  Column buildErrorView(String? error) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.warning_amber_rounded,
          color: Colors.orange,
          size: 48,
        ),
        Text(error ?? ''),
      ],
    );
  }

  Shimmer buildLoadingView() {
    return Shimmer.fromColors(
      child: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, i) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(4),
                height: 12,
                width: 200,
                color: Colors.white,
              ),
              Container(
                margin: const EdgeInsets.all(4),
                height: 12,
                width: 100,
                color: Colors.white,
              ),
            ],
          );
        },
      ),
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
    );
  }

  Column buildEmptyView() {
    return Column(
      children: [
        FlutterLogo(),
        Text('All caught up!'),
      ],
    );
  }
}
