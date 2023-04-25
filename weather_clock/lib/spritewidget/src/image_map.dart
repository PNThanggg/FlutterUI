part of spritewidget;

/// The ImageMap is a helper class for loading and keeping references to
/// multiple images.
class ImageMap {
  /// Creates a new ImageMap where images will be loaded from the specified
  /// [bundle], or from the [rootBundle] if no bundle is provided.
  ImageMap({AssetBundle? bundle}) : _bundle = bundle ?? rootBundle;

  final AssetBundle _bundle;
  final _images = <String, ui.Image>{};

  /// Loads a list of images given their urls.
  Future<List<ui.Image>> load(List<String> urls) {
    return Future.wait(urls.map(loadImage));
  }

  /// Loads a single image given the image's [url] and adds it to the
  /// [ImageMap].
  Future<ui.Image> loadImage(String url) async {
    ImageStream stream =
        AssetImage(url, bundle: _bundle).resolve(ImageConfiguration.empty);
    Completer<ui.Image> completer = Completer<ui.Image>();
    late ImageStreamListener listener;
    listener = ImageStreamListener((ImageInfo frame, bool synchronousCall) {
      final ui.Image image = frame.image;
      _images[url] = image;
      completer.complete(image);
      stream.removeListener(listener);
    });
    stream.addListener(listener);
    return completer.future;
  }

  /// Returns a preloaded image, given its [url].
  ui.Image? getImage(String url) => _images[url];

  /// Returns a preloaded image, given its [url].
  ui.Image? operator [](String url) => _images[url];
}
