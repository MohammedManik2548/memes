import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../business_logics/controllers/meme_controller.dart';
import 'meme_details_screen.dart';

class MemeListScreen extends StatelessWidget {
  final MemeController _controller = Get.put(MemeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Memes')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) => _controller.searchMemes(value),
              decoration: const InputDecoration(
                labelText: 'Search Memes',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (_controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                itemCount: _controller.filteredMemes.length,
                itemBuilder: (context, index) {
                  var meme = _controller.filteredMemes[index];
                  return ListTile(
                    leading: ClipRRect(
                       borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        meme.url ?? '',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(meme.name ?? ''),
                    onTap: () {
                      Get.to(() => MemeDetailScreen(meme: meme));
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
