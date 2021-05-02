import 'throwable.dart';

abstract class Patternable {
  const Patternable();

  List<Throwable> get throwSequence;
}
