import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:les_store_app/controllers/auth_controller.dart';
import 'package:les_store_app/provider/user_provder.dart';

class ShippingScreen extends ConsumerStatefulWidget {
  const ShippingScreen({super.key});

  @override
  _ShippingScreenState createState() => _ShippingScreenState();
}

class _ShippingScreenState extends ConsumerState<ShippingScreen> {
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  late TextEditingController stateController = TextEditingController();
  late TextEditingController cityController = TextEditingController();
  late TextEditingController localityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // read the current user data from the provider
    final user = ref.read(userProvder);

    // initialize the controllers with the current data if available
    //if user data is not available then initialize with empty string
    stateController = TextEditingController(text: user?.state ?? "");
    cityController = TextEditingController(text: user?.city ?? "");
    localityController = TextEditingController(text: user?.locality ?? "");
  }

  //show loading dialog
  _showLoadingDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 20),
                Text(
                  'Updating...',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    letterSpacing: 1.7,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.read(userProvder);
    final update = ref.read(userProvder.notifier);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Delivery Address',
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.7,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: globalKey,
          child: Column(
            children: [
              Center(
                child: Text(
                  'Where will your order\n be shipped',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    letterSpacing: 1.7,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                validator: (value) {
                  if (value == null || value!.isEmpty) {
                    return 'Please enter the state field';
                  } else {
                    return null;
                  }
                },
                controller: stateController,
                decoration: InputDecoration(labelText: 'State'),
              ),
              SizedBox(height: 20),
              TextFormField(
                validator: (value) {
                  if (value == null || value!.isEmpty) {
                    return 'Please enter the city field';
                  } else {
                    return null;
                  }
                },
                controller: cityController,
                decoration: InputDecoration(labelText: 'City'),
              ),
              SizedBox(height: 20),

              TextFormField(
                validator: (value) {
                  if (value == null || value!.isEmpty) {
                    return 'Please enter the locality field';
                  } else {
                    return null;
                  }
                },
                controller: localityController,
                decoration: InputDecoration(labelText: 'Locality'),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(12),
        child: InkWell(
          onTap: () async {
            if (globalKey.currentState!.validate()) {
              _showLoadingDialog();
              await AuthController()
                  .updateUserData(
                    context: context,
                    id: user!.id,
                    state: stateController.text,
                    city: cityController.text,
                    locality: localityController.text,
                  )
                  .whenComplete(() {
                    update.recreateUserState(
                      state: stateController.text,
                      city: cityController.text,
                      locality: localityController.text,
                    );
                    Navigator.pop(context); // close the dialog
                    Navigator.pop(context); // close the screen
                  });
            }
          },
          child: Container(
            height: 80,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Color(0xFF3854EE),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(
              child: Text(
                'Save Address',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
