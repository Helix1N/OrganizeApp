abstract class ServiceGeneric<T> {
  Future<T?> readOne(int id);
  Future<List<T?>> readAll();
  Future update(T value);
  Future create(T value);
  Future delete(int value);
}
