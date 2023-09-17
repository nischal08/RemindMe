import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:remind_me/data/image_constants.dart';
import 'package:remind_me/models/news_model.dart';
import 'package:remind_me/styles/app_colors.dart';
import 'package:remind_me/styles/app_sizes.dart';
import 'package:remind_me/styles/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailScreen extends StatelessWidget {
  final Articles articles;
  const NewsDetailScreen(this.articles, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(articles.title),
      ),
      body: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          Container(
            alignment: Alignment.topCenter,
            height: MediaQuery.of(context).size.height / 3,
            child: CachedNetworkImage(
              color: AppColors.blackColor,
              imageUrl: articles.urlToImage!,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              imageBuilder: (context, imageProvider) {
                return Image(
                  image: imageProvider,
                );
              },
               progressIndicatorBuilder: (context, url, downloadProgress) =>
                  const CircularProgressIndicator(
                color: Colors.transparent,
                strokeWidth: 0,
              ),
              errorWidget: (context, url, error) {
                return Image.asset(AppImage.logoImage, fit: BoxFit.contain,
                  height: MediaQuery.of(context).size.height / 5,
                );
              },
            ),
          ),
          Positioned.fill(
            right: 0,
            left: 0,
            top: (MediaQuery.of(context).size.height / 3) - 100,
            child: Container(
              clipBehavior: Clip.hardEdge,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 0),
                      blurRadius: 12,
                      spreadRadius: 8,
                      color: Colors.grey.withOpacity(0.25),
                    ),
                  ],
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: AppSizes.paddingLg * 1.3,
                  left: AppSizes.paddingLg,
                  right: AppSizes.paddingLg,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      articles.title,
                      style: titleText.copyWith(
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat.yMMMd().format(
                            DateTime.parse(articles.publishedAt),
                          ),
                          style: smallText.copyWith(color: AppColors.greyColor),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: AppSizes.paddingLg,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(
                          bottom: AppSizes.paddingLg * 3,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              articles.content,
                              textAlign: TextAlign.justify,
                              style: bodyText.copyWith(
                                color: AppColors.greyColor,
                              ),
                            ),
                            const SizedBox(
                              height: AppSizes.paddingLg,
                            ),
                            Text(
                              "For more detail click below",
                              textAlign: TextAlign.justify,
                              style: bodyText.copyWith(
                                color: Colors.black,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                launchUrl(Uri.parse(articles.url));
                              },
                              child: Text(
                                articles.url,
                                textAlign: TextAlign.justify,
                                style: bodyText.copyWith(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
