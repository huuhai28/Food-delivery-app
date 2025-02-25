import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Model/cart_model.dart';
import '../Provider/cart_provider.dart';
import '../Widgets/cart_items.dart';
import '../consts.dart'; // Import file màu của bạn

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = "Nguyễn Hữu Hải";
  String email = "nguyenhai281103@gmail.com";
  String location = "Hà Nội, Việt Nam";

  void _editProfile() {
    TextEditingController nameController = TextEditingController(text: name);
    TextEditingController emailController = TextEditingController(text: email);
    TextEditingController locationController =
        TextEditingController(text: location);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Chỉnh sửa thông tin"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: "Họ và tên")),
              TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: "Email")),
              TextField(
                  controller: locationController,
                  decoration: const InputDecoration(labelText: "Địa chỉ")),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Hủy"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: korange),
              onPressed: () {
                setState(() {
                  name = nameController.text;
                  email = emailController.text;
                  location = locationController.text;
                });
                Navigator.pop(context);
              },
              child: const Text("Lưu", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    List<CartModel> carts = cartProvider.carts.reversed.toList();
    return Scaffold(
      backgroundColor: kbgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: kpink,
                    backgroundImage: AssetImage('assets/profile_picture.png'),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name,
                          style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: kblack)),
                      Text(email,
                          style: const TextStyle(color: kyellow, fontSize: 16)),
                      Text(location,
                          style: const TextStyle(color: kblack, fontSize: 14)),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: korange,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: _editProfile,
                  child: const Text("Chỉnh sửa thông tin",
                      style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 380,
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12, blurRadius: 5, spreadRadius: 2)
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your Orders",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: kblack,
                      ),
                    ),
                    Container(
                      height: 300,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ...List.generate(
                              carts.length,
                              (index) => Container(
                                height: 145,
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(
                                  top: index == 0 ? 5 : 0,
                                  right: 20,
                                  left: 10,
                                  bottom: 10,
                                ),
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    FadeInUp(
                                      delay: Duration(
                                          milliseconds: (index + 1) *
                                              200), // after this animation is applied in all items one by one
                                      child: CartItems(
                                        cart: carts[index],
                                        showControls: false,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12, blurRadius: 5, spreadRadius: 2)
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Settings",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: kblack)),
                    SizedBox(height: 10),
                    ListTile(
                      leading: Icon(Icons.notifications, color: kblack),
                      title: Text("Notifications",
                          style: TextStyle(color: kblack)),
                    ),
                    ListTile(
                      leading: Icon(Icons.payment, color: kblack),
                      title: Text("Payment Methods",
                          style: TextStyle(color: kblack)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
