import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sayang_dibuang_mobile/core/providers/page_provider.dart';
import 'package:sayang_dibuang_mobile/core/theme/theme_color.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:sayang_dibuang_mobile/crowdfunding/utils/crowdfund_api_handler.dart';

class EditCrowdfundPage extends StatefulWidget {
  EditCrowdfundPage({super.key, required this.crowdfund});
  dynamic crowdfund;

  @override
  State<EditCrowdfundPage> createState() => _EditCrowdfundPageState();
}

class _EditCrowdfundPageState extends State<EditCrowdfundPage> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  int _received = 0;
  int _target = 0;

  @override
  void initState() {
    super.initState();

    _title = widget.crowdfund['title'];
    _description = widget.crowdfund['description'];
    _received = widget.crowdfund['received'];
    _target = widget.crowdfund['target'];
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarColor: ThemeColor.sand,
          systemNavigationBarColor: ThemeColor.sand,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: ThemeColor.sand,
          body: Column(
            children: [
              // Back Button
              Row(
                children: [
                  BackButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  const Text("Edit Crowdfund",
                      style: TextStyle(
                          fontFamily: 'Verona',
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              // Form
              Expanded(
                child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              initialValue: widget.crowdfund['title'],
                              decoration: InputDecoration(
                                hintText: "Dibutuhkan 20 karton telur",
                                labelText: "Judul",

                                // Menambahkan circular border agar lebih rapi
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                              // Menambahkan behavior saat nama diketik
                              onChanged: (String? value) {
                                setState(() {
                                  _title = value!;
                                });
                              },
                              // Menambahkan behavior saat data disimpan
                              onSaved: (String? value) {
                                setState(() {
                                  _title = value!;
                                });
                              },
                              // Validator sebagai validasi form
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Judul tidak boleh kosong!';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(
                              height: 24,
                            ),

                            // Description Field
                            TextFormField(
                              keyboardType: TextInputType.multiline,
                              maxLines: 10,
                              initialValue: widget.crowdfund['description'],
                              decoration: InputDecoration(
                                hintText: "Dibutuhkan 20 karton telur",
                                labelText: "Deskripsi",

                                // Menambahkan circular border agar lebih rapi
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                              // Menambahkan behavior saat nama diketik
                              onChanged: (String? value) {
                                setState(() {
                                  _description = value!;
                                });
                              },
                              // Menambahkan behavior saat data disimpan
                              onSaved: (String? value) {
                                setState(() {
                                  _description = value!;
                                });
                              },
                              // Validator sebagai validasi form
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Judul tidak boleh kosong!';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(
                              height: 24,
                            ),

                            // Received
                            TextFormField(
                              initialValue:
                                  widget.crowdfund['received'].toString(),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                  hintText: "10000",
                                  labelText: "Jumlah yang Diperoleh",
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: ThemeColor.darkGreen,
                                          width: 2.0)),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(5.0))),
                              onChanged: (String? received) {
                                setState(() {
                                  _received = (received!.isEmpty)
                                      ? 0
                                      : int.parse(received);
                                });
                              },
                              onSaved: (String? received) {
                                setState(() {
                                  _received = (received!.isEmpty)
                                      ? 0
                                      : int.parse(received);
                                });
                              },
                              validator: (String? received) {
                                if (int.parse(received!) < 0) {
                                  return "Nilai tidak boleh negatif!";
                                }
                                if (int.parse(received) > _target) {
                                  return "Jumlah diperoleh tidak boleh lebih besar dari jumlah diinginkan!";
                                }
                                return null;
                              },
                            ),

                            const SizedBox(
                              height: 24,
                            ),

                            // Received
                            TextFormField(
                              initialValue:
                                  widget.crowdfund['target'].toString(),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                  hintText: "10000",
                                  labelText: "Jumlah yang Diinginkan",
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(5.0))),
                              onChanged: (String? target) {
                                setState(() {
                                  _target = int.parse(target!);
                                });
                              },
                              onSaved: (String? target) {
                                setState(() {
                                  _target = int.parse(target!);
                                });
                              },
                              validator: (String? target) {
                                if (int.parse(target!) < 0) {
                                  return "Nilai tidak boleh negatif!";
                                }

                                return null;
                              },
                            ),

                            // Submit Button
                            const SizedBox(height: 24.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              ThemeColor.darkGreen),
                                    ),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        CrowdfundAPIHandler.editCrowdfund(
                                            request, widget.crowdfund['id'], {
                                          'csrfmiddlewaretoken':
                                              request.cookies['csrftoken'],
                                          'title': _title,
                                          'description': _description,
                                          'received': _received.toString(),
                                          'target': _target.toString(),
                                        });

                                        // Go back to crowdfunding main page (pop twice)
                                        Navigator.of(context).pop();
                                        Provider.of<PageProvider>(context,
                                                listen: false)
                                            .popInTab();
                                      }
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Simpan!",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Verona',
                                              fontSize: 16)),
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
