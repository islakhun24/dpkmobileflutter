import '../fragment/dashboardFrag.dart';
import '../fragment/acceptanceFrag.dart';
import '../fragment/checkerFrag.dart';
typedef T Constructor<T>();

final Map<String, Constructor<Object>> _constructors = <String, Constructor<Object>>{};

void register<T>(Constructor<T> constructor) {
  _constructors[T.toString()] = constructor as Constructor<Object>;
}

class ClassBuilder {
  static void registerClasses() {
    register<DashboardFrag>(() => DashboardFrag());
    register<AcceptanceFrag>(() => AcceptanceFrag());
    register<CheckerFrag>(() => CheckerFrag());
  }

  static dynamic fromString(String type) {
    if (_constructors[type] != null) return _constructors[type]!();
  }
}