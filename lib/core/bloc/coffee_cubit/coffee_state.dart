part of 'coffee_cubit.dart';

@immutable
abstract class CoffeeState {}

class CoffeeInitial extends CoffeeState {}

class CoffeeLoading extends CoffeeState {}

class CoffeeSuccess extends CoffeeState {
  final List<Coffee>? dataCoffee;
  CoffeeSuccess(this.dataCoffee);
}

class CoffeeFailed extends CoffeeState {
  final String? message;
  CoffeeFailed(this.message);
}
