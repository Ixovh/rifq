import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rifq/core/di/setup.dart';
import 'package:rifq/core/routes/base_routes.dart';
import 'package:rifq/core/theme/app_color.dart';
import 'package:rifq/core/theme/app_theme.dart';
import 'package:rifq/features/owner_flow/auth/presentation/widgets/container_button.dart';
import '../cubit/clinic_details_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

class ClinicDetailsScreen extends StatelessWidget {
  final String providerId;

  const ClinicDetailsScreen({super.key, required this.providerId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ClinicDetailsCubit>()..load(providerId),
      child: Scaffold(
        backgroundColor: context.background,
        body: BlocBuilder<ClinicDetailsCubit, ClinicDetailsState>(
          builder: (context, state) {
            if (state is ClinicDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ClinicDetailsError) {
              return Center(child: Text(state.message));
            }

            if (state is ClinicDetailsLoaded) {
              final e = state.entity;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      e.providerImage ?? "",
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),

                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //!------------------CLINIC NAME------------------
                          Text(
                            e.providerName,
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 8),

                          //!------------------SERVICE NAME------------------
                          Text(
                            e.itemName,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),

                          SizedBox(height: 10),

                          //!------------------DESCRIPTION------------------
                          Text(
                            e.itemDescription ??
                                "A general veterinary visit that includes examination & consultation.",
                            style: const TextStyle(fontSize: 16, height: 1.4),
                          ),

                          SizedBox(height: 20),

                          //!------------------PRICE------------------
                          if (e.price != null)
                            Row(
                              children: [
                                Icon(Icons.payments, size: 22),
                                SizedBox(width: 10),
                                Text(
                                  "${e.price} SAR",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),

                          const SizedBox(height: 15),

                          //!------------------PHONE------------------
                          if (e.phone != null)
                            InkWell(
                              onTap: () => _call(e.phone),
                              child: Row(
                                children: [
                                  Icon(Icons.phone, size: 22),
                                  SizedBox(width: 10),
                                  Text(
                                    e.phone!,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          SizedBox(height: 15),

                          //!------------------LOCATION------------------
                          if (e.location != null)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.location_on, size: 22),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    e.location!,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),

                          SizedBox(height: 10),

                          if (e.locationUrl != null)
                            
                            Center(
                              child: SizedBox(
                                width: 339.w,
                                height: 26.h,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    _openLocation(e.locationUrl);
                                  },
                                  icon: Icon(
                                    Icons.location_on,
                                    color: AppColors.primary300,
                                  ),
                                  label: Text(
                                    "Location",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                      side: BorderSide(
                                        color: AppColors.primary300,
                                        width: 1.w,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                          SizedBox(height: 25),
                          ContainerButton(
                            label: 'Book Now',
                            containerColor: context.primary50,
                            textColor: context.background,
                            fontSize: 21,
                            onTap: () {
                              context.push(Routes.bookAppointment, extra: e);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }

            return SizedBox();
          },
        ),
      ),
    );
  }

  //!! url lancher
  void _openLocation(String? url) async {
    if (url == null) return;
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  //!! phone method
  void _call(String? phone) async {
    if (phone == null) return;
    final uri = Uri(scheme: 'tel', path: phone);
    await launchUrl(uri);
  }
}
