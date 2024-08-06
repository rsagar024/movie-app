import 'package:flutter/material.dart';
import 'package:movie_app/utils/global_variable.dart';
import 'package:movie_app/utils/notification_database_methods.dart';
import 'package:movie_app/utils/uni_services.dart';
import 'package:sqflite/sqflite.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  late NotificationDatabaseMethods _notificationDatabaseMethods;
  List _notify = [];
  bool isLoading = false;

  @override
  void initState() {
    setState(() {
      isLoading = true;
    });
    super.initState();
    getDatabase();
  }

  void getDatabase() async {
    _notificationDatabaseMethods = NotificationDatabaseMethods();
    Database notifyDatabase = await _notificationDatabaseMethods.notifyDatabase;
    if (notifyDatabase != null) {
      _notify = await _notificationDatabaseMethods.getNotifyList();
      setState(() {
        result = _notify.length;
        isLoading = false;
      });
    }
  }

  Future refresh() async {
    setState(() {
      _notify.clear();
      isLoading = true;
    });
    getDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          )
        : RefreshIndicator(
            onRefresh: refresh,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ).copyWith(top: 20),
              child: ListView.separated(
                itemCount: _notify.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      print(_notify[index].payload);
                      UniServices.uniHandler(Uri.parse(_notify[index].payload));
                    },
                    child: SizedBox(
                      height: 80,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(
                              right: 10,
                            ),
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 15,
                              backgroundImage: AssetImage(
                                'assets/images/logo.png',
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _notify[index].click == 0
                                        ? Text(
                                            _notify[index].title,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'SF_Pro',
                                            ),
                                          )
                                        : Text(
                                            _notify[index].title,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'SF_Pro',
                                              color: Colors.grey[500],
                                            ),
                                          ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 5,
                                        horizontal: 7,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.black12,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: _notify[index].click == 0
                                          ? Text(
                                              _notify[index].date,
                                              style: const TextStyle(
                                                fontSize: 8,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'SF_Pro',
                                                color: Colors.black,
                                              ),
                                            )
                                          : Text(
                                              _notify[index].date,
                                              style: TextStyle(
                                                fontSize: 8,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'SF_Pro',
                                                color: Colors.grey[500],
                                              ),
                                            ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 5,
                                  ),
                                  child: _notify[index].click == 0
                                      ? Text(
                                          _notify[index].body,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'SF_Pro',
                                          ),
                                          maxLines: 2,
                                        )
                                      : Text(
                                          _notify[index].body,
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'SF_Pro',
                                            color: Colors.grey[500],
                                          ),
                                          maxLines: 2,
                                        ),
                                ),
                                // Text(
                                //   '20-03-2024',
                                //   style: TextStyle(
                                //     fontSize: 13,
                                //     fontWeight: FontWeight.w400,
                                //     fontFamily: 'SF_Pro',
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          // IconButton(
                          //   onPressed: () {},
                          //   icon: Icon(
                          //     Icons.delete,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
  }
}
