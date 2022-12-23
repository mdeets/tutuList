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


    onTodayTasksClicked:
    {

    }


    Rectangle
    {
        id:local_root;
        anchors.fill:parent;
        color:"yellow";
        Row
        {
            anchors.fill:parent;

            spacing: parent.width/5;
            Rectangle
            {
                width:parent.width/5;
                height:parent.height;
                color:"gray";
                Image
                {
                    anchors.centerIn:parent;
                    property string myvg: Configs.pathToIcon+"allTasks.png";
                    source: myvg;
                }

                MouseArea
                {
                    anchors.fill: parent;
                    onClicked: allTasksClicked();
                }
            }
            Rectangle
            {
                width:parent.width/5;
                height:parent.height;
                color:"red";
                MouseArea
                {
                    anchors.fill: parent;
                    onClicked: todayTasksClicked();
                }
            }
            Rectangle
            {
                width:parent.width/5;
                height:parent.height;
                color:"blue";
                MouseArea
                {
                    anchors.fill: parent;
                    onClicked: completedTasksClicked()
                }
            }
        }
    }
}
