import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:sayang_dibuang_mobile/core/theme/theme_color.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/providers/loading.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/widgets/form_field.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentHeight = MediaQuery.of(context).size.height;
    final currentWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: ThemeColor.gold),
      body: ChangeNotifierProvider(
        create: (context) => Loading(),
        child: SafeArea(
          child: Center(
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.only(
                  top: 50, bottom: 50, left: 40, right: 40),
              width: (currentWidth > 500) ? 500 : double.infinity,
              height: currentHeight,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: ThemeColor.white),
              child: const Register(),
            ),
          ),
        ),
      ),
      backgroundColor: ThemeColor.sand,
    );
  }
}

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Text(
            "Register",
            style: TextStyle(
                fontFamily: "Verona",
                fontWeight: FontWeight.bold,
                fontSize: 32),
          ),
          Text(
            "Buat Akun Anda",
            style: TextStyle(
              fontFamily: "PlusJakarta",
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 30),
          const RegisterForm(),
        ],
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _registerFormKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;

  String username = "";
  String password1 = "";
  String password2 = "";
  String first_name = "";
  String last_name = "";
  String email = "";
  String telephone = "";
  String whatsapp = "";
  String line = "";

  double widthForm = 300;
  double heightForm = 50;

  void setUsername(String? value) {
    setState(() {
      username = value!;
    });
  }

  void setPassword1(String? value) {
    setState(() {
      password1 = value!;
    });
  }

  void setPassword2(String? value) {
    setState(() {
      password2 = value!;
    });
  }

  void setFirstname(String? value) {
    setState(() {
      first_name = value!;
    });
  }

  void setLastname(String? value) {
    setState(() {
      last_name = value!;
    });
  }

  void setEmail(String? value) {
    setState(() {
      email = value!;
    });
  }

  void setTelephone(String? value) {
    setState(() {
      telephone = value!;
    });
  }

  void setWhatsapp(String? value) {
    setState(() {
      whatsapp = value!;
    });
  }

  void setLine(String? value) {
    setState(() {
      line = value!;
    });
  }

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return "Field tidak boleh kosong";
    }
    return null;
  }

  void togglePasswordView() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Form(
        key: _registerFormKey,
        child: Column(
          children: [
            SizedBox(
              width: widthForm,
              height: heightForm,
              child: TextFormFieldAuth(
                  placeholder: "Username",
                  setFieldState: setUsername,
                  validator: validator),
            ),
            const SizedBox(height: 10.0),
            SizedBox(
              width: widthForm,
              height: heightForm,
              child: TextFormFieldAuth(
                  placeholder: "Password",
                  obscureText: true,
                  setFieldState: setPassword1,
                  validator: validator),
            ),
            const SizedBox(height: 10.0),
            SizedBox(
              width: widthForm,
              height: heightForm,
              child: TextFormFieldAuth(
                  placeholder: "Konfirmasi Password",
                  obscureText: true,
                  setFieldState: setPassword2,
                  validator: validator),
            ),
            const SizedBox(height: 10.0),
            SizedBox(
              width: widthForm,
              height: heightForm,
              child: TextFormFieldAuth(
                  placeholder: "Nama depan",
                  setFieldState: setFirstname,
                  validator: validator),
            ),
            const SizedBox(height: 10.0),
            SizedBox(
              width: widthForm,
              height: heightForm,
              child: TextFormFieldAuth(
                  placeholder: "Nama belakang",
                  setFieldState: setLastname,
                  validator: validator),
            ),
            const SizedBox(height: 10.0),
            SizedBox(
              width: widthForm,
              height: heightForm,
              child: TextFormFieldAuth(
                  placeholder: "Email (Ex: sayangdibuang@gmail.com)",
                  setFieldState: setEmail,
                  validator: validator),
            ),
            const SizedBox(height: 10.0),
            SizedBox(
              width: widthForm,
              height: heightForm,
              child: TextFormFieldAuth(
                  placeholder: "Nomor telepon (+62/62/08xxx)",
                  setFieldState: setTelephone,
                  validator: validator),
            ),
            const SizedBox(height: 10.0),
            SizedBox(
              width: widthForm,
              height: heightForm,
              child: TextFormFieldAuth(
                  placeholder: "Nomor whatsapp (+62/62/08xxx)",
                  setFieldState: setWhatsapp,
                  validator: validator),
            ),
            const SizedBox(height: 10.0),
            SizedBox(
              width: widthForm,
              height: heightForm,
              child: TextFormFieldAuth(
                  placeholder: "ID Line",
                  setFieldState: setLine,
                  validator: validator),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(ThemeColor.gold),
                ),
                onPressed: () async {
                  context.read<Loading>().toggleLoading();
                  if (_registerFormKey.currentState!.validate()) {}
                  if (!mounted) return;
                  context.read<Loading>().toggleLoading();
                },
                child: SizedBox(
                    height: 40,
                    width: 200,
                    child: Center(
                      child: Consumer<Loading>(
                        builder: (context, loading, child) {
                          return (!loading.isLoading())
                              ? const Text(
                                  "Daftar",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "PlusJakarta",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      "Daftar",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "PlusJakarta",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    SizedBox(
                                      width: 10,
                                      height: 10,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                );
                        },
                      ),
                    ))),
          ],
        ));
  }
}
