import "package:fishmartmobile/screens/expensesScreen.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";

import "../components/alertComponent.dart";
import "../components/decoratedButton.dart";
import "../components/decorated_input.dart";
import "../components/loadingComponent.dart";
import "../constants/colors.dart";
import "../services/networkOperations.dart";

class ExpensesInfoScreen extends StatefulWidget {
  const ExpensesInfoScreen({super.key});

  static String routeName = "/expense-info";

  @override
  State<ExpensesInfoScreen> createState() => _ExpensesInfoScreenState();
}

class _ExpensesInfoScreenState extends State<ExpensesInfoScreen> {
  
  //define form key
  //used for form validation
  final GlobalKey<FormState> __formKey = GlobalKey<FormState>();

  //define email and password controllers
  //hold the data from user input
  var nameController = TextEditingController();
  var amountController = TextEditingController();
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

              Navigator.pushNamedAndRemoveUntil(context, ExpensesScreen.routeName, (route) => false);
            },
            )
        ),

        title: Container(
          child: Text("Add an expense record", style: const TextStyle(fontFamily: "Poppins-Medium", fontSize: 18),) ,
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
                         const Text("Add a new expense record", style: const TextStyle(fontFamily: "Poppins-Medium", fontSize: 17),),

                        const Divider(color: lightGreyColor,),
                                
                        Container(
                          child: Column(
                            children: <Widget>[

                              Form(
                                key: __formKey,
                                child: Column(
                                  children: <Widget>[

                                      DecoratedInputBox(
                                        controller: nameController,
                                        hintText: "Enter expense name",
                                        inputType: TextInputType.text,
                                        secureText: false,
                                        label: "Expense Name",
                                        icon: const Icon(Icons.person_outline_sharp, color: primaryColor,size: 25,),
                                        horizontalPadding: 2,
                                        verticalPadding: 2,
                                      ),

                                      const SizedBox(height: 20,),

                                      DecoratedInputBox(
                                        controller: amountController,
                                        hintText: "Enter expense amount",
                                        inputType: TextInputType.text,
                                        secureText: false,
                                        label: "Expense Amount",
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

                                          var expenseInfo = {
                                            "name": nameController.text,
                                            "amount": amountController.text,
                                            "description": descriptionController.text,
                                          };

                                          print(expenseInfo);

                                          var expenseResponse = await saveExpense(expenseInfo);

                                          print(expenseResponse);

                                          if (expenseResponse['message'] != null) {
                                            var message = expenseResponse['message'];
                                            setState(() {
                                                isLoading = false;
                                            });

                                            showAlertDialog(context, message, "Cheers! This expense was added successfully.", "exepnses", true);
                                            
                                          } else{

                                            //return error component
                                           showAlertDialog(context, "Whoops! Something went wrong, try again later", "Whoops! Something went wrong, try again later.", "expenses", false);
                                            
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