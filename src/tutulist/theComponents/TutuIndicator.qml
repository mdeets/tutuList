import QtQuick 2.15
import QtQuick.Controls 2.15

import "../theScripts/config.js" as Configs
Item
{
    width:parent.width;
    height: Configs.bottomMenu_height;
    property int setCurrentPage: 0;
    onSetCurrentPageChanged:
    {
        switch(setCurrentPage)
        {
        case 1:
            allTasksClicked();
            break;
        case 2:
            todayTasksClicked();
            break;
        case 3:
            completedTasksClicked();
            break;
        default:
            console.log("source: tutuBottomMenu.qml -> something went wrong when doing the setCurrentPage");
        }
    }

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
        buttonCompletedTasks.opacity=1;
        buttonTodayTasks.opacity=0.3;
        buttonAllTasks.opacity=0.3;
    }

    onAllTasksClicked:
    {
        buttonAllTasks.opacity=1;
        buttonTodayTasks.opacity=0.3;
        buttonCompletedTasks.opacity=0.3;
    }

    onTodayTasksClicked:
    {
        buttonTodayTasks.opacity=1;
        buttonAllTasks.opacity=0.3;
        buttonCompletedTasks.opacity=0.3;
    }


    Rectangle
    {
        id:local_root;
        width:parent.width/1.25//parent.height*3+parent.width/2.5//*3+12
        anchors.centerIn: parent;
        height:parent.height;
        radius:parent.width;
        color:Configs.color_bg_indicator;

        MouseArea
        {
            anchors.fill:parent;
        }
        Rectangle
        {
            id:buttonAllTasks;
            width:parent.height;
            height:parent.height;
            color:"transparent";
            radius: 100;
            anchors
            {
                right:buttonTodayTasks.left;
                rightMargin: width/2;
            }


            Image
            {
                anchors.centerIn:parent;
                width:30;
                height:30;
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
            radius: 100;
            anchors.centerIn:parent;
            Image
            {
                anchors.centerIn:parent;
                width:30;
                height:30;
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
            radius: 100;
            anchors
            {
                left:buttonTodayTasks.right;
                leftMargin: width/2;
            }

            Image
            {
                anchors.centerIn:parent;
                width:30;
                height:30;
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
