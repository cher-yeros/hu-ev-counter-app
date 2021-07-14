import 'package:flutter/material.dart';

class PageOne extends StatelessWidget {
  const PageOne({
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
                  'ያለ ምንም ምክኒያት እግዚአብሔር ይወደናል።',
                  style: TextStyle(
                    fontSize: 19,
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
                            'assets/images/one.jpg',
                            // height: 170,
                            width: size.width - 10,
                          )),
                          SizedBox(height: 30),
                          Text(
                            """በእርሱ የሚያምን ሁሉ የዘላለም ሕይወት እንዲኖረው
እንጂ እንዳይጠፋ እግዚአብሔር አንድያ ልጁን 
እስከ መስጠት ድረስ ዓለምን እንዲሁ ወዶአልና፤
  — ዮሐንስ 3፥16 (አዲሱ መ.ት)
ስለዚህም ለህይወታችን አስደናቂ ዕቅድ አዘጋጅቶልናል።
ክርስቶስ እንዲህ አለ:- “እኔ ሕይወት እንዲሆንላቸው እንዲበዛላቸውም መጣሁ።”
  — ዮሐንስ 10፥10
ነገር ግን ሰዎች ሁሉ ይህንን ሙሉና አርኪ ህይወት አልተለማመዱም ምክንያቱም. . .

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
