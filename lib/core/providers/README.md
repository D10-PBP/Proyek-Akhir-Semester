# Guide untuk Memakai PageProvider

### 1) Memasukkan screen utama setiap modul

Masukkan screen utama setiap modul ke list berikut:

```dart
class PageProvider extends ChangeNotifier {
  Widget currentPage;
  int currentPageIndex;
  List<Widget> history = [];
  List<Widget> mainPages = [
    // insert here
  ];
```

### 2) Pindah ke Halaman Lain

Gunakan method `push()` untuk pindah ke halaman lain. Hal ini serupa dengan menggunakan `Navigator.push()` bawaan Flutter.

Contoh penggunaan:

```dart
// Widget ini ada di page CrowdfundingsPage()
class UserCrowdfunds extends StatelessWidget {
  Future<List<Crowdfund>> crowdfunds;

  UserCrowdfunds({Key? key, required this.crowdfunds}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ...
    return ListView.builder(
        ..
        return GestureDetector(
            onTap: () {
            // Penggunaan push()
            // User akan pergi ke halaman yang dituju
            Provider.of<PageProvider>(context, listen: false).push(
                // argumen pertama: screen yang sekarang
                const CrowdfundingsPage(),
                // argumen kedua: screen yang ingin dituju
                UserCrowdfundPage(
                    crowdfund: snapshot.data[index],
                ));
            },
```

### 3) Kembali ke Halaman Sebelumnya

Gunakan method `pop()` untuk kembali ke halaman sebelumnya. Hal ini serupa dengan menggunakan `Navigator.pop()` bawaan Flutter.

Contoh penggunaan:

```dart
class UserCrowdfundPage extends StatefulWidget {
  ...
}

class _UserCrowdfundPageState extends State<UserCrowdfundPage> {
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      BackButton(
        onPressed: () {
          // Penggunaan pop()
          // User akan kembali ke halaman yang sebelumnya dituju
          Provider.of<PageProvider>(context, listen: false).pop();
        },
      ),
      ...
    ]);
  }
}
```
