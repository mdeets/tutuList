import QtQuick 2.15
import QtQuick.Controls 2.15
import "../theScripts/alltasks.js" as AllTasks
import "../theScripts/config.js" as Configs
import "../theScripts/completedtasks.js" as AddToCompletedTasks
import "../theScripts/todaytasks.js" as AddToTodayTask

Item
{
    signal openTheSetupTaskForm;

    onOpenTheSetupTaskForm:
    {
        console.log("-----------------------------------------------------------------------------");
    }

    signal reloadAllTasks;
    onReloadAllTasks:
    {
//        console.log("source: AllTasks.qml -> signal reloadAllTasks -> result Alltasks.getlist() -> " +AllTasks.getList());
        console.log("source : AllTasks.qml -> signal reloadAllTasks called.");
        listModelMain.clear();
        AllTasks.getList(listModelMain,"appendToList");
    }

    anchors.fill:parent;
    Component.onCompleted:
    {
        console.log("source : AllTasks.qml -> im completelly loaded.");
        reloadAllTasks();
    }

//    StackView
//    {
//        id:mainStackView;
//        visible:  false;
////        onVisibleChanged:
////        {
////            if(visible)
////                console.log("source: allTasks.qml -> theStack View is now visible.");
////            else
////                reloadAllTasks();
////        }

//        initialItem: "./AllTasks.qml";
//        anchors.fill:parent;
//    }


    Rectangle
    {
        id:theListBase;
        anchors
        {
            left:parent.left;
            right:parent.right;
            top:parent.top;
            bottom:addNewQuickTask.top;
        }
        color:"brown";

        ListView
        {
            id:listViewMain;
            anchors.fill:parent;
//            anchors.topMargin:35;
            clip:true;
            model:
            ListModel
            {
                id:listModelMain;
            }
            delegate:
            Item
            {
                width: listViewMain.width;
                height: 70;
                Rectangle
                {
                    anchors.fill: parent;
                    color:"magenta";
                    Rectangle
                    {
                        id:itemmm2;
                        width: parent.width/1.10;
                        height: 50;
                        color: "black";
                        radius:15;
                        anchors.horizontalCenter: parent.horizontalCenter;

                        MouseArea
                        {
                            anchors.fill:parent;
                            onClicked:
                            {
                                console.log("source : AllTasks.qml ->  on task clicked, details are: id="+tId + " title="+tTitle + " desc="+tDesc + " timetoperform="+tTimerToPerForm+ " deadlione"+tDeadline + " creation="+tCreation + " priority="+tPriority);
                                openTheSetupTaskForm();
                            }
                        }

                        Text
                        {
                            text: tTitle;
                            color:"white";
                            font.pointSize: 18;
                            width:parent.width/3;
                            clip:true;
                            anchors
                            {
                                verticalCenter:parent.verticalCenter;
                                left:parent.left;
                                leftMargin: 30;
                            }

                        }
                        Rectangle
                        {
                            id:todayButton;
                            width:45;
                            height:parent.height;
                            anchors.right:parent.right;
                            color:"gray";
                            Text
                            {
                                text:"today";
                                anchors.centerIn: parent;
                            }

                            MouseArea
                            {
                                anchors.fill:parent;
                                onClicked:
                                {
                                    console.log("source : AllTasks.qml -> add to today this task clicked, id="+tId);
                                    const res = AddToTodayTask.addTaskToToday(tId);
                                    if(res)
                                    {
                                        console.log("source : AllTasks.qml -> i confirm the task is completely adde to today task.");
                                        reloadAllTasks();
                                    }
                                    else
                                        console.log("source : AllTasks.qml -> something went wrong error="+res)
                                }
                            }
                        }

                        Rectangle
                        {
                            id:completeButton;
                            width:45;
                            height:parent.height;
                            anchors.right:todayButton.left;
                            color:"purple";
                            Text
                            {
                                text:"comp";
                                anchors.centerIn: parent;
                            }

                            MouseArea
                            {
                                anchors.fill:parent;
                                onClicked:
                                {
                                    console.log("source : AllTasks.qml -> complete this task clicked, id="+tId);
                                    const res = AddToCompletedTasks.completeTask(tId);
                                    if(res)
                                    {
                                        console.log("source : AllTasks.qml -> i confirm the task is completely completed.");
                                        reloadAllTasks();
                                    }
                                    else
                                        console.log("source : AllTasks.qml -> something went wrong error="+res)
                                }
                            }
                        }




                    }


                }

            }//end of item delegate

        }//end of list view


    }

    Rectangle
    {
        id:addNewQuickTask;
        width:parent.width;
        height:50;
        color:"gray";
        anchors.bottom:parent.bottom;
        TextField
        {
            id:taskTitle;
            width:parent.width/2;
            height:parent.height;
        }
        Rectangle
        {
            anchors.right:parent.right;
            color:"blue";
            width:40;
            height:parent.height;
            MouseArea
            {
                anchors.fill:parent;
                onClicked:
                {
                    console.log("source : AllTasks.qml -> on submit new task button clicked.");
                    if(taskTitle.text==="")
                    {
                        console.log("source: allTasks.qml -> add new task via setup and form.");

                    }
                    else
                    {
                        const res=  AllTasks.addQuicklyNewTask(taskTitle.text);
                        if(res)
                        {
                            console.log("source : AllTasks.qml -> response is ok query submitted as QuickTask.");
                            taskTitle.clear();
                            reloadAllTasks();
                        }
                    }
                }
            }
        }
    }


}
