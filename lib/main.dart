import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_taker2/model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'package:image_picker/image_picker.dart';

void main() {
  runApp(k());
}

class k extends StatefulWidget {
  @override
  _kState createState() => _kState();
}

class _kState extends State<k> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  File? image;
  ImagePicker picker = ImagePicker(); // object to pick image
  bool showSpinner = false ;

  TextEditingController textController = TextEditingController();
  String displayText = "";



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Upload"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
            SizedBox(

            height: 200.0,
            width: 200.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(123),
               child: Container(
                 color: Colors.black12,
                 child: image == null
                     ? Icon(
                   Icons.image,
                   size: 50,
                   color: Colors.black,
                 )
                     :
                    Image.file(
                     image!,
                     fit: BoxFit.fill,


                 ),
               ),
            )

            ),
                //width: MediaQuery.of(context).size.width,
          // decoration: BoxDecoration(
          //   color: Colors.green,
          //   borderRadius: BorderRadius.circular(100)),




              ElevatedButton.icon(label:Text(
                "Gallery",
                style: TextStyle(
                  color: Colors.yellow,
                ),
              ) ,
                onPressed: () {
                  getgall();
                },

                icon: Icon(Icons.photo),
                style: ElevatedButton.styleFrom(
                  primary: Colors.teal,
                    padding: EdgeInsets.symmetric(horizontal: 40)// Background color
                ),

              ),
              ElevatedButton.icon(
                label: Text(
                  "Camera",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  getcam();
                }, icon: Icon(Icons.add_a_photo_outlined),
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 40)
                ),
              ),
              ElevatedButton.icon(
                  onPressed: (){
                    print('delete');
                    delete();
                  },
                  icon: Icon(Icons.delete),
                  label: Text('Delete'),
              style: ElevatedButton.styleFrom(
                backgroundColor:Colors.deepOrange,
                padding: EdgeInsets.symmetric(horizontal: 40)
              ),
              ),
              ElevatedButton.icon(
                onPressed: (){
                  print('button pressed');

                },
                icon: Icon(Icons.arrow_circle_up),

                label: Text('Upload'),
                style: ElevatedButton.styleFrom(
                    backgroundColor:Colors.deepPurple,
                    padding: EdgeInsets.symmetric(horizontal: 40)

              )),
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: TextField(

                  controller: textController,
                  maxLines: null,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    label: Text('PHONE NUMBER'),
                    hintText: 'Entere phone no.',
                    border: OutlineInputBorder()
                  ),

                ),
              ),
              ElevatedButton(onPressed: (){
                // setState(() {
                //   displayText = textController.text;
                // });
                uploadPhotos(image!.path, textController.text);
              }, child: Text("Submit")),
              //Text(displayText,style: TextStyle(fontSize: 20),)
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getcam() async {
    // ignore: deprecated_member_use
    var img = await picker.getImage(source: ImageSource.camera);
    setState(() {
      image = File(img!.path);
    });
  }

  getgall() async {
    // ignore: deprecated_member_use
    var img = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      image = File(img!.path);
    });
  }

  delete() {
    setState(() {
      image=null;
    });
  }

  static const urlPrefix='https://api-ecart-vendor.rotam.ai/ecart/vendor/update-profile-pic/7676767676';

  Future<Welcome> updatePost( String img ,String phone) async {
    final url = Uri.parse(urlPrefix);
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({

      }),
    );

    if (response.statusCode == 200) {
      return Welcome.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update post');
    }

  }

  Future<String> uploadPhotos( paths,url) async{
    var request= http.MultipartRequest('POST',Uri.parse(urlPrefix));
    for (String path in paths)
      request.files.add(await http.MultipartFile.fromPath('image', path));

    http.StreamedResponse response= await request.send();
    var responseBytes = await response.stream.toBytes();
    var responseString = utf8.decode(responseBytes);

    if(response.statusCode==200){
      print(await response.stream.toBytes());
    }
    else{
      print(response.reasonPhrase);
    }
    return responseString;
  }

  // Future<void> uploadImage ()async{
  //
  //   setState(() {
  //     showSpinner = true ;
  //   });
  //
  //   var stream  = new http.ByteStream(image!.openRead());
  //   stream.cast();
  //
  //   var length = await image!.length();
  //
  //   var uri = Uri.parse(urlPrefix);
  //   //https://api-ecart-vendor.rotam.ai/ecart/vendor/update-profile-pic/7676767676
  //
  //   var request = http.put(Uri.parse(urlPrefix),headers:{
  //     'string':'img',
  //     'String':'phone',
  //   });
  //
  //
  //   request.fields['title'] = "Static title" ;
  //
  //   var multiport = http.MultipartFile(
  //       'image',
  //       stream,
  //       length);
  //
  //   request.files.add(multiport);
  //
  //   var response = await request.send() ;
  //
  //   print(response.stream.toString());
  //   if(response.statusCode == 200 || response.statusCode ==201){
  //     setState(() {
  //       showSpinner = false ;
  //     });
  //     print('image uploaded');
  //   }else {
  //     print('failed');
  //     setState(() {
  //       showSpinner = false ;
  //     });
  //
  //   }
  //
  // }
//
}
