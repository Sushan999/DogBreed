import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';
import 'package:readmore/readmore.dart';
import 'dart:io';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.symmetric(vertical: 49),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
                      color: Colors.green[300],
                      borderRadius: BorderRadius.circular(
                        4,
                      ),
                    ),
                  ),
                  Container(
                    height: 8,
                    width: 8,
                    margin: const EdgeInsets.only(left: 11),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[100],
                      borderRadius: BorderRadius.circular(
                        4,
                      ),
                    ),
                  ),
                  Container(
                    height: 8,
                    width: 8,
                    margin: const EdgeInsets.only(left: 12),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[100],
                      borderRadius: BorderRadius.circular(
                        4,
                      ),
                    ),
                  ),
                  Container(
                    height: 8,
                    width: 8,
                    margin: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[100],
                      borderRadius: BorderRadius.circular(
                        4,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Card(
                clipBehavior: Clip.antiAlias,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusStyle.roundedBorder10,
                ),
                child: Container(
                  height: 440,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusStyle.roundedBorder10,
                  ),
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      _buildDogDetails(context),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          margin: const EdgeInsets.only(
                            left: 30,
                            top: 383,
                            right: 200,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 2,
                          ),
                          decoration: AppDecoration.fillPrimary.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder10,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomImageView(
                                imagePath: ImageConstant.imgIconoirBirthdayCake,
                                height: 32.adaptSize,
                                width: 32.adaptSize,
                                margin: EdgeInsets.only(
                                  top: 2.v,
                                  bottom: 17.v,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 20.h,
                                  top: 1.v,
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      "Life Expectancy",
                                      style: CustomTextStyles.titleSmall14,
                                    ),
                                    SizedBox(height: 2.v),
                                    Text(
                                      "12 to 14 years",
                                      style: theme.textTheme.titleSmall,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      CustomElevatedButton(
                        width: 167.h,
                        text: "Dog Health",
                        margin: EdgeInsets.only(right: 24.h),
                        leftIcon: Container(
                          margin: EdgeInsets.only(right: 23.h),
                          child: CustomImageView(
                            imagePath: ImageConstant.imgSolarhealthlineduotone,
                            height: 32.adaptSize,
                            width: 32.adaptSize,
                          ),
                        ),
                        buttonStyle: const ButtonStyle(),
                        alignment: Alignment.bottomRight,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      actions: [
        AppbarTrailingIconbutton(
          imagePath: ImageConstant.imgGroup10,
          margin: EdgeInsets.symmetric(horizontal: 13.h),
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildDogDetails(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 15.h,
          vertical: 6.v,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 94.v,
              width: 321.h,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      height: 19.v,
                      width: 23.h,
                      margin: EdgeInsets.only(top: 5.v),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: 19.v,
                              width: 23.h,
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary,
                                borderRadius: BorderRadius.circular(
                                  11.h,
                                ),
                              ),
                            ),
                          ),
                          CustomImageView(
                            imagePath: ImageConstant.imgTeenyiconsTickOutline,
                            height: 15.adaptSize,
                            width: 15.adaptSize,
                            alignment: Alignment.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 94.v,
                      width: 309.h,
                      child: Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              "With 99.74 % accuracy, the doggo is a",
                              style: CustomTextStyles.titleMediumLightgreen700,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 4.h,
                                bottom: 19.v,
                              ),
                              child: Text(
                                "Siberian Husky",
                                style: theme.textTheme.headlineMedium,
                              ),
                            ),
                          ),
                          CustomImageView(
                            imagePath: ImageConstant.imgMaterialSymbol,
                            height: 38.adaptSize,
                            width: 38.adaptSize,
                            alignment: Alignment.centerRight,
                            margin: EdgeInsets.only(right: 80.h),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Row(
                              children: [
                                Container(
                                  width: 82.h,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 9.h,
                                    vertical: 1.v,
                                  ),
                                  decoration:
                                      AppDecoration.fillBlueGray.copyWith(
                                    borderRadius:
                                        BorderRadiusStyle.roundedBorder10,
                                  ),
                                  child: Text(
                                    "Working Dog",
                                    style: CustomTextStyles.bodySmallBlack900,
                                  ),
                                ),
                                Container(
                                  height: 23.v,
                                  width: 87.h,
                                  margin: EdgeInsets.only(left: 16.h),
                                  child: Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Container(
                                          height: 23.v,
                                          width: 87.h,
                                          decoration: BoxDecoration(
                                            color: appTheme.blueGray100,
                                            borderRadius: BorderRadius.circular(
                                              10.h,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Text(
                                          "Purebred Dog",
                                          style: CustomTextStyles
                                              .bodySmallBlack900,
                                        ),
                                      ),
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
                ],
              ),
            ),
            SizedBox(height: 12.v),
            Padding(
              padding: EdgeInsets.only(left: 15.h),
              child: Text(
                "Breed Traits and Characteristics",
                style: theme.textTheme.titleLarge,
              ),
            ),
            SizedBox(height: 2.v),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 324.h,
                child: ReadMoreText(
                  "Siberian Husky, a thickly coated, compact sled dog of medium size and great endurance, was developed to work in packs, pulling light loads at moderate speeds over vast frozen expanses. Huskies are friendly, fastidious, and dignified. The graceful, medium-sized Siberian Husky's almond-shaped eyes can be either brown or blue'¿and sometimes one of ea ...",
                  trimLines: 7,
                  colorClickableText: appTheme.black900,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: "Read more",
                  moreStyle: CustomTextStyles.titleSmallBlack900.copyWith(
                    height: 1.40,
                  ),
                  lessStyle: CustomTextStyles.titleSmallBlack900.copyWith(
                    height: 1.40,
                  ),
                ),
              ),
            ),
            SizedBox(height: 9.v),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 13.h,
                  right: 5.h,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 162.h,
                      padding: EdgeInsets.symmetric(vertical: 4.v),
                      decoration: AppDecoration.fillPrimary.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomImageView(
                            imagePath: ImageConstant.imgIconParkOutli,
                            height: 31.adaptSize,
                            width: 31.adaptSize,
                            margin: EdgeInsets.only(
                              top: 6.v,
                              bottom: 15.v,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 2.v),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 20.h),
                                  child: Text(
                                    "Height :",
                                    style: theme.textTheme.titleSmall,
                                  ),
                                ),
                                Text(
                                  "20 to 23.5 inches",
                                  style: theme.textTheme.titleSmall,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 171.h,
                      margin: EdgeInsets.only(left: 9.h),
                      padding: EdgeInsets.symmetric(vertical: 4.v),
                      decoration: AppDecoration.fillPrimary.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomImageView(
                            imagePath:
                                ImageConstant.imgHealthiconsWeightOutline,
                            height: 32.adaptSize,
                            width: 32.adaptSize,
                            margin: EdgeInsets.only(
                              top: 4.v,
                              bottom: 16.v,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 1.v),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 20.h),
                                    child: Text(
                                      "Weight :",
                                      style: theme.textTheme.titleSmall,
                                    ),
                                  ),
                                ),
                                Text(
                                  "35 to 60 pounds",
                                  style: theme.textTheme.titleSmall,
                                ),
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
            SizedBox(height: 19.v),
          ],
        ),
      ),
    );
  }
}

class CustomButtonStyles {
  // Filled button style
  static ButtonStyle get fillPurpleCc => ElevatedButton.styleFrom(
        backgroundColor: appTheme.purple100Cc,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.h),
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
    this.placeHolder = 'assets/images/image_not_found.png',
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
          return Container(
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
            placeholder: (context, url) => Container(
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
    return SizedBox();
  }
}

extension ImageTypeExtension on String {
  ImageType get imageType {
    if (this.startsWith('http') || this.startsWith('https')) {
      return ImageType.network;
    } else if (this.endsWith('.svg')) {
      return ImageType.svg;
    } else if (this.startsWith('file://')) {
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

class AppDecoration {
  // Fill decorations
  static BoxDecoration get fillBlueGray => BoxDecoration(
        color: appTheme.blueGray100,
      );
  static BoxDecoration get fillOnPrimaryContainer => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
      );
  static BoxDecoration get fillPrimary => BoxDecoration(
        color: theme.colorScheme.primary,
      );
}

class ImageConstant {
  // Image folder path
  static String imagePath = 'assets/images';

  // Homepage - Container images
  static String imgSearch = '$imagePath/img_search.png';

  static String imgPawprint = '$imagePath/img_pawprint.png';

  static String imgImage = '$imagePath/img_image.png';

  static String imgImage167x138 = '$imagePath/img_image_167x138.png';

  static String imgRectangle561 = '$imagePath/img_rectangle_561.png';

  static String imgForward = '$imagePath/img_forward.png';

  static String imgRectangle562 = '$imagePath/img_rectangle_562.png';

  static String imgRectangle564 = '$imagePath/img_rectangle_564.png';

  static String imgNavHome = '$imagePath/img_nav_home.png';

  static String imgNavBreedsGray600 = '$imagePath/img_nav_breeds_gray_600.svg';

  static String imgNavCamera = '$imagePath/img_nav_camera.svg';

  static String imgNavSaved = '$imagePath/img_nav_saved.png';

  static String imgNavCare = '$imagePath/img_nav_care.svg';

  // Breeds Page images
  static String imgSearchLightGreen700 =
      '$imagePath/img_search_light_green_700.svg';

  static String imgRectangle567 = '$imagePath/img_rectangle_567.png';

  static String imgRectangle568 = '$imagePath/img_rectangle_568.png';

  static String imgRectangle569 = '$imagePath/img_rectangle_569.png';

  static String imgRectangle570 = '$imagePath/img_rectangle_570.png';

  static String imgRectangle571 = '$imagePath/img_rectangle_571.png';

  static String imgRectangle572 = '$imagePath/img_rectangle_572.png';

  static String imgRectangle573 = '$imagePath/img_rectangle_573.png';

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

const num FIGMA_DESIGN_WIDTH = 390;
const num FIGMA_DESIGN_HEIGHT = 844;
const num FIGMA_DESIGN_STATUS_BAR = 0;
typedef ResponsiveBuild = Widget Function(
  BuildContext context,
  Orientation orientation,
  DeviceType deviceType,
);

class Sizer extends StatelessWidget {
  const Sizer({
    Key? key,
    required this.builder,
  }) : super(key: key);

  /// Builds the widget whenever the orientation changes.
  final ResponsiveBuild builder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeUtils.setScreenSize(constraints, orientation);
        return builder(context, orientation, SizeUtils.deviceType);
      });
    });
  }
}

class SizeUtils {
  /// Device's BoxConstraints
  static late BoxConstraints boxConstraints;

  /// Device's Orientation
  static late Orientation orientation;

  /// Type of Device
  ///
  /// This can either be mobile or tablet
  static late DeviceType deviceType;

  /// Device's Height
  static late double height = 844;

  /// Device's Width
  static late double width = 390;

  static void setScreenSize(
    BoxConstraints constraints,
    Orientation currentOrientation,
  ) {
    // Sets boxConstraints and orientation
    boxConstraints = constraints;
    orientation = currentOrientation;

    // Sets screen width and height
    if (orientation == Orientation.portrait) {
      width =
          boxConstraints.maxWidth.isNonZero(defaultValue: FIGMA_DESIGN_WIDTH);
      height = boxConstraints.maxHeight.isNonZero();
    } else {
      width =
          boxConstraints.maxHeight.isNonZero(defaultValue: FIGMA_DESIGN_WIDTH);
      height = boxConstraints.maxWidth.isNonZero();
    }
    deviceType = DeviceType.mobile;
  }
}

/// This extension is used to set padding/margin (for the top and bottom side) &
/// height of the screen or widget according to the Viewport height.
extension ResponsiveExtension on num {
  /// This method is used to get device viewport width.
  double get _width => SizeUtils.width;

  /// This method is used to get device viewport height.
  double get _height => SizeUtils.height;

  /// This method is used to set padding/margin (for the left and Right side) &
  /// width of the screen or widget according to the Viewport width.
  double get h => ((this * _width) / FIGMA_DESIGN_WIDTH);

  /// This method is used to set padding/margin (for the top and bottom side) &
  /// height of the screen or widget according to the Viewport height.
  double get v =>
      (this * _height) / (FIGMA_DESIGN_HEIGHT - FIGMA_DESIGN_STATUS_BAR);

  /// This method is used to set smallest px in image height and width
  double get adaptSize {
    var height = v;
    var width = h;
    return height < width ? height.toDoubleValue() : width.toDoubleValue();
  }

  /// This method is used to set text font size according to Viewport
  double get fSize => adaptSize;
}

extension FormatExtension on double {
  /// Return a [double] value with formatted according to provided fractionDigits
  double toDoubleValue({int fractionDigits = 2}) {
    return double.parse(this.toStringAsFixed(fractionDigits));
  }

  double isNonZero({num defaultValue = 0.0}) {
    return this > 0 ? this : defaultValue.toDouble();
  }
}

enum DeviceType { mobile, tablet, desktop }

String _appTheme = "primary";

/// Helper class for managing themes and colors.
class ThemeHelper {
  // A map of custom color themes supported by the app
  Map<String, PrimaryColors> _supportedCustomColor = {
    'primary': PrimaryColors()
  };

// A map of color schemes supported by the app
  Map<String, ColorScheme> _supportedColorScheme = {
    'primary': ColorSchemes.primaryColorScheme
  };

  /// Changes the app theme to [_newTheme].
  void changeTheme(String _newTheme) {
    _appTheme = _newTheme;
  }

  /// Returns the primary colors for the current theme.
  PrimaryColors _getThemeColors() {
    //throw exception to notify given theme is not found or not generated by the generator
    if (!_supportedCustomColor.containsKey(_appTheme)) {
      throw Exception(
          "$_appTheme is not found.Make sure you have added this theme class in JSON Try running flutter pub run build_runner");
    }
    //return theme from map

    return _supportedCustomColor[_appTheme] ?? PrimaryColors();
  }

  /// Returns the current theme data.
  ThemeData _getThemeData() {
    //throw exception to notify given theme is not found or not generated by the generator
    if (!_supportedColorScheme.containsKey(_appTheme)) {
      throw Exception(
          "$_appTheme is not found.Make sure you have added this theme class in JSON Try running flutter pub run build_runner");
    }
    //return theme from map

    var colorScheme =
        _supportedColorScheme[_appTheme] ?? ColorSchemes.primaryColorScheme;
    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
      textTheme: TextThemes.textTheme(colorScheme),
      scaffoldBackgroundColor: colorScheme.onPrimaryContainer.withOpacity(1),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.h),
          ),
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      dividerTheme: DividerThemeData(
        thickness: 1,
        space: 1,
        color: appTheme.blueGray100.withOpacity(0.8),
      ),
    );
  }

  /// Returns the primary colors for the current theme.
  PrimaryColors themeColor() => _getThemeColors();

  /// Returns the current theme data.
  ThemeData themeData() => _getThemeData();
}

/// Class containing the supported text theme styles.
class TextThemes {
  static TextTheme textTheme(ColorScheme colorScheme) => TextTheme(
        bodySmall: TextStyle(
          color: appTheme.lightGreen800,
          fontSize: 12.fSize,
          fontFamily: 'Catamaran',
          fontWeight: FontWeight.w300,
        ),
        headlineLarge: TextStyle(
          color: appTheme.black900,
          fontSize: 32.fSize,
          fontFamily: 'Livvic',
          fontWeight: FontWeight.w900,
        ),
        headlineMedium: TextStyle(
          color: appTheme.black900,
          fontSize: 29.fSize,
          fontFamily: 'Catamaran',
          fontWeight: FontWeight.w700,
        ),
        labelLarge: TextStyle(
          color: appTheme.blueGray400,
          fontSize: 12.fSize,
          fontFamily: 'DM Sans',
          fontWeight: FontWeight.w500,
        ),
        titleLarge: TextStyle(
          color: appTheme.black900,
          fontSize: 20.fSize,
          fontFamily: 'Catamaran',
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          color: appTheme.black900,
          fontSize: 18.fSize,
          fontFamily: 'Catamaran',
          fontWeight: FontWeight.w600,
        ),
        titleSmall: TextStyle(
          color: appTheme.lightGreen800,
          fontSize: 15.fSize,
          fontFamily: 'Catamaran',
          fontWeight: FontWeight.w500,
        ),
      );
}

/// Class containing the supported color schemes.
class ColorSchemes {
  static final primaryColorScheme = ColorScheme.light(
    // Primary colors
    primary: Color(0XFFEEF7E8),

    // On colors(text colors)
    onPrimary: Color(0XFF9747FF),
    onPrimaryContainer: Color(0XCEFFFFFF),
  );
}

/// Class containing custom colors for a primary theme.
class PrimaryColors {
  // Black
  Color get black900 => Color(0XFF000000);

  // BlueGray
  Color get blueGray100 => Color(0XFFD9D9D9);
  Color get blueGray400 => Color(0XFF8B8B8B);

  // DeepPurple
  Color get deepPurpleA200 => Color(0XFF964FF3);

  // Gray
  Color get gray200 => Color(0XFFE9E9E9);
  Color get gray50 => Color(0XFFF8F8F8);
  Color get gray600 => Color(0XFF777777);

  // LightGreen
  Color get lightGreen700 => Color(0XFF61AF2B);
  Color get lightGreen800 => Color(0XFF50981D);

  // PurpleCc
  Color get purple100Cc => Color(0XCCF6C6FB);
}

PrimaryColors get appTheme => ThemeHelper().themeColor();
ThemeData get theme => ThemeHelper().themeData();

class CustomTextStyles {
  // Body text style
  static get bodySmallBlack900 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.black900,
        fontWeight: FontWeight.w400,
      );
  static get bodySmallBlack900ExtraLight => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.black900,
        fontSize: 11.fSize,
        fontWeight: FontWeight.w200,
      );
  // Label text style
  static get labelLargeCatamaranBlack900 =>
      theme.textTheme.labelLarge!.catamaran.copyWith(
        color: appTheme.black900.withOpacity(0.87),
        fontSize: 13.fSize,
        fontWeight: FontWeight.w600,
      );
  static get labelLargeCatamaranBlack90013 =>
      theme.textTheme.labelLarge!.catamaran.copyWith(
        color: appTheme.black900,
        fontSize: 13.fSize,
      );
  static get labelLargeCatamaranBlack900SemiBold =>
      theme.textTheme.labelLarge!.catamaran.copyWith(
        color: appTheme.black900,
        fontSize: 13.fSize,
        fontWeight: FontWeight.w600,
      );
  static get labelLargeCatamaranLightgreen700 =>
      theme.textTheme.labelLarge!.catamaran.copyWith(
        color: appTheme.lightGreen700,
        fontSize: 13.fSize,
        fontWeight: FontWeight.w600,
      );
  static get labelLargeCatamaranLightgreen700_1 =>
      theme.textTheme.labelLarge!.catamaran.copyWith(
        color: appTheme.lightGreen700,
      );
  static get labelLargeLightgreen700 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.lightGreen700.withOpacity(0.7),
      );
  static get labelLargeLightgreen700_1 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.lightGreen700.withOpacity(0.78),
      );
  // Title text style
  static get titleLargeBlack900 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.black900.withOpacity(0.89),
      );
  static get titleMedium19 => theme.textTheme.titleMedium!.copyWith(
        fontSize: 19.fSize,
      );
  static get titleMediumBlack900 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.black900.withOpacity(0.96),
        fontSize: 19.fSize,
      );
  static get titleMediumLightgreen700 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.lightGreen700.withOpacity(0.8),
      );
  static get titleMedium_1 => theme.textTheme.titleMedium!;
  static get titleSmall14 => theme.textTheme.titleSmall!.copyWith(
        fontSize: 14.fSize,
      );
  static get titleSmallBlack900 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.black900,
      );
  static get titleSmallBlack900SemiBold => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.black900,
        fontSize: 14.fSize,
        fontWeight: FontWeight.w600,
      );
  static get titleSmallDeeppurpleA200 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.deepPurpleA200,
      );
  static get titleSmallLightgreen700 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.lightGreen700,
        fontWeight: FontWeight.w700,
      );
  static get titleSmallLightgreen700Bold =>
      theme.textTheme.titleSmall!.copyWith(
        color: appTheme.lightGreen700,
        fontWeight: FontWeight.w700,
      );
  static get titleSmallLightgreen700SemiBold =>
      theme.textTheme.titleSmall!.copyWith(
        color: appTheme.lightGreen700,
        fontWeight: FontWeight.w600,
      );
}

extension on TextStyle {
  TextStyle get dMSans {
    return copyWith(
      fontFamily: 'DM Sans',
    );
  }

  TextStyle get livvic {
    return copyWith(
      fontFamily: 'Livvic',
    );
  }

  TextStyle get catamaran {
    return copyWith(
      fontFamily: 'Catamaran',
    );
  }
}

class CustomElevatedButton extends BaseButton {
  CustomElevatedButton({
    Key? key,
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
        height: this.height ?? 53.v,
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
                    CustomTextStyles.titleSmallDeeppurpleA200,
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

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({
    Key? key,
    this.height,
    this.leadingWidth,
    this.leading,
    this.title,
    this.centerTitle,
    this.actions,
  }) : super(
          key: key,
        );

  final double? height;

  final double? leadingWidth;

  final Widget? leading;

  final Widget? title;

  final bool? centerTitle;

  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: height ?? 57.v,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      leadingWidth: leadingWidth ?? 0,
      leading: leading,
      title: title,
      titleSpacing: 0,
      centerTitle: centerTitle ?? false,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size(
        SizeUtils.width,
        height ?? 57.v,
      );
}

class AppbarTrailingIconbutton extends StatelessWidget {
  AppbarTrailingIconbutton({
    Key? key,
    this.imagePath,
    this.margin,
    this.onTap,
  }) : super(
          key: key,
        );

  String? imagePath;

  EdgeInsetsGeometry? margin;

  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap!.call();
      },
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: CustomIconButton(
          height: 57.v,
          width: 60.h,
          child: CustomImageView(
            imagePath: ImageConstant.imgGroup10,
          ),
        ),
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  CustomIconButton({
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
