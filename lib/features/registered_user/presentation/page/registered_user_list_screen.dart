import 'package:carpark/features/registered_user/domain/entity/registered_user.dart';
import 'package:carpark/features/registered_user/presentation/bloc/registered_user_create/registered_user_create_bloc.dart';
import 'package:carpark/features/registered_user/presentation/bloc/registered_user_list/registered_user_list_bloc.dart';
import 'package:carpark/features/registered_user/presentation/bloc/registered_user_update/registered_user_update_bloc.dart';
import 'package:carpark/features/registered_user/presentation/page/registered_user_create.dart';
import 'package:carpark/features/registered_user/presentation/page/registered_user_logs_screen.dart';
import 'package:carpark/features/registered_user/presentation/page/registered_user_update_screen.dart';
import 'package:carpark/features/registered_user/presentation/widget/registered_user_list_header_widget.dart';
import 'package:carpark/features/registered_user/presentation/widget/registered_user_list_row_widget.dart';
import 'package:carpark/injector/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RegisteredUserListScreen extends StatefulWidget {
  const RegisteredUserListScreen({super.key});

  @override
  State<RegisteredUserListScreen> createState() =>
      _RegisteredUserListScreenState();

  static Widget get page => MultiBlocProvider(
    providers: [
      BlocProvider<RegisteredUserListBloc>(
        create: (context) =>
            getIt<RegisteredUserListBloc>()..add(GetRegisteredUserList()),
      ),
      BlocProvider<RegisteredUserCreateBloc>(
        create: (context) =>
            getIt<RegisteredUserCreateBloc>()
              ..add(InitialCreateRegisteredUser()),
      ),
      BlocProvider<RegisteredUserUpdateBloc>(
        create: (context) => getIt<RegisteredUserUpdateBloc>(),
      ),
    ],
    child: const RegisteredUserListScreen(),
  );
}

class _RegisteredUserListScreenState extends State<RegisteredUserListScreen> {
  late RegisteredUserListBloc _registeredUserListBloc;
  late RegisteredUserUpdateBloc _registeredUserUpdateBloc;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _registeredUserListBloc = context.read<RegisteredUserListBloc>();
    _registeredUserUpdateBloc = context.read<RegisteredUserUpdateBloc>();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisteredUserListBloc, RegisteredUserListState>(
      builder: (context, state) {
        switch (state) {
          case RegisteredUserListCreating():
            return const RegisteredUserCreate();
          case RegisteredUserListUpdating():
            return const RegisteredUserUpdateScreen();
          default:
            return Column(
              children: [
                _buildSearchBar(),
                const RegisteredUserListHeaderWidget(),
                Expanded(
                  child: Builder(
                    builder: (context) {
                      switch (state) {
                        case RegisteredUserListInitial():
                          return const SizedBox();
                        case RegisteredUserListCreating():
                          return const RegisteredUserCreate();
                        case RegisteredUserListLoading():
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        case RegisteredUserListSuccess(:final registeredUsers):
                          return _buildList(registeredUsers);
                        case RegisteredUserListFailure(:final message):
                          return Center(child: Text(message));
                        default:
                          return const SizedBox();
                      }
                    },
                  ),
                ),
              ],
            );
        }
      },
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              autofocus: false,
              autocorrect: false,
              controller: _searchController,
              onChanged: onSearchTextChanged,
              decoration: InputDecoration(
                labelText: 'Search',
                suffixIcon: GestureDetector(
                  onTap: () {
                    _searchController.clear();
                    onSearchTextChanged('');
                  },
                  child: const Icon(Icons.clear),
                ),
                contentPadding: const EdgeInsets.all(20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: () {
              _registeredUserListBloc.add(RegisteredUserCreating());
            },
            icon: const Icon(Icons.person_add),
            tooltip: 'สร้างผู้ติดต่อใหม่',
          ),
        ),
      ],
    );
  }

  Widget _buildList(List<RegisteredUser> registeredUsers) {
    return ListView.builder(
      itemCount: registeredUsers.length,
      itemBuilder: (context, index) {
        return RegisteredUserRowWidget(
          user: registeredUsers[index],
          onTapViewLogs: () {
            context.push(
              "${RegisteredUserLogsScreen.routeName}/${registeredUsers[index].id}",
            );
          },
          onEditTap: () {
            _registeredUserListBloc.add(RegisteredUserUpdating());
            _registeredUserUpdateBloc.add(
              GetRegisteredUser(registeredUsers[index].id),
            );
          },
        );
      },
    );
  }

  void onSearchTextChanged(String text) {
    _registeredUserListBloc.add(SearchRegisteredUser(text));
  }
}
