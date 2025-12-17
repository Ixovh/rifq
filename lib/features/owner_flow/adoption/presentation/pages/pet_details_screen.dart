import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:rifq/core/theme/app_theme.dart';
import 'package:rifq/features/owner_flow/adoption/presentation/cubit/adoption_cubit.dart';
import 'package:rifq/features/owner_flow/auth/presentation/widgets/custom_form_builder_text_field.dart';
import 'package:rifq/features/owner_flow/add_pet/domain/entities/add_pet_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PetDetailsScreen extends StatelessWidget {
  final AddPetEntity pet;

  const PetDetailsScreen({super.key, required this.pet});

  String _calculateAge(DateTime birthdate) {
    final now = DateTime.now();
    final difference = now.difference(birthdate);
    final years = difference.inDays / 365.25;

    if (years < 1.0) {
      final months = (difference.inDays / 30.44).round();
      if (months < 1) {
        return '1 month';
      }
      return '$months month${months == 1 ? '' : 's'}';
    }

    final formattedYears = years.toStringAsFixed(1);
    final cleanYears = formattedYears.endsWith('.0')
        ? formattedYears.substring(0, formattedYears.length - 2)
        : formattedYears;

    return '$cleanYears year';
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AdoptionCubit>();

    return Scaffold(
      backgroundColor: context.background,
      appBar: AppBar(
        backgroundColor: context.background,
        title: Text(
          pet.name,
          style: context.body1.copyWith(color: context.primary300),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: context.primary300),
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocConsumer<AdoptionCubit, AdoptionState>(
        listener: (context, state) {
          if (state is AdoptionRequestSent) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Adoption request sent successfully'),
                backgroundColor: context.success,
              ),
            );
            context.pop();
          }
          if (state is AdoptionError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: context.error,
              ),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Pet Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: Image.network(
                    pet.photoUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 300.h,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 300.h,
                        color: context.neutral100,
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/icon/logo.svg',
                            colorFilter: ColorFilter.mode(
                              context.neutral400,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 24.h),

                // Pet Info
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      pet.name,
                      style: context.h4.copyWith(color: context.neutral1000),
                    ),
                    SizedBox(width: 8.w),
                    Icon(
                      pet.gender == 'male' ? Icons.male : Icons.female,
                      color: context.secondary100,
                      size: 28.r,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      pet.breed,
                      style: context.body1.copyWith(color: context.neutral500),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 18.r,
                      color: context.primary300,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      _calculateAge(pet.birthdate),
                      style: context.body1.copyWith(color: context.neutral500),
                    ),
                  ],
                ),
                SizedBox(height: 32.h),

                // Owner Phone Number (if available)
                FutureBuilder<String?>(
                  future: _getOwnerPhoneNumber(context, pet.ownerId),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                CupertinoIcons.phone_solid,
                                size: 18.r,
                                color: context.primary300,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                snapshot.data!,
                                style: context.body1.copyWith(
                                  color: context.neutral500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 32.h),
                        ],
                      );
                    }
                    return SizedBox.shrink();
                  },
                ),

                // Adoption Request Form
                Text(
                  'Send Adoption Request',
                  style: context.h5.copyWith(color: context.neutral1000),
                ),
                SizedBox(height: 16.h),

                FormBuilder(
                  key: cubit.adoptionRequestFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title Field
                      CustomFormBuilderTextField(
                        name: 'phone number',
                        label: 'Phone Number',
                        iconData: CupertinoIcons.phone_solid,
                        controller: cubit.adoptionRequestPhoneNumberController,
                        validators: [
                          FormBuilderValidators.required(
                            errorText: 'Please enter a phone number',
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),

                      // Description Field
                      FormBuilderTextField(
                        name: 'description',
                        controller: cubit.adoptionRequestDescriptionController,
                        cursorColor: context.neutral1000,
                        maxLines: 5,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.r,
                            vertical: 15.r,
                          ),
                          prefixIcon: Icon(
                            CupertinoIcons.text_alignleft,
                            color: const Color(0xFF949494),
                          ),
                          labelText: 'Description',
                          hintText:
                              'Tell the owner why you want to adopt this pet',
                          filled: true,
                          fillColor: context.neutral100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.r),
                            borderSide: const BorderSide(
                              color: Color(0xFF949494),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.r),
                            borderSide: BorderSide(
                              color: context.neutral700,
                              width: 1,
                            ),
                          ),
                          alignLabelWithHint: true,
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                            errorText: 'Please enter a description',
                          ),
                        ]),
                      ),
                      SizedBox(height: 24.h),

                      // Submit Button
                      SizedBox(
                        width: double.infinity,
                        height: 50.h,
                        child: ElevatedButton(
                          onPressed: state is AdoptionLoading
                              ? null
                              : () {
                                  if (cubit.adoptionRequestFormKey.currentState
                                          ?.saveAndValidate() ??
                                      false) {
                                    cubit.sendAdoptionRequest(
                                      petId: pet.id,
                                      phone: cubit
                                          .adoptionRequestPhoneNumberController
                                          .text
                                          .trim(),
                                      description: cubit
                                          .adoptionRequestDescriptionController
                                          .text
                                          .trim(),
                                    );
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: context.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          child: state is AdoptionLoading
                              ? CircularProgressIndicator(color: context.neutral300)
                              : Text(
                                  'Send Request',
                                  style: context.body1.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<String?> _getOwnerPhoneNumber(
    BuildContext context,
    String ownerId,
  ) async {
    try {
      final response = await Supabase.instance.client
          .from('users')
          .select('phone')
          .eq('id', ownerId)
          .maybeSingle();

      if (response == null) {
        return null;
      }

      return response['phone'] as String?;
    } catch (e) {
      return null;
    }
  }
}
