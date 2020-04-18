import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/models/user.dart';
import 'package:social_media/notifiers/user_notifier/user_notifier.dart';
import 'package:social_media/utils/constants.dart' as constants;

class DataPage extends StatefulWidget {
  User _user;
  DataPage(this._user);

  @override
  _DataPageState createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  String _email, _password, _name, _phoneNumber, _description;
  DateTime _dateOfBirth = DateTime.now();
  int _gender = constants.USER_GENDER_MALE, _country = 0;
  GlobalKey<FormState> _formKey;
  UserNotifier _userNotifier;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey();
  }

  String validate(String value, String fieldName) {
    if (value.isEmpty) return '$fieldName field is required';
    return null;
  }

  // method for saving data in the current user  >>
  void saveData() {
    _userNotifier.user.name = _name;
    _userNotifier.user.phoneNumber = _phoneNumber;
    _userNotifier.user.isCompletedAccount = true;
    _userNotifier.user.country = _country;
    _userNotifier.user.gender = _gender;
    _userNotifier.user.description = _description;
  }

  @override
  Widget build(BuildContext context) {
    _userNotifier = Provider.of<UserNotifier>(context, listen: false);
    return Container(
      padding: EdgeInsets.all(16),
      child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.text,
                onSaved: (value) {
                  _name = value.trim();
                },
                validator: (value) => validate(value, 'Name'),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Name',
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                onSaved: (value) {
                  _email = value.trim();
                },
                validator: (value) => validate(value, 'Email'),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: 'Email',
// icon: Icon(Ico)
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.phone,
                onSaved: (value) {
                  _phoneNumber = value.trim();
                },
                validator: (value) => validate(value, 'Phone number'),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.call),
                  labelText: 'Enter phone number',
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                onSaved: (value) {
                  _password = value.trim();
                },
                validator: (value) => validate(value, 'Password'),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  labelText: 'Enter password',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text('Gender'),
                  Row(
                    children: <Widget>[
                      Radio(
                        value: constants.USER_GENDER_MALE,
                        groupValue: _gender,
                        onChanged: (value) {
                          setState(() {
                            _gender = value;
                          });
                        },
                      ),
                      Text('Male'),
                      Radio(
                        value: constants.USER_GENDER_FEMALE,
                        groupValue: _gender,
                        onChanged: (value) {
                          setState(() {
                            _gender = value;
                          });
                        },
                      ),
                      Text('Female')
                    ],
                  )
                ],
              ),
              DropdownButtonFormField(
                  value: _country,
                  onChanged: (value) {
                    setState(() {
                      _country = value;
                    });
                  },
                  items: constants.COUNTRIES
                      .map<DropdownMenuItem<int>>((String item) {
                    return DropdownMenuItem(
                        value: constants.COUNTRIES.indexOf(item),
                        child: Text(item));
                  }).toList()),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                maxLines: 5,
                keyboardType: TextInputType.text,
                onSaved: (value) {
                  _description = value.trim();
                },
                validator: (value) => validate(value, 'Description'),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 0.5),
                      borderRadius: BorderRadius.zero),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 0.5),
                      borderRadius: BorderRadius.zero),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 0.5),
                      borderRadius: BorderRadius.zero),
                  disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1),
                      borderRadius: BorderRadius.zero),
                  hintText: 'Enter description',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                    onPressed: () async {
//                        _dateOfBirth = await RoundedDatePicker.show(context,
//                            initialDate: _dateOfBirth,
//                            firstDate: DateTime(DateTime.now().year - 50),
//                            borderRadius: 16);
//                        setState(() {});
                    },
                    icon: Icon(
                      Icons.date_range,
                      size: 30,
                      color: Colors.teal,
                    ),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 12),
                    child: Text(
                      _dateOfBirth.toString().substring(0, 10),
                      style: TextStyle(fontSize: 18, color: Colors.teal),
                    ),
                  )
                ],
              ),
            ],
          )),
    );
  }
}
