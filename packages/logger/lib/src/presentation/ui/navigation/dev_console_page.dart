/*
 * Copyright (C) 2025 Finharbor DOO. - All Rights Reserved
 *
 * Unauthorized copying or redistribution of this file in source and binary forms via any medium
 * is strictly prohibited.
 */

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:logger/src/presentation/bloc/dev_console_cubit.dart';
import 'package:logger/src/presentation/ui/screen/dev_console_screen.dart';

@RoutePage()
class DevConsolePage extends StatefulWidget {
  const DevConsolePage({super.key});

  @override
  State<DevConsolePage> createState() => _DevConsolePageState();
}

class _DevConsolePageState extends State<DevConsolePage> {
  final _cubit = GetIt.I<DevConsoleCubit>()..fetchDebugInfo();

  @override
  Widget build(BuildContext context) => BlocProvider(create: (_) => _cubit, child: const DevConsoleScreen());
}
