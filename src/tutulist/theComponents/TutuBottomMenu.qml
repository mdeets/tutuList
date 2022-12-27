import QtQuick 2.15
import QtQuick.Controls 2.15

import "../theScripts/config.js" as Configs
Item
{
    width:parent.width;
    height: Configs.bottomMenu_height;

    signal todayTasksClicked;
    signal allTasksClicked;
    signal completedTasksClicked;

    signal hide;
    signal show;

    onHide:
    {
        visible:false;
    }
    onShow:
    {
        visible:true;
    }

    onCompletedTasksClicked:
    {
        buttonCompletedTasks.color="gray";
        buttonTodayTasks.color="transparent";
        buttonAllTasks.color="transparent";
    }

    onAllTasksClicked:
    {
        buttonAllTasks.color="gray";
        buttonTodayTasks.color="transparent";
        buttonCompletedTasks.color="transparent";
    }

    onTodayTasksClicked:
    {
        buttonTodayTasks.color="gray";
        buttonAllTasks.color="transparent";
        buttonCompletedTasks.color="transparent";
    }


    Rectangle
    {
        id:local_root;
        width:parent.height*3+12
        anchors.centerIn: parent;
        height:parent.height;
        color:"transparent";
        Row
        {
            width:parent.width;
            height:parent.height;
            anchors.centerIn:parent;
            spacing: parent.width/25;

            Rectangle
            {
                id:buttonAllTasks;
                width:parent.height;
                height:parent.height;
                color:"transparent";
                radius: 100
                Image
                {
                    anchors.centerIn:parent;
                    source: Configs.icon_bottomMenu_allTasks;
                }

                MouseArea
                {
                    anchors.fill: parent;
                    onClicked:
                    {
                        allTasksClicked();
                    }

                }
            }
            Rectangle
            {
                id:buttonTodayTasks;
                width:parent.height;
                height:parent.height;
                color:"transparent";
                radius: 100
                Image
                {
                    anchors.centerIn:parent;
                    source: Configs.icon_bottomMenu_todayTasks;
                }
                MouseArea
                {
                    anchors.fill: parent;
                    onClicked:
                    {
                        todayTasksClicked();
                    }

                }
            }
            Rectangle
            {
                id:buttonCompletedTasks;
                width:parent.height;
                height:parent.height;
                color:"transparent";
                radius: 100
                Image
                {
                    anchors.centerIn:parent;
                    source: Configs.icon_bottomMenu_completedTasks;
                }
                MouseArea
                {
                    anchors.fill: parent;
                    onClicked:
                    {
                        completedTasksClicked()
                    }

                }
            }
        }
    }
}
