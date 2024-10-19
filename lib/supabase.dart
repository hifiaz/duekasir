import 'package:due_kasir/utils/env.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

loadSupabase() async {
  await Supabase.initialize(
    url: Environment.url,
    anonKey: Environment.anonKey,
  );
}
