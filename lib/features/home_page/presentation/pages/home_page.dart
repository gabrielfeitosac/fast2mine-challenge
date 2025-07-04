import 'package:fast2mine_challenge/core/utils/colors.dart';
import 'package:fast2mine_challenge/features/home_page/presentation/widgets/button_widget.dart';
import 'package:fast2mine_challenge/features/home_page/presentation/widgets/home_container.dart';
import 'package:fast2mine_challenge/features/home_page/presentation/widgets/status_container.dart';
import 'package:fast2mine_challenge/features/home_page/presentation/widgets/sync_status.dart';
import 'package:fast2mine_challenge/features/home_page/presentation/widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        color: primaryColor,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeContainer(
                title: 'ETAPA ATUAL',
                containerWidget: StatusContainer(status: 'EM CARREGAMENTO'),
              ),
              HomeContainer(
                title: 'EQUIPAMENTO DE CARGA',
                itemText: 'EXCAV-001',
              ),
              HomeContainer(
                title: 'PONTO DE BASCULAMENTO',
                itemText: 'X: 100 | Y : 200',
              ),
              HomeContainer(
                title: 'VELOCIDADE ATUAL',
                itemText: '18.0 km/h',
              ),
              HomeContainer(
                title: 'STATUS DE SINCRONIZAÇÃO',
                containerWidget: SyncStatus(unsynchronizedQuantity: 0),
              ),
              SizedBox(height: 20),
              ButtonWidget(
                text: 'SIMULAR PROXIMA LEITURA',
                backgroundColor: buttonColor,
                icon: Icons.play_arrow_rounded,
                textColor: primaryColor,
                onPressed: () {},
              ),
              VerticalSpacing(1),
              ButtonWidget(
                text: 'SINCRONIZAR DADOS',
                backgroundColor: containerColor,
                icon: Icons.cloud_sync_rounded,
                textColor: fontColor,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
