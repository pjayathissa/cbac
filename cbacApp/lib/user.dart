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
    'other': false,
  };

  Map userDetails = {
    'firstName': 'placeholder',
    'lastName': 'placeholder',
    'street': 'placeholder',
    'city': 'placeholder',
    'postCode': 'placeholder',
  };
  bool newsletter = false;
  save() {
    print('saving user using a web service');
  }
}