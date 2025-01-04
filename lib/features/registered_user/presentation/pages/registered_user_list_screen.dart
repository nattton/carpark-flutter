import 'package:carpark/features/registered_user/domain/entity/registered_user.dart';
import 'package:carpark/features/registered_user/presentation/bloc/registered_user_list/registered_user_list_bloc.dart';
import 'package:carpark/features/registered_user/presentation/bloc/smart_card/smart_card_bloc.dart';
import 'package:carpark/features/registered_user/presentation/widget/registered_user_create.dart';
import 'package:carpark/features/registered_user/presentation/widget/registered_user_list_card.dart';
import 'package:carpark/features/registered_user/presentation/widget/registered_user_list_header.dart';
import 'package:carpark/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisteredUserListScreen extends StatefulWidget {
  const RegisteredUserListScreen({super.key});

  @override
  State<RegisteredUserListScreen> createState() =>
      _RegisteredUserListScreenState();

  static Widget get page => MultiBlocProvider(
        providers: [
          BlocProvider<RegisteredUserListBloc>(
            create: (context) =>
                RegisteredUserListBloc(sl())..add(GetRegisteredUserList()),
          ),
          BlocProvider<SmartCardBloc>(
            create: (context) => SmartCardBloc(),
          ),
        ],
        child: const RegisteredUserListScreen(),
      );
}

class _RegisteredUserListScreenState extends State<RegisteredUserListScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<RegisteredUserListBloc, RegisteredUserListState, bool>(
      selector: (state) => state is RegisteredUserListCreating,
      builder: (context, state) {
        if (state) {
          return const RegisteredUserCreate();
        }
        return Column(
          children: [
            _buildSearchBar(),
            const RegisteredUserListHeader(),
            Expanded(child:
                BlocBuilder<RegisteredUserListBloc, RegisteredUserListState>(
              builder: (context, state) {
                if (state is RegisteredUserListCreating) {
                  return const RegisteredUserCreate();
                } else if (state is RegisteredUserListLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is RegisteredUserListSuccess) {
                  return _buildList(state.registeredUsers);
                } else if (state is RegisteredUserListFailure) {
                  return Center(
                    child: Text(state.message),
                  );
                }
                return Container();
              },
            )),
          ],
        );
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
                contentPadding:
                    const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              context
                  .read<RegisteredUserListBloc>()
                  .add(CreateRegisteredUser());
            },
            child: const Text('Add'),
          ),
        ),
      ],
    );
  }

  Widget _buildList(List<RegisteredUser> registeredUsers) {
    return ListView.builder(
      itemCount: registeredUsers.length,
      itemBuilder: (context, index) {
        return RegisteredUserListCard(
            user: registeredUsers[index], onTap: () {});
      },
    );
  }

  onSearchTextChanged(String text) async {
    context.read<RegisteredUserListBloc>().add(SearchRegisteredUser(text));
  }
}
