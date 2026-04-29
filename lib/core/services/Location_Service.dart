import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<bool> checkAndRequestLocationService() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return false;
    }

    return await checkAndRequestLocationPermission();
  }
  Future<bool> checkAndRequestLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      return false;
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return false;
      }
    }

    return true;
  }
  Future<Position?> getLocation() async {
    final hasAccess = await checkAndRequestLocationService();
    if (!hasAccess) return null;

    try {
      return await Geolocator.getCurrentPosition(
       locationSettings: LocationSettings(
         accuracy: LocationAccuracy.low
       )
      );
    } catch (e) {
      return null;
    }
  }
}