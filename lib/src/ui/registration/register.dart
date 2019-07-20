import 'package:flutter/material.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
//local imports
import 'package:flutter_newspaper/src/bloc/user_bloc.dart';
import 'package:flutter_newspaper/src/bloc/user_bloc_provider.dart';
import 'package:flutter_newspaper/src/ui/custom/custom.dart';

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
    final userBloc = UserBlocProvider.of(context);
    return Scaffold(
      body: Container(
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(25.0),
            children: <Widget>[
              Center(
                child: Column(
                  children: <Widget>[
                    GradientText(txt: 'Welcome To', fontSize: 48.0),
                    ColorText(txt: 'Newspaper', fontSize: 64.0),
                    _fullNameTextField(userBloc),
                    EmailTextField(userBloc),
                    PasswordTextField(userBloc),
                    _repeatPasswordTextField(userBloc),
                    _countryPicker(userBloc),
                    RaisedButton(
                      onPressed: () {
                        _showDatePicker(userBloc);
                      },
                      child: Text("Pick your birthday $_dateTime."),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              submitButton(userBloc),
              RaisedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
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
      ),
    );
  }

  void _showDatePicker(UserBloc userBloc) {
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
          userBloc.changeUserBirthday(dateTime);
          print('this is the date on change' + _dateTime.toString());
        });
      },
      onConfirm: (dateTime, List<int> index) {
        setState(() {
          _dateTime = dateTime;
          userBloc.changeUserBirthday(dateTime);
          print('this is the date on confirm' + _dateTime.toString());
        });
      },
    );
  }

  Widget _fullNameTextField(UserBloc userBloc) {
    return StreamBuilder(
        stream: userBloc.userFullNameStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return TextField(
            onChanged: userBloc.changeUserFullName,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: 'Please Enter your fullname',
              labelText: snapshot.data,
              errorText: snapshot.error,
            ),
          );
        });
  }

  Widget _repeatPasswordTextField(UserBloc userBloc) {
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

  Widget _countryPicker(UserBloc userBloc) {
    return StreamBuilder(
        stream: userBloc.userCountryStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Center(
            child: Column(
              children: <Widget>[
                CountryPicker(
                  showDialingCode: false,
                  showName: false,
                  onChanged: (Country country) {
                    setState(() {
                      _selected = country;
                      userBloc.changeUserCountry(country.name);
                    });
                  },
                  selectedCountry: _selected,
                ),
                Text(snapshot.hasError ? snapshot.error : 'we\'re cool')
              ],
            ),
          );
        });
  }

  //Build some text feilds widgets and link them to the country and date pickers
  Widget submitButton(UserBloc userBloc) {
    return StreamBuilder(
      stream: userBloc.validatedSignUp,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
          onPressed: snapshot.hasData
              ? () {
                  userBloc.submitSignUp(context);
                }
              : null,
          child: Text('Sign Up!'),
        );
      },
    );
  }
}
