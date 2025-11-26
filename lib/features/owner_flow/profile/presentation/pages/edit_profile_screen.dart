import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/common/widgets/button/custome_button_widgets.dart';
import '../../domain/entities/user_profile_entity.dart';
import '../cubit/profile_cubit.dart';

class EditProfileScreen extends StatelessWidget {
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();
    UserProfileEntity? currentUser;
    final currentState = cubit.state;
    if (currentState is ProfileLoaded) {
      currentUser = currentState.user;
    } else if (currentState is ProfileUpdated) {
      currentUser = currentState.user;
    }
    final TextEditingController emailController = TextEditingController(
        text: currentUser?.email ?? ''
    );
    final TextEditingController nameController = TextEditingController(
        text: currentUser?.name ?? ''
    );

    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileUpdated) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('updaeted')),
          );
          Navigator.pop(context);
        }
        if (state is ProfileError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('error: ${state.message}')),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is ProfileLoading;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  SizedBox(height: 10.h),
                  Center(
                    child: CircleAvatar(
                      radius: 60.r,
                      backgroundColor: Color(0xFFBBE9E3),
                      child: Text(
                        currentUser != null ? currentUser.name[0].toUpperCase() : "?",
                        style: TextStyle(
                          fontSize: 48.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 112.h),
                  Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: emailController,
                          enabled: !isLoading,
                          decoration: InputDecoration(
                            label: Text("Email"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18.r),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter Your Email!";
                            } else if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                              return "Enter a valid email!";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 26.h),
                        TextFormField(
                          controller: nameController,
                          enabled: !isLoading,
                          decoration: InputDecoration(
                            label: Text("Name"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18.r),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter Your Name!";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 60.h),
                  isLoading
                      ? CircularProgressIndicator()
                      : CustomeButtonWidgets(
                    titel: 'Update',
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        final updatedUser = UserProfileEntity(
                          authId: currentUser!.authId,
                          email: emailController.text,
                          name: nameController.text,
                          id: currentUser.id,
                            createdAt: currentUser.createdAt

                        );
                        cubit.updateUserProfile(updatedUser);
                      }
                    },
                    buttonWidth: 366.w,
                    buttonhight: 58.h,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }}