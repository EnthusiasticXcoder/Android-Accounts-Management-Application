import 'package:my_app/services/services.dart';

class NodeBloc extends Bloc<NodeEvent, NodeState> {
  NodeBloc(DatabaseService service) : super(const NodeLoadingState(true)) {
    // Initialise Event
    on<NodeEventInitialise>(
      (event, emit) async {
        try {
          // start loading
          emit(const NodeLoadingState(true));
          await service.initialiseUser();
        } on NoUsersFoundinDatabase {
          // stop Loading
          emit(const NodeLoadingState(false));
          emit(const NodeStateCreateUser());
          return;
        }
        await service.initialiseNodes();

        // stop Loading
        emit(const NodeLoadingState(false));

        emit(
          NodeStateUserExist(
            currentUser: service.currentUser,
            allUsers: service.getAllUsers,
          ),
        );
      },
    );

    // Create User Event
    on<NodeEventCreateUser>(
      (event, emit) async {
        // start loading
        emit(const NodeLoadingState(true));
        await service.createUser(
          username: event.username,
          info: event.info,
        );

        await service.initialiseNodes();
        String name = service.currentUser.name;

        // cloase loading
        emit(const NodeLoadingState(false));
        emit(
          NodeStateUserExist(
            currentUser: service.currentUser,
            allUsers: service.getAllUsers,
            message: 'User Created $name',
          ),
        );
      },
    );

    // Delete User Event
    on<NodeEventDeleteUser>(
      (event, emit) async {
        try {
          emit(const NodeLoadingState(true));
          await service.deleteUser(event.userId);

          String name = service.currentUser.name;

          emit(const NodeLoadingState(false));
          emit(NodeStateUserExist(
            currentUser: service.currentUser,
            allUsers: service.getAllUsers,
            message: 'User Deleted, Login as $name',
          ));
        } on AllUserDeleted {
          emit(const NodeLoadingState(false));
          emit(const NodeStateCreateUser());
        } on Exception {
          // error message
          emit(const NodeLoadingState(false));
          String name = service.currentUser.name;
          emit(
            NodeStateUserExist(
              currentUser: service.currentUser,
              allUsers: service.getAllUsers,
              message: 'Unable TO Deleted User, Login as $name',
            ),
          );
        }
      },
    );

    // Update User Event
    on<NodeEventUpdateUser>((event, emit) async {
      // start loading
      emit(const NodeLoadingState(true));

      await service.updateUser(
        id: service.currentUser.id,
        imagePath: event.imagePath,
        info: event.info,
        name: event.name,
      );
      // stop Loading
      emit(const NodeLoadingState(false));
      emit(
        NodeStateUserExist(
          allUsers: service.getAllUsers,
          currentUser: service.currentUser,
        ),
      );
    });

    // Change Active USer
    on<NodeEventChangeActiveUser>((event, emit) async {
      // Start Loading
      emit(const NodeLoadingState(true));
      await service.changeActiveUser(event.user);

      await service.initialiseNodes();
      // stop Loading
      emit(const NodeLoadingState(false));

      String name = service.currentUser.name;

      emit(
        NodeStateUserExist(
          allUsers: service.getAllUsers,
          currentUser: service.currentUser,
          message: 'User Changed, Logged In as $name',
        ),
      );
    });
  }
}
