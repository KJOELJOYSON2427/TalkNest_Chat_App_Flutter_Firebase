import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_project/Config/images.dart';

class Chatbubble extends StatelessWidget {
  final String message;
  final bool isComing;
  final String time;
  final String status;
  final String imageURl;

  const Chatbubble({
    super.key,
    required this.message,
    required this.isComing,
    required this.time,
    required this.status,
    required this.imageURl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment:
            isComing ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.sizeOf(context).width / 1.3,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius:
                  isComing
                      ? BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(10),
                      )
                      : BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(0),
                      ),
            ),
            child:
                imageURl == ""
                    ? Text(
                      message,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    )
                    : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: imageURl,
                            fit: BoxFit.cover,
                            placeholder:
                                (context, url) => CircularProgressIndicator(),
                            errorWidget:
                                (context, url, error) => Icon(Icons.error),
                          ),
                        ),
                        message == "" ? Container() : SizedBox(height: 10),

                        message == ""
                            ? Container()
                            : Text(
                              message,
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                            ),
                      ],
                    ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment:
                isComing ? MainAxisAlignment.start : MainAxisAlignment.end,
            children: [
              isComing
                  ? Text(time)
                  : Row(
                    children: [
                      Text(time),
                      SizedBox(width: 10),
                      SvgPicture.asset(AssestsImage.chatStatus, width: 20),
                    ],
                  ),
            ],
          ),
        ],
      ),
    );
  }
}
