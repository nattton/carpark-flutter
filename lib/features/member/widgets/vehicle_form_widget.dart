import 'package:carpark/features/member/view_models/member_viewmodel.dart';
import 'package:carpark/shared/injector/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';

class VehicleFormWidget extends WatchingWidget {
  const VehicleFormWidget({super.key});

  MemberViewModel get _memberViewModel => getIt<MemberViewModel>();

  @override
  Widget build(BuildContext context) {
    final vehicle = watchValue(
      (MemberViewModel viewModel) => viewModel.vehicleEditing,
    );

    return Column(
      children: [
        const SizedBox(height: 8),
        TextFormField(
          initialValue: vehicle?.plateNumber ?? '',
          autocorrect: false,
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            labelText: 'เลขทะเบียน',
            suffixIcon: const Icon(Icons.text_format),
            contentPadding: const EdgeInsets.all(20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onChanged: (value) {
            _memberViewModel.vehicleEditing.value = _memberViewModel
                .vehicleEditing
                .value
                ?.copyWith(
                  plateNumber: value,
                );
          },
        ),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: vehicle?.resemble ?? '',
          autocorrect: false,
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            labelText: 'เลขทะเบียนที่คล้าย',
            suffixIcon: const Icon(Icons.text_format),
            contentPadding: const EdgeInsets.all(20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onChanged: (value) {
            _memberViewModel.vehicleEditing.value = _memberViewModel
                .vehicleEditing
                .value
                ?.copyWith(
                  resemble: value,
                );
          },
        ),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: vehicle?.plateProvince ?? '',
          autocorrect: false,
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            labelText: 'จังหวัด',
            suffixIcon: const Icon(Icons.text_fields),
            contentPadding: const EdgeInsets.all(20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onChanged: (value) {
            _memberViewModel.vehicleEditing.value = _memberViewModel
                .vehicleEditing
                .value
                ?.copyWith(
                  plateProvince: value,
                );
          },
        ),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: vehicle?.brand ?? '',
          autocorrect: false,
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            labelText: 'ยี่ห้อ',
            suffixIcon: const Icon(Icons.text_fields),
            contentPadding: const EdgeInsets.all(20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onChanged: (value) {
            _memberViewModel.vehicleEditing.value = _memberViewModel
                .vehicleEditing
                .value
                ?.copyWith(
                  brand: value,
                );
          },
        ),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: vehicle?.color ?? '',
          autocorrect: false,
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            labelText: 'สี',
            suffixIcon: const Icon(Icons.text_fields),
            contentPadding: const EdgeInsets.all(20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onChanged: (value) {
            _memberViewModel.vehicleEditing.value = _memberViewModel
                .vehicleEditing
                .value
                ?.copyWith(
                  color: value,
                );
          },
        ),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: vehicle?.telephone ?? '',
          autocorrect: false,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            labelText: 'โทร.',
            suffixIcon: const Icon(Icons.phone),
            contentPadding: const EdgeInsets.all(20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onChanged: (value) {
            _memberViewModel.vehicleEditing.value = _memberViewModel
                .vehicleEditing
                .value
                ?.copyWith(
                  telephone: value,
                );
          },
        ),
      ],
    );
  }
}
