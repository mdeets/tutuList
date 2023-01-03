import QtQuick 2.15
import "calculateDates.js" as CD

Item
{

    signal monPicked; signal tuePicked; signal wedPicked;
    signal thuPicked; signal friPicked; signal satPicked; signal sunPicked;
    onMonPicked:{CD.pickWeek("monday",true,week1,week2,week3,week4,week5,week6);}
    onTuePicked:{CD.pickWeek("tuesday",true,week1,week2,week3,week4,week5,week6);}
    onWedPicked:{CD.pickWeek("wednesday",true,week1,week2,week3,week4,week5,week6);}
    onThuPicked:{CD.pickWeek("thursday",true,week1,week2,week3,week4,week5,week6);}
    onFriPicked:{CD.pickWeek("friday",true,week1,week2,week3,week4,week5,week6);}
    onSatPicked:{CD.pickWeek("saturday",true,week1,week2,week3,week4,week5,week6);}
    onSunPicked:{CD.pickWeek("sunday",true,week1,week2,week3,week4,week5,week6);}

    signal monUnpicked; signal tueUnpicked; signal wedUnpicked;
    signal thuUnpicked; signal friUnpicked; signal satUnpicked; signal sunUnpicked;
    onMonUnpicked: {CD.pickWeek("monday",false,week1,week2,week3,week4,week5,week6);}
    onTueUnpicked: {CD.pickWeek("tuesday",false,week1,week2,week3,week4,week5,week6);}
    onWedUnpicked: {CD.pickWeek("wednesday",false,week1,week2,week3,week4,week5,week6);}
    onThuUnpicked: {CD.pickWeek("thursday",false,week1,week2,week3,week4,week5,week6);}
    onFriUnpicked: {CD.pickWeek("friday",false,week1,week2,week3,week4,week5,week6);}
    onSatUnpicked: {CD.pickWeek("saturday",false,week1,week2,week3,week4,week5,week6);}
    onSunUnpicked: {CD.pickWeek("sunday",false,week1,week2,week3,week4,week5,week6);}






    id:root;
    anchors.fill: parent;
    property int pickMode: 2; // 1 -> only one pick          2 -> mutiple pick
    property bool setViewOnlyStatus:false;
    property int setMonth: 1;
    property int setYear: 2022;
    property variant setPickedDays: [];//it must be filled [2,...] !!!! not an int/string
    onSetPickedDaysChanged:
    {
        CD.pickedDays(setPickedDays,week1);
        CD.pickedDays(setPickedDays,week2);
        CD.pickedDays(setPickedDays,week3);
        CD.pickedDays(setPickedDays,week4);
        CD.pickedDays(setPickedDays,week5);
        CD.pickedDays(setPickedDays,week6);
    }

    property variant monthDays: CD.automaticMonth(setYear,setMonth);
    property int countColumns: CD.calculateColumns_of_MonthDays(monthDays.length);
    property variant monthDaysForShow: CD.automaticMonth(setYear,setMonth,true);//true parameter is for free spacer
    property variant extractDaysVar: [];

    signal goClearDays;
    onGoClearDays:
    {
        CD.resetAllSelectedElements(week1);
        CD.resetAllSelectedElements(week2);
        CD.resetAllSelectedElements(week3);
        CD.resetAllSelectedElements(week4);
        CD.resetAllSelectedElements(week5);
        CD.resetAllSelectedElements(week6);
//        monUnpicked(); tueUnpicked(); wedUnpicked();
//        thuUnpicked(); friUnpicked(); satUnpicked(); sunUnpicked();

    }

    signal goUniqDays;
    onGoUniqDays:
    {
        //remove duplicated values
        week1.outputPickedDays = CD.uniqBy(week1.outputPickedDays,JSON.stringify);
        week2.outputPickedDays = CD.uniqBy(week2.outputPickedDays,JSON.stringify);
        week3.outputPickedDays = CD.uniqBy(week3.outputPickedDays,JSON.stringify);
        week4.outputPickedDays = CD.uniqBy(week4.outputPickedDays,JSON.stringify);
        week5.outputPickedDays = CD.uniqBy(week5.outputPickedDays,JSON.stringify);
        week6.outputPickedDays = CD.uniqBy(week6.outputPickedDays,JSON.stringify);

        //LATER HERE REMOVE 0 numbers from ouputPickDAys LIKE UP CODE but with new function
    }


    signal ifDayIsntEmptyPush;

    onIfDayIsntEmptyPush:
    {
        if(week1.outputPickedDays.length>0)
            extractDaysVar.push(week1.outputPickedDays.toString());
        if(week2.outputPickedDays.length>0)
            extractDaysVar.push(week2.outputPickedDays.toString());
        if(week3.outputPickedDays.length>0)
            extractDaysVar.push(week3.outputPickedDays.toString());
        if(week4.outputPickedDays.length>0)
            extractDaysVar.push(week4.outputPickedDays.toString());
        if(week5.outputPickedDays.length>0)
            extractDaysVar.push(week5.outputPickedDays.toString());
        if(week6.outputPickedDays.length>0)
            extractDaysVar.push(week6.outputPickedDays.toString());

    }


    signal  cleanDays;
    onCleanDays:
    {
        goClearDays();
        extractDaysVar=[];
    }

    signal goExtractDays;
    onGoExtractDays:
    {
        goUniqDays();

        /*
            print values for check test (if needed copy these into somewhere before month/year going ++ or --
            but dont expect month/year will be correct becuse these codes dont know user pressed
            back or next month/year and will write next/back month/year inside the console so
            please move these codes into back/next month/year and when user press next --setyear/month
            or user pressed next ++setyear/month.
        */
        console.log("month= "+ setMonth + "\t year= " + setYear +" \tweek1= "+week1.outputPickedDays+ "\t week2= "+week2.outputPickedDays + "\t week3= " + week3.outputPickedDays + "\t week4= "+week4.outputPickedDays+ "\t week5= "+week5.outputPickedDays+ "\t week6= " + week6.outputPickedDays);

        if(week1.outputPickedDays.length>0 ||
                week2.outputPickedDays.length>0 ||
                week3.outputPickedDays.length>0 ||
                week4.outputPickedDays.length>0 ||
                week5.outputPickedDays.length>0 ||
                week6.outputPickedDays.length>0)
        {
            extractDaysVar.push(setYear,setMonth);
            ifDayIsntEmptyPush();
        }


        console.log(extractDaysVar);




//        for(var i=0; i<extractDaysVar.length; i++)
//            console.log(extractDaysVar[i]);



        //down code is old.
//        extractDaysVar[0] = setYear;
//        extractDaysVar[1] = setMonth;
//        extractDaysVar[2] = week1.outputPickedDays;
//        extractDaysVar[3] = week2.outputPickedDays;
//        extractDaysVar[4] = week3.outputPickedDays;
//        extractDaysVar[5] = week4.outputPickedDays;
//        extractDaysVar[6] = week5.outputPickedDays;
//        extractDaysVar[7] = week6.outputPickedDays;


        //make clear values and backgrounds from calendar and make em ready for next month/year
        //if remove these bottom codes, the next month will be selected monthdays and user didnt select those
//        goClearDays();
    }

    onSetMonthChanged: //BUTTON SAVE CLICKED
    {
        goClearDays();
    }
    onSetYearChanged:
    {
        goClearDays();
    }

    Column
    {
        anchors.fill: parent;
        Rectangle
        {
            width: parent.width;
            height: parent.height/countColumns;
            color:cBG_Unknown;
            MyWeekDayPicker
            {
                id:week1;
                setPickMode: pickMode;
                setMonthDayPicker:true;
                setViewOnly: setViewOnlyStatus;
                emptyTextForAll:"0"; //will set disable(false),opcity(zero),bgColor:unknonw(transparent) for '0' values
                setBaseRadius:100;
                textAPick:monthDaysForShow[0];
                textBPick:monthDaysForShow[1];
                textCPick:monthDaysForShow[2];
                textDPick:monthDaysForShow[3];
                textEPick:monthDaysForShow[4];
                textFPick:monthDaysForShow[5];
                textGPick:monthDaysForShow[6];
            }
        }
        Rectangle
        {
            width: parent.width;
            height: parent.height/countColumns;
            color:cBG_Unknown;
            MyWeekDayPicker
            {
                id:week2;
                setPickMode: pickMode;
                setMonthDayPicker:true;
                emptyTextForAll:"0";
                setBaseRadius:100;
                textAPick:monthDaysForShow[7];
                textBPick:monthDaysForShow[8];
                textCPick:monthDaysForShow[9];
                textDPick:monthDaysForShow[10];
                textEPick: monthDaysForShow[11];
                textFPick: monthDaysForShow[12];
                textGPick: monthDaysForShow[13];
                setViewOnly: setViewOnlyStatus;
            }
        }

        Rectangle
        {
            width: parent.width;
            height: parent.height/countColumns;
            color:cBG_Unknown;
            MyWeekDayPicker
            {
                id:week3;
                setPickMode: pickMode;
                setMonthDayPicker:true;
                emptyTextForAll:"0";
                setBaseRadius:100;
                textAPick:monthDaysForShow[14];
                textBPick:monthDaysForShow[15];
                textCPick:monthDaysForShow[16];
                textDPick:monthDaysForShow[17];
                textEPick: monthDaysForShow[18];
                textFPick: monthDaysForShow[19];
                textGPick: monthDaysForShow[20];
                setViewOnly: setViewOnlyStatus;
            }
        }


        Rectangle
        {
            width: parent.width;
            height: parent.height/countColumns;
            color:cBG_Unknown;
            MyWeekDayPicker
            {
                id:week4;
                setPickMode: pickMode;
                setMonthDayPicker:true;
                emptyTextForAll:"0";
                setBaseRadius:100;
                textAPick:monthDaysForShow[21];
                textBPick:monthDaysForShow[22];
                textCPick:monthDaysForShow[23];
                textDPick:monthDaysForShow[24];
                textEPick: monthDaysForShow[25];
                textFPick: monthDaysForShow[26];
                textGPick: monthDaysForShow[27];
                setViewOnly: setViewOnlyStatus;
            }
        }

        Rectangle
        {
            width: parent.width;
            height: parent.height/countColumns;
            color:cBG_Unknown;
            MyWeekDayPicker
            {
                id:week5;
                setPickMode: pickMode;
                setMonthDayPicker:true;
                emptyTextForAll:"0";
                setBaseRadius:100;
                textAPick:monthDaysForShow[28];
                textBPick:monthDaysForShow[29];
                textCPick:monthDaysForShow[30];
                textDPick:monthDaysForShow[31];
                textEPick: monthDaysForShow[32];
                textFPick: monthDaysForShow[33];
                textGPick: monthDaysForShow[34];
                setViewOnly: setViewOnlyStatus;
            }
        }

        Rectangle
        {
            width: parent.width;
            height: parent.height/countColumns;
            color:cBG_Unknown;
            MyWeekDayPicker
            {
                id:week6;
                setPickMode: pickMode;
                setMonthDayPicker:true;
                emptyTextForAll:"0";
                setBaseRadius:100;
                textAPick:monthDaysForShow[35];
                textBPick:monthDaysForShow[36];
                textCPick:monthDaysForShow[37];
                textDPick:monthDaysForShow[38];
                textEPick:monthDaysForShow[39];
                textFPick:monthDaysForShow[40];
                textGPick:monthDaysForShow[41];
                setViewOnly: setViewOnlyStatus;
            }
        }

    }
}

