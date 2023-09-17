import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:remind_me/bloc/news_bloc.dart';
import 'package:remind_me/data/image_constants.dart';
import 'package:remind_me/data/response/app_response.dart';
import 'package:remind_me/data/response/status.dart';
import 'package:remind_me/models/news_model.dart';
import 'package:remind_me/screens/news_detail_screen.dart';
import 'package:remind_me/styles/app_colors.dart';
import 'package:remind_me/styles/styles.dart';
import 'package:remind_me/utils/navigation_util.dart';
import 'package:remind_me/widgets/general_error.dart';
import 'package:remind_me/widgets/general_loading.dart';

/*
 * Presents the latest news to the user
 */

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late Future future;
  int index = 0;
  int carouselItemLimit = 2;
  @override
  void initState() {
    super.initState();
    context.read<NewsBloc>().getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<NewsBloc>().getNews();
        },
        child:
            BlocBuilder<NewsBloc, AppResponse<NewsModel>>(builder: (_, state) {
          switch (state.status) {
            case Status.LOADING:
              return const GeneralLoading();
            case Status.ERROR:
              return const GeneralError();
            case Status.COMPLETED:
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: ListView.separated(
                  itemCount: state.data!.articles.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 16.h,
                    );
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        navigate(
                          context,
                          NewsDetailScreen(state.data!.articles[index]),
                        );
                      },
                      child: NewsItem(
                        state.data!.articles[index],
                      ),
                    );
                  },
                ),
              );
            default:
              return const SizedBox.shrink();
          }
        }),
      ),
    );
  }
}

class NewsItem extends StatelessWidget {
  final Articles articles;
  const NewsItem(
    this.articles, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Column(
            children: [
              Text(
                articles.title,
                style: bodyText,
              ),
              SizedBox(height: 6.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Icon(Icons.calendar_month),
                  SizedBox(width: 4.w),
                  Text(
                    DateFormat.yMMMEd().format(
                      DateTime.parse(articles.publishedAt),
                    ),
                    style: smallText.copyWith(
                      color: AppColors.textSoftGreyColor,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        SizedBox(
          width: 16.w,
        ),
        Expanded(
          flex: 4,
          child: CachedNetworkImage(
            imageUrl: articles.urlToImage!,
            imageBuilder: (context, imageProvider) {
              return Container(
                height: 80.h,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                color: Colors.green,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
            progressIndicatorBuilder: (context, url, progress) {
              progress.downloaded;

              return Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Container(
                    // height: 90.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5.r),
                          topRight: Radius.circular(5.r)),
                      image: const DecorationImage(
                        opacity: 0.4,
                        image: AssetImage(AppImage.logoImage),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  const CircularProgressIndicator(),
                ],
              );
            },
            errorWidget: (context, url, error) {
              return Image.asset(AppImage.logoImage, fit: BoxFit.contain, height: 90.h,);
            },
          ),
        )
      ],
    );
  }
}
