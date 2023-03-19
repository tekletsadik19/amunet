import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../models/post_model.dart';
import '../utils/firebase.dart';
import '../utils/progress_indicators.dart';
import '../utils/responsive.dart';
import '../widgets/amunet_icon_button.dart';


class ViewImage extends StatefulWidget {
  final PostModel post;

  ViewImage({required this.post});

  @override
  _ViewImageState createState() => _ViewImageState();
}

final DateTime timestamp = DateTime.now();

currentUserId() {
  return firebaseAuth.currentUser!.uid;
}



class _ViewImageState extends State<ViewImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResponsiveWidget.isWeb
          ? ResponsiveWidget.responsiveVisibility(
        context: context,
        tabletLandscape: false,
        desktop: false,
      )
          ? AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        automaticallyImplyLeading: false,
        leading: FenoteIconButton(
          borderColor: Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          borderWidth: 1,
          buttonSize: 60,
          icon: const Icon(
            Icons.arrow_back_rounded,
            size: 30,
          ),
          onPressed: () async {
            Navigator.of(context).pop();
          },
        ),
        elevation: 0,
      )
          : null
          : null,
      backgroundColor: Theme.of(context).canvasColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              if (ResponsiveWidget.responsiveVisibility(
                context: context,
                phone: false,
                tablet: false,
              ))
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 44, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                        const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                        child: FenoteIconButton(
                          borderColor: Colors.transparent,
                          borderRadius: BorderRadius.circular(30),
                          borderWidth: 1,
                          buttonSize: 44,
                          icon: const Icon(
                            Icons.arrow_back_rounded,
                            size: 24,
                          ),
                          onPressed: () async {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              widget.post.mediaUrl!=null
                  ?Padding(
                    padding: const EdgeInsets.all(20),
                    child: buildImage(context)
                  )
                  :Container(),
              widget.post.description!=null
                  ?Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      child: Text(widget.post.description!),
                    ),
                  )
                  :Container(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          elevation: 0.0,
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: 40.0,
              width: MediaQuery.of(context).size.width,
              child: Row(children: [
                Column(
                  children: [
                    Text(
                      widget.post.username!,
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 3.0),
                    Row(
                      children: [
                        const Icon(FontAwesomeIcons.clock, size: 13.0),
                        const SizedBox(width: 3.0),
                        Text(DateFormat('dd MM yyyy hh:mm').format(widget.post.timestamp!.toDate())),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
              ]),
            ),
          )),
    );
  }

  buildImage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: CachedNetworkImage(
          imageUrl: widget.post.mediaUrl!,
          placeholder: (context, url) {
            return circularProgress(context);
          },
          errorWidget: (context, url, error) {
            return const Icon(Icons.error);
          },
          height: 400.0,
          fit: BoxFit.contain,
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }
}
