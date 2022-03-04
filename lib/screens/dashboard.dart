import 'package:bytebank_web_api/screens/name.dart';
import 'package:bytebank_web_api/screens/transactions_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'contacts_list.dart';

class DashboardContainer extends StatelessWidget {
  const DashboardContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NameCubit('Gustavo'),
      child: DashboardView(),
    );
  }
}

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // misturando blocbuilder (observer de eventos) com UI - Não recomendado
        title: BlocBuilder<NameCubit, String>(
          builder: (context, state) => Text("Welcome $state"),
        )
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('images/bytebank_logo.png'),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _FeatureItem(
                  "Transfer",
                  Icons.monetization_on,
                  onClick: () => _showContactsList(context),
                ),
                _FeatureItem(
                  "Transaction Feed",
                  Icons.description,
                  onClick: () => _showTransactionsList(context),
                ),
                _FeatureItem(
                  "Change Name",
                  Icons.person_outline,
                  onClick: () => _showChangeName(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final String _name;
  final IconData? _icon;
  final Function? onClick;

  const _FeatureItem(this._name, this._icon, {@required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).primaryColor,
        //InkWell widget para adicionar acoes de gestos no container
        //Possui as animacoes padroes do Material Design, difrente do GestureDetector
        //Precisa estar dentro de um widget Material
        //Estando no Widget Material  a cor do container tem que ser determinada no Material e não no container
        child: InkWell(
          onTap: () => onClick!(),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            height: 95,
            width: 130,
            alignment: Alignment.bottomLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  _icon,
                  color: Colors.white,
                  size: 24.0,
                ),
                Text(
                  _name,
                  style: const TextStyle(color: Colors.white, fontSize: 16.0),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _showContactsList(BuildContext context) {
// usado para instalar o crashlytics do firebase
  // FirebaseCrashlytics.instance.crash();
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => const ContactsList(),
    ),
  );
}

void _showChangeName(BuildContext blocContext) {
  Navigator.of(blocContext).push(
    MaterialPageRoute(
      builder: (context) => BlocProvider.value(
        value: BlocProvider.of<NameCubit>(blocContext),
        child: const NameContainer(),
      ),
    ),
  );
}

void _showTransactionsList(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => TransactionsList(),
    ),
  );
}
