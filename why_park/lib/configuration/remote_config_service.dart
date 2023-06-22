import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfig {

    RemoteConfig() {
      _initConfig();
    }

    final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;

    Future<void> _initConfig() async {
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(
            seconds: 1), // a fetch will wait up to 10 seconds before timing out
        minimumFetchInterval: const Duration(
            seconds:
            10), // fetch parameters will be cached for a maximum of 1 hour
      ));

      _fetchConfig();
    }

    // Fetching, caching, and activating remote config
    void _fetchConfig() async {
      await remoteConfig.fetchAndActivate();
    }
}