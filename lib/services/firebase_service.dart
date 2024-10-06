import 'package:firebase_remote_config/firebase_remote_config.dart';

class FirebaseService {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  FirebaseService() {
    _initializeRemoteConfig();
  }

  // Initialize Remote Config with default values
  Future<void> _initializeRemoteConfig() async {
    try {
      await _remoteConfig.setDefaults({
        'showDiscountedPrice': false, // Default value
      });

      // Fetch and activate the latest config values from Firebase
      await _remoteConfig.fetchAndActivate();
    } catch (e) {
      print('Error initializing Remote Config: $e');
    }
  }

  // Method to get the 'showDiscountedPrice' value
  Future<bool> getShowDiscountedPrice() async {
    try {
      // Set config settings to ensure quick fetches with no caching
      await _remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),  // Set fetch timeout
        minimumFetchInterval: const Duration(seconds: 0),  // Force fetch without caching
      ));

      // Fetch the latest config
      bool fetched = await _remoteConfig.fetchAndActivate();

      // Return the boolean value for 'showDiscountedPrice'
      return _remoteConfig.getBool('showDiscountedPrice');
    } catch (e) {
      print('Error fetching Remote Config value: $e');
      return false; // Return a default value in case of error
    }
  }
}
