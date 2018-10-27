import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';

Future<void> getCurrentLocation() async {
  var currentLocation = <String, double>{};

  var location = new Location();

// Platform messages may fail, so we use a try/catch PlatformException.
  try {
    currentLocation = await location.getLocation();
    final coordinates = new Coordinates(
        currentLocation['latitude'], currentLocation['longitude']);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print("${first.featureName} : ${first.addressLine}");
  } catch (e) {
    currentLocation = null;
  }
}
