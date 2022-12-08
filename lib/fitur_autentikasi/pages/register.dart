import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:sayang_dibuang_mobile/core/theme/theme_color.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/models/error_message.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/providers/loading.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/utilities/auth.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/utilities/dialog.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/widgets/form_field.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/models/register_user.dart';

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
          backgroundColor: ThemeColor.darkGreen,
          shadowColor: Colors.transparent),
      body: ChangeNotifierProvider(
        create: (context) => Loading(),
        child: SafeArea(
          child: Center(
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 25, right: 25),
              width: (currentWidth > 500) ? 500 : double.infinity,
              height: currentHeight,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: ThemeColor.white),
              child: const Register(),
            ),
          ),
        ),
      ),
      backgroundColor: ThemeColor.darkGreen,
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
  late final RegisterUser registerUser;

  @override
  void initState() {
    super.initState();

    registerUser = RegisterUser(
        username: username,
        password1: password1,
        password2: password2,
        first_name: first_name,
        last_name: last_name,
        email: email,
        telephone: telephone,
        whatsapp: whatsapp,
        line: line);
  }

  String username = "";
  String password1 = "";
  String password2 = "";
  String first_name = "";
  String last_name = "";
  String email = "";
  String telephone = "";
  String whatsapp = "";
  String line = "";

  bool usernameValid = true;
  bool passwordValid = true;
  bool firstnameValid = true;
  bool emailValid = true;
  bool telephoneValid = true;
  bool whatsappValid = true;

  double widthForm = double.infinity;
  double heightForm = 50;

  TextStyle errorStyle = const TextStyle(
    color: Colors.red,
    fontSize: 0.01,
  );

  void setUsername(String? value) {
    setState(() {
      username = value!;
      registerUser.username = value;
    });
  }

  void setPassword1(String? value) {
    setState(() {
      password1 = value!;
      registerUser.password1 = value;
    });
  }

  void setPassword2(String? value) {
    setState(() {
      password2 = value!;
      registerUser.password2 = value;
    });
  }

  void setFirstname(String? value) {
    setState(() {
      first_name = value!;
      registerUser.first_name = value;
    });
  }

  void setLastname(String? value) {
    setState(() {
      last_name = value!;
      registerUser.last_name = value;
    });
  }

  void setEmail(String? value) {
    setState(() {
      email = value!;
      registerUser.email = value;
    });
  }

  void setTelephone(String? value) {
    setState(() {
      telephone = value!;
      registerUser.telephone = value;
    });
  }

  void setWhatsapp(String? value) {
    setState(() {
      whatsapp = value!;
      registerUser.whatsapp = value;
    });
  }

  void setLine(String? value) {
    setState(() {
      line = value!;
      registerUser.line = value;
    });
  }

  validator({String? type}) {
    return (String? value) {
      switch (type) {
        case "username":
          if (!usernameValid) return "";
          break;
        case "password":
          if (!passwordValid) return "";
          break;
        case "email":
          if (!emailValid) return "";
          break;
        case "telephone":
          if (!telephoneValid) return "";
          break;
        case "whatsapp":
          if (!whatsappValid) return "";
          return null;
      }

      if (value == null || value.isEmpty) {
        return "";
      }

      return null;
    };
  }

  void setValidState(ErrorMessage errorMessage) {
    setState(() {
      usernameValid = (errorMessage.username == null);
      passwordValid = (errorMessage.password2 == null);
      emailValid = (errorMessage.email == null);
      telephoneValid = (errorMessage.telephone == null);
      whatsappValid = (errorMessage.whatsapp == null);
    });
  }

  void resetValidState() {
    setState(() {
      usernameValid = true;
      passwordValid = true;
      emailValid = true;
      telephoneValid = true;
      whatsappValid = true;
    });
  }

  void checkInvalid(ErrorMessage errorMessage) {
    setValidState(errorMessage);
    _registerFormKey.currentState!.validate();
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
      child: Column(children: [
        SizedBox(
          width: widthForm,
          height: heightForm,
          child: Row(
            children: [
              Expanded(
                child: TextFormFieldAuth(
                  placeholder: "Username*",
                  setFieldState: setUsername,
                  validator: validator(type: "username"),
                  errorStyle: errorStyle,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextFormFieldAuth(
                  placeholder: "Password*",
                  obscureText: true,
                  setFieldState: setPassword1,
                  validator: validator(type: "password"),
                  errorStyle: errorStyle,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        SizedBox(
          width: widthForm,
          height: heightForm,
          child: TextFormFieldAuth(
            placeholder: "Konfirmasi Password*",
            obscureText: true,
            setFieldState: setPassword2,
            validator: validator(type: "password"),
            errorStyle: errorStyle,
          ),
        ),
        const SizedBox(height: 10.0),
        SizedBox(
          width: widthForm,
          height: heightForm,
          child: TextFormFieldAuth(
            placeholder: "Nama depan*",
            setFieldState: setFirstname,
            validator: validator(),
            errorStyle: errorStyle,
          ),
        ),
        const SizedBox(height: 10.0),
        SizedBox(
          width: widthForm,
          height: heightForm,
          child: TextFormFieldAuth(
            placeholder: "Nama belakang",
            setFieldState: setLastname,
            errorStyle: errorStyle,
          ),
        ),
        const SizedBox(height: 10.0),
        SizedBox(
          width: widthForm,
          height: heightForm,
          child: TextFormFieldAuth(
            placeholder: "Email*",
            setFieldState: setEmail,
            validator: validator(type: "email"),
            hintText: "Ex: sayangdibuang@gmail.com",
            errorStyle: errorStyle,
          ),
        ),
        const SizedBox(height: 10.0),
        SizedBox(
          width: widthForm,
          height: heightForm,
          child: TextFormFieldAuth(
            placeholder: "Nomor telepon*",
            setFieldState: setTelephone,
            validator: validator(type: "telephone"),
            hintText: "+62/62/08xxx",
            errorStyle: errorStyle,
          ),
        ),
        const SizedBox(height: 10.0),
        SizedBox(
          width: widthForm,
          height: heightForm,
          child: TextFormFieldAuth(
            placeholder: "Nomor whatsapp",
            setFieldState: setWhatsapp,
            hintText: "+62/62/08xxx",
            errorStyle: errorStyle,
            validator: validator(type: "whatsapp"),
          ),
        ),
        const SizedBox(height: 10.0),
        SizedBox(
          width: widthForm,
          height: heightForm,
          child: TextFormFieldAuth(
            placeholder: "ID Line",
            setFieldState: setLine,
            errorStyle: errorStyle,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Consumer<Loading>(
            builder: (context, loading, child) {
              return TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(ThemeColor.gold),
                ),
                onPressed: () async {
                  resetValidState();
                  context.read<Loading>().toggleLoading();
                  if (_registerFormKey.currentState!.validate()) {
                    final response =
                        await register(mounted, request, registerUser);

                    if (response.contains(RegExp("{.*}"))) {
                      ErrorMessage errorMessage =
                          errorMessageFromJson(response);
                      if (!mounted) return;
                      myDialog(context, errorMessage.toString(), height: 300);
                      checkInvalid(errorMessage);
                    } else {
                      if (!mounted) return;
                      myDialog(context, response);
                    }
                  } else {
                    myDialog(
                        context, "Field berbintang (*) tidak boleh kosong");
                  }

                  if (!mounted) return;
                  context.read<Loading>().toggleLoading();
                },
                child: child!,
              );
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
      ]),
    );
  }
}
