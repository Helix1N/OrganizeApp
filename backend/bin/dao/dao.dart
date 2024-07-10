abstract class DAO<T> {
  Future create(T value);
  Future<T?> readOne(int id);
  Future<List<T?>> readAll();
  Future update(T value);
  Future delete(int id);
}
