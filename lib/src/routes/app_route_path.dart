enum AppRoute {
  loading("/loading"),
  login("/login"),
  register("/register"),
  market("/market"),
  details("/coin-details"),
  wallet("/wallet"),
  settings("/settings");

  final String path;
  const AppRoute(this.path);
}
