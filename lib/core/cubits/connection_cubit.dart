import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionCubit extends Cubit<bool?> {
  ConnectionCubit() : super(null) {
    checkConnection();
  }

  Future<void> checkConnection() async {
    final result = await Connectivity().checkConnectivity();
    emit(!result.contains(ConnectivityResult.none));
  }
}
