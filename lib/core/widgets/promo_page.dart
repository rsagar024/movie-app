import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/global_variable.dart';

class PromoPage extends StatefulWidget {
  const PromoPage({Key? key}) : super(key: key);

  @override
  State<PromoPage> createState() => _PromoPageState();
}

class _PromoPageState extends State<PromoPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      result = 3;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 10,
            ),
            child: Stack(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 220,
                      decoration: BoxDecoration(
                        // color: Colors.blue,
                        image: const DecorationImage(
                          image: AssetImage('assets/images/notify/first.png'),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 80,
                      ),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: SizedBox(
                          height: 90,
                          child: Image.asset(
                              'assets/images/notify/first-suffix.png'),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        top: 40,
                        left: 40,
                      ),
                      child: Text(
                        'Discount 25% Just order\n3 ticket Now!',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Lexend',
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 90,
                        left: 40,
                      ),
                      child: Image.asset(
                        'assets/images/notify/button.png',
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 140,
                    left: 22,
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.81,
                    child: Image.asset(
                      'assets/images/notify/second.png',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 265,
                    left: 22,
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.81,
                    child: Image.asset(
                      'assets/images/notify/third.png',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
            bottom: 15,
          ),
          child: Text(
            '*The end of list :)',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.grey[500],
            ),
          ),
        )
      ],
    );
  }
}
