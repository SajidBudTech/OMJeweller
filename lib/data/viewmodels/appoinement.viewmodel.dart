import 'package:flutter_om_jeweller/data/viewmodels/base.viewmodel.dart';
import 'package:flutter_om_jeweller/constants/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_om_jeweller/constants/string/app.string.dart';
import 'package:intl/intl.dart';
import 'package:flutter_om_jeweller/data/models/loading_state.dart';
import 'package:flutter_om_jeweller/data/models/avaialable_slot.dart';
import 'package:flutter_om_jeweller/data/models/appointment.dart';
import 'package:flutter_om_jeweller/data/repositories/appointment.repository.dart';
import 'package:flutter_om_jeweller/bloc/auth.bloc.dart';

class AppointmentViewModel extends MyBaseViewModel {
  //BannerRepository instance
  LoadingState appointmentLoadingState = LoadingState.Loading;
  List<Appointment> appointmentslist=[];

  AppointmentRepository _appointmentRepository=AppointmentRepository();

  List<AvailableSlot> availableslotList = [];
  List<String> slotList=["11:00 AM","12:00 PM","01:00 PM","02:00 PM","03:00 PM",
    "04:00 PM","05:00 PM","06:00 PM","07:00 PM"];

   AppointmentViewModel(){
    AppStrings.selectedBookDate=DateFormat("yyyy-MM-dd").format(DateTime.now());
  }


//get all banners
  void fetchAppointmentDetailsDateWise() async {
    //add null data so listener can show shimmer widget to indicate loading
    setBusy(true);
    appointmentLoadingState=LoadingState.Loading;
    notifyListeners();
    try {

     /* courtData = await branchDetailsRepository.getCourtDetails(branchId: branchDetailsId,selectedDate: selectedDate);
      CourtDetailsList=courtData.courtDetails;
      equipmentDetailsList=courtData.equipmentDeatils;*/
      availableslotList.clear();

      for(String oneslot in slotList){
        AvailableSlot availableSlotone=AvailableSlot(slot: oneslot,active: false,partiallyactive: false);
        DateTime slotDate=new DateFormat('yyyy-MM-dd hh:mm aa').parse(AppStrings.selectedBookDate+" "+oneslot);
        DateTime newcurrentDate=DateTime.now();
        if(isCurrentDateIsAfter(newcurrentDate, slotDate)) {
          availableSlotone.active=true;
        }
        availableslotList.add(availableSlotone);
      }

      appointmentLoadingState=LoadingState.Done;
      notifyListeners();
    } catch (error) {
      //setError(error);
      appointmentLoadingState = LoadingState.Failed;
      notifyListeners();
      print("Error getting banners ==> $error");
    }
    setBusy(false);
  }


  bool isCurrentDateIsAfter(DateTime newCurrent,DateTime currentDate) {
    return newCurrent.compareTo(currentDate) > 0 ;
  }


  void getAllMyAppointment() async {
    //add null data so listener can show shimmer widget to indicate loading
    appointmentLoadingState = LoadingState.Loading;
    notifyListeners();
    final int userId=AuthBloc.getUserID();
    try {
      appointmentslist = await _appointmentRepository.getAllMyAppointment(userID: userId);
      appointmentLoadingState = LoadingState.Done;
      notifyListeners();
    } catch (error) {
      appointmentLoadingState = LoadingState.Failed;
      notifyListeners();
    }
  }

}
