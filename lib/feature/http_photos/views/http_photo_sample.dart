import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_web_sample/feature/http_photos/models/photo.dart';

class HttpPhotoSample extends StatelessWidget {
  const HttpPhotoSample({super.key});

  @override
  Widget build(BuildContext context) {
    List<Photo> parsePhotos(String responseBody) {
      final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

      return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
    }

    Future<List<Photo>> fetchPhotos() async {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
      return parsePhotos(response.body);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Http Photo Sample',
        ),
      ),
      body: FutureBuilder(
        future: fetchPhotos(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return PhotosList(photos: snapshot.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class PhotosList extends StatelessWidget {
  const PhotosList({super.key, required this.photos});
  final List<Photo> photos;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        return Image.network(photos[index].thumbnailUrl);
      },
    );
  }
}
