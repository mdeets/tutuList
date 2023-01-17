import QtQuick 2.15
import "../theScripts/config.js" as Configs
Item
{
    id:root;
    width:parent.width;
    height:50;
    visible:false;
    property string setTitle: "Test notification";
    property string setDescription: "This is an example description.";
    property int setTimeOutTimePerSecond: 3;
    property string setMessageType: "error"; //values are : error, success, info, warning.

    property color setBorderColor: "#E4CCC4";
    property color setBackgroundColor: "#FCEFEA";
    property color setTitleColor: "black";
    property color setDescriptionColor: "#dedede";

    signal actionWhenButtonClicked;//usage from outside
    signal actionWhenTimedOut;//usage from outside

    signal showMessage;
    onShowMessage:
    {
        timerToInviseMessage.start();
        root.visible=true;
    }

    signal hideMessage;
    onHideMessage:
    {
        root.visible=false;
        //reset values here.
        timerToInviseMessage.stop();
    }

    Component.onCompleted:
    {
        console.log("source: TutuShowNotificationMessage.qml -> component starts.");
    }

    Timer
    {
        id:timerToInviseMessage;
        interval: 1000; running: false; repeat: false;
        onTriggered:
        {
            setTimeOutTimePerSecond--;
            if(setTimeOutTimePerSecond<=0)
            {
                hideMessage();
            }
            else
            {
                console.log("source: TutuShowNotificationMessage.qml -> timer ticked, timeout=",setTimeOutTimePerSecond);
            }
        }
    }

    Rectangle
    {
        id:local_root;
        anchors.fill: parent;
        color:"red";
        radius:25;
        MouseArea //to unclickable sections under this section.
        {
            anchors.fill: parent;
        }

        Rectangle
        {
            id:baseIcon;
            width:50;
            height:50;
            color:"yellow";
            anchors
            {
                verticalCenter:parent.verticalCenter;
                margins: 24;
            }
            Image
            {
                anchors.fill: parent;
                source: setIcon;
            }
        }
        Text
        {
            text:setTitle;
            color:setTitleColor;
            anchors
            {
                top:baseIcon.top;
                left:baseIcon.right;
                leftMargin:24;
            }
        }
        Text
        {
            text:setDescription;
            color:setDescriptionColor;
            anchors
            {
                bottom:baseIcon.bottom;
                left:baseIcon.right;
                leftMargin:24;
            }
        }
        Rectangle
        {
            id:buttonClose;
            color: "white";
            radius:24;
            anchors
            {
                margins:24;
                right:parent.right;
            }
            MouseArea
            {
                anchors.fill: parent;
                onClicked:
                {
                    console.log("close called");
                    hideMessage();
                }
            }
            Image
            {
                anchors.fill: parent;
                source: setIconClose;
            }
        }


    }

}
