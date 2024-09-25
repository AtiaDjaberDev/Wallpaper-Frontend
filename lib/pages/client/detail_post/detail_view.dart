import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
// import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/pages/client/detail_post/detail_controller.dart';
import 'package:wallpaper_app/models/post.dart';
import 'package:wallpaper_app/service/helper_service.dart';
import 'package:share_plus/share_plus.dart';

class DetailView extends StatelessWidget {
  final controller = Get.put(DetailController());
  final helperService = Get.find<HelperService>();
  DateTime now = DateTime.now();

  Widget imagesDesc(Post post, context) {
    return
        // InteractiveViewer(
        //     maxScale: 2,
        //     minScale: 1,
        //     boundaryMargin: EdgeInsets.all(1.0),
        //     child:
        SizedBox(
      height: 280.0,
      width: Get.width,
      child: CarouselSlider(
        items: [
          CachedNetworkImage(
            imageUrl: post.photo!,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade50,
                      offset: const Offset(0.2, 0.2),
                      blurRadius: 10)
                ],
                image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
              ),
            ),
            placeholder: (context, url) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SpinKitDoubleBounce(color: Colors.blue, size: 50)
              ],
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          for (var i = 0; i < post.attachments!.length; i++) ...[
            CachedNetworkImage(
              imageUrl: post.attachments![i].path!,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade50,
                        offset: const Offset(0.2, 0.2),
                        blurRadius: 10)
                  ],
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.fill),
                ),
              ),
              placeholder: (context, url) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SpinKitDoubleBounce(color: Colors.blue, size: 50)
                ],
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            )
          ]
        ],
        options: CarouselOptions(
          height: 300,
          aspectRatio: 16 / 9,
          viewportFraction: 1,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,

          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          // onPageChanged: callbackFunction,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }

  String idOld = "0";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: ListView(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: <Widget>[
                      Container(height: 290),
                      // Obx(
                      //   () => Stack(
                      //     alignment: Alignment.bottomCenter,
                      //     children: <Widget>[
                      //       Hero(
                      //         tag: "1",
                      //         child: Container(
                      //           height: 300,
                      //           decoration: BoxDecoration(
                      //               color: Colors.grey[300],
                      //               image: DecorationImage(
                      //                   image: NetworkImage(
                      //                       "https://sooqyemen.com/files/image/upload/" +
                      //                           ctrDetail.mainPhoto.value),
                      //                   fit: BoxFit.fill)),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Column(
                        children: [
                          imagesDesc(helperService.post!, context),
                        ],
                      ),

                      Positioned(
                          top: 20,
                          right: 20,
                          height: 40,
                          width: 40,
                          child: InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black.withOpacity(0.4),
                              ),
                              child: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                          )),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 4.0, right: 4.0, top: 8),
                    child: Text(
                      helperService.post!.title ?? "",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          fontSize: 16),
                      textAlign: TextAlign.right,
                      maxLines: 10,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Container(
                      child: Text(
                        helperService.post!.description ?? "",
                        style: const TextStyle(
                            color: Colors.black87, fontSize: 15),
                        textAlign: TextAlign.right,
                        maxLines: 10,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 80)
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              sharePost(idOld);
            },
            child: const Icon(Icons.share),
          ),
        ),
      ),
    );
  }

  Future<void> sharePost(String idPost) async {
    // String url = "whatsapp://send?phone=$phone&text=${Uri.parse(message)}";
    Share.share("https://sooqyemen.com/11" + idPost);

    // var url = "https://sooqyemen.com/11" + ctrDetail.idPost.value.toString();
    // if (await canLaunch(url)) {
    //   await launch(url);
    // } else {
    //   throw 'Could not launch $url';
    // }
  }
}

// Padding(
//   padding: const EdgeInsets.all(8.0),
//   child: Container(
//     child: Directionality(
//       textDirection: TextDirection.rtl,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Container(
//             height: 40,
//             width: 40,
//             padding: EdgeInsets.all(4),
//             decoration: BoxDecoration(
//                 border:
//                     Border.all(color: Colors.white, width: 2),
//                 color: Colors.purple[100],
//                 shape: BoxShape.circle),
//             child: Icon(
//               Icons.chat,
//               color: Colors.purple,
//             ),
//           ),
//           Container(
//             height: 40,
//             width: 40,
//             padding: EdgeInsets.all(4),
//             decoration: BoxDecoration(
//                 border:
//                     Border.all(color: Colors.white, width: 2),
//                 color: Colors.green[100],
//                 shape: BoxShape.circle),
//             child: Icon(
//               Icons.call,
//               color: Colors.green,
//             ),
//           ),
//           Container(
//             height: 40,
//             width: 40,
//             padding: EdgeInsets.all(4),
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.white, width: 2),
//               color: Colors.red[100],
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               MdiIcons.flag,
//               color: Colors.red,
//             ),
//           ),
//           Container(
//             height: 40,
//             width: 40,
//             padding: EdgeInsets.all(4),
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.white, width: 2),
//               color: Colors.blue[100],
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               MdiIcons.facebook,
//               color: Colors.blue,
//             ),
//           ),
//           Container(
//             height: 40,
//             width: 40,
//             padding: EdgeInsets.all(4),
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.white, width: 2),
//               color: Colors.green[100],
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               MdiIcons.whatsapp,
//               color: Colors.green,
//             ),
//           ),
//           InkWell(
//               onTap: () async {
//                 // _delete(8);

//                 ctrDetail.makePhoneCall(ctrDetail.number);
//               },
//               child: Container(
//                 height: 40,
//                 width: 40,
//                 padding: EdgeInsets.all(4),
//                 decoration: BoxDecoration(
//                   border:
//                       Border.all(color: Colors.white, width: 2),
//                   color: Colors.blue[100],
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(
//                   MdiIcons.twitter,
//                   color: Colors.blue,
//                 ),
//               ))
//         ],
//       ),
//     ),
//   ),
// ),
// Directionality(
//   textDirection: TextDirection.rtl,
//   child: Padding(
//     padding: const EdgeInsets.only(left: 12.0, right: 12),
//     child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               Icon(
//                 Icons.person,
//                 color: Colors.black54,
//                 size: 20,
//               ),
//               Text(ctrDetail.user_name.value),
//             ],
//           ),
//           Row(
//             children: [
//               Icon(
//                 Icons.chat,
//                 color: Colors.black54,
//                 size: 20,
//               ),
//               Text(ctrDetail.replayCount.value + " "),
//             ],
//           )
//         ]),
//   ),
// ),
// SizedBox(
//   height: 4,
// ),
// Directionality(
//   textDirection: TextDirection.rtl,
//   child: Padding(
//     padding: const EdgeInsets.only(right: 12.0, left: 12),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Row(
//           children: <Widget>[
//             Icon(
//               Icons.pin_drop,
//               color: Colors.black54,
//               size: 20,
//             ),
//             Text(
//               ctrDetail.locationName.value,
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//               style: TextStyle(
//                   fontSize: 12, color: Colors.black54),
//             ),
//           ],
//         ),
//         Row(
//           children: <Widget>[
//             Icon(
//               Icons.timer,
//               color: Colors.black54,
//               size: 20,
//             ),
//             Text(
//               ctrDetail.timeAgo.value,
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//               style: TextStyle(
//                   fontSize: 12, color: Colors.black54),
//             ),
//           ],
//         )
//       ],
//     ),
// ),
// ),
