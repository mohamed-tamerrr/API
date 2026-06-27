import 'package:API/core/network/api_service.dart';
import 'package:API/core/network/dio_client.dart';
import 'package:API/features/home/cubit/home_cubit.dart';
import 'package:API/features/home/data/repo/home_repo_imp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const API());
}

class API extends StatelessWidget {
  const API({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit(
            homeRepo: HomeRepoImp(
              apiService: ApiService(dioClient: DioClient()),
            ),
          )..getProducts(),
        ),
      ],

      child: MaterialApp(
        home: Scaffold(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
