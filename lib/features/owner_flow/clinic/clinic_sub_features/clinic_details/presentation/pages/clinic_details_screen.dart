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
                    Stack(
                      children: [
                        Image.network(
                          e.providerImage ?? "",
                          height: 250,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          top: 40,
                          left: 16,
                          child: GestureDetector(
                            onTap: () {
                              context.pop();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha:  0.5),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 22,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //!------------------CLINIC NAME------------------
                          Text(
                            e.providerName,
                            style: context.h3.copyWith(
                              color: context.primary500,
                            ),
                          ),

                          SizedBox(height: 18),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              if (e.price != null)
                                Row(
                                  children: [
                                    Icon(
                                      Icons.payments,
                                      size: 20,
                                      color: context.primary500,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "${e.price} SAR",
                                      style: context.body1.copyWith(
                                        color: context.green200,
                                      ),
                                    ),
                                  ],
                                ),
                              SizedBox(width: 20),

                              if (e.phone != null)
                                InkWell(
                                  onTap: () => _call(e.phone),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.phone,
                                        size: 18,
                                        color: context.primary500,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        e.phone!,
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.blue,
                                          // decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),

                          Divider(),
                          //!------------------SERVICE NAME------------------
                          SizedBox(height: 10),
                          Text(
                            "About",
                            style: context.h5.copyWith(
                              color: context.neutral1000,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            e.itemDescription ??
                                "A general veterinary visit that includes examination & consultation.",
                            style: context.body2.copyWith(
                              color: context.neutral1000,
                            ),
                          ),

                          SizedBox(height: 20),

                          Text(
                            "Services",
                            style: context.h5.copyWith(
                              color: context.neutral1000,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            e.itemName,
                            style: context.body2.copyWith(
                              color: context.neutral1000,
                            ),
                          ),

                          SizedBox(height: 10),

                          Text(
                            "Location",
                            style: context.h5.copyWith(
                              color: context.neutral1000,
                            ),
                          ),

                          SizedBox(height: 15),

                          if (e.location != null)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 22,
                                  color: context.red100,
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    e.location!,
                                    style: context.body2.copyWith(
                                      color: context.neutral1000,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                          const SizedBox(height: 15),

                          SizedBox(height: 10),

                          if (e.locationUrl != null)
                            ContainerButton(
                              label: 'Location',
                              containerColor: context.background,
                              textColor: context.primary50,
                              fontSize: 21,
                              onTap: () {
                                _openLocation(e.locationUrl);
                              },
                            ),
                          SizedBox(height: 10),
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
