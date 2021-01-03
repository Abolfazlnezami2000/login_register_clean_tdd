import 'package:login_register_clean_tdd/Features/register/domain/entities/register.dart';
import 'package:meta/meta.dart';

class RegisterModel extends Register {
  RegisterModel({@required bool out}) : super(out: out);

  // factory NumberTriviaModel.fromJson(Map<String, dynamic> json) {
  //   return NumberTriviaModel(
  //     text: json['text'],
  //     number: (json['number'] as num).toInt(),
  //   );
  // }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'text': text,
  //     'number': number,
  //   };
  // }RegisterRemoteDataSource
}
