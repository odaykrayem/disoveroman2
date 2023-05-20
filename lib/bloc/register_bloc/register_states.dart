class RegisterStates{
  final String userName;
  final String email;
  final String password;
  final String rePassword;
// optional named parameter
  const RegisterStates({this.password="", this.email="", this.rePassword="",this.userName=""});


  RegisterStates copyWith({
    String? userName, String? email, String? password, String? rePassword
  }){
    return RegisterStates(password: password??this.password, email: email??this.email,
        rePassword: rePassword??this.rePassword, userName: userName??this.userName);
}

}