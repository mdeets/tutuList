import QtQuick 2.15
import "../theComponents/"
import "../theScripts/alltasks.js" as SaveTask
import "../theScripts/config.js" as Configs
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

//        anchors.fill: parent;
        color:Configs.color_background

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
            }
            GetAField_Form_with_Title_and_InputText
            {
                id:taskTimetoperform
                anchors.top:taskDeadline.bottom;
                setLabel: "Time To Perform:";
                setPlaceHolderInput: "enter the for time to perform";
            }


            Row
            {
                id:baseButtons;
                height:45;
                width:parent.width;
                anchors.top:taskTimetoperform.bottom;
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
