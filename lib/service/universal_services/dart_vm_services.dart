import 'dart:io';

import 'universal_services_base.dart';

class UniversalServices implements UniversalServicesBase {
  static final i = UniversalServices._();
  UniversalServices._();

  @override
  bool get isMobile => Platform.isAndroid || Platform.isIOS;

  @override
  void setWebPathStrategy() {}
}
