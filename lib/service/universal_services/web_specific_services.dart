import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'universal_services_base.dart';

class UniversalServices implements UniversalServicesBase {
  static final i = UniversalServices._();
  UniversalServices._();

  @override
  void setWebPathStrategy() {
    setUrlStrategy(PathUrlStrategy());
  }

  @override
  bool get isMobile => false;
}
