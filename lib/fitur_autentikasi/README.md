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
    Hal ini dapat dilakukan dengan memanfaatkan `Consumer<CurrentUserProfileModel>` pada widget `Redirect`.

    ```dart
    class Redirect extends StatelessWidget {
        const Redirect({
            super.key,
            required this.currentWidget,
            required this.mainWidget,
            required this.destinationWidget,
        });

        final Widget currentWidget;
        final Widget mainWidget;
        final Widget destinationWidget;

        ...

        @override
        Widget build(BuildContext context) {
            return Consumer<CurrentUserProfileModel>(
                builder: ((context, profile, child) {
                    if (profile.hasCurrentUser()) {
                        return destinationWidget;
                    } else {
                        return mainWidget;
                    }
                }),
            );
        }
    }
    ```
    Pada contoh di atas, apabila `profile` yang merupakan instance dari `CurrentUserProfileModel` telah memiliki user yang sedang login, maka `child` dari widget `Consumer` adalah  `destinationWidget`. Perhatikan bahwa, pada kasus tersebut, destinationWidget yang akan ditampilkan pada screen.

    Perhatikan bahwa ketika instance dari `CurrentUserProfileModel` mengalami perubahan (ada pemanggilan fungsi `notifyListeners()`, seperti pada fungsi `addUser()` dan `removeUser()` pada `current_user_profile.dart`), fungsi `builder` dari widget `Consumer<CurrentUserProfileModel>` akan dipanggil untuk `rebuild` dan widget yang sesuai akan ditampilkan di screen (berdasarkan kondisi apakah ada user yang telah login atau tidak). 
    
    > Salah satu keuntungan penggunaan Consumer adalah widget di atasnya dalam widget tree tidak akan di-*rebuild*. 
    
    > Penjelasan Consumer dapat dilihat pada link berikut.<br>
        1. https://pub.dev/documentation/provider/latest/provider/Consumer-class.html<br> 
        2. https://docs.flutter.dev/development/data-and-backend/state-mgmt/simple

4. Redirect ke halaman login<br>
    Redirect dapat dilakukan dengan memanfaatkan fungsi static `loginHandler()` yang tersedia dari widget `Redirect`. Pada `TextButton` yang bertujuan untuk mengarahkan ke `screen` baru yang membutuhkan autentikasi, kalian dapat memanfaatkan `loginHandler()`. Contohnya sebagai berikut.

    ```dart
    import 'package:sayang_dibuang_mobile/fitur_autentikasi/widgets/redirect.dart';

    // Main Widget dapat diakses oleh publik
    // Main Widget befungsi sebagai widget yang ditampilkan ketika pengguna tidak terautentikasi
    class MainWidget extends StatelessWidget {
        const MainWidget({super.key});

        @override
        Widget build(BuildContext context) {
            return SafeArea(
                child: Center(
                    child: Container(
                        ...
                        child: Column(
                        ...
                        children: [
                            const Text(
                            "Halaman Login Demo",
                            style: TextStyle(fontSize: 32),
                            ),
                            TextButton(
                                ...
                                onPressed: Redirect.loginHandler(context,
                                    currentWidget: const MainWidget(),
                                    mainWidget: const MainWidget(),
                                    destinationWidget: const DestinationWidget()),
                                child: const Text(
                                "Button Redirect Login",
                                style: TextStyle(color: ThemeColor.white),
                                ))
                        ],
                        ),
                    ),
            ));
        }
    }
    ```
 
    - `currentWidget` adalah `widget` saat ini. 
    - `mainWidget` adalah `widget` yang akan ditampilkan ke user ketika user melakukan logout atau dengan kata lain `widget` yang akan ditampilkan ke pengguna publik (belum login).
    - `destinationWidget` adalah `widget` yang akan ditampilkan ke user yang telah login.
    > :warning: field `currentWidget` belum berfungsi apa-apa karena pembuat masih bingung :sweat_smile:)

    > Contoh lebih lengkap dapat dilihat pada [`demo.dart`](./demo_pages/demo.dart) pada folder `demo_pages`. 
    
    > Akses button demo pada `navigation bar` terletak sebelah kanan button `profile`.


5. Case Tambahan untuk Redirect<br>
    Apabila fitur dari awal hanya dapat diakses ketika pengguna telah login, seperti fitur *crowdfunding*. Kalian harus membuat 2 halaman: halaman pemberitahuan bahwa user harus login dan halaman utama. Lalu, tambahkan widget pemberitahuan pada [`page_provider_dart`](../core/providers/page_provider.dart). Contoh sebagai berikut.

    ```dart
    List<Widget> mainPages = [
         MessagePage(), 
        ...
    ];
    ```

    Lalu, pada widget `MessagePage()` tambahkan `TextButton` untuk login dengan `loginHandler()` seperti di atas.

    ```dart
    import 'package:sayang_dibuang_mobile/fitur_autentikasi/widgets/redirect.dart';

    class MessagePage extends StatelessWidget {
        const MessagePage({super.key});

        @override
        Widget build(BuildContext context) {
            return SafeArea(
                child: Center(
                    child: Container(
                        ...
                        child: Column(
                            ...
                            children: [
                            const Text("Login Message", style: TextStyle(fontSize: 32)),
                            TextButton(
                                ...
                                onPressed: Redirect.loginHandler(context,
                                    currentWidget: const MessagePage(),
                                    mainWidget: const MessagePage(),
                                    destinationWidget: const DestinationWidget()),
                                child: const Text(
                                    "Login untuk Akses Fitur",
                                    style: TextStyle(color: ThemeColor.white),
                                ))
                            ],
                        ),
            )));
            ;
        }
    }
    ```

    > Untuk mencoba hal di atas, kalian tinggal *uncomment* `MessagePage(),` dalam list `mainPages`.

6. Memperbarui poin user<br>
    Pembuat belum mengimplementasikan hal ini (ditunggu ya :sweat_smile:).


## Akun Dummy untuk Testing
| Username | Password |
| --- | --- |
| dummy | pbpsukses |
| dummy2 | pbpsukses |
