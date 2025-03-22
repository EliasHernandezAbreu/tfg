import 'package:tfg/process_state.dart';

abstract class ProcessAlgorithm {
    ProcessState nextState(ProcessState oldState, int deltaTime);
}
