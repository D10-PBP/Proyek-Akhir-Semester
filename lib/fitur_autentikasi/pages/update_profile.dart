import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:sayang_dibuang_mobile/core/theme/theme_color.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/models/error_message.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/models/update_user.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/providers/current_user_profile.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/providers/loading.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/utilities/auth.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/utilities/dialog.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/widgets/form_field.dart';

class UpdateProfilePage extends StatelessWidget {
  const UpdateProfilePage({super.key});

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
              child: const UpdateProfile(),
            ),
          ),
        ),
      ),
      backgroundColor: ThemeColor.darkGreen,
    );
  }
}

class UpdateProfile extends StatelessWidget {
  const UpdateProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [
          Text(
            "Perbauri Profil",
            style: TextStyle(
                fontFamily: "Verona",
                fontWeight: FontWeight.bold,
                fontSize: 32),
          ),
          SizedBox(height: 20),
          UpdateProfileForm(),
        ],
      ),
    );
  }
}

class UpdateProfileForm extends StatefulWidget {
  const UpdateProfileForm({super.key});

  @override
  State<UpdateProfileForm> createState() => _UpdateProfileFormState();
}

class _UpdateProfileFormState extends State<UpdateProfileForm> {
  final _updateProfileFormKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  late final UpdateUser updateUser;

  @override
  void initState() {
    super.initState();

    updateUser = UpdateUser(
        username: context.read<CurrentUserProfileModel>().user!.username,
        firstName: context.read<CurrentUserProfileModel>().user!.firstName,
        lastName: context.read<CurrentUserProfileModel>().user!.lastName,
        telephone: context.read<CurrentUserProfileModel>().user!.telephone,
        whatsapp: context.read<CurrentUserProfileModel>().user!.whatsapp,
        line: context.read<CurrentUserProfileModel>().user!.line);
  }

  String first_name = "";
  String last_name = "";
  String telephone = "";
  String whatsapp = "";
  String line = "";

  bool firstnameValid = true;
  bool telephoneValid = true;
  bool whatsappValid = true;

  double widthForm = double.infinity;
  double heightForm = 50;

  TextStyle errorStyle = const TextStyle(
    color: Colors.red,
    fontSize: 0.01,
  );

  void setFirstname(String? value) {
    setState(() {
      first_name = value!;
      updateUser.firstName = value;
    });
  }

  void setLastname(String? value) {
    setState(() {
      last_name = value!;
      updateUser.lastName = value;
    });
  }

  void setTelephone(String? value) {
    setState(() {
      telephone = value!;
      updateUser.telephone = value;
    });
  }

  void setWhatsapp(String? value) {
    setState(() {
      whatsapp = value!;
      updateUser.whatsapp = value;
    });
  }

  void setLine(String? value) {
    setState(() {
      line = value!;
      updateUser.line = value;
    });
  }

  validator({String? type}) {
    return (String? value) {
      switch (type) {
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
      telephoneValid = (errorMessage.telephone == null);
      whatsappValid = (errorMessage.whatsapp == null);
    });
  }

  void resetValidState() {
    setState(() {
      telephoneValid = true;
      whatsappValid = true;
    });
  }

  void checkInvalid(ErrorMessage errorMessage) {
    setValidState(errorMessage);
    _updateProfileFormKey.currentState!.validate();
  }

  void togglePasswordView() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final profile = context.read<CurrentUserProfileModel>();
    return Form(
      key: _updateProfileFormKey,
      child: Column(children: [
        const SizedBox(height: 10.0),
        SizedBox(
          width: widthForm,
          height: heightForm,
          child: TextFormFieldAuth(
            placeholder: "Username",
            initialValue: profile.user!.username,
            enabled: false,
          ),
        ),
        const SizedBox(height: 10.0),
        SizedBox(
          width: widthForm,
          height: heightForm,
          child: TextFormFieldAuth(
            placeholder: "Email",
            initialValue: profile.user!.email,
            enabled: false,
          ),
        ),
        const SizedBox(height: 10.0),
        SizedBox(
          width: widthForm,
          height: heightForm,
          child: TextFormFieldAuth(
            placeholder: "Poin",
            initialValue: profile.user!.poin.toString(),
            enabled: false,
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
            initialValue: profile.user!.firstName,
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
            initialValue: profile.user!.lastName,
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
            numberOnly: true,
            initialValue: profile.user!.telephone,
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
            numberOnly: true,
            initialValue: profile.user!.whatsapp,
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
            initialValue: profile.user!.line,
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
                  if (_updateProfileFormKey.currentState!.validate()) {
                    final response = await updateUserData(
                        profile, mounted, request, updateUser);

                    if (response.contains(RegExp("{.*}"))) {
                      ErrorMessage errorMessage =
                          errorMessageFromJson(response);
                      if (!mounted) return;
                      messageDialog(context, errorMessage.toString(),
                          height: 300);
                      checkInvalid(errorMessage);
                    } else {
                      if (!mounted) return;
                      messageDialog(context, response);
                    }
                  } else {
                    messageDialog(
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
                              "Perbarui",
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
                                  "Perbarui",
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
