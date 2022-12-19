import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:clipboard/clipboard.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';


class CeaserCipher extends StatefulWidget {
  const CeaserCipher({super.key});

  @override
  State<CeaserCipher> createState() => _CeaserCipherState();
}

class _CeaserCipherState extends State<CeaserCipher> {
  var alphabets = {
  'a':0,
  'b':1,
  'c':2,
  'd':3,
  'e':4,
  'f':5,
  'g':6,
  'h':7,
  'i':8,
  'j':9,
  'k':10,
  'l':11,
  'm':12,
  'n':13,
  'o':14,
  'p':15,
  'q':16,
  'r':17,
  's':18,
  't':19,
  'u':20,
  'v':21,
  'w':22,
  'x':23,
  'y':24,
  'z':25,
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

  final fieldText = TextEditingController();
  final fieldText1 = TextEditingController();
  final fieldText2 = TextEditingController();
  String? plaintext;
  int len = 0;
  String output = "Encrypted Text here";
  String generateCipher(String plaintext){
    String cipherText = "";
    for(int i=0; i<plaintext.length; i++) {
      var char = plaintext[i];
      cipherText += alphabetnew[(alphabets[char]! + int.parse(fieldText1.text)) % 26]!;
    }
    return cipherText;
  }


  void clearText() {
    fieldText.clear();
  }

  Future<String> getFilePath() async {
    print('running1');
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
    String appDocumentsPath = appDocumentsDirectory.path;
    String filePath = '$appDocumentsPath/demoTextFile.txt'; 
    print(filePath);
    return filePath;
  }

   void saveFile(String output) async {
    print('running');
    File file = File(await getFilePath());
    file.writeAsString(output); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Color(0xff0F0F11),
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(onPressed: (){}, icon: Icon(Icons.error, color: Colors.white,)),
          ),
        ],
        elevation: 0,
        backgroundColor: Color(0xff1C1C26),
        title: Text('Ceaser Cipher', style: TextStyle(fontSize: 14 ,color: Colors.white, letterSpacing: 2),),),
        body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        child: SingleChildScrollView(child: Column(
          children: [
            SizedBox(height: 20,),
             Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Plain Text', style: TextStyle(letterSpacing: 2, fontSize: 20 ,fontWeight: FontWeight.w400,color:Color(0xff869EA5)),),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: fieldText,
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
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              GestureDetector(
                onTap: (){},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color(0xff1C1C26),),
                    child: Center(child: Text('Paste', style: TextStyle(color: Colors.white),)),),
                ),
              ),
               GestureDetector(
                onTap: clearText,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color(0xff1C1C26),),
                    child: Center(child: Text('Clear', style: TextStyle(color: Colors.white),)),),
                ),
              ),
              GestureDetector(
                onTap: (){                  
                  plaintext = fieldText.text;
                  plaintext = plaintext?.replaceAll(" ", "");
                  plaintext = plaintext?.toLowerCase();
                  
                  setState((){
                    
                    output = generateCipher(plaintext!);
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: 100,
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
              )
            ],),
            SizedBox(height: 30,),
            TextField(
              controller: fieldText1,
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Key',
                hintStyle: TextStyle(color: Color(0xff869EA5), fontSize: 14, letterSpacing: 1),
              
                filled: true,
                fillColor: Color(0xff1C1C26),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none
                ),
                
              ),
            ),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Cipher Text', style: TextStyle(letterSpacing: 2, fontSize: 20 ,fontWeight: FontWeight.w400,color:Color(0xff869EA5)),),
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
                child: Text(output!, style: TextStyle(color: Color(0xff869EA5)),),
              )),
            SizedBox(height: 30,),
            Row(children: [
               GestureDetector(
                onTap: () async {
                    await Clipboard.setData(ClipboardData(text: output));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color(0xff1C1C26),),
                    child: Center(child: Text('Copy', style: TextStyle(color: Colors.white),)),),
                ),
              ),
               GestureDetector(
                onTap: (){
                  print('test1');
                  saveFile(output!);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color(0xff1C1C26),),
                    child: Center(child: Text('Export',style: TextStyle(color: Colors.white),)),),
                ),
              )
            ],),
            SizedBox(
              height: 100,
            ),
          Text('Made with ❤️ by Vivek', style: TextStyle(fontWeight: FontWeight.w300, color: Color(0xff869EA5)),),
          SizedBox(
            height: 20,
          )
          ],
        ),),
      ),
    
        );
      }
    }