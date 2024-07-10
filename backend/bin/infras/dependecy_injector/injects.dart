import '../database/db_configuration.dart';
import '../database/mariadb_db_configuration.dart';
import './dependency_injector.dart';
import '../security/security_service_imp.dart';
import '../security/security_service.dart';
import '../../apis/api_login.dart';
import '../../apis/api_signup.dart';
import '../../services/service_generic.dart';
import '../../services/service_login.dart';
import '../../services/service_signup.dart';
import '../../services/service_task.dart';
import '../../dao/user_dao.dart';
import '../../apis/api_task.dart';
import '../../dao/task_dao.dart';

class Injects {
  static DependencyInjector initialize() {
    var di = DependencyInjector();

    di.register<DbConfiguration>(() => MariadbDbConfiguration());
    di.register<UserDao>(() => UserDao(di<DbConfiguration>()));
    di.register<TaskDao>(() => TaskDao(di<DbConfiguration>()));
    di.register<ServiceTask>(() => ServiceTask(di<TaskDao>()));
    di.register<ServiceLogin>(() => ServiceLogin(di<UserDao>()));
    di.register<ServiceSignUp>(() => ServiceSignUp(di<UserDao>()));
    di.register<SecurityService>(() => SecurityServiceImp());
    di.register<APILogin>(
        () => APILogin(di<SecurityService>(), di<ServiceLogin>()));
    di.register<APITask>(
        () => APITask(di<SecurityService>(), di<ServiceTask>()));
    di.register<APISignUp>(
        () => APISignUp(di<SecurityService>(), di<ServiceSignUp>()));

    return di;
  }
}
