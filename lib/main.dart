import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:go_router/go_router.dart';
import 'package:epsi_shop/page/cart_page.dart';
import 'package:epsi_shop/page/payment_page.dart';

import 'app.dart';
import 'bo/cart.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => Cart(), child: const MyApp()));
}

