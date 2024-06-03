import 'package:get_it/get_it.dart';
import 'package:social_media_app/authservice.dart';
import 'package:social_media_app/firestoreservice.dart';

final locator = GetIt.instance;

void setup() {
  locator.registerSingleton<AuthService>(AuthService());
  locator.registerSingleton<FirestoreService>(FirestoreService());
}
