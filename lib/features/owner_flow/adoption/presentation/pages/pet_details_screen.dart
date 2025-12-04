import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rifq/core/theme/app_theme.dart';
import 'package:rifq/features/owner_flow/add_pet/domain/entities/add_pet_entity.dart';
import 'package:rifq/features/owner_flow/adoption/presentation/cubit/adoption_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PetDetailsScreen extends StatelessWidget {
  final AddPetEntity pet;
  final String? location;
  final String? ownerName;
  final bool isMyPet;

  const PetDetailsScreen({
    super.key,
    required this.pet,
    this.location,
    this.ownerName,
    this.isMyPet = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdoptionCubit, AdoptionState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => context.pop(),
            ),
            title: Text(
              isMyPet ? 'My Pet' : 'Adopt',
              style: context.body2.copyWith(
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ),
          extendBodyBehindAppBar: true,
          body: Stack(
            children: [
              // Full screen pet image
              _buildPetImage(context),

              // Bottom sheet with details
              _buildDetailsBottomSheet(context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPetImage(BuildContext context) {
    final isNetworkUrl =
        pet.photoUrl.startsWith('http://') ||
        pet.photoUrl.startsWith('https://');

    if (isNetworkUrl) {
      return Image.network(
        pet.photoUrl,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            color: context.neutral200,
            child: Icon(Icons.pets, size: 64.r, color: context.neutral500),
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            width: double.infinity,
            height: double.infinity,
            color: context.neutral200,
            child: Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                    : null,
                color: context.primary300,
              ),
            ),
          );
        },
      );
    } else {
      return Image.asset(
        pet.photoUrl,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            color: context.neutral200,
            child: Icon(Icons.pets, size: 64.r, color: context.neutral500),
          );
        },
      );
    }
  }

  Widget _buildDetailsBottomSheet(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.65,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: context.background,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.r),
              topRight: Radius.circular(30.r),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                margin: EdgeInsets.only(top: 12.h),
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: context.neutral300,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),

              // Content
              Flexible(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: EdgeInsets.symmetric(
                    horizontal: 27.r,
                    vertical: 20.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Pet Name
                      Text(
                        pet.name,
                        style: context.body1.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 24.sp,
                          color: context.neutral900,
                        ),
                      ),

                      SizedBox(height: 12.h),

                      // Location
                      if (location != null) ...[
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 16.r,
                              color: context.primary300,
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              location!,
                              style: context.body2.copyWith(
                                color: context.neutral600,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                      ],

                      // Age
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 16.r,
                            color: context.primary300,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            _formatAge(pet.birthdate),
                            style: context.body2.copyWith(
                              color: context.neutral600,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20.h),

                      // Attributes
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildAttributeChip(
                            context,
                            icon: Icons.person,
                            label: pet.gender,
                          ),
                          _buildAttributeChip(
                            context,
                            icon: Icons.palette,
                            label: pet.species,
                          ),
                          _buildAttributeChip(
                            context,
                            icon: Icons.pets,
                            label: pet.breed,
                          ),
                        ],
                      ),

                      SizedBox(height: 24.h),

                      // Owner Information
                      Row(
                        children: [
                          // Owner Avatar
                          CircleAvatar(
                            radius: 24.r,
                            backgroundColor: context.neutral200,
                            child: Icon(
                              Icons.person,
                              color: context.neutral500,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          // Owner Name
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Owner by:',
                                  style: context.body2.copyWith(
                                    color: context.neutral600,
                                    fontSize: 12.sp,
                                  ),
                                ),
                                Text(
                                  ownerName ?? 'Unknown',
                                  style: context.body2.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: context.neutral900,
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Contact Button
                          Container(
                            width: 48.w,
                            height: 48.h,
                            decoration: BoxDecoration(
                              color: context.primary300,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.phone,
                                color: Colors.white,
                                size: 20.r,
                              ),
                              onPressed: () {
                                // TODO: Handle contact owner
                              },
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 24.h),

                      // Description
                      Text(
                        'Description',
                        style: context.body1.copyWith(
                          fontWeight: FontWeight.w600,
                          color: context.neutral900,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        '${pet.name} is a healthy, playful ${pet.species.toLowerCase()} with updated vaccinations. Perfect for anyone looking for a sweet and loving companion ready for a new home.',
                        style: context.body2.copyWith(
                          color: context.neutral600,
                          fontSize: 14.sp,
                          height: 1.5,
                        ),
                      ),

                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),

              // Action Button (Fixed at bottom)
              Container(
                padding: EdgeInsets.all(20.r),
                decoration: BoxDecoration(
                  color: context.background,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: SafeArea(
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (isMyPet) {
                          _handleRemoveFromAdoption(context);
                        } else {
                          _handleAdopt(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isMyPet
                            ? Colors.red
                            : context.primary300,
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        isMyPet ? 'Remove from Adoption' : 'Adopt',
                        style: context.body1.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _handleAdopt(BuildContext context) {
    final cubit = context.read<AdoptionCubit>();
    final currentUserId = Supabase.instance.client.auth.currentUser?.id;

    if (currentUserId != null) {
      cubit.sendAdoptionRequest(
        petId: pet.id,
        ownerId: currentUserId,
        title: 'Adoption Request for ${pet.name}',
        description: 'I would like to adopt ${pet.name}.',
      );

      // Show success message and pop
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Adoption request sent successfully'),
          backgroundColor: Colors.green,
        ),
      );
      context.pop();
    }
  }

  void _handleRemoveFromAdoption(BuildContext context) {
    final cubit = context.read<AdoptionCubit>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove from Adoption'),
        content: Text(
          'Are you sure you want to remove ${pet.name} from adoption?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await cubit.removePetFromAdoption(pet.id);

              // Refresh the pets list after removal
              final currentUserId =
                  Supabase.instance.client.auth.currentUser?.id;
              if (currentUserId != null) {
                cubit.getMyPets(currentUserId);
              }

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${pet.name} removed from adoption'),
                  backgroundColor: Colors.green,
                ),
              );
              context.pop();
            },
            child: const Text('Remove', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Widget _buildAttributeChip(
    BuildContext context, {
    required IconData icon,
    required String label,
  }) {
    return Column(
      children: [
        Container(
          width: 60.w,
          height: 60.h,
          decoration: BoxDecoration(
            color: context.primary100,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(icon, color: context.primary300, size: 24.r),
        ),
        SizedBox(height: 8.h),
        Text(
          label,
          style: context.body2.copyWith(
            color: context.neutral600,
            fontSize: 12.sp,
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  String _formatAge(DateTime birthdate) {
    final now = DateTime.now();
    final difference = now.difference(birthdate);
    final totalDays = difference.inDays;
    final years = totalDays / 365.0;

    if (years >= 1) {
      final formattedYears = years.toStringAsFixed(1);
      final cleanYears = formattedYears.endsWith('.0')
          ? formattedYears.split('.')[0]
          : formattedYears;
      return '$cleanYears year${years < 2 ? '' : 's'}';
    } else {
      final months = (totalDays / 30).floor();
      if (months > 0) {
        return '$months month${months == 1 ? '' : 's'}';
      } else {
        return 'Less than a month';
      }
    }
  }
}
