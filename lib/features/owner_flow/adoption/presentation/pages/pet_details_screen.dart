import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rifq/core/theme/app_theme.dart';
import 'package:rifq/features/owner_flow/adoption/presentation/cubit/adoption_cubit.dart';
import 'package:rifq/features/owner_flow/add_pet/domain/entities/add_pet_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PetDetailsScreen extends StatefulWidget {
  final AddPetEntity pet;

  const PetDetailsScreen({super.key, required this.pet});

  @override
  State<PetDetailsScreen> createState() => _PetDetailsScreenState();
}

class _PetDetailsScreenState extends State<PetDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _isSubmitting = false;

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

  Future<String?> _getCurrentUserId() async {
    try {
      final authUser = Supabase.instance.client.auth.currentUser;
      if (authUser == null) {
        return null;
      }

      final userResponse = await Supabase.instance.client
          .from('users')
          .select('id')
          .eq('auth_id', authUser.id)
          .maybeSingle();

      if (userResponse == null) {
        return null;
      }

      return userResponse['id'] as String;
    } catch (e) {
      return null;
    }
  }

  Future<void> _submitAdoptionRequest() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    final userId = await _getCurrentUserId();
    if (userId == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('User not logged in'),
            backgroundColor: context.error,
          ),
        );
      }
      setState(() {
        _isSubmitting = false;
      });
      return;
    }

    final cubit = context.read<AdoptionCubit>();
    await cubit.sendAdoptionRequest(
      petId: widget.pet.id,
      userId: userId,
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
    );

    setState(() {
      _isSubmitting = false;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.background,
      appBar: AppBar(
        backgroundColor: context.background,
        title: Text(
          widget.pet.name,
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
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Pet Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: Image.network(
                      widget.pet.photoUrl,
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
                        widget.pet.name,
                        style: context.h4.copyWith(color: context.neutral1000),
                      ),
                      SizedBox(width: 8.w),
                      Icon(
                        widget.pet.gender == 'male' ? Icons.male : Icons.female,
                        color: context.secondary100,
                        size: 28.r,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        widget.pet.breed,
                        style: context.body1.copyWith(
                          color: context.neutral500,
                        ),
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
                        _calculateAge(widget.pet.birthdate),
                        style: context.body1.copyWith(
                          color: context.neutral500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32.h),

                  // Adoption Request Form
                  Text(
                    'Send Adoption Request',
                    style: context.h5.copyWith(color: context.neutral1000),
                  ),
                  SizedBox(height: 16.h),

                  // Title Field
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      hintText: 'Enter request title',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),

                  // Description Field
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      hintText: 'Tell the owner why you want to adopt this pet',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      alignLabelWithHint: true,
                    ),
                    maxLines: 5,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24.h),

                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    height: 50.h,
                    child: ElevatedButton(
                      onPressed: _isSubmitting ? null : _submitAdoptionRequest,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: _isSubmitting
                          ? CircularProgressIndicator(color: Colors.white)
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
          );
        },
      ),
    );
  }
}
