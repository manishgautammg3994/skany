part of "app_pages.dart";

abstract class Routes {
  static const splash = _Path.splash;
  // static const exploreVideos = _Path.exploreVideos;
  static const home = _Path.home;
  // static const videoView = _Path.videoView;

}

abstract class _Path {
  static const splash =
      "/splash/"; //never forget to add / before thenamed routes unless it will not work
  // static const exploreVideos = "/explorevideos/";
  static const home = "/home/";
  // static const videoView = "/video/";
}
