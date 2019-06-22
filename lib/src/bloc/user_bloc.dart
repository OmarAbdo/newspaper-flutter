import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import '../models/user.dart';

class UserBloc {
  final _repository = Repository();
  final _userFetcher = PublishSubject<UserModel>();

  Observable<UserModel> get signleUser => _userFetcher.stream;

  fetchUser() async {
    UserModel userModel = await _repository.fetchUser();   
    print('this is working'); 
    print(userModel.userEmail);
    _userFetcher.sink.add(userModel); 
  }

  /// just making dart happy 
  dispose() {
    _userFetcher.close();
  }
}


final userBloc = UserBloc();

