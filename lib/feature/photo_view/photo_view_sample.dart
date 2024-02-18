import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoViewSample extends StatelessWidget {
  const PhotoViewSample({super.key});

  static const imageUrls = [
    'https://cdn.pixabay.com/photo/2015/05/04/10/16/vegetables-752153_1280.jpg',
    'https://cdn.pixabay.com/photo/2015/12/09/17/11/vegetables-1085063_1280.jpg',
    'https://cdn.pixabay.com/photo/2016/08/11/08/04/vegetables-1584999_1280.jpg',
    'https://cdn.pixabay.com/photo/2015/05/30/01/18/vegetables-790022_1280.jpg',
    'https://cdn.pixabay.com/photo/2017/06/09/16/39/carrots-2387394_1280.jpg',
    'https://cdn.pixabay.com/photo/2016/02/20/21/41/vegetables-1212845_1280.jpg',
    'https://cdn.pixabay.com/photo/2018/09/15/10/36/vegetables-3679075_1280.jpg',
    'https://cdn.pixabay.com/photo/2016/03/05/19/02/vegetables-1238252_1280.jpg',
    'https://cdn.pixabay.com/photo/2015/03/14/14/00/carrots-673184_1280.jpg',
    'https://cdn.pixabay.com/photo/2016/08/01/17/08/tomatoes-1561565_1280.jpg',
    'https://cdn.pixabay.com/photo/2017/01/25/18/08/vegetables-2008578_1280.png',
    'https://cdn.pixabay.com/photo/2014/08/06/20/32/potatoes-411975_1280.jpg',
    'https://cdn.pixabay.com/photo/2017/02/28/20/59/carrots-2106825_1280.jpg',
    'https://cdn.pixabay.com/photo/2014/08/18/23/11/bell-peppers-421087_1280.jpg',
    'https://cdn.pixabay.com/photo/2016/07/11/00/18/carrots-1508847_1280.jpg',
    'https://cdn.pixabay.com/photo/2016/04/25/10/19/mushrooms-1351561_1280.jpg',
    'https://cdn.pixabay.com/photo/2018/12/07/00/19/savoy-cabbage-3860933_1280.jpg',
    'https://cdn.pixabay.com/photo/2018/10/03/21/57/cabbage-3722498_1280.jpg',
    'https://cdn.pixabay.com/photo/2018/03/09/17/39/paprika-3212137_1280.jpg',
    'https://cdn.pixabay.com/photo/2014/10/22/21/54/bell-peppers-499068_1280.jpg',
    'https://cdn.pixabay.com/photo/2014/10/19/21/50/broccoli-494754_1280.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Photo View Sample',
        ),
      ),
      body: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              openPhotoViewGallery(context, index);
            },
            child: Image.network(
              imageUrls[index],
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }

  Future<void> openPhotoViewGallery(
      BuildContext context, int initialIndex) async {
    await showDialog(
      context: context,
      builder: (context) {
        return GalleryScreen(imageUrls: imageUrls, initialIndex: initialIndex);
      },
    );
  }
}

class GalleryScreen extends StatelessWidget {
  const GalleryScreen(
      {super.key, required this.imageUrls, required this.initialIndex});

  final List<String> imageUrls;
  final int initialIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
        ),
        Expanded(
          child: PhotoViewGallery.builder(
            itemCount: imageUrls.length,
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: NetworkImage(
                  imageUrls[index],
                ),
                initialScale: PhotoViewComputedScale.contained,
              );
            },
            pageController: PageController(initialPage: initialIndex),
            scrollPhysics: const BouncingScrollPhysics(),
            backgroundDecoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            enableRotation: true,
            loadingBuilder: (context, event) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ],
    );
  }
}
