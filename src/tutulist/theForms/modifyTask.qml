//this form is copeid from setupTask.qml

import QtQuick 2.15
import "../theComponents"
import "../theScripts/alltasks.js" as AllTask


Item
{
    //form setup
    property string get_entered_value : "";
    property string setLabel : "Default label:";
    property string setPlaceHolderInput: "Enter the " + setLabel;
    anchors.fill: parent;
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
        color:"gray";
        anchors.fill: parent;
    }

    ListView
    {
        anchors.fill:parent;
        Column
        {
            anchors.fill: parent;
            spacing:50

            GetAField_Form_with_Title_and_InputText
            {
                id:taskTitle;
                setLabel: "Title:";
                defaultValue: titleValue;
                setPlaceHolderInput: "enter the for title";
            }
            GetAField_Form_with_Title_and_InputText
            {
                id:taskDescription
                setLabel: "Description:";
                defaultValue: descriptionValue;
                setPlaceHolderInput: "enter the for description";
            }

            GetAField_Form_with_Title_and_InputText
            {
                id:taskPriority
                setLabel: "Priority:";
                defaultValue: priorityValue;
                setPlaceHolderInput: "enter the for priority";
            }
            GetAField_Form_with_Title_and_InputText
            {
                id:taskDeadline
                setLabel: "Deadline:";
                defaultValue: deadlineValue;
                setPlaceHolderInput: "enter the for deadline";
            }
            GetAField_Form_with_Title_and_InputText
            {
                id:taskTimetoperform
                setLabel: "Time To Perform:";
                defaultValue: timeToPerformValue;
                setPlaceHolderInput: "enter the for time to perform";
            }


            Row
            {
                id:baseButtons;
                height:45;
                width:parent.width;
                Rectangle
                {
                    id:cancelButton;
                    width:parent.width/2;
                    height:45;
                    color:"red";
                    Text
                    {
                        text:"cancel";
                        anchors.centerIn:parent;
                    }
                    MouseArea
                    {
                        anchors.fill:parent;
                        onClicked:
                        {
                            console.log("source : modifytask.qml -> cancel button clicked");
                            quitFromModifyTaskForm();
                        }
                    }
                }



                Rectangle
                {
                    id:submitButton;
                    width:parent.width/2;
                    height:45;
                    color:"green";
                    Text
                    {
                        text:"modify and save.";
                        anchors.centerIn:parent;
                    }
                    MouseArea
                    {
                        anchors.fill:parent;
                        onClicked:
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

