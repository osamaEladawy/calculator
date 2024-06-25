// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cubit.dart';
import 'screens/home_screen.dart';
import 'shared/components/constant.dart';
import 'shared/cubit/cubit.dart';
import 'shared/cubit/states.dart';
import 'shared/network/local/cache_helper.dart';
import 'shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  bool isDark = CacheHelper.getData(key:'isDark') != null;
  runApp(MyApp(
    isDark: isDark,
  ));
}

class MyApp extends StatelessWidget {
  bool isDark;
  MyApp( {super.key,
    required this.isDark,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) =>AppCubit()..changeAppMode(
            fromShared: isDark,
          ),),
        BlocProvider(
          create: (BuildContext context) =>CalculatorCubit()),
      ],
      child: BlocConsumer<AppCubit , AppStates>(
        listener: (context , state) {},
        builder: (context , state){
          return MaterialApp(
            debugShowCheckedModeBanner: false ,
            theme: lightTheme,
            darkTheme: darkTheme,
            // themeMode: ThemeMode.light,
            themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light, //AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}

