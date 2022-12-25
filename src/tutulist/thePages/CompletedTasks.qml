import QtQuick 2.15
import QtQuick.Controls 2.15
//import "../theScripts/TodayTasks.js" as AllTasks
import "../theScripts/config.js" as Configs
import "../theScripts/completedtasks.js" as CompletedTasks //just addToCompletedTasks used from CompletedTasks.js
import "../theScripts/todaytasks.js" as AddToTodayTasks

Item
{
    signal reloadAllTasks;
    onReloadAllTasks:
    {
//        console.log("source: CompletedTasks.qml -> signal reloadAllTasks -> result TodayTasks.getlist() -> " +TodayTasks.getList());
        console.log("source : CompletedTasks.qml -> signal reloadAllTasks called.");
        listModelMain.clear();
        if(CompletedTasks.getList(listModelMain,"appendToList")!==1)
        {
            console.log("source:completedtasks.qml -> i confirm getlist is successfully done.");
        }
    }

    anchors.fill:parent;
    Component.onCompleted:
    {
        console.log("source : CompletedTasks.qml -> im completelly loaded.");
        reloadAllTasks();
    }

    Rectangle
    {
        id:theListBase;
        anchors
        {
            fill:parent;
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
                                console.log("source : CompletedTasks.qml ->  on task clicked, details are: id="+tId + " title="+tTitle + " desc="+tDesc + " timetoperform="+tTimerToPerForm+ " deadlione"+tDeadline + " creation="+tCreation + " priority="+tPriority);
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
                            id:uncompleteTask;
                            width:45;
                            height:parent.height;
                            anchors.right:parent.right;
                            color:"purple";
                            Text
                            {
                                text:"uncomp";
                                anchors.centerIn: parent;
                            }

                            MouseArea
                            {
                                anchors.fill:parent;
                                onClicked:
                                {
                                    console.log("source : CompletedTasks.qml -> uncomplete this task clicked, id="+tId);
                                    const res = CompletedTasks.uncompleteTask(tId);
                                    if(res)
                                    {
                                            console.log("source : CompletedTasks.qml -> i confirm the task is uncompleted.");
                                            reloadAllTasks();
                                    }
                                    else
                                        console.log("source : CompletedTasks.qml -> something went wrong error="+res)
                                }
                            }
                        }
                        Rectangle
                        {
                            id:addToToday;
                            width:45;
                            height:parent.height;
                            anchors.right:uncompleteTask.left;
                            color:"gray";
                            Text
                            {
                                text:"+today";
                                anchors.centerIn: parent;
                            }

                            MouseArea
                            {
                                anchors.fill:parent;
                                onClicked:
                                {
                                    console.log("source : CompletedTasks.qml -> add to today task clicked., id="+tId);
                                    const res = CompletedTasks.uncompleteTask(tId);
                                    if(res)
                                    {
                                        const res_addToTodayTask = AddToTodayTasks.addTaskToToday(tId);
                                        if(res_addToTodayTask)
                                        {
                                            console.log("source : CompletedTasks.qml -> i confirm the task is uncompleted and added into today tasks.");
                                            reloadAllTasks();
                                        }
                                        else
                                            console.log("source : CompletedTasks.qml -> something went wrong error="+res_addToTodayTask)

                                    }
                                    else
                                        console.log("source : CompletedTasks.qml -> something went wrong error="+res)
                                }
                            }
                        }



                    }


                }

            }//end of item delegate

        }//end of list view


    }

}
