import QtQuick 2.15
import QtQuick.Controls 2.15
//import "../theScripts/TodayTasks.js" as AllTasks
import "../theScripts/config.js" as Configs
import "../theScripts/completedtasks.js" as AddToCompletedTasks //just addToCompletedTasks used.
import "../theScripts/todaytasks.js" as TodayTasks
Item
{
    signal reloadAllTasks;
    onReloadAllTasks:
    {
//        console.log("source: todayTasks.qml -> signal reloadAllTasks -> result TodayTasks.getlist() -> " +TodayTasks.getList());
        console.log("source : todayTasks.qml -> signal reloadAllTasks called.");
        listModelMain.clear();
        TodayTasks.getList(listModelMain,"appendToList");
    }

    anchors.fill:parent;
    Component.onCompleted:
    {
        console.log("source : todayTasks.qml -> im completelly loaded.");
        reloadAllTasks();
    }

    Rectangle
    {
        id:theListBase;
        anchors
        {
            fill:parent
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
                                console.log("source : todayTasks.qml ->  on task clicked, details are: id="+tId + " title="+tTitle + " desc="+tDesc + " timetoperform="+tTimerToPerForm+ " deadlione"+tDeadline + " creation="+tCreation + " priority="+tPriority);
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
                            id:completeTask;
                            width:45;
                            height:parent.height;
                            anchors.right:parent.right;
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
                                    console.log("source : todayTasks.qml -> complete this task clicked, id="+tId);
                                    const res = AddToCompletedTasks.completeTask(tId);
                                    if(res)
                                    {
                                        const res_removeTaskFromToday = TodayTasks.removeTaskFromToday(tId);
                                        if(res_removeTaskFromToday)
                                        {
                                            console.log("source : todayTasks.qml -> i confirm the task is removed from todaytask and added into completed tasks.");
                                            reloadAllTasks();
                                        }
                                        else
                                            console.log("source : todayTasks.qml -> something went wrong error="+res_removeTaskFromToday);

                                    }
                                    else
                                        console.log("source : todayTasks.qml -> something went wrong error="+res)
                                }
                            }
                        }


                        Rectangle
                        {
                            id:removeFromToday;
                            width:45;
                            height:parent.height;
                            anchors.right:completeTask.left;
                            color:"gray";
                            Text
                            {
                                text:"remo";
                                anchors.centerIn: parent;
                            }

                            MouseArea
                            {
                                anchors.fill:parent;
                                onClicked:
                                {
                                    console.log("source : todayTasks.qml -> remove this task from today clicekd., id="+tId);
                                    const res = TodayTasks.removeTaskFromToday(tId);
                                    if(res)
                                    {
                                            console.log("source : todayTasks.qml -> i confirm the task is removed from todaytasks.");
                                            reloadAllTasks();
                                    }
                                    else
                                        console.log("source : todayTasks.qml -> something went wrong error="+res)
                                }
                            }
                        }



                    }


                }

            }//end of item delegate

        }//end of list view


    }




}
