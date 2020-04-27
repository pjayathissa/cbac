class User {
  // static const String Cough = 'cough';
  // static const String Fever = 'fever';

  String firstName = 'placeholder';
  String lastName = 'placeholder';
  Map symptoms = {
    "cough": false,
    "fever": false,
  };
  bool newsletter = false;
  save() {
    print('saving user using a web service');
  }
}