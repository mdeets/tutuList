import QtQuick 2.15
import "../theComponents/"
import "../theScripts/alltasks.js" as SaveTask
Item
{
    Component.onCompleted:
    {
        taskTitle.text = "";
        taskDescription.text = "";
        taskPriority.text = "";
        taskDeadline.text = "";
        taskTimetoperform.text = "";
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

    anchors.fill:parent;
    Rectangle
    {
        anchors.fill: parent;
        color:"gray";

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
                    setPlaceHolderInput: "enter the for title";
                }
                GetAField_Form_with_Title_and_InputText
                {
                    id:taskDescription
                    setLabel: "Description:";
                    setPlaceHolderInput: "enter the for description";
                }

                GetAField_Form_with_Title_and_InputText
                {
                    id:taskPriority
                    setLabel: "Priority:";
                    setPlaceHolderInput: "enter the for priority";
                }
                GetAField_Form_with_Title_and_InputText
                {
                    id:taskDeadline
                    setLabel: "Deadline:";
                    setPlaceHolderInput: "enter the for deadline";
                }
                GetAField_Form_with_Title_and_InputText
                {
                    id:taskTimetoperform
                    setLabel: "Time To Perform:";
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
                                quitTheSetupTaskFrom();
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
                            text:"Save";
                            anchors.centerIn:parent;
                        }
                        MouseArea
                        {
                            anchors.fill:parent;
                            onClicked:
                            {
                                console.log("source : setupTask.qml -> save button clicked");
                                saveTheSetupTaskForm();
                            }
                        }
                    }



                }


            }

        }




    }
}
