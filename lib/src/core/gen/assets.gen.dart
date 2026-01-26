// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/android_studio.png
  AssetGenImage get androidStudio =>
      const AssetGenImage('assets/images/android_studio.png');

  /// File path: assets/images/bloc.png
  AssetGenImage get bloc => const AssetGenImage('assets/images/bloc.png');

  /// File path: assets/images/claude.png
  AssetGenImage get claude => const AssetGenImage('assets/images/claude.png');

  /// File path: assets/images/dart.jpeg
  AssetGenImage get dartJpeg => const AssetGenImage('assets/images/dart.jpeg');

  /// File path: assets/images/dart.jpg
  AssetGenImage get dartJpg => const AssetGenImage('assets/images/dart.jpg');

  /// File path: assets/images/docker.jpg
  AssetGenImage get docker => const AssetGenImage('assets/images/docker.jpg');

  /// File path: assets/images/express-js.png
  AssetGenImage get expressJs =>
      const AssetGenImage('assets/images/express-js.png');

  /// File path: assets/images/figma.png
  AssetGenImage get figma => const AssetGenImage('assets/images/figma.png');

  /// File path: assets/images/firebase.png
  AssetGenImage get firebase =>
      const AssetGenImage('assets/images/firebase.png');

  /// File path: assets/images/flutter.jpg
  AssetGenImage get flutter => const AssetGenImage('assets/images/flutter.jpg');

  /// File path: assets/images/getx.jpeg
  AssetGenImage get getx => const AssetGenImage('assets/images/getx.jpeg');

  /// File path: assets/images/git-hub.png
  AssetGenImage get gitHub => const AssetGenImage('assets/images/git-hub.png');

  /// File path: assets/images/git.jpg
  AssetGenImage get git => const AssetGenImage('assets/images/git.jpg');

  /// File path: assets/images/grapSql.png
  AssetGenImage get grapSql => const AssetGenImage('assets/images/grapSql.png');

  /// File path: assets/images/mongodb.png
  AssetGenImage get mongodb => const AssetGenImage('assets/images/mongodb.png');

  /// File path: assets/images/nest-js.jpg
  AssetGenImage get nestJs => const AssetGenImage('assets/images/nest-js.jpg');

  /// File path: assets/images/node-js.png
  AssetGenImage get nodeJs => const AssetGenImage('assets/images/node-js.png');

  /// File path: assets/images/postgreSQL.webp
  AssetGenImage get postgreSQL =>
      const AssetGenImage('assets/images/postgreSQL.webp');

  /// File path: assets/images/postman.jpg
  AssetGenImage get postman => const AssetGenImage('assets/images/postman.jpg');

  /// File path: assets/images/profile.jpg
  AssetGenImage get profile => const AssetGenImage('assets/images/profile.jpg');

  /// File path: assets/images/rest-api.jpg
  AssetGenImage get restApi =>
      const AssetGenImage('assets/images/rest-api.jpg');

  /// File path: assets/images/riverpod.png
  AssetGenImage get riverpod =>
      const AssetGenImage('assets/images/riverpod.png');

  /// File path: assets/images/vscode.jpg
  AssetGenImage get vscode => const AssetGenImage('assets/images/vscode.jpg');

  /// File path: assets/images/xcode.jpg
  AssetGenImage get xcode => const AssetGenImage('assets/images/xcode.jpg');

  /// List of all assets
  List<AssetGenImage> get values => [
    androidStudio,
    bloc,
    claude,
    dartJpeg,
    dartJpg,
    docker,
    expressJs,
    figma,
    firebase,
    flutter,
    getx,
    gitHub,
    git,
    grapSql,
    mongodb,
    nestJs,
    nodeJs,
    postgreSQL,
    postman,
    profile,
    restApi,
    riverpod,
    vscode,
    xcode,
  ];
}

class Assets {
  const Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
