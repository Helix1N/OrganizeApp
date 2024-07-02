typedef T InstanceCreator<T>();

class DependencyInjector {
  DependencyInjector._();

  static final _singleton = DependencyInjector._();
  factory DependencyInjector() => _singleton;

  final _instanceMap = Map<Type, _InstaceGenerator<Object>>();

  void register<T extends Object>(
    InstanceCreator<T> instance, {
    bool isSingleton = false,
  }) {
    _instanceMap[T] = _InstaceGenerator(instance, isSingleton);
  }

  T get<T extends Object>() {
    final instance = _instanceMap[T]?.getInstance();
    if (instance != null && instance is T) return instance;
    throw Exception("[ERROR] -> Instance ${T.toString()} not found");
  }
}

class _InstaceGenerator<T> {
  T? _instance;
  bool _isFirstGet = false;

  final InstanceCreator<T> _instanceCreator;

  _InstaceGenerator(this._instanceCreator, bool isSingleton)
      : _isFirstGet = isSingleton;

  T? getInstance() {
    if (_isFirstGet) {
      _instance = _instanceCreator();
      _isFirstGet = false;
    }

    return _instance ?? _instanceCreator();
  }
}
