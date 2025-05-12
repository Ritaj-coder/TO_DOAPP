

class MyUser {
  static const String collectionName = 'users';
  String ID;

  String Name;

  String Email;

  MyUser({required this.ID, required this.Name, required this.Email});

  MyUser.fromFireStore(Map<String, dynamic> data)
      : this(ID: data['id'], Name: data['name'], Email: data['email']);

  Map<String, dynamic> toFireStore() {
    return {'id': ID, 'name': Name, 'email': Email};
  }
}
