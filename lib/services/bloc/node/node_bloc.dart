import 'package:my_app/services/services.dart';

class NodeBloc extends Bloc<NodeEvent, NodeState> {
  NodeBloc(DatabaseService service) : super(const NodeLoadingState()) {
    // Initialise Event
    on<NodeEventInitialise>(
      (event, emit) async {
        try {
          emit(const NodeLoadingState());
          await service.initialiseUser();
        } on NoUsersFoundinDatabase {
          emit(const NodeStateCreateUser());
          return;
        }
        await service.initialiseNodes();
        emit(NodeStateUserExist(
          currentUser: service.currentUser,
          allUsers: service.getAllUsers,
        ));
      },
    );

    // Create User Event
    on<NodeEventCreateUser>(
      (event, emit) async {
        emit(const NodeLoadingState());
        await service.createUser(
          username: event.username,
          info: event.info,
          imagePath: event.imagePath,
        );

        await service.initialiseNodes();
        String name = service.currentUser.name;
        emit(NodeStateUserExist(
          currentUser: service.currentUser,
          allUsers: service.getAllUsers,
          message: 'User Created $name',
        ));
      },
    );

    // Delete User Event
    on<NodeEventDeleteUser>(
      (event, emit) async {
        try {
          emit(const NodeLoadingState());
          await service.deleteUser(event.userId);

          String name = service.currentUser.name;
          emit(NodeStateUserExist(
            currentUser: service.currentUser,
            allUsers: service.getAllUsers,
            message: 'User Deleted, Login as $name',
          ));
        } on AllUserDeleted {
          emit(const NodeStateCreateUser());
        } on Exception {
          // error message

          String name = service.currentUser.name;
          emit(NodeStateUserExist(
            currentUser: service.currentUser,
            allUsers: service.getAllUsers,
            message: 'Unable TO Deleted User, Login as $name',
          ));
        }
      },
    );

    // Update User Event
    on<NodeEventUpdateUser>((event, emit) async {
      await service.updateUser(
        id: event.id,
        imagePath: event.imagePath,
        info: event.info,
        name: event.name,
      );

      emit(NodeStateUserExist(
        allUsers: service.getAllUsers,
        currentUser: service.currentUser,
      ));
    });

    // Change Active USer
    on<NodeEventChangeActiveUser>((event, emit) async {
      await service.changeActiveUser(event.user);

      String name = service.currentUser.name;
      emit(NodeStateUserExist(
        allUsers: service.getAllUsers,
        currentUser: service.currentUser,
        message: 'User Changed, Loggedin as $name',
      ));
    });
  }
}
