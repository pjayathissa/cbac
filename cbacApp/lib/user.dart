class User {
  // static const String Cough = 'cough';
  // static const String Fever = 'fever';



  String firstName = 'placeholder';
  String lastName = 'placeholder';
  String address = 'placeholder';
  String postCode = 'placeholder';
  Map symptoms = {
    'cough': false,
    'fever': false,
    'soreThroat': false,
    'breath': false,
    'coryza': false,
    'anosmia':false,
    'other': false,
    'diarrhoea':false,
    'headache':false,
    'myalgia':false,
    'nausea':false,
    'confusion':false,
  };

  Map userDetails = {
    'firstName': 'placeholder',
    'lastName': 'placeholder',
    'street': 'placeholder',
    'city': 'placeholder',
    'postCode': 'placeholder',
    'phoneNumber': 'placeholder',
    'email': 'placeholder',
  };

  String travelValue = 'placeholder';
  List<Map<String, dynamic>> travelOptions = [
  {'key': 'yes', 'title': 'Yes'},
  {'key': 'no', 'title': 'No'},
  {'key': 'dontknow', 'title': 'Dont know'}
];

  DateTime travelDate;



  bool newsletter = false;
  save() {
    print('saving user using a web service');
  }
}
