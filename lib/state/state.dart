import 'package:flutter_riverpod/flutter_riverpod.dart';

StateProvider authstate = StateProvider<int>((ref) => 0);
StateProvider themestate = StateProvider<bool>((ref) => false);
