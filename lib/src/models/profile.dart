class Profile {
  String _uid;
  String _phoneNumber;
  String _userName;

  String get uid => _uid;
  String get phoneNumber => _phoneNumber;
  String get userName => _userName;

  Profile._(
    this._uid,
    this._phoneNumber,
    this._userName,
  );
}
