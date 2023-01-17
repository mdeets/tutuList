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
    visible:false;

    onVisibleChanged:
    {
        console.log("source : QuicklySetupTaskStep.qml -> root visible changed set focuse textinput = true")
        taskTitle.focus=true;
    }

    onSaveButtonClicked:
    {
        console.log("source : QuicklySetupTaskStep.qml -> signal saveButtonClicked called.");

        const rs = StepTask.quicklyAddNewStep(setTaskId,taskTitle.text);
        if(rs)
        {
            console.log("source : QuicklySetupTaskStep.qml -> response is ok query submitted as new step task.");
            taskTitle.text="";
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
        color:appColors.c_input_background;
        border.color: appColors.c_bg_indicator;
        radius:15;
        Row
        {
            anchors.fill:parent;
            TextInput
            {
                id:taskTitle;
                color:appColors.c_font_text;
                width:parent.width-40;// minus 40px for button
                height:parent.height;
                padding:14;
                focus: true;
                wrapMode: TextInput.WrapAtWordBoundaryOrAnywhere
                maximumLength: setMaxLenght;
                onEditingFinished:
                {
                    if(taskTitle.length>0)
                    {
                        console.log("source : QuicklySetupTaskStep.qml -> on editing finished or enter pressed.");
                        saveButtonClicked();
                    }
                }
            }
            Rectangle
            {
                id:submitButton;
                color:"transparent";
                width:40;
                height:parent.height;
                Image
                {
                    width:24;
                    height:24;
                    id:iconButton;
                    anchors.centerIn:parent;
                    source: taskTitle.length>0 ? appIcons.icon_submitTasks : appIcons.icon_cancel;
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
