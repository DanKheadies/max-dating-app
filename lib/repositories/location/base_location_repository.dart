import 'package:max_dating_app/models/models.dart';

abstract class BaseLocationRepository {
  Future<Location?> getLocation(String location);
}
