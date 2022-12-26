import 'package:organizer_client/shared/utils/get_location.dart';
import 'package:timezone/timezone.dart';

Future<DateTime> getTimestamp() async {
  final String address = await determineAddressFromPosition();
  print('address: $address');
  // get the current time at the device location using the location's latitude and longitude
  final location = getLocation(address);
  final now = TZDateTime.now(location);
  // convert now to DateTime.now
  final dateTime = DateTime.parse(now.toString());
  return dateTime;
}
