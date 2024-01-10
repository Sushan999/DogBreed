import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pupscan/Api/api.dart';
import 'package:pupscan/utils/models.dart';
import 'package:readmore/readmore.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key, required this.id});
  final int id;
  @override
  // ignore: library_private_types_in_public_api
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late DogDetail _dog;
  late List<String> imageUrls = [];

  int currentPage = 0;
  late PageController pageController;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    _loadDetail();
    // pageController = PageController(initialPage: currentPage);
    pageController = PageController(initialPage: currentPage);
    // Set up a timer for auto-sliding every 5 seconds
    timer = Timer.periodic(const Duration(seconds: 4), (Timer t) {
      if (currentPage < imageUrls.length - 1) {
        currentPage++;
      } else {
        currentPage = 0;
      }
      pageController.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  Future<void> _loadDetail() async {
    DogDetail dog = await ApiCalls.loadDetail(widget.id);
    setState(() {
      _dog = dog;
      imageUrls = [dog.img0, dog.img, dog.img1];
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Breed Detail'),
          backgroundColor: Colors.lightGreen[200],
        ),
        body: imageUrls.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Container(
                  width: size.width,
                  height: size.height,
                  padding:
                      const EdgeInsets.symmetric(vertical: 40, horizontal: 1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: size.width,
                        height: 180,
                        child: PageView.builder(
                          controller: pageController,
                          itemCount: imageUrls.length,
                          onPageChanged: (index) {
                            setState(() {
                              currentPage = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            return Image.network(
                              imageUrls[index],
                              fit: BoxFit.fitHeight,
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                      Card(
                        clipBehavior: Clip.antiAlias,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusStyle.roundedBorder10,
                        ),
                        child: Container(
                          height: 550,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusStyle.roundedBorder10,
                          ),
                          child: SingleChildScrollView(
                            child: Stack(
                              alignment: Alignment.bottomLeft,
                              children: [
                                _buildDogDetails(context),
                                const SizedBox(
                                  height: 4,
                                ),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                      left: 35,
                                      top: 350,
                                      right: 185,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 7,
                                      vertical: 0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.green.withOpacity(0.2),
                                    ).copyWith(
                                      borderRadius:
                                          BorderRadiusStyle.roundedBorder10,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomImageView(
                                          imagePath: ImageConstant
                                              .imgIconoirBirthdayCake,
                                          height: 30,
                                          width: 32,
                                          margin: const EdgeInsets.only(
                                            top: 2,
                                            bottom: 17,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 1,
                                            top: 1,
                                          ),
                                          child: Column(
                                            children: [
                                              Text(
                                                "Life Expectancy",
                                                style: TextStyle(
                                                  color: Colors.lightGreen[800],
                                                  fontSize: 15,
                                                  fontFamily: 'Catamaran',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Text(
                                                _dog.life,
                                                style: TextStyle(
                                                  color: Colors.lightGreen[800],
                                                  fontSize: 15,
                                                  fontFamily: 'Catamaran',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                CustomElevatedButton(
                                  onPressed: () {
                                    launchUrl(Uri.parse(_dog.akc));
                                  },
                                  height: 50,
                                  width: 167,
                                  text: "Learn More",
                                  margin: const EdgeInsets.only(right: 15),
                                  leftIcon: Container(
                                    margin: const EdgeInsets.only(right: 15),
                                    // child: CustomImageView(
                                    //   // imagePath:
                                    //   //     ImageConstant.imgSolarhealthlineduotone,
                                    //   height: 32.adaptSize,
                                    //   width: 32.adaptSize,
                                    // ),
                                  ),
                                  buttonStyle: const ButtonStyle(),
                                  alignment: Alignment.bottomRight,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  /// Section Widget
  Widget _buildDogDetails(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 30,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 60,
              width: 320,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      height: 19,
                      width: 23,
                      margin: const EdgeInsets.only(top: 4),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: 19,
                              width: 23,
                              decoration: BoxDecoration(
                                // color: theme.colorScheme.primary,
                                borderRadius: BorderRadius.circular(
                                  11,
                                ),
                              ),
                            ),
                          ),
                          CustomImageView(
                            imagePath: ImageConstant.imgTeenyiconsTickOutline,
                            height: 15,
                            width: 15,
                            alignment: Alignment.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 94,
                      width: 309,
                      child: Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 4,
                                bottom: 19,
                              ),
                              child: Text(
                                _dog.breed,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 29,
                                  fontFamily: 'Catamaran',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Row(
                              children: [
                                Container(
                                  width: 300,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 9,
                                    vertical: 1,
                                  ),
                                  decoration: const BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 201, 200, 200))
                                      .copyWith(
                                    borderRadius:
                                        BorderRadiusStyle.roundedBorder10,
                                  ),
                                  child: Text(
                                    _dog.character,
                                    style: const TextStyle(color: Colors.black),
                                    // style: CustomTextStyles.bodySmallBlack900,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                "Breed Traits and Characteristics",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Catamaran',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 2),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 324,
                child: ReadMoreText(
                  _dog.description,
                  trimLines: 12,
                  colorClickableText: Colors.black,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: "Read more",
                  moreStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: 'Catamaran',
                    fontWeight: FontWeight.w500,
                  ),
                  lessStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: 'Catamaran',
                    fontWeight: FontWeight.w500,
                    height: 1.40,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 9),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 13,
                  right: 5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 173,
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.2),
                      ).copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomImageView(
                            imagePath: ImageConstant.imgIconParkOutli,
                            height: 31,
                            width: 31,
                            margin: const EdgeInsets.only(
                              top: 6,
                              bottom: 15,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 1),
                                  child: Text(
                                    "Height :",
                                    style: TextStyle(
                                      color: Colors.lightGreen[800],
                                      fontSize: 15,
                                      fontFamily: 'Catamaran',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Text(
                                  _dog.height,
                                  style: TextStyle(
                                    color: Colors.lightGreen[800],
                                    fontSize: 14,
                                    fontFamily: 'Catamaran',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 150,
                      margin: const EdgeInsets.all(4),
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 0),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.2),
                      ).copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomImageView(
                            imagePath:
                                ImageConstant.imgHealthiconsWeightOutline,
                            height: 32,
                            width: 34,
                            margin: const EdgeInsets.only(
                              top: 3,
                              bottom: 16,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 1),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 50),
                                    child: Text(
                                      "Weight :",
                                      style: TextStyle(
                                        color: Colors.lightGreen[800],
                                        fontSize: 15,
                                        fontFamily: 'Catamaran',
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                                Text(
                                  _dog.weight,
                                  style: TextStyle(
                                    color: Colors.lightGreen[800],
                                    fontSize: 13,
                                    fontFamily: 'Catamaran',
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 19),
          ],
        ),
      ),
    );
  }
}

class CustomButtonStyles {
  // Filled button style
  static ButtonStyle get fillPurpleCc => ElevatedButton.styleFrom(
        backgroundColor: Colors.purple[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      );
  // text button style
  static ButtonStyle get none => ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        elevation: MaterialStateProperty.all<double>(0),
      );
}

// ignore: must_be_immutable
class CustomImageView extends StatelessWidget {
  ///[imagePath] is required parameter for showing image
  String? imagePath;

  double? height;
  double? width;
  Color? color;
  BoxFit? fit;
  final String placeHolder;
  Alignment? alignment;
  VoidCallback? onTap;
  EdgeInsetsGeometry? margin;
  BorderRadius? radius;
  BoxBorder? border;

  ///a [CustomImageView] it can be used for showing any type of images
  /// it will shows the placeholder image if image is not found on network image
  CustomImageView({
    super.key,
    this.imagePath,
    this.height,
    this.width,
    this.color,
    this.fit,
    this.alignment,
    this.onTap,
    this.radius,
    this.margin,
    this.border,
    this.placeHolder =
        'https://static.displate.com/324x454/displate/2023-07-07/36564f7949ef83fec3743ccd3bbcabc2_20665b5530dd3d5737abad41cda98d27.avif',
  });

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment!,
            child: _buildWidget(),
          )
        : _buildWidget();
  }

  Widget _buildWidget() {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        child: _buildCircleImage(),
      ),
    );
  }

  ///build the image with border radius
  _buildCircleImage() {
    if (radius != null) {
      return ClipRRect(
        borderRadius: radius ?? BorderRadius.zero,
        child: _buildImageWithBorder(),
      );
    } else {
      return _buildImageWithBorder();
    }
  }

  ///build the image with border and border radius style
  _buildImageWithBorder() {
    if (border != null) {
      return Container(
        decoration: BoxDecoration(
          border: border,
          borderRadius: radius,
        ),
        child: _buildImageView(),
      );
    } else {
      return _buildImageView();
    }
  }

  Widget _buildImageView() {
    if (imagePath != null) {
      switch (imagePath!.imageType) {
        case ImageType.svg:
          return SizedBox(
            height: height,
            width: width,
            child: SvgPicture.asset(
              imagePath!,
              height: height,
              width: width,
              fit: fit ?? BoxFit.contain,
              colorFilter:
                  ColorFilter.mode(color ?? Colors.black, BlendMode.srcIn),
            ),
          );
        case ImageType.file:
          return Image.file(
            File(imagePath!),
            height: height,
            width: width,
            fit: fit ?? BoxFit.cover,
            color: color,
          );
        case ImageType.network:
          return CachedNetworkImage(
            height: height,
            width: width,
            fit: fit,
            imageUrl: imagePath!,
            color: color,
            placeholder: (context, url) => SizedBox(
              height: 30,
              width: 30,
              child: LinearProgressIndicator(
                color: Colors.grey.shade200,
                backgroundColor: Colors.grey.shade100,
              ),
            ),
            errorWidget: (context, url, error) => Image.asset(
              placeHolder,
              height: height,
              width: width,
              fit: fit ?? BoxFit.cover,
            ),
          );
        case ImageType.png:
        default:
          return Image.asset(
            imagePath!,
            height: height,
            width: width,
            fit: fit ?? BoxFit.cover,
            color: color,
          );
      }
    }
    return const SizedBox();
  }
}

extension ImageTypeExtension on String {
  ImageType get imageType {
    if (startsWith('http') || startsWith('https')) {
      return ImageType.network;
    } else if (endsWith('.svg')) {
      return ImageType.svg;
    } else if (startsWith('file://')) {
      return ImageType.file;
    } else {
      return ImageType.png;
    }
  }
}

enum ImageType { svg, png, network, file, unknown }

class BorderRadiusStyle {
  // Rounded borders
  static BorderRadius get roundedBorder10 => BorderRadius.circular(
        10,
      );
}

class ImageConstant {
  // Image folder path
  static String imagePath = 'assets/images';

  // Homepage - Container images

  // Result images
  static String imgGroup10 = '$imagePath/img_group_10.svg';

  static String imgTeenyiconsTickOutline =
      '$imagePath/img_teenyicons_tick_outline.svg';

  static String imgMaterialSymbol = '$imagePath/img_material_symbol.svg';

  static String imgIconParkOutli = '$imagePath/img_icon_park_outli.svg';

  static String imgHealthiconsWeightOutline =
      '$imagePath/img_healthicons_weight_outline.svg';

  static String imgIconoirBirthdayCake =
      '$imagePath/img_iconoir_birthday_cake.svg';

  static String imgSolarhealthlineduotone =
      '$imagePath/img_solarhealthlineduotone.svg';

  static String imageNotFound = 'assets/images/image_not_found.png';
}

class CustomElevatedButton extends BaseButton {
  CustomElevatedButton({
    super.key,
    this.decoration,
    this.leftIcon,
    this.rightIcon,
    EdgeInsets? margin,
    VoidCallback? onPressed,
    ButtonStyle? buttonStyle,
    Alignment? alignment,
    TextStyle? buttonTextStyle,
    bool? isDisabled,
    double? height,
    double? width,
    required String text,
  }) : super(
          text: text,
          onPressed: onPressed,
          buttonStyle: buttonStyle,
          isDisabled: isDisabled,
          buttonTextStyle: buttonTextStyle,
          height: height,
          width: width,
          alignment: alignment,
          margin: margin,
        );

  final BoxDecoration? decoration;

  final Widget? leftIcon;

  final Widget? rightIcon;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: buildElevatedButtonWidget,
          )
        : buildElevatedButtonWidget;
  }

  Widget get buildElevatedButtonWidget => Container(
        height: this.height ?? 53,
        width: this.width ?? double.maxFinite,
        margin: margin,
        decoration: decoration,
        child: ElevatedButton(
          style: buttonStyle,
          onPressed: isDisabled ?? false ? null : onPressed ?? () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              leftIcon ?? const SizedBox.shrink(),
              Text(
                text,
                style: buttonTextStyle ??
                    TextStyle(
                      color: Colors.deepPurple[200],
                      fontSize: 15,
                      fontFamily: 'Catamaran',
                      fontWeight: FontWeight.w500,
                    ),
              ),
              rightIcon ?? const SizedBox.shrink(),
            ],
          ),
        ),
      );
}

class BaseButton extends StatelessWidget {
  BaseButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.buttonStyle,
    this.buttonTextStyle,
    this.isDisabled,
    this.height,
    this.width,
    this.margin,
    this.alignment,
  }) : super(
          key: key,
        );

  final String text;

  final VoidCallback? onPressed;

  final ButtonStyle? buttonStyle;

  final TextStyle? buttonTextStyle;

  final bool? isDisabled;

  final double? height;

  final double? width;

  final EdgeInsets? margin;

  final Alignment? alignment;

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    Key? key,
    this.alignment,
    this.height,
    this.width,
    this.padding,
    this.decoration,
    this.child,
    this.onTap,
  }) : super(
          key: key,
        );

  final Alignment? alignment;

  final double? height;

  final double? width;

  final EdgeInsetsGeometry? padding;

  final BoxDecoration? decoration;

  final Widget? child;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: iconButtonWidget,
          )
        : iconButtonWidget;
  }

  Widget get iconButtonWidget => SizedBox(
        height: height ?? 0,
        width: width ?? 0,
        child: IconButton(
          padding: EdgeInsets.zero,
          icon: Container(
            height: height ?? 0,
            width: width ?? 0,
            padding: padding ?? EdgeInsets.zero,
            decoration: decoration,
            child: child,
          ),
          onPressed: onTap,
        ),
      );
}
