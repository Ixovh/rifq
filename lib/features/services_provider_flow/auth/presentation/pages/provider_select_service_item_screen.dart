import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:rifq/core/routes/base_routes.dart';
import 'package:rifq/core/theme/app_theme.dart';
import 'package:rifq/features/owner_flow/auth/presentation/widgets/container_button.dart';
import 'package:rifq/features/owner_flow/auth/presentation/widgets/custom_form_builder_text_field.dart';
import 'package:rifq/features/services_provider_flow/auth/presentation/cubit/provider_auth_cubit.dart';

class ProviderSelectServiceItemScreen extends StatelessWidget {
  const ProviderSelectServiceItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProviderAuthCubit>();
    final formKey = GlobalKey<FormBuilderState>();

    return BlocConsumer<ProviderAuthCubit, ProviderAuthState>(
      listener: (context, state) {
        switch (state) {
          case ProviderAuthServiceItemAddedSuccessState _:
            context.go(Routes.providerHome);
            break;
          case ProviderAuthErrorState _:
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.msg)));
            break;
          default:
            break;
        }
      },
      builder: (context, state) {
        final isLoading = state is ProviderAuthLoadingState;

        return Scaffold(
          backgroundColor: context.neutral100,
          appBar: AppBar(
            title: Text(
              'Add Service Item',
              style: context.h5.copyWith(color: context.primary400),
            ),
            backgroundColor: context.neutral100,
            elevation: 0,
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: FormBuilder(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24.h),
                    Text(
                      'Please add at least one service item with name, description, and price:',
                      style: context.body1.copyWith(fontSize: 16.sp),
                    ),
                    SizedBox(height: 32.h),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomFormBuilderTextField(
                              name: 'name',
                              label: 'Service Name',
                              iconData: Icons.label_outline,
                              validators: [
                                FormBuilderValidators.required(
                                  errorText: 'Service name is required.',
                                ),
                              ],
                            ),
                            SizedBox(height: 24.h),
                            FormBuilderTextField(
                              name: 'description',
                              maxLines: 5,
                              cursorColor: context.neutral1000,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.r,
                                  vertical: 15.r,
                                ),
                                prefixIcon: Icon(
                                  Icons.description_outlined,
                                  color: const Color(0xFF949494),
                                ),
                                labelText: 'Description',
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
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                  errorText: 'Description is required.',
                                ),
                              ]),
                            ),
                            SizedBox(height: 24.h),
                            CustomFormBuilderTextField(
                              name: 'price',
                              label: 'Price',
                              iconData: Icons.attach_money,
                              validators: [
                                FormBuilderValidators.required(
                                  errorText: 'Price is required.',
                                ),
                                FormBuilderValidators.numeric(
                                  errorText: 'Please enter a valid number.',
                                ),
                                (value) {
                                  if (value != null && value.isNotEmpty) {
                                    final price = double.tryParse(value);
                                    if (price == null || price <= 0) {
                                      return 'Price must be greater than zero.';
                                    }
                                  }
                                  return null;
                                },
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    ContainerButton(
                      label: 'Add Service Item',
                      containerColor: context.primary300,
                      textColor: context.neutral100,
                      fontSize: 20,
                      onTap: isLoading
                          ? null
                          : () {
                              if (formKey.currentState?.saveAndValidate() ??
                                  false) {
                                final formData = formKey.currentState!.value;
                                final providerId = cubit.providerId;

                                if (providerId == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Provider ID not found'),
                                    ),
                                  );
                                  return;
                                }

                                cubit.addServiceItem(
                                  providerId: providerId,
                                  name: formData['name'] as String,
                                  description:
                                      formData['description'] as String,
                                  price: double.parse(
                                    formData['price'] as String,
                                  ),
                                );
                              }
                            },
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
