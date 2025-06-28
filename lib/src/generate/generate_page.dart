import 'package:flutter/material.dart';
import '../../data/models/qr_type_enum.dart';
import '../components/custom_bottom_navigation_bar.dart';
import '../../common_lib.dart';
import '../../theme/app_colors.dart';

class GeneratePage extends HookConsumerWidget {
  const GeneratePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageIndex = ref.watch(currentPageIndexProvider);

    // Map titles to QRType enum
    List<QRType> qrTypes = [
      QRType.text,
      QRType.website,
      QRType.network,
      QRType.event,
      QRType.contact,
      QRType.business,
      QRType.email,
      QRType.whatsApp,
      QRType.location,
      QRType.twitter,
      QRType.instagram,
      QRType.phoneNumber,
    ];
    List<String> icons = [
      Assets.assetsImagesText,
      Assets.assetsImagesInternet,
      Assets.assetsImagesWifi,
      Assets.assetsImagesCalender,
      Assets.assetsImagesContacts,
      Assets.assetsImagesOrgenization,
      Assets.assetsImagesEmail,
      Assets.assetsImagesWhatsapp,
      Assets.assetsImagesLocation,
      Assets.assetsImagesTwitter,
      Assets.assetsImagesInstgram,
      Assets.assetsImagesCall,
    ];

    return AnimatedPositioned(
      top: 0,
      bottom: 0,
      right: pageIndex != 0 ? MediaQuery.of(context).size.width : 0,
      duration: const Duration(milliseconds: 200),
      child: Container(
        padding: const EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: AppColors.backgroundWithOpacity,
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Generate QR',
                    style: TextStyle(fontSize: 26, color: AppColors.textPrimary),
                  ),
                  IconButton.filled(
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.background,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => context.pushNamed(RoutesDocument.settings),
                    icon: SvgPicture.asset(
                      Assets.assetsSvgMenu,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              GridView.builder(
                itemCount: qrTypes.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 140,
                  mainAxisExtent: 140,
                ),
                itemBuilder: (context, index) {
                  QRType type = qrTypes[index];
                  return InkWell(
                    onTap: () => context.pushNamed(RoutesDocument.generate, extra: type),
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 35, right: 20, left: 20),
                      height: 100,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: 80,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColors.background,
                                border: Border.all(color: AppColors.primary, width: 2),
                                borderRadius: const BorderRadius.all(Radius.circular(8)),
                              ),
                              child: Image.asset(
                                icons[index],
                                height: 50,
                                width: 50,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 25,
                              width: 75,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary,
                                    blurRadius: 10,
                                  )
                                ],
                                color: AppColors.primary,
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                              ),
                              child: Text(
                                type.toTitleString(),
                                style: const TextStyle(color: AppColors.background),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
