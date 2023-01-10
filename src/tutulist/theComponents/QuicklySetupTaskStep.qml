import QtQuick 2.15
import QtQuick.Controls 2.15
import "../theScripts/config.js" as Configs
import "../theScripts/steptasks.js" as StepTask
Item
{
    id:local_root;
    anchors.fill:parent;
    property int setTaskId: 0;
    property int setMaxLenght:40;
    signal cancelButtonClicked;
    signal saveButtonClicked;


    onSaveButtonClicked:
    {
        console.log("source : QuicklySetupTaskStep.qml -> signal saveButtonClicked called.");

        const rs = StepTask.quicklyAddNewStep(setTaskId,taskTitle.text);
        if(rs)
        {
            console.log("source : QuicklySetupTaskStep.qml -> response is ok query submitted as new step task.");
            reloadAllTasks();
        }
        else
        {
            console.log("source : QuicklySetupTaskStep.qml ->failed to add new step task.");
        }
    }

    onCancelButtonClicked:
    {
        taskTitle.clear();
        local_root.visible=false;
    }

    z:10;
    Rectangle
    {
        id:addQuicklyBase;
        anchors.fill:parent;
        color:Configs.color_input_background;
        border.color: Configs.color_bg_indicator;
        radius:15;
        Row
        {
            anchors.fill:parent;
//            TextField
            TextInput
            {
                id:taskTitle;
                color:Configs.color_font_text;
                width:parent.width-40;// minus 40px for button
                height:parent.height;
                padding:14;
                wrapMode: "WrapAnywhere"
                maximumLength: setMaxLenght;
            }
            Rectangle
            {
                id:submitButton;
//                anchors.right:parent.right;
                color:"transparent";
                width:40;
                height:parent.height;
                Image
                {
                    id:iconButton;
                    anchors.centerIn:parent;
                    source: taskTitle.length>0 ? Configs.icon_submitTasks : Configs.icon_cancel;
                }

                MouseArea
                {
                    anchors.fill:parent;
                    onClicked:
                    {
                        if(taskTitle.length<=0)
                        {
                            console.log("source : QuicklySetupTaskStep.qml -> on cancel new task step button clicked.");
                            cancelButtonClicked();
                        }
                        else
                        {
                            console.log("source : QuicklySetupTaskStep.qml -> on submit new task step button clicked.");
                            saveButtonClicked();
                        }
                    }
                }
            }//end of submit
        }

    }
}
