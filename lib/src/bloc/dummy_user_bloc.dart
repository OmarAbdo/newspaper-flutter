import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import '../models/user.dart';

class DummyUserBloc {
  final _repository = Repository();
  final _userFetcher = BehaviorSubject<UserModel>();

  /// how about having a user stream that can menipulate its internal props like objects?
  //StreamController
  final _user = BehaviorSubject<UserModel>();
  //Stream
  Stream get userFullNameStream  => _user.stream;
  //Sink 
  Function get changeUserFullName => _user.sink.add;

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


final dummyUserBloc = DummyUserBloc();

