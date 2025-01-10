import 'dart:io';

import 'package:carpark/features/registered_user/domain/entity/registered_user.dart';
import 'package:carpark/features/registered_user/presentation/bloc/registered_user_create/registered_user_create_bloc.dart';
import 'package:carpark/features/registered_user/presentation/bloc/registered_user_list/registered_user_list_bloc.dart';
import 'package:carpark/features/registered_user/presentation/bloc/registered_user_update/registered_user_update_bloc.dart';
import 'package:carpark/features/registered_user/presentation/pages/registered_user_create.dart';
import 'package:carpark/features/registered_user/presentation/pages/registered_user_logs_screen.dart';
import 'package:carpark/features/registered_user/presentation/pages/registered_user_update.dart';
import 'package:carpark/features/registered_user/presentation/widget/registered_user_list_header.dart';
import 'package:carpark/features/registered_user/presentation/widget/registered_user_list_row.dart';
import 'package:carpark/injector/injector.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
            create: (context) => getIt<RegisteredUserCreateBloc>()
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
            return const RegisteredUserUpdate();
          default:
            return Column(
              children: [
                _buildSearchBar(),
                const RegisteredUserListHeader(),
                Expanded(child: BlocBuilder<RegisteredUserListBloc,
                    RegisteredUserListState>(
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
              _registeredUserListBloc.add(RegisteredUserCreateScreen());
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
        return RegisteredUserRow(
            user: registeredUsers[index],
            onTapViewLogs: () {
              Navigator.pushNamed(context, RegisteredUserLogsScreen.routeName,
                  arguments: registeredUsers[index].id);
            },
            onTapQR: () async {
              final user = registeredUsers[index];
              String filename =
                  "${user.idCard}_${user.thaiName}_${user.engName}.png"
                      .replaceAll(" ", "_");

              String? outputFile = await FilePicker.platform.saveFile(
                dialogTitle: 'Please select an output file:',
                fileName: filename,
              );

              if (outputFile != null) {
                final file = File(outputFile);
                ByteData? qrBytes = await QrPainter(
                  data: user.generatedId,
                  version: QrVersions.auto,
                ).toImageData(878);
                if (qrBytes != null) {
                  final buffer = qrBytes.buffer;
                  file.writeAsBytes(buffer.asUint8List(
                      qrBytes.offsetInBytes, qrBytes.lengthInBytes));
                }
              }
            },
            onEditTap: () {
              _registeredUserListBloc.add(RegisteredUserUpdateScreen());
              _registeredUserUpdateBloc
                  .add(GetRegisteredUser(registeredUsers[index].id));
            });
      },
    );
  }

  onSearchTextChanged(String text) async {
    context.read<RegisteredUserListBloc>().add(SearchRegisteredUser(text));
  }
}
