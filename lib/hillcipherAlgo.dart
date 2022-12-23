import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/services.dart';

class HillCipherAlgo extends StatefulWidget {
  const HillCipherAlgo({super.key});

  @override
  State<HillCipherAlgo> createState() => _HillCipherAlgoState();
}

Widget matrixElement(TextEditingController t){
  return Container(
                    width: 50,
                    height: 50,
                    child:TextField(
                      controller: t,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        isDense: true,
                        filled: true,
                        fillColor: Color(0xff1C1C26),
                        border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8)
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged:(value){},                            
                     ),
                  );
}

class _HillCipherAlgoState extends State<HillCipherAlgo> with TickerProviderStateMixin {

  var alphabets = {
  'a': 0,
  'b': 1,
  'c': 2,
  'd': 3,
  'e': 4,
  'f': 5,
  'g': 6,
  'h': 7,
  'i': 8,
  'j': 9,
  'k': 10,
  'l': 11,
  'm': 12,
  'n': 13,
  'o': 14,
  'p': 15,
  'q': 16,
  'r': 17,
  's': 18,
  't': 19,
  'u': 20,
  'v': 21,
  'w': 22,
  'x': 23,
  'y': 24,
  'z': 25,
};

var alphabetnew = {
  0: 'a',
  1: 'b',
  2: 'c',
  3: 'd',
  4: 'e',
  5: 'f',
  6: 'g',
  7: 'h',
  8: 'i',
  9: 'j',
  10: 'k',
  11: 'l',
  12: 'm',
  13: 'n',
  14: 'o',
  15: 'p',
  16: 'q',
  17: 'r',
  18: 's',
  19: 't',
  20: 'u',
  21: 'v',
  22: 'w',
  23: 'x',
  24: 'y',
  25: 'z'
};


  TextEditingController plainTextcontroller = TextEditingController();
  TextEditingController cipherTextcontroller = TextEditingController();
  TextEditingController m00 = TextEditingController();
  TextEditingController m01 = TextEditingController();
  TextEditingController m02 = TextEditingController();
  TextEditingController m10 = TextEditingController();
  TextEditingController m11 = TextEditingController();
  TextEditingController m12 = TextEditingController();
  TextEditingController m20 = TextEditingController();
  TextEditingController m21 = TextEditingController();
  TextEditingController m22 = TextEditingController();

  
List key = [];
String output = "";

int _currentIndex = 0;
TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
    
}


void computeMatrix(){
  if(!m00.text.isEmpty&&!m00.text.isEmpty&&!m01.text.isEmpty&&!m02.text.isEmpty&&!m10.text.isEmpty&&!m11.text.isEmpty&&!m12.text.isEmpty&&!m20.text.isEmpty&&!m21.text.isEmpty&&!m22.text.isEmpty){
    key = [
      [int.parse(m00.text),int.parse(m01.text),int.parse(m02.text)],
      [int.parse(m10.text),int.parse(m11.text),int.parse(m12.text)],
      [int.parse(m20.text),int.parse(m21.text),int.parse(m22.text)],
    ];
  }
}

String getCipher(){
  List trigraph = [];
  List corrTrigraph = [];
  List matrixMul = [];
  String plainText = "";
  // for replacing spaces
  plainText = plainTextcontroller.text.replaceAll(" ", "");
  plainText = plainText.toLowerCase();
  print(plainText);

  // for filler letter
  
  while(plainText.length%3!=0){
      plainText += 'x';
  }

  int trigraphNumber = plainText.length ~/ 3;

  print(plainText);
  

  // producing empty trigraph list
  for (int i = 0; i < plainText.length; i += 3) {
    trigraph.add(plainText.substring(i, i + 3));
  }

  // producing empty corresponding trigraph list
  for (int i = 0; i < 1; i++) {
    for (int j = 0; j < trigraphNumber; j++) {
      corrTrigraph.add([]);
    }
  }

  // producing emoty matrix for result
  for (int i = 0; i < 1; i++) {
    for (int j = 0; j < trigraphNumber; j++) {
      matrixMul.add([]);
    }
  }

  // adding items to corresponding trigraph list
  for (int i = 0; i < trigraph.length; i++) {
    corrTrigraph[i].clear();
    for (int j = 0; j < trigraph[i].length; j++) {
      corrTrigraph[i].add(alphabets[trigraph[i][j]]);
    }
  }

  // matrix multiplication
  int m = 0;
  num value = 0;
  for(int k=0;k<corrTrigraph.length;k++){
  matrixMul[m].clear();
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      value += corrTrigraph[k][j] * key[j][i];
    }
    matrixMul[m].add(value % 26);
    value = 0;
  }
  m+=1;
}

  // print cipher text
  List cipher=[];
  for(int i=0; i<matrixMul.length;i++){
    for(int j=0; j<3; j++){
      cipher.add(alphabetnew[matrixMul[i][j]]);
    }
    
  }
  return cipher.join();
}


Widget encryptPage(){
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 20),
    child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Message', style: TextStyle(letterSpacing: 2, fontSize: 20 ,fontWeight: FontWeight.w400,color:Color(0xff869EA5)),),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: plainTextcontroller,
                    onChanged: (value){
                      
                    },
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
            
                      hintText: 'Plain Text',
            
                      hintStyle: TextStyle(color: Color(0xff869EA5), letterSpacing: 1, fontSize: 14),
                      filled: true,
                      fillColor: Color(0xff1C1C26),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none
                      ),
                      
                    ),
                  ),
                  SizedBox(height: 10,),
                  GestureDetector(
                  onTap: (){  
                    computeMatrix();  
                    print(key);
                    print(getCipher());
                    setState(() {
                      output = getCipher();    
                    });
                         
                    
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      width: width/4,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color(0xff1C1C26),),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/connected-circle.png", height: 7),
                          SizedBox(width: 5,),
                          Center(child: Text('Convert', style: TextStyle(color: Color(0xff869EA5),)),
                       ) ],
                      ),),
                  ),
                ),
                SizedBox(height: 20,),
                    Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Key', style: TextStyle(letterSpacing: 2, fontSize: 20 ,fontWeight: FontWeight.w400,color:Color(0xff869EA5)),),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  
                  Row(
                    children: [
                      matrixElement(m00),
                      SizedBox(width:10),
                      matrixElement(m01),
                      SizedBox(width:10),
                      matrixElement(m02),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      matrixElement(m10),
                      SizedBox(width:10),
                      matrixElement(m11),
                      SizedBox(width:10),
                      matrixElement(m12),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      matrixElement(m20),
                      SizedBox(width:10),
                      matrixElement(m21),
                      SizedBox(width:10),
                      matrixElement(m22),
                    ],
                  ),
                  SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Encrypted Text', style: TextStyle(letterSpacing: 2, fontSize: 20 ,fontWeight: FontWeight.w400,color:Color(0xff869EA5)),),
                  ],
                ),
                SizedBox(height: 20,),
                Container(
                  width: 500,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xff1C1C26),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(output, style: TextStyle(color: Color(0xff869EA5)),),
                  )),
                  SizedBox(height: 5,),
              Row(children: [
                 GestureDetector(
                  onTap: () async {
                      await Clipboard.setData(ClipboardData(text: output));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      width: width/4,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color(0xff1C1C26),),
                      child: Center(child: Text('Copy', style: TextStyle(color: Colors.white),)),),
                  ),
                ),
                 GestureDetector(
                  onTap: (){
                    print('test1');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      width: width/4,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color(0xff1C1C26),),
                      child: Center(child: Text('Export',style: TextStyle(color: Colors.white),)),),
                  ),
                )
              ],),
                  ],
                ),
              ),
  );
}

Widget decryptPage(){
  return Center(
    child: Text('Coming Soon...', style: TextStyle(color: Color(0xff26262e), letterSpacing: 2,),),
  );
}

 var size, width,height;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold( 
      backgroundColor: Color(0xff0f0f11),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff1c1c26),
        title: Text('HILL CIPHER',style: TextStyle(color: Colors.white, fontSize: 14, letterSpacing: 2,),),),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: Column(children: [
            SizedBox(height: 20,),
            Container(
              height: 45,
              width: 250,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(25)
              ),
              
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Color.fromARGB(100, 0, 247, 255),
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                tabs: [
                  Tab(
                    text: "Encrypt",
                  ),
                  Tab(
                    text: "Decrypt",
                  ),
              ]),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  encryptPage(),
                  decryptPage(),
                ]),
                )
          ]),
        ),
    );
  }
}