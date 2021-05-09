import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

abstract class FormzInputs extends Equatable {
  const FormzInputs();

  List<FormzInput> get inputs;

  FormzStatus validate() => Formz.validate(inputs);

  @override
  List<Object> get props => [...inputs];
}
