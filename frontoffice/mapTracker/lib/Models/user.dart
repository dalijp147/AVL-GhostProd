
class AppUser {

  String id;
  String name;
  String phone;
  String? email;
  String? pwd;
  String? address;
  String? isChan;

  AppUser({
    this.id = 'no-id',
    this.email = 'no-email',
    this.name = 'no-name',
    this.pwd  = 'no-pwd',
    this.phone  = 'no-phone',
    this.address  = 'no-address',
    this.isChan  = 'false',

  });
}
