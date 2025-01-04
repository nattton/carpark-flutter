import 'package:carpark/features/registered_user/presentation/bloc/registered_user_list/registered_user_list_bloc.dart';
import 'package:carpark/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisteredUserListScreen extends StatefulWidget {
  const RegisteredUserListScreen({super.key});

  @override
  State<RegisteredUserListScreen> createState() =>
      _RegisteredUserListScreenState();

  static Widget get page => BlocProvider<RegisteredUserListBloc>(
        create: (context) =>
            RegisteredUserListBloc(sl())..add(GetRegisteredUserList()),
        child: const RegisteredUserListScreen(),
      );
}

class _RegisteredUserListScreenState extends State<RegisteredUserListScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisteredUserListBloc, RegisteredUserListState>(
      builder: (context, state) {
        if (state is RegisteredUserListLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is RegisteredUserListSuccess) {
          return ListView.builder(
            itemCount: state.registeredUsers.length,
            itemBuilder: (context, index) {
              return Text(state.registeredUsers[index].thaiName);
            },
          );
        } else if (state is RegisteredUserListFailure) {
          return Center(
            child: Text(state.message),
          );
        }
        return Container();
      },
    );
  }
}
