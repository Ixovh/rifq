import 'dart:io';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../domain/entities/provider_profile_entity.dart';
import '../../domain/usecases/provider_profile_usecase.dart';

part 'provider_profile_state.dart';

class ProviderProfileCubit extends Cubit<ProviderProfileState> {
  final ProviderProfileUsecase usecase;

  // Form key and controllers
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final locationController = TextEditingController();
  final commercialRegisterController = TextEditingController();
  final locationUrlController = TextEditingController();

  // Uploaded image URL
  String? uploadedImageUrl;

  ProviderProfileCubit(this.usecase) : super(ProviderProfileInitial());

  void initializeControllers(ProviderProfileEntity provider) {
    nameController.text = provider.name;
    emailController.text = provider.email;
    phoneController.text = provider.phone;
    locationController.text = provider.location;
    commercialRegisterController.text = provider.commercialRegister;
    locationUrlController.text = provider.locationUrl;
    uploadedImageUrl = provider.image;
  }

  void clearControllers() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    locationController.clear();
    commercialRegisterController.clear();
    locationUrlController.clear();
    uploadedImageUrl = null;
  }

  Future<void> getProviderProfile(String authId) async {
    emit(ProviderProfileLoading());
    final result = await usecase.getProviderProfile(authId);
    result.when((success) {
      initializeControllers(success);
      emit(ProviderProfileLoaded(success));
    }, (error) => emit(ProviderProfileError(error)));
  }

  Future<void> updateProfile(
    String providerId,
    ProviderProfileEntity currentProvider,
  ) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    emit(ProviderProfileLoading());

    // Use uploaded image URL if available, otherwise keep existing image
    final imageUrl = uploadedImageUrl ?? currentProvider.image;

    final updatedProvider = ProviderProfileEntity(
      authId: currentProvider.authId,
      email: emailController.text,
      name: nameController.text,
      phone: phoneController.text,
      location: locationController.text,
      commercialRegister: commercialRegisterController.text,
      locationUrl: locationUrlController.text,
      image: imageUrl,
      id: currentProvider.id,
      createdAt: currentProvider.createdAt,
    );

    final result = await usecase.updateProviderProfile(updatedProvider);
    result.when((success) {
      initializeControllers(success);
      emit(ProviderProfileUpdated(success));
    }, (error) => emit(ProviderProfileError(error)));
  }

  Future<void> pickAndUploadImage(String providerId) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return;

      emit(ProviderProfileLoading());
      final imageFile = File(pickedFile.path);

      final result = await usecase.uploadImage(providerId, imageFile);
      result.when((success) {
        uploadedImageUrl = success;
        emit(ProviderProfileImageUploaded(success));
      }, (error) => emit(ProviderProfileError(error)));
    } catch (e) {
      emit(ProviderProfileError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    locationController.dispose();
    commercialRegisterController.dispose();
    locationUrlController.dispose();
    return super.close();
  }
}
