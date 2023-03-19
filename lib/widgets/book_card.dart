import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/ebook/book.dart';
import '../utils/progress_indicators.dart';

class BookCard extends StatelessWidget {
  final Book book;

  BookCard({
    Key? key,
    required this.book,
  }) : super(key: key);

  static final uuid = const Uuid();
  final String imgTag = uuid.v4();
  final String titleTag = uuid.v4();
  final String authorTag = uuid.v4();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.0,
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        elevation: 4.0,
        child: InkWell(
          borderRadius: const BorderRadius.all(
            Radius.circular(10.0),
          ),
          onTap: () {

          },
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
            child: Hero(
              tag: imgTag,
              child: CachedNetworkImage(
                imageUrl: '${book.coverPhotoUrl}',
                placeholder: (context, url) => circularProgress(
                  context,
                ),
                errorWidget: (context, url, error) => Image.asset(
                  'assets/images/image_logo.png',
                  fit: BoxFit.cover,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
