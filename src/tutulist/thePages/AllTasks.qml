import QtQuick 2.15
import QtQuick.Controls 2.15
import "../theScripts/alltasks.js" as AllTasks
Item
{
    anchors.fill:parent;
    Rectangle
    {
        id:local_root;
        anchors.fill: parent;
        color:"red";
        Text
        {
            text:"all Tasks page."
        }
    }

    Rectangle
    {
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
                    const res=  AllTasks.addQuicklyNewTask(taskTitle.text);
                    if(res)
                    {
                        console.log("source : AllTasks.qml -> response is ok query submitted as QuickTask.");
                        taskTitle.clear();
                        console.log("source: AllTasks.qml -> result Alltasks.getlist() -> " +AllTasks.getList());
                    }
                }
            }
        }
    }


}
