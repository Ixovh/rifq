import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq/core/theme/app_color.dart';
import 'package:rifq/core/theme/app_theme.dart';
import 'package:rifq/features/owner_flow/auth/presentation/widgets/container_button.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../core/shared/shared_in_owner_flow/shared/entities/provider_items_view_entity.dart';
import '../cubit/hotel_cubit.dart';

class HotelInfoTabContent extends StatelessWidget {
  final ProviderItemsViewEntity hotel;
  const HotelInfoTabContent({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Text("About the Hotel :",style: context.body1.copyWith(color: context.neutral1000),),
          SizedBox(height: 12.h),
          Text(hotel.itemDescription!,style: context.body3.copyWith(color: context.neutral1000),),
          SizedBox(height: 12.h),
          Text(" Rules & Requirements : ",style: context.body1.copyWith(color: context.neutral1000),),
          SizedBox(height: 20.h),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Image.asset('assets/images/mdi_checkbox-outline.png'),
                      SizedBox(width: 12.w),
                      Flexible(
                        child: Text(
                          "Must be vaccinated",
                          style: context.body3.copyWith(color: context.neutral1000),
                          ),),],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Image.asset('assets/images/mdi_checkbox-outline.png'),
                      SizedBox(width: 12.w),
                      Flexible(
                        child: Text(
                          "Late Fee Applies",
                          style: context.body3.copyWith(color: context.neutral1000),
                        ),
                      ),
                    ],),),
              ],),
            SizedBox(height: 10.h),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Image.asset('assets/images/mdi_checkbox-outline.png'),
                      SizedBox(width: 12.w),
                      Flexible(
                        child: Text(
                          "Pets must be flea-free",
                          style: context.body3.copyWith(color: context.neutral1000),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Image.asset('assets/images/mdi_checkbox-outline.png'),
                      SizedBox(width: 12.w),
                      Flexible(
                        child: Text(
                          "Bring Food if Allergic",
                          style:context.body3.copyWith(color: context.neutral1000),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Image.asset('assets/images/mdi_checkbox-outline.png'),
                      SizedBox(width: 10.w),
                      Flexible(
                        child: Text(
                          "Pet passport required",
                          style: context.body3.copyWith(color: context.neutral1000),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
          SizedBox(height: 70.h),
          if (hotel.locationUrl != null && hotel.locationUrl!.isNotEmpty)
             ContainerButton(
                              label: 'Location',
                              containerColor: context.background,
                              textColor: context.primary50,
                              fontSize: 21,
                              onTap: () {
                                _openLocation(hotel.locationUrl);
                              },
                            ),
            ]),
    );
  }

    void _openLocation(String? url) async {
    if (url == null) return;
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
