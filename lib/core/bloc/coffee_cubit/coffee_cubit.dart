import 'package:bloc/bloc.dart';
import 'package:coffe_app/core/helper/failure.dart';
import 'package:coffe_app/core/models/coffee.dart';
import 'package:coffe_app/core/repository/general_repo.dart';
import 'package:coffe_app/utils/notification_utils.dart';
import 'package:meta/meta.dart';

import '../../helper/either.dart';

part 'coffee_state.dart';

class CoffeeCubit extends Cubit<CoffeeState> {
  CoffeeCubit() : super(CoffeeInitial());

  final GeneralRepo _repo = GeneralRepo();
  List<Coffee> listCoffee = [];

  Future<void> getCoffee() async {
    emit(CoffeeLoading());
    Either<Failure, List<Coffee>> res = await _repo.dataCoffee();
    res.when(error: (e) {
      NotifUtils.showSnackbar(e.message);
      emit(CoffeeFailed(e.message));
    }, success: (data) {
      listCoffee = data;
      listCoffee.sort(
        (a, b) =>
            int.parse(a.id.toString()).toInt().compareTo(b.id?.toInt() ?? 0),
      );
      emit(CoffeeSuccess(data));
    });
  }
}
