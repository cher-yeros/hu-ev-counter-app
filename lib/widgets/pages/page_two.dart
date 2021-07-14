import 'package:flutter/material.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          // color: Colors.blue,
          // height: size.height,
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  'ኃጢአት ሰውን ከእግዚአብሔር ለይቷል።',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                      width: size.width,
                      // height: size.height * .64,

                      // margin: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          // color: Colors.black,
                          boxShadow: [
                            // BoxShadow(
                            //     offset: Offset(0, 5),
                            //     color: Colors.grey,
                            //     blurRadius: 30)
                          ]),
                      child: Column(
                        children: <Widget>[
                          Container(
                              // width: size.width * .8,
                              child: Image.asset(
                            'assets/images/two.jpg',
                            // height: 170,
                            width: size.width - 10,
                          )),
                          SizedBox(height: 30),
                          Text(
                            """“ሁሉ ኃጢአትን ሠርተዋልና የእግዚአብሔርም ክብር ጎድሎአቸዋል፤”
  — ሮሜ 3፥23
እግዚአብሔር ሰውን ሲፈጥረው ከእርሱጋ የቀረብ 
ግንኙነት በመመስረት በደስታ እንዲኖር ነበር። 
ነገር ግን ሰው በራሱ መንገድ ለመጓዝ በመምረጡ 
ግንኙነታቸው ተቋረጠ። በራሳችን መንገድ ስንጓዝ 
ለእግዚአብሔር ማንታዘዝና ለሱ ግድ የሌለን እንሆናለን።  
መፅሓፍ ቅዱስ ይህን አይነቱን አስተሳሰብ ነው ኃጢአት ብሎ የሚጠራው። 
""",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              letterSpacing: .1,
                            ),
                          )
                        ],
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
