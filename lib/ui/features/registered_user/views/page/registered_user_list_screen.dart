import 'dart:async';

import 'package:carpark/config/injector.dart';
import 'package:carpark/domain/models/registered_user.dart';
import 'package:carpark/routing/routes.dart';
import 'package:carpark/ui/features/registered_user/view_models/registered_user_create_viewmodel.dart';
import 'package:carpark/ui/features/registered_user/view_models/registered_user_list_viewmodel.dart';
import 'package:carpark/ui/features/registered_user/view_models/registered_user_update_viewmodel.dart';
import 'package:carpark/ui/features/registered_user/views/page/registered_user_create.dart';
import 'package:carpark/ui/features/registered_user/views/page/registered_user_update_screen.dart';
import 'package:carpark/ui/features/registered_user/views/registered_user_list_header_widget.dart';
import 'package:carpark/ui/features/registered_user/views/registered_user_list_row_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

class RegisteredUserListScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<RegisteredUserListScreen> createState() =>
      _RegisteredUserListScreenState();

  static Widget get page => const RegisteredUserListScreen();
}

class _RegisteredUserListScreenState extends State<RegisteredUserListScreen> {
  late final RegisteredUserListViewModel _listViewModel;
  late final RegisteredUserCreateViewModel _createViewModel;
  late final RegisteredUserUpdateViewModel _updateViewModel;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _listViewModel = getIt<RegisteredUserListViewModel>();
    _createViewModel = getIt<RegisteredUserCreateViewModel>()..initialize();
    _updateViewModel = getIt<RegisteredUserUpdateViewModel>();
    unawaited(_listViewModel.getRegisteredUserList());
  }

  @override
  void dispose() {
    _searchController.dispose();
    _listViewModel.dispose();
    _createViewModel.dispose();
    _updateViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _listViewModel,
      builder: (context, _) {
        switch (_listViewModel.mode) {
          case RegisteredUserListMode.creating:
            return RegisteredUserCreate(
              viewModel: _createViewModel,
              listViewModel: _listViewModel,
            );
          case RegisteredUserListMode.updating:
            return RegisteredUserUpdateScreen(
              viewModel: _updateViewModel,
              listViewModel: _listViewModel,
            );
          case RegisteredUserListMode.list:
            return Column(
              children: [
                _buildSearchBar(),
                const RegisteredUserListHeaderWidget(),
                Expanded(
                  child: Builder(
                    builder: (context) {
                      if (_listViewModel.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (_listViewModel.errorMessage != null) {
                        return Center(
                          child: Text(_listViewModel.errorMessage!),
                        );
                      }
                      return _buildList(_listViewModel.registeredUsers);
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
            padding: const EdgeInsets.all(8),
            child: TextField(
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
                contentPadding: const EdgeInsets.all(20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: IconButton(
            onPressed: () {
              _listViewModel.startCreating();
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
          onTapViewLogs: () async {
            await context.push(
              Routes.registeredUserLogsWithId(registeredUsers[index].id),
            );
          },
          onEditTap: () {
            _listViewModel.startUpdating();
            unawaited(
              _updateViewModel.getRegisteredUser(registeredUsers[index].id),
            );
          },
        );
      },
    );
  }

  void onSearchTextChanged(String text) {
    unawaited(_listViewModel.searchRegisteredUser(text));
  }
}
