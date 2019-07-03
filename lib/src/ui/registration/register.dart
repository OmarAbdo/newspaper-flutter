import 'package:flutter/material.dart';
import '../../bloc/dummy_user_bloc.dart';
import '../../bloc/user_bloc.dart';
import '../custom/custom.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';

/// Later enhancements
/// 1. make the INIT_DATETIME dynamiclly picks today instead of 2019-01-01
/// 2. the birthday button should display only the date and it should be done in a proper way
/// 3. only enable the submit button on all data validation
/// 4. this including the date field displaying the initial value which it's not picked by the bloc too (either way initial value shouldn't be acceppted)

//DatePicker Values
const String MIN_DATETIME = '1920-01-01';
const String MAX_DATETIME = '2099-12-31';
const String INIT_DATETIME = '2019-01-01'; // Make it today later

class Register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterState();
  }
}

class _RegisterState extends State<Register> {
  bool _showTitle = true;

  DateTimePickerLocale _locale = DateTimePickerLocale.en_us;
  List<DateTimePickerLocale> _locales = DateTimePickerLocale.values;

  String _format = 'yyyy-MMMM-dd';
  TextEditingController _formatCtrl = TextEditingController();

  DateTime _dateTime;

  @override
  void initState() {
    super.initState();
    _formatCtrl.text = _format;
    _dateTime = DateTime.parse(INIT_DATETIME);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(25.0),
          children: <Widget>[
            Center(
              child: Column(
                children: <Widget>[
                  GradientText(txt: 'Welcome To', fontSize: 48),
                  ColorText(txt: 'Newspaper', fontSize: 64),
                  _fullNameTextField(),
                  _emailTextField(),
                  _passwordTextField(),
                  _repeatPasswordTextField(),
                  _countryPicker(),
                  RaisedButton(
                    onPressed: _showDatePicker,
                    child: Text("Pick your birthday $_dateTime."),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            RaisedButton(
              onPressed: userBloc.submit,
              child: Text('Sign Up!'),
            ),
            RaisedButton(
              onPressed: dummyUserBloc.fetchDummyUser,
              child: Text('Already have an account?'),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/loginbg.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  void _showDatePicker() {
    DatePicker.showDatePicker(
      context,
      pickerTheme: DateTimePickerTheme(
        showTitle: _showTitle,
        confirm: Text('Pick Birthday', style: TextStyle(color: Colors.cyan)),
        cancel: Text('Close Dialog', style: TextStyle(color: Colors.red)),
      ),
      minDateTime: DateTime.parse(MIN_DATETIME),
      maxDateTime: DateTime.parse(MAX_DATETIME),
      initialDateTime: _dateTime,
      dateFormat: _format,
      locale: _locale,
      onCancel: () {
        debugPrint('onCancel');
      },
      onChange: (dateTime, List<int> index) {
        setState(() {
          _dateTime = dateTime;
        });
      },
      onConfirm: (dateTime, List<int> index) {
        setState(() {
          _dateTime = dateTime;
          userBloc.changeUserBirthday(dateTime);
        });
      },
    );
  }

  Widget _fullNameTextField() {
    return StreamBuilder(
        stream: userBloc.userFullNameStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return TextField(
            onChanged: userBloc.changeUserFullName,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: 'Please Enter your fullname',
              labelText: 'Full Name',
              errorText: snapshot.error,
            ),
          );
        });
  }

  Widget _emailTextField() {
    return StreamBuilder(
        stream: userBloc.userEmailAddress,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return TextField(
            onChanged: userBloc.changeUserEmailAddress,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'Please Enter your Email address',
              labelText: 'Email Address',
              errorText: snapshot.error,
            ),
          );
        });
  }

  Widget _passwordTextField() {
    return StreamBuilder(
        stream: userBloc.userPasswordStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return TextField(
            obscureText: true,
            onChanged: userBloc.changeUserPassword,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: 'Please Enter your password',
              labelText: 'Password',
              errorText: snapshot.error,
            ),
          );
        });
  }

  Widget _repeatPasswordTextField() {
    return StreamBuilder(
        stream: userBloc.userRepeatPasswordStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return TextField(
            obscureText: true,
            onChanged: userBloc.changeUserRepeatPassword,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: 'Please Confirm Your password',
              labelText: 'Password Confirm',
              errorText: snapshot.error,
            ),
          );
        });
  }

  Country _selected;

  Widget _countryPicker() {
    return StreamBuilder(
        stream: userBloc.userCountryStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Center(
            child: CountryPicker(
              showDialingCode: true,
              onChanged: (Country country) {
                setState(() {
                  _selected = country;
                  userBloc.changeUserCountry(country.name);
                });
              },
              selectedCountry: _selected,
            ),
          );
        });
  }
}
