//this form is copeid from setupTask.qml

import QtQuick 2.15
import "../theComponents"
import "../theScripts/alltasks.js" as AllTask
import "../theScripts/config.js" as Configs
import QtQuick.Controls 2.15

import "../theComponents/calendar" as TutuCalender

Page
{
    //form setup
    property string get_entered_value : "";
    property string setLabel : "Default label:";
    property string setPlaceHolderInput: "Enter the " + setLabel;

    //task modify details:
    property int idValue:0;
    property string titleValue: "default-title";
    property string descriptionValue: "default-description";
    property string timeToPerformValue: "default-timeToPerform";
    property string priorityValue: "default-priority";
    property string deadlineValue: "default-deadline";
    property string creationdateValue: "default-creationdate";


    signal quitFromModifyTaskForm;
    onQuitFromModifyTaskForm:
    {
        console.log("source : modifyTask.qml -> signal quit from modifyTaskForm called.");
    }


    signal saveTheModifiedTaskForm;
    onSaveTheModifiedTaskForm:
    {
        if(idValue!=0)
        {
            const result_modify = AllTask.updateWholeTask(idValue,
                                                          taskTitle.get_entered_value,
                                                          taskDescription.get_entered_value,
                                                          taskPriority.get_entered_value,
                                                          taskTimetoperform.get_entered_value,
                                                          taskDeadline.get_entered_value);

            if(result_modify)
            {
                console.log("source: modifyTask.qml -> i confirm the task is modified successfully");
                quitFromModifyTaskForm();
            }
        }
        else
        {
            console.log("source : modifyTask.qml -> there is problem with task id recived. id="+idValue);
        }
    }


    signal closeCalenderPicker;
    onCloseCalenderPicker:
    {
        baseCalenderPicker.visible=false;
        mainCalender.cleanDays(); //old numbers will keep inside this, so need to clean that for next or if user unselect and select app works fine next time.
        //in this case we just need a single day date.
    }


    Component.onCompleted:
    {
        console.log("source : modifyTask.qml -> the modify page is loaded.");
    }

    Rectangle
    {
        id:local_root;
        color:appColors.c_background;
        anchors.fill: parent;
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
                        quitFromModifyTaskForm();
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
                text:"Modify Task";
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
                    //                        anchors.top:parent.top;
                    setLabel: "Title:";
                    setPlaceHolderInput: "enter the for title";
                    defaultValue: titleValue;
                }
                GetAField_Form_with_Title_and_InputText
                {
                    id:taskDescription
                    anchors.top:taskTitle.bottom;
                    setLabel: "Description:";
                    setPlaceHolderInput: "enter the for description";
                    setHeight:100;
                    defaultValue: descriptionValue;
                }

                GetAField_Form_with_Title_and_InputText
                {
                    id:taskPriority;
                    anchors.top:taskDescription.bottom;
                    setLabel: "Priority:";
                    setPlaceHolderInput: "enter the for priority";
                    defaultValue: priorityValue;
                }
                GetAField_Form_with_Title_and_InputText
                {
                    id:taskDeadline
                    anchors.top:taskPriority.bottom;
                    setLabel: "Deadline:";
                    setPlaceHolderInput: "enter the for deadline";
                    defaultValue: deadlineValue;

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
                    defaultValue: timeToPerformValue;
                }


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
                        setRightButtonText:"Modify";
                        setRightButtonBackColor: appColors.c_button_background;
                        setRightButtonFontColor: appColors.c_button_text;
                        setRightButtonBorderColor: "transparent";

                        setLeftButtonText: "Cancel";
                        setLeftButtonBackColor: appColors.c_button_background_cancel;
                        setLeftButtonFontColor: appColors.c_button_text//appColors.c_button_text_cancel;
                        setLeftButtonBorderColor: "transparent";

                        onLeftButtonClicked:
                        {
                            console.log("source : modifytask.qml -> cancel button clicked");
                            quitFromModifyTaskForm();
                        }
                        onRightButtonClicked:
                        {
                            console.log("source : modifytask.qml -> save button clicked");
                            saveTheModifiedTaskForm();
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
                    console.log("source : modifyTask.qml -> background calender picker clicked. lets hide calender.");
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
                        console.log("source : modifyTask.qml -> calender buttons back button clicked");
                        closeCalenderPicker();
                    }
                    onRightButtonClicked:
                    {
                        console.log("source : modifyTask.qml -> save button clicked");
                        mainCalender.checkoutPuts();
                        console.log("data : modifyTask.qml -> calenderPicker -> picked days = "+mainCalender.give_OutputPickedDays);
                        const selected_year =  mainCalender.give_OutputPickedDays[0];
                        const selected_month = mainCalender.give_OutputPickedDays[1];
                        var selected_day = mainCalender.give_OutputPickedDays[2];


                        //to fix 2023/3/3,4,9
                        selected_day+=",";
                        selected_day = selected_day.slice(0,selected_day.search(","));


                        //put picked into input box
                        console.log("data : modifyTask.qml -> selected date = " + selected_year + "/"+ selected_month + "/" + selected_day)
                        taskDeadline.defaultValue = selected_year + "/" + selected_month + "/" + selected_day;
                        closeCalenderPicker();
                    }
                }
            }
        }
    }
}

