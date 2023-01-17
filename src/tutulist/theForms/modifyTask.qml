//this form is copeid from setupTask.qml

import QtQuick 2.15
import "../theComponents"
import "../theScripts/alltasks.js" as AllTask
import "../theScripts/config.js" as Configs
import QtQuick.Controls 2.15
Page
{
    //form setup
    property string get_entered_value : "";
    property string setLabel : "Default label:";
    property string setPlaceHolderInput: "Enter the " + setLabel;
//    anchors.fill: parent;
//    height:40;

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

    Component.onCompleted:
    {
        console.log("source : modifyTask.qml -> the modify page is loaded.");
    }

    Rectangle
    {
        id:local_root;
        color:Configs.color_background;
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
            color:Configs.color_background;
            Rectangle
            {
                id:baseButtonBack;
                width:24;
                height:24;
                color:"transparent";
    //            border.color: Configs.color_bg_indicator;
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
                    source: Configs.icon_back;
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
                color: Configs.color_font_title

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
            color:Configs.color_background
            ListView
            {
                anchors.fill:parent;
                Column
                {
                    anchors.fill: parent;
                    width:parent.width;
                    height:parent.height;
                    spacing:50

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
                            setRightButtonBackColor: Configs.color_button_background;
                            setRightButtonFontColor: Configs.color_button_text;
                            setRightButtonBorderColor: "transparent";

                            setLeftButtonText: "Cancel";
                            setLeftButtonBackColor: Configs.color_button_background_cancel;
                            setLeftButtonFontColor: Configs.color_button_text//Configs.color_button_text_cancel;
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
        }
    }



}

