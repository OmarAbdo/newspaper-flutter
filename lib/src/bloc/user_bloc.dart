import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import '../models/user.dart';

class UserBloc {
  final _repository = Repository();
  final _userFetcher = BehaviorSubject<UserModel>();

  //New code
  final _user = BehaviorSubject<UserModel>();

  Observable<UserModel> get signleUser => _userFetcher.stream;

  fetchDummyUser() async {
    UserModel userModel = await _repository.fetchUser();   
    print('this is working'); 
    print(userModel.user);
    _userFetcher.sink.add(userModel); 
  }

  /// just making dart happy 
  dispose() {
    _userFetcher.close();
  }
}


final userBloc = UserBloc();

