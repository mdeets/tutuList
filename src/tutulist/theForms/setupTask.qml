import QtQuick 2.15
import "../theComponents/"
import "../theScripts/alltasks.js" as SaveTask
import "../theScripts/config.js" as Configs
import QtQuick.Controls 2.15


import "../theComponents/calendar" as TutuCalender

Page
{
    Component.onCompleted:
    {
        console.log("source : setupTask.qml -> form loaded.");
    }

    signal quitTheSetupTaskFrom;
    onQuitTheSetupTaskFrom:
    {
        console.log("source : setupTask.qml -> signal quitTheSetupTaskForm called.");
    }

    signal saveTheSetupTaskForm;
    onSaveTheSetupTaskForm:
    {
        console.log("source : setupTask.qml -> signal saveTheSetupTaskForm called.");
        const resultSave = SaveTask.addNewTask(taskTitle.get_entered_value,
                                               taskDescription.get_entered_value,
                                               taskPriority.get_entered_value,
                                               taskDeadline.get_entered_value,
                                               taskTimetoperform.get_entered_value);
        if(resultSave)
        {
            console.log("source : setupTask.qml -> i comfirm the task is created succrsfuyl.");
            quitTheSetupTaskFrom();
        }
        else
        {
            console.log("source : setupTask.qml -> failur to add new task. error="+resultSave);
        }
    }


    signal closeCalenderPicker;
    onCloseCalenderPicker:
    {
        baseCalenderPicker.visible=false;
        mainCalender.cleanDays(); //old numbers will keep inside this, so need to clean that for next or if user unselect and select app works fine next time.
        //in this case we just need a single day date.
    }


    Rectangle
    {
        id:local_root;
        height:parent.height;
        width: parent.width;
        anchors.centerIn:parent;
        color:appColors.c_background;
        MouseArea
        {
            anchors.fill: parent;
        }

        Rectangle
        {
            id:titleBar;
            width:parent.width;
            height:60;
            color:appColors.c_background;
            Rectangle
            {
                id:baseButtonBack;
                width:24;
                height:24;
                color:"transparent";
                radius:100;
                anchors
                {
                    verticalCenter: parent.verticalCenter;
                    left:parent.left;
                    leftMargin:15;
                }
                Image
                {
                    anchors.fill: parent;
                    source: appIcons.icon_back;
                }
                MouseArea
                {
                    anchors.fill: parent;
                    onClicked:
                    {
                        quitTheSetupTaskFrom();
                    }
                }
            }
            Text
            {
                anchors
                {
                    left:baseButtonBack.right;
                    leftMargin:25;
                    top:baseButtonBack.top;
                    topMargin:-5;
                }
                text:"New Task";
                font.pointSize: Configs.font_size_title
                color: appColors.c_font_title

            }
        }

        Rectangle
        {
            anchors
            {
                top:titleBar.bottom;
                topMargin:10;
                left:parent.left;
                right:parent.right;
                bottom:parent.bottom;
            }
            color:appColors.c_background


            ListView
            {
                anchors.fill:parent;

                GetAField_Form_with_Title_and_InputText
                {
                    id:taskTitle;
                    anchors.top:parent.top;
                    setLabel: "Title:";
                    setPlaceHolderInput: "enter the for title";
                }
                GetAField_Form_with_Title_and_InputText
                {
                    id:taskDescription
                    anchors.top:taskTitle.bottom;
                    setLabel: "Description:";
                    setPlaceHolderInput: "enter the for description";
                    setHeight:100;
                }

                GetAField_Form_with_Title_and_InputText
                {
                    id:taskPriority;
                    anchors.top:taskDescription.bottom;
                    setLabel: "Priority:";
                    setPlaceHolderInput: "enter the for priority";
                }
                GetAField_Form_with_Title_and_InputText
                {
                    id:taskDeadline
                    anchors.top:taskPriority.bottom;
                    setLabel: "Deadline:";
                    setPlaceHolderInput: "enter the for deadline";


                    //open/pick button Calender
                    Rectangle
                    {
                        id:openCalenderButton;
                        width:25
                        height:25
                        color:"transparent"
                        Image
                        {
                            id: iconOpenCalender;
                            source:appIcons.icon_calender;
                            width:25;
                            height:25;
                        }
                        anchors
                        {
                            verticalCenter: parent.verticalCenter
                            right: parent.right
                            rightMargin: parent.width/7
                        }
                        MouseArea
                        {
                            anchors.fill: parent;
                            onClicked:
                            {
                                console.log("source : setuptask.qml -> open canledner");
                                baseCalenderPicker.visible=true;
                            }
                        }
                    }

                }

                GetAField_Form_with_Title_and_InputText
                {
                    id:taskTimetoperform
                    anchors.top:taskDeadline.bottom;
                    setLabel: "Time To Perform:";
                    setPlaceHolderInput: "enter the for time to perform";
                }
                //button place.

                Rectangle
                {
                    width:parent.width/1.25;
                    height:40;
                    color:"transparent"
                    anchors
                    {
                        top:taskTimetoperform.bottom;
                        horizontalCenter:parent.horizontalCenter;
                    }
                    clip:true;
                    TutuButton
                    {
                        setRightButtonText:"Save";
                        setRightButtonBackColor: appColors.c_button_background;
                        setRightButtonFontColor: appColors.c_button_text;
                        setRightButtonBorderColor: "transparent";

                        setLeftButtonText: "Cancel";
                        setLeftButtonBackColor: appColors.c_button_background_cancel;
                        setLeftButtonFontColor: appColors.c_button_text//appColors.c_button_text_cancel;
                        setLeftButtonBorderColor: "transparent";

                        onLeftButtonClicked:
                        {
                            console.log("source : setupTask.qml -> cancel button clicked");
                            quitTheSetupTaskFrom();
                        }
                        onRightButtonClicked:
                        {
                            console.log("source : setupTask.qml -> save button clicked");
                            saveTheSetupTaskForm();
                        }
                    }
                }



            }


        }



        //Clander Picker.
        Rectangle
        {
            id:closeOpcityBox;
            anchors.fill: parent;
            color:"gray";
            opacity: 0.5;
            visible: baseCalenderPicker.visible
            MouseArea
            {
                anchors.fill: parent;
                onClicked:
                {
                    console.log("source : setuptask.qml -> background calender picker clicked. lets hide calender.");
                    closeCalenderPicker();
                }
            }
        }
        Rectangle
        {
            id:baseCalenderPicker;
            visible: false;
            width:350
            height:350;
            color:"transparent"
            anchors
            {
                centerIn:parent;
            }
            MouseArea  { anchors.fill: parent; } // to avoid hide when user clicked between day numbers.

            TutuCalender.TheCalendar
            {
                id:mainCalender;
            }
        }
        Rectangle
        {
            id:titleBarCalenderPicker;
            width: baseCalenderPicker.width;
            height:50;
            radius:30;
            color:appColors.c_input_background;
            visible: baseCalenderPicker.visible
            anchors
            {
                top:baseCalenderPicker.bottom;
                topMargin: -27;
                left:baseCalenderPicker.left;
            }

            Rectangle
            {
                width:parent.width/1.25;
                height:40;
                color:"transparent"
                anchors
                {
                    horizontalCenter:parent.horizontalCenter;
                }
                clip:true;
                TutuButton
                {
                    setRightButtonText:"Pick";
                    setRightButtonBackColor: appColors.c_button_background;
                    setRightButtonFontColor: appColors.c_button_text;
                    setRightButtonBorderColor: "transparent";

                    setLeftButtonText: "Back";
                    setLeftButtonBackColor: appColors.c_button_background_cancel;
                    setLeftButtonFontColor: appColors.c_button_text//appColors.c_button_text_cancel;
                    setLeftButtonBorderColor: "transparent";

                    onLeftButtonClicked:
                    {
                        console.log("source : setupTask.qml -> calender buttons back button clicked");
                        closeCalenderPicker();
                    }
                    onRightButtonClicked:
                    {
                        console.log("source : setupTask.qml -> save button clicked");
                        mainCalender.checkoutPuts();
                        console.log("data : setupTask.qml -> calenderPicker -> picked days = "+mainCalender.give_OutputPickedDays);
                        const selected_year =  mainCalender.give_OutputPickedDays[0];
                        const selected_month = mainCalender.give_OutputPickedDays[1];
                        var selected_day = mainCalender.give_OutputPickedDays[2];


                        //to fix 2023/3/3,4,9
                        selected_day+=",";
                        selected_day = selected_day.slice(0,selected_day.search(","));


                        //put picked into input box
                        console.log("data : setupTask.qml -> selected date = " + selected_year + "/"+ selected_month + "/" + selected_day)
                        taskDeadline.defaultValue = selected_year + "/" + selected_month + "/" + selected_day;
                        closeCalenderPicker();
                    }
                }
            }
        }

    }


}
