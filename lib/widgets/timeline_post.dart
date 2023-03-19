import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../components/custom_card.dart';
import '../components/view_post.dart';
import '../models/user_model.dart'as user_model;
import '../models/post_model.dart';
import '../repository/profile/profile_provider.dart';
import '../utils/firebase.dart' as firebaseService;


class TimelinePostView extends ConsumerStatefulWidget {
  const TimelinePostView({Key? key, required this.post}) : super(key: key);
  final PostModel post;

  @override
  ConsumerState<TimelinePostView> createState() => _TimelinePostViewState();
}

class _TimelinePostViewState extends ConsumerState<TimelinePostView> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if(widget.post != null){
          Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ViewImage(post: widget.post!),
              )
          );
        }
      },
      child: CustomCard(
          onTap: null,
          borderRadius: BorderRadius.circular(7.0),
          child: Column(
            children: [
              _postHead(context),
              widget.post.mediaUrl != null? CachedNetworkImage(
                imageUrl: widget.post.mediaUrl!,
                height: 300.0,
                width: double.infinity,
              ):Container(),
              Visibility(
                visible: widget.post.description != null &&
                    widget.post.description.toString().isNotEmpty,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    widget.post.description ?? "",
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 15.0,
                      overflow: TextOverflow.ellipsis
                    ),
                    maxLines: widget.post.mediaUrl != null?3:15,
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }

  Widget _postHead(BuildContext context){
    user_model.User user;
    bool isMe = firebaseService.currentUserId() == widget.post.ownerId!;
    final userData = ref.watch(getUserDataStream(widget.post.ownerId!));
    return userData.when(
        data: (DocumentSnapshot snapshot){
          user =  user_model.User.fromDocument(snapshot);
          return Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 50.0,
              decoration: const BoxDecoration(
                color: Colors.white60,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              child: GestureDetector(
                onTap: (){
                  if(widget.post != null){
                    Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ViewImage(post: widget.post!),
                        )
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          CachedNetworkImage(
                            placeholder: (context, url) =>const CircleAvatar(
                              radius: 20.0,
                              backgroundColor: Color(0xff4D4D4D),
                            ),
                            errorWidget: (context, url, error) => const CircleAvatar(
                              radius: 20.0,
                              backgroundColor: Color(0xff4D4D4D),
                            ),
                            fit: BoxFit.cover,
                            imageUrl: user.photoUrl!,
                            imageBuilder: (context, imageProvider) {
                              return CircleAvatar(
                                radius: 20.0,
                                backgroundColor: const Color(0xff4D4D4D),
                                backgroundImage: NetworkImage(
                                    user.photoUrl!),
                              );
                            },
                          ),
                          const SizedBox(width: 5.0),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.post.username ?? "",
                                style: const TextStyle(
                                  fontFamily: 'Raleway',
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff4D4D4D),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                DateFormat('dd MM yyyy hh:mm').format(widget.post.timestamp!.toDate()),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      isMe?
                      IconButton(
                        icon: const Icon(FontAwesomeIcons.deleteLeft),
                        onPressed: () {
                        },
                      )
                          : IconButton(
                        icon: const Icon(FontAwesomeIcons.bookmark, size: 25.0),
                        onPressed: () {
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        error: (value,stack)=> Container(),
        loading: ()=>const ListTile(
          leading: CircleAvatar(
            radius: 20.0,
            backgroundColor: Color(0xff4D4D4D),
          ),
          title: Text("Fenote Abew"),
        ));
  }


}
