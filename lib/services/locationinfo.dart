import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';

Future<Address> getCurrentLocation() async {
  var currentLocation = <String, double>{};

  var location = new Location();
  var first;

// Platform messages may fail, so we use a try/catch PlatformException.
  try {
    currentLocation = await location.getLocation();
    final coordinates = new Coordinates(
        currentLocation['latitude'], currentLocation['longitude']);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    first = addresses.first;  
  } catch (e) {
    print(e);
  }
  return first;
}

