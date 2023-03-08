import 'dart:developer';

import 'package:coffe_app/core/bloc/coffee_cubit/coffee_cubit.dart';
import 'package:coffe_app/core/models/coffee.dart';
import 'package:coffe_app/utils/nav_utils.dart';
import 'package:coffe_app/utils/prefs_utils.dart';
import 'package:coffe_app/utils/theme.dart';
import 'package:coffe_app/view/pages/login.dart';
import 'package:coffe_app/view/widgets/loading_circular.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<bool>? isVisible;
  CoffeeCubit? cubit;

  void _visibility(int index) {
    setState(() {
      isVisible?[index] = !isVisible![index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CoffeeCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Catalog"),
          centerTitle: true,
          backgroundColor: ConfigColor.lightBrown,
          actions: [
            IconButton(
                onPressed: () async {
                  await PrefsUtils().clear('isLogin');
                  Nav.toAll(LoginPage());
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        backgroundColor: ConfigColor.darkBrown,
        body: SafeArea(
          child: BlocBuilder<CoffeeCubit, CoffeeState>(
            builder: (context, state) {
              cubit = context.read<CoffeeCubit>();
              if (state is CoffeeInitial) {
                cubit?.getCoffee().then((value) {
                  isVisible = List.filled(
                    cubit?.listCoffee.length ?? 0,
                    false,
                  );
                });
              }
              if (state is CoffeeSuccess) {
                return ListView.builder(
                    itemCount: cubit?.listCoffee.length,
                    itemBuilder: (context, index) {
                      var data = cubit?.listCoffee[index];
                      return coffeeBox(data, cubit, index);
                    });
              }
              return const LoadingCircular();
            },
          ),
        ),
      ),
    );
  }

  Widget coffeeBox(Coffee? data, CoffeeCubit? cubit, int coffeeIndex) {
    return Container(
      margin: const EdgeInsets.only(top: 16, right: 16, left: 16),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: ConfigColor.primaryColor,
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(60),
              child: Image.network(
                data?.image ?? '',
                height: 100,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return const LoadingCircular();
                  } else {
                    return child;
                  }
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.error,
                    color: Colors.red,
                    size: 80,
                  );
                },
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${data?.title} | ID : ${data?.id}",
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 16),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(isVisible?[coffeeIndex] == false &&
                        data!.description!.length > 100
                    ? '${data.description!.substring(0, 100)}...'
                    : data?.description ?? ""),
                data!.description!.length > 100
                    ? TextButton(
                        onPressed: () => _visibility(coffeeIndex),
                        child: Text(
                          isVisible?[coffeeIndex] == true
                              ? "Show less"
                              : "Show more",
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w700),
                        ),
                      )
                    : const SizedBox(
                        height: 10,
                      ),
                ingredientsWidget(cubit, coffeeIndex)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget ingredientsWidget(CoffeeCubit? cubit, int coffeeIndex) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: cubit?.listCoffee[coffeeIndex].ingredients?.length,
          itemBuilder: (context, index) {
            var data = cubit?.listCoffee[coffeeIndex].ingredients?[index];
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: ConfigColor.darkBrown),
              child: Center(
                child: Text(
                  data ?? "",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            );
          }),
    );
  }
}
