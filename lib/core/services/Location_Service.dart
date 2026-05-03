import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

@injectable
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

    Position? currentPosition;
    Future<Position?> getLocation() async {
      final hasAccess = await checkAndRequestLocationService();
      if (!hasAccess) return null;

      try {
        currentPosition = await Geolocator.getCurrentPosition(
          locationSettings: LocationSettings(
            accuracy: LocationAccuracy.medium,
            timeLimit: const Duration(seconds: 10),
          ),
        );
        return currentPosition;
      } catch (e) {
        currentPosition = await Geolocator.getLastKnownPosition();
        return currentPosition;
      }
    }
}