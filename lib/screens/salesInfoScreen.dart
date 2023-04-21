import "package:fishmartmobile/components/alertComponent.dart";
import "package:fishmartmobile/screens/salesScreen.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";

import "../components/decoratedButton.dart";
import "../components/decorated_input.dart";
import "../components/errorComponent.dart";
import "../components/loader.dart";
import "../components/loadingComponent.dart";
import "../constants/colors.dart";
import "../services/networkOperations.dart";
import "homeScreen.dart";
import 'package:fishmartmobile/globals.dart' as globals;

class SalesInfoScreen extends StatefulWidget {
  const SalesInfoScreen({super.key});

  static String routeName = "/sales-info";

  @override
  State<SalesInfoScreen> createState() => _SalesInfoScreenState();
}

class _SalesInfoScreenState extends State<SalesInfoScreen> {//define form key
  //used for form validation
  final GlobalKey<FormState> __formKey = GlobalKey<FormState>();

  //define email and password controllers
  //hold the data from user input
  var productNameController = TextEditingController();
  var priceController = TextEditingController();
  var quantityController = TextEditingController();
  var totalPriceController = TextEditingController();
  var descriptionController = TextEditingController();

  late bool isLoading;

   @override
    void initState() {
      // TODO: implement initState
      isLoading = false;
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: Container (
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 17),
          child: InkWell(
            child: SvgPicture.asset('assets/icons/back_icon.svg', height: 10,),
            onTap: (){

              Navigator.pushNamedAndRemoveUntil(context, SalesScreen.routeName, (route) => false);
            },
            )
        ),

        title: Container(
          child: Text("Add a sale record", style: const TextStyle(fontFamily: "Poppins-Medium", fontSize: 18),) ,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[

            //load header
            // TopViewWidget(
            //   heading: "Materials", 
            //   subHeading: location, 
            //   description: "Counting of Materials", 
            //   otherDescription: "status : "+locationStockTakingStatus+". You are "+((teamLead == "1"? "a Team Lead" : "not a Team Lead")), 
            //   flex: 1, 
            //   childView: true),

            //new header here


            //here is body of location screen
            SizedBox(height: 20,),
            Expanded(
              flex : 2,
              child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    alignment: Alignment.topLeft,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                                
                        //materials header
                         const Text("Add a new sale record", style: const TextStyle(fontFamily: "Poppins-Medium", fontSize: 17),),

                        const Divider(color: lightGreyColor,),
                                
                        Container(
                          child: Column(
                            children: <Widget>[

                              Form(
                                key: __formKey,
                                child: Column(
                                  children: <Widget>[

                                      DecoratedInputBox(
                                        controller: productNameController,
                                        hintText: "Enter product name",
                                        inputType: TextInputType.text,
                                        secureText: false,
                                        label: "Product Name",
                                        icon: const Icon(Icons.person_outline_sharp, color: primaryColor,size: 25,),
                                        horizontalPadding: 2,
                                        verticalPadding: 2,
                                      ),

                                      const SizedBox(height: 20,),

                                      DecoratedInputBox(
                                        controller: priceController,
                                        hintText: "Enter price",
                                        inputType: TextInputType.text,
                                        secureText: false,
                                        label: "Price",
                                        icon: const Icon(Icons.person_outline_sharp, color: primaryColor,size: 25,),
                                        horizontalPadding: 2,
                                        verticalPadding: 2,
                                      ),

                                      const SizedBox(height: 20,),

                                      DecoratedInputBox(
                                        controller: quantityController,
                                        hintText: "Enter quantity",
                                        inputType: TextInputType.text,
                                        secureText: false,
                                        label: "Quantity",
                                        icon: const Icon(Icons.person_outline_sharp, color: primaryColor,size: 25,),
                                        horizontalPadding: 2,
                                        verticalPadding: 2,
                                      ),

                                      const SizedBox(height: 20,),

                                      DecoratedInputBox(
                                        controller: totalPriceController,
                                        hintText: "Enter total price",
                                        inputType: TextInputType.text,
                                        secureText: false,
                                        label: "Total Price",
                                        icon: const Icon(Icons.person_outline_sharp, color: primaryColor,size: 25,),
                                        horizontalPadding: 2,
                                        verticalPadding: 2,
                                      ),

                                      const SizedBox(height: 20,),

                                      DecoratedInputBox(
                                        controller: descriptionController,
                                        hintText: "Enter description",
                                        inputType: TextInputType.text,
                                        secureText: false,
                                        label: "Description",
                                        icon: const Icon(Icons.person_outline_sharp, color: primaryColor,size: 25,),
                                        horizontalPadding: 2,
                                        verticalPadding: 2,
                                      ),

                                      const SizedBox(height: 20,),


                                      DecoratedButton(
                                        text: "SUBMIT",
                                        primaryColor: primaryColor,
                                        textColor: bgColor,
                                        onPressed: () async {
                                          // start loading
                                          setState(() {
                                            isLoading = true;
                                          });

                                          var saleInfo = {
                                            "productName": productNameController.text,
                                            "price": priceController.text,
                                            "quantity": quantityController.text,
                                            "totalPrice": totalPriceController.text,
                                            "description": descriptionController.text,
                                          };

                                          print(saleInfo);

                                          var saleResponse = await saveSale(saleInfo);

                                          print(saleResponse);

                                          if (saleResponse['message'] != null) {
                                            var message = saleResponse['message'];
                                            setState(() {
                                                isLoading = false;
                                            });

                                            showAlertDialog(context, message, "Cheers! This Sale was added successfully.", "sales", true);
                                          } else{

                                            var message = saleResponse['message'];

                                            //return error component
                                            showAlertDialog(context, message, "Whoops! Something bad has happened, try again later.", "sales", true);

                                            
                                          }
                                          
                                        },
                                        icon: Icons.add
                                      ),


                                  ],
                                )
                              )
                            ],
                          ),
                        ),

                        isLoading ? LoadingComponent() : Container(),
                                
                      ],
                    ),
                  ),
                ),
              )
          ],
        )
        ),
      
    );
  }
}