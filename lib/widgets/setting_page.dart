import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController helpController = TextEditingController();
  bool isVisible = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    nameController.text = 'Jessica Liu';
    usernameController.text = '@Jeje_liu';
    helpController.text = 'Report a problem';
    bioController.text = 'Genius, Billionare, Playgirl';
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    usernameController.dispose();
    bioController.dispose();
    helpController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //1st Code
    /*Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: const Color(0xFFF5F6F7),
            child: ListView(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.33,
                  color: Colors.transparent,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                            right: 20,
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.settings),
                            onPressed: () {
                              setState(() {
                                isVisible=true;
                                print(isVisible);
                              });
                              // isVisible = false;
                            },
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.09,
                          ),
                          child: const CircleAvatar(
                            backgroundImage: AssetImage(
                              'assets/images/profile.jpg',
                            ),
                            radius: 47,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.07),
                          child: BlurryContainer(
                            borderRadius: BorderRadius.circular(10),
                            height: MediaQuery.of(context).size.height * 0.19,
                            width: MediaQuery.of(context).size.width * 0.37,
                            child: Container(
                              color: const Color(0x80F5F6F7),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.06,
                          ),
                          child: const CircleAvatar(
                            backgroundImage: AssetImage(
                              'assets/images/profile.jpg',
                            ),
                            radius: 40,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.2,
                            bottom: MediaQuery.of(context).size.height * 0.16,
                          ),
                          child: const CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: AssetImage(
                              'assets/images/verify.png',
                            ),
                            radius: 15,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.23,
                          ),
                          child: Column(
                            children: const [
                              Text(
                                'Jessica Liu',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: Text(
                                  '@Jeje_liu',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFFB2B6C0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 25,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset('assets/images/rank.png'),
                      makeDesign(3, 'Want'),
                      makeDesign(2, 'Watched'),
                      makeDesign(8, 'Series'),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ).copyWith(top: 10),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  height: MediaQuery.of(context).size.height * 0.485,
                  child: ListView(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: ElevatedButton(
                              style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                  Color(0xFF3544C4),
                                ),
                              ),
                              onPressed: () {},
                              child: const Text(
                                'Want',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: ElevatedButton(
                              style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                  Color(0xFFF5F6F7),
                                ),
                                foregroundColor: MaterialStatePropertyAll(
                                  Color(0xFF616161),
                                ),
                              ),
                              onPressed: () {},
                              child: const Text(
                                'Watched',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: ElevatedButton(
                              style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                  Color(0xFFF5F6F7),
                                ),
                                foregroundColor: MaterialStatePropertyAll(
                                  Color(0xFF616161),
                                ),
                              ),
                              onPressed: () {},
                              child: const Text(
                                'Series',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 170,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 6,
                          itemBuilder: (context, index) {
                            // bool fav=false;
                            return GestureDetector(
                              onTap: () {
                                // print('Clicked $index');
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MovieDetailScreen()),
                                  (Route<dynamic> route) => true,
                                );
                              },
                              child: Container(
                                width: 145,
                                margin: const EdgeInsets.only(right: 20),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(20),
                                  image: const DecorationImage(
                                    image: AssetImage(
                                      'assets/images/poster.png',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(top: 20, left: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          BlurryContainer(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 2,
                                              horizontal: 7,
                                            ),
                                            borderRadius: BorderRadius.circular(20),
                                            child: Row(
                                              children: const [
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.white,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(left: 5),
                                                  child: Text(
                                                    '7.2',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(right: 10),
                                            child: BlurryContainer(
                                              padding: const EdgeInsets.symmetric(
                                                vertical: 2,
                                                horizontal: 7,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: GestureDetector(
                                                onTap: () {},
                                                child: const Icon(
                                                  Icons.favorite_border,
                                                  color: Colors.white,
                                                  // ):const Icon(Icons.favorite,color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )*/

    //2nd Code
    /*isVisible
              ? Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  // color: const Color(0xFFF5F6F8),
                  color: Colors.transparent,
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.08,
                      ),
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isVisible = false;
                                    });
                                  },
                                  child: const Icon(
                                    Icons.horizontal_rule,
                                    size: 35,
                                  ),
                                ),
                                const Text(
                                  'Settings',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF35405A),
                                  ),
                                )
                              ],
                            ),
                            const Divider(
                              thickness: 1.2,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ).copyWith(
                                bottom: 20,
                              ),
                              height: MediaQuery.of(context).size.height * 0.79,
                              // color: Colors.yellow,
                              width: MediaQuery.of(context).size.width,
                              child: ListView(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: const [
                                        CircleAvatar(
                                          backgroundImage: AssetImage(
                                            'assets/images/profile.jpg',
                                          ),
                                          radius: 47,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: 40,
                                            left: 80,
                                          ),
                                          child: CircleAvatar(
                                            backgroundColor: Color(0xFFF5F6F7),
                                            radius: 15,
                                            child: Icon(
                                              Icons.camera_alt,
                                              color: Colors.black,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  labelText('Name'),
                                  textField(
                                    controller: nameController,
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  labelText('Username'),
                                  textField(
                                    controller: usernameController,
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  labelText('Bio'),
                                  textField(
                                    controller: bioController,
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  labelText('Gender'),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 7,
                                          horizontal: 20,
                                        ),
                                        margin: const EdgeInsets.only(
                                          right: 20,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          // color: Colors.blue,

                                          border: Border.all(
                                            width: 0.5,
                                            // color: Colors.blue,
                                            color: const Color(0xFF979797),
                                          ),
                                        ),
                                        child: const Text(
                                          'Male',
                                          style: TextStyle(
                                            color: Color(0xFF616161),
                                            // color: Colors.white,
                                            // fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 7,
                                          horizontal: 20,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.blue,
                                          border: Border.all(
                                            width: 0.5,
                                            // color: const Color(0xFF979797),
                                            color: Colors.blue,
                                          ),
                                        ),
                                        child: const Text(
                                          'Female',
                                          style: TextStyle(
                                            // color: Color(0xFF616161),
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  labelText('Help'),
                                  textField(
                                    isSuffix: true,
                                    controller: helpController,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: const Color(0xFF979797),
                                    ),
                                    margin: const EdgeInsets.only(
                                      top: 30,
                                      bottom: 80,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                    ),
                                    child: const Text(
                                      'Update',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Color(0xFF212121),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),*/
    return isVisible
        ? Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            // color: const Color(0xFFF5F6F7),
            color: Colors.transparent,
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1,
                ),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isVisible = false;
                              });
                            },
                            child: const Icon(
                              Icons.linear_scale,
                              size: 30,
                            ),
                          ),
                          const Text(
                            'Settings',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF35405A),
                              fontFamily: 'SF_Pro',
                            ),
                          )
                        ],
                      ),
                      const Divider(
                        thickness: 1.2,
                      ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ).copyWith(bottom: 20),
                        height: MediaQuery.of(context).size.height * 0.79,
                        // color: Colors.yellow,
                        width: MediaQuery.of(context).size.width,
                        child: ListView(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Stack(
                                alignment: Alignment.center,
                                children: const [
                                  CircleAvatar(
                                    backgroundImage: AssetImage(
                                      'assets/images/profile.jpg',
                                    ),
                                    radius: 47,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 40, left: 80),
                                    child: CircleAvatar(
                                      backgroundColor: Color(0xFFF5F6F7),
                                      radius: 15,
                                      child: Icon(
                                        Icons.camera_alt,
                                        color: Colors.black,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            labelText('Name'),
                            textField(
                              controller: nameController,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            labelText('Username'),
                            textField(
                              controller: usernameController,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            labelText('Bio'),
                            textField(
                              controller: bioController,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            labelText('Gender'),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 7,
                                    horizontal: 20,
                                  ),
                                  margin: const EdgeInsets.only(
                                    right: 20,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.blue,
                                    border: Border.all(
                                      width: 0.5,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  child: const Text(
                                    'Male',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'SF_Pro',
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 7, horizontal: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    // color: Colors.grey,
                                    border: Border.all(
                                      width: 0.5,
                                      color: const Color(0xFF979797),
                                    ),
                                  ),
                                  child: const Text(
                                    'Female',
                                    style: TextStyle(
                                      color: Color(0xFF616161),
                                      fontFamily: 'SF_Pro',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            labelText('Help'),
                            textField(
                              isSuffix: true,
                              controller: helpController,
                            ),
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: const Color(0xFF979797),
                              ),
                              margin: const EdgeInsets.symmetric(vertical: 30),
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                              ),
                              child: const Text(
                                'Update',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xFF212121),
                                  fontFamily: 'SF_Pro',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : Container(
            color: Colors.transparent,
          );
  }

  Widget labelText(String name) {
    return Text(
      name,
      style: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w400,
        color: Colors.grey[500],
        fontFamily: 'SF_Pro',
      ),
    );
  }

  Widget textField({
    bool isSuffix = false,
    required TextEditingController controller,
  }) {
    return SizedBox(
      height: 35,
      child: TextField(
        controller: controller,
        onChanged: (value) {
          // controller.text = value;
        },
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Color(0xFF353535),
          fontFamily: 'SF_Pro',
        ),
        decoration: InputDecoration(
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              width: 0.2,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              width: 0.5,
            ),
          ),
          suffixIcon: isSuffix
              ? const Icon(
                  Icons.arrow_forward_ios,
                )
              : const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.transparent,
                ),
        ),
      ),
    );
  }
}
