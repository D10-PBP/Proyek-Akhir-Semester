# Fitur Autentikasi
Fitur autentikasi bertujuan agar fitur tertentu hanya dapat diakses ketika pengguna telah terdaftar dan login (terautentikasi).

***

## Dokumentasi
1. Login dan Logout<br>
Akses button profile pada `navigation bar` (terletak paling kanan) dan lakukan login atau logout.

2. Pengaksesan data profil user yang sedang login<br>
Fitur autentikasi memanfaatkan state management berupa [provider](https://pub.dev/packages/provider) package. Oleh karena itu, untuk mengakses data profil user, sintaks dari provider package yang sesuai harus digunakan. Berikut cara penggunaannya.

    ```dart
    import 'package:provider/provider.dart';
    import 'package:sayang_dibuang_mobile/fitur_autentikasi/models/user_profile.dart';

    ...

    // build method pada stateless ataupun stateful widget
    @override
    Widget build(BuildContext context) {
        final profile = context.read<CurrentUserProfileModel>();
        
        // Perhatikan widget yang di-return bisa tidak harus Column
        // Penggunaan Column di sini hanya untuk mempermudah
        return Column(
            children: [
                Text(profile.user!.username),
                Text(profile.user!.email),
                Text(profile.user!.poin.toString()), // tipe data poin adalah int
                Text(profile.user!.fullname),
                Text(profile.user!.telephone),
                Text(profile.user!.whatsapp),
                Text(profile.user!.line),
            ]);
    }
    ```
    > Field di atas hanya dapat diakses ketika user sedang login

    Perhatikan bahwa `profile.user!` hanya dapat digunakan ketika user telah login. Hal ini dikarenakan kita dapat memastikan bahwa `profile.user != null` setelah user login. 

    Ketika user belum login, `profile.user == null`. Oleh karena itu, hati-hati dalam mengakses field (Pastikan bahwa ada user yang sedang login [cara memvalidasi user ada di bawah]).

3. Memvalidasi apakah ada user yang telah login<br>
Hal ini dapat dilakukan dengan memanfaatkan `Consumer<CurrentUserProfileModel>`. Berikut contoh bagaimana memvalidasi apakah user telah login untuk halaman profil.

    ```dart
    class Profile extends StatelessWidget {
        const Profile({super.key});

        @override
        Widget build(BuildContext context) {
            return SafeArea(
            child: Center(child: Consumer<CurrentUserProfileModel>(
                builder: ((context, profile, child) {
                return (profile.hasCurrentUser())
                    ? const ProfileUser()
                    : const ProfileLogin();
                }),
            )),
            );
        }
    }
    ```
    Pada contoh di atas, apabila `profile` yang merupakan instance dari `CurrentUserProfileModel` telah memiliki user yang sedang login, maka `child` dari widget `Center` adalah  `ProfileUser()`.

    Perhatikan bahwa ketika instance dari `CurrentUserProfileModel` mengalami perubahan (ada pemanggilan fungsi `notifyListeners()`, seperti pada fungsi `addUser()` dan `removeUser()` pada `current_user_profile.dart`), fungsi `builder` dari widget `Consumer<CurrentUserProfileModel>` akan dipanggil untuk `rebuild`. Salah satu keuntungan penggunaan Consumer adalah widget di atasnya dalam widget tree tidak akan di-*rebuild*. 
    
    Penjelasan Consumer dapat dilihat pada link berikut.
    1. https://pub.dev/documentation/provider/latest/provider/Consumer-class.html 
    2. https://docs.flutter.dev/development/data-and-backend/state-mgmt/simple

4. Redirect ke halaman login<br>
Pembuat belum mengimplementasikan hal ini (ditunggu ya :sweat_smile:).

5. Memperbarui poin user<br>
Pembuat belum mengimplementasikan hal ini (ditunggu ya :sweat_smile:).



## Akun Dummy untuk Testing
| Username | Password |
| --- | --- |
| dummy | pbpsukses |
| dummy2 | pbpsukses |
