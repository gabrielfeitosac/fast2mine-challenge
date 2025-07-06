import 'package:fast2mine_challenge/core/utils/colors.dart';
import 'package:fast2mine_challenge/core/utils/device_screen.dart';
import 'package:fast2mine_challenge/features/home_page/presentation/controllers/home_controller.dart';
import 'package:fast2mine_challenge/features/home_page/presentation/widgets/button_widget.dart';
import 'package:fast2mine_challenge/features/home_page/presentation/widgets/home_container.dart';
import 'package:fast2mine_challenge/features/home_page/presentation/widgets/status_container.dart';
import 'package:fast2mine_challenge/features/home_page/presentation/widgets/sync_status.dart';
import 'package:fast2mine_challenge/features/home_page/presentation/widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeController controller;

  @override
  void initState() {
    super.initState();
    controller = HomeController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
        color: primaryColor,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VerticalSpacing(4),
              Obx(
                () => HomeContainer(
                  title: 'ETAPA ATUAL',
                  containerWidget:
                      StatusContainer(status: controller.currentStatus),
                ),
              ),
              Obx(
                () => HomeContainer(
                  title: 'EQUIPAMENTO DE CARGA',
                  itemText: controller.equipmentLoad,
                ),
              ),
              Obx(
                () => HomeContainer(
                  title: 'PONTO DE BASCULAMENTO',
                  itemText: controller.tippingPoint,
                ),
              ),
              Obx(
                () => HomeContainer(
                  title: 'VELOCIDADE ATUAL',
                  itemText: controller.currentSpeed,
                ),
              ),
              Obx(
                () => HomeContainer(
                  title: 'STATUS DE SINCRONIZAÇÃO',
                  containerWidget: SyncStatus(
                    unsynchronizedQuantity: controller.completeCycles.length,
                  ),
                ),
              ),
              VerticalSpacing(5),
              ButtonWidget(
                text: 'SIMULAR PROXIMA LEITURA',
                backgroundColor: buttonColor,
                icon: Icons.play_arrow_rounded,
                textColor: primaryColor,
                onPressed: controller.simulate,
              ),
              VerticalSpacing(1),
              ButtonWidget(
                text: 'SINCRONIZAR DADOS',
                backgroundColor: containerColor,
                icon: Icons.cloud_sync_rounded,
                textColor: fontColor,
                onPressed: () => controller.syncData(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
