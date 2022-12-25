library stepper_view;

import 'package:flutter/material.dart';
import 'btn_widget.dart';
import 'data/StepsDataModel.dart';


class StepperView extends StatefulWidget {

  StepperView({Key? key, required this.data,required this.numberOfSteps,this.onFinish}) :
        super(key: key);

  List<StepData>? data;
  int numberOfSteps;
  Function()? onFinish = (){};

  @override
  State<StepperView> createState() => _StepperViewState();
}

class _StepperViewState extends State<StepperView> {
  ThemeData theme = ThemeData();
  int _selectedIndex=0;
  int? stepNumber;
  List<StepperStates>currentStates = [];

  @override
  void didChangeDependencies() {
    generateInitialState(widget.numberOfSteps);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: ListView.builder(itemBuilder: (context,index){
          return IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    headerCircle(index),
                    const SizedBox(height: 5,),
                    Container(height: 16,width:isLastStep(index)?0:1,color: Colors.grey.shade400,),
                    Expanded(child: Container(height: double.infinity,width:isLastStep(index)?0:1,color: Colors.grey.shade400,)),
                    const SizedBox(height: 5,),
                  ],
                ),
                const SizedBox(width: 5,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const SizedBox(height: 10,),

                      Text(widget.data!.isNotEmpty? widget.data![index].title!:"Loading...",style:TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: currentStates[index] == StepperStates.disabled ? Colors.grey:Colors.black),),

                      const SizedBox(height: 10,),

                      isLastStep(index)?const Text("Last Step",style: TextStyle(fontSize: 12,
                          color: Colors.grey,fontWeight: FontWeight.bold),textAlign: TextAlign.justify):Container(),

                      const SizedBox(height: 10,),

                      Visibility(
                          visible: _selectedIndex == index ? true:false,
                          child: stepperBody(index)
                      ),

                    ],
                  ),
                )
              ],
            ),
          );
        },shrinkWrap: true,itemCount: widget.numberOfSteps,),
      ),
    ));
  }

  Widget stepperBody(int index){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10,),

        Text(widget.data!.isNotEmpty? widget.data![index].description!:"Loading...",style: const TextStyle(fontSize: 18,
            color: Colors.black),textAlign: TextAlign.justify),

        Row(
          children: [
            BtnWidget(text: isLastStep(index)?"Finish":"Continue",onTap:isLastStep(index)?widget.onFinish:(){
              if(!isLastStep(index)) {
                _moveForward(index);
              }

            },),
            BtnWidget(text: "Back",backgourndColor: Colors.white,
              textColor: _selectedIndex ==0 ?Colors.grey:Colors.blue,width: 50,onTap: (){

                if(index >0){
                  _moveBackWards(index);
                }

              },)
          ],
        )
      ],
    );
  }

  Widget headerCircle(int index){
    stepNumber = index+1;
    return Container(
      height: 40,
      width: 40,
      child: Center(child:currentStates[index] == StepperStates.complete ? const Icon(Icons.check,color: Colors.white,):
      Text("$stepNumber",style: const TextStyle(color: Colors.white),)),
      decoration: BoxDecoration(
          color: currentStates[index] == StepperStates.disabled ? Colors.grey:theme.primaryColor,
          shape: BoxShape.circle
      ),
    );
  }

  void _moveForward(int index){
    setState(() {
      _selectedIndex = index+1;
      currentStates[index] = StepperStates.complete;
      currentStates[index+1] =  StepperStates.enabled;
    });

  }

  void _moveBackWards(int index){
    setState(() {
      _selectedIndex = index-1;
    });

  }


  bool isLastStep(int index){

    if(currentStates.length == index+1){
      return true;
    }else{
      return false;
    }

  }

  generateInitialState(int steps){
    for(int i = 0;i<steps;i++){
      if(i==0){
        currentStates.add(StepperStates.enabled);
      }else{
        currentStates.add(StepperStates.disabled);
      }
    }
    setState(() {

    });
  }

}

enum StepperStates{
  disabled,
  enabled,
  complete
}

