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
import '../../dao/dao_user.dart';
import '../../apis/api_task.dart';
import '../../dao/dao_task.dart';
import '../database/tables/db_tasks.dart';
import '../database/tables/db_users.dart';
import '../../utils/env_custom.dart';

class Injects {
  static Future<DependencyInjector> initialize() async {
    var di = DependencyInjector();
    var dbTasksTable = await EnvCustom.get<String>(key: 'db_tasks_table');
    var dbTasksId = await EnvCustom.get<String>(key: 'db_tasks_table');
    var dbTasksTitle = await EnvCustom.get<String>(key: 'db_tasks_table');
    var dbTasksDescription = await EnvCustom.get<String>(key: 'db_tasks_table');
    var dbTasksIdAssignee = await EnvCustom.get<String>(key: 'db_tasks_table');
    var dbTasksIdUser = await EnvCustom.get<String>(key: 'db_tasks_table');
    var dbTasksStatus = await EnvCustom.get<String>(key: 'db_tasks_table');
    var dbTasksSubtitle = await EnvCustom.get<String>(key: 'db_tasks_table');
    var dbUsersTable = await EnvCustom.get<String>(key: 'db_tasks_table');
    var dbUsersId = await EnvCustom.get<String>(key: 'db_users_id');
    var dbUsersName = await EnvCustom.get<String>(key: 'db_users_name');
    var dbUsersLocation = await EnvCustom.get<String>(key: 'db_users_location');
    var dbUsersPassword = await EnvCustom.get<String>(key: 'db_users_password');
    var dbUsersEmail = await EnvCustom.get<String>(key: 'db_users_email');
    var dbUsersIsActive =
        await EnvCustom.get<String>(key: 'db_users_is_active');

    di.register<DBTasks>(() => DBTasks(
        table: dbTasksTable,
        title: dbTasksTitle,
        subtitle: dbTasksSubtitle,
        status: dbTasksStatus,
        description: dbTasksDescription,
        idAssignee: dbTasksIdAssignee,
        id: dbTasksId,
        idUser: dbTasksIdUser));
    di.register<DBUsers>(() => DBUsers(
          table: dbUsersTable,
          name: dbUsersName,
          password: dbUsersPassword,
          location: dbUsersLocation,
          isActive: dbUsersIsActive,
          email: dbUsersEmail,
          id: dbUsersId,
        ));

    di.register<DBConfiguration>(() => MariadbDBConfiguration());
    di.register<DaoUser>(() => DaoUser(
        dbConfiguration: di<DBConfiguration>(), dbUsers: di<DBUsers>()));
    di.register<DaoTask>(() => DaoTask(
        dbConfiguration: di<DBConfiguration>(), dbTasks: di<DBTasks>()));
    di.register<ServiceTask>(() => ServiceTask(di<DaoTask>()));
    di.register<ServiceLogin>(() => ServiceLogin(di<DaoUser>()));
    di.register<ServiceSignUp>(() => ServiceSignUp(di<DaoUser>()));
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
