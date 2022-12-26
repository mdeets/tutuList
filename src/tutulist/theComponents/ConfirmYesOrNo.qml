import QtQuick 2.15

Item
{
    id: local_root;
    property string response : "wait";


    property string textMessage : "Are you sure?";
    property string textConfirmButton: "Yes";
    property string textCancelButton: "Cancel";
    width:parent.width/2;
    height:parent.height/10;
    anchors.horizontalCenter: parent.horizontalCenter;
    anchors.verticalCenter: parent.verticalCenter;
    Rectangle
    {
        anchors.fill:parent;
        width:100;
        height:25;
        Rectangle
        {
            id:baseLabel;
            color:"white";
            anchors.fill:parent;
            width:parent.width;
            height:10;
            Text
            {
                color:"black"
                font.bold: true;
                font.pointSize: 15
                id:messagelabel;
                width:parent.width;
                height:parent.height;
                anchors.verticalCenter: parent.verticalCenter;
                text:textMessage;
                wrapMode: Text.WordWrap
            }
        }


        Rectangle
        {
            id:baseConfirmButton;
            width:parent.width/2;
            height:25;
            color:"lime";
            anchors.right: baseLabel.right;
            anchors.top: baseLabel.bottom;
            Text
            {
                color:"white";
                anchors.centerIn:parent;
                font.bold: true;
                font.pointSize: 15
                text:textConfirmButton;
            }
            MouseArea
            {
                anchors.fill:parent;
                onClicked:
                {
                    response="confirmed";
                    console.log("source : ConfirmYesOrNo.qml -> button confirm pressed. ",response);
                }
            }
        }

        Rectangle
        {
            id:baseCancelButton;
            width:parent.width/2;
            height:25;
            color:"red";
            anchors.left: baseLabel.left;
            anchors.top: baseLabel.bottom;
            Text
            {
                color:"white";
                anchors.centerIn:parent;
                font.bold: true;
                font.pointSize: 15
                text:textCancelButton;
            }
            MouseArea
            {
                anchors.fill:parent;
                onClicked:
                {
                    response="canceled";
                    console.log("source : ConfirmYesOrNo.qml -> button cancel pressed. " ,response);
                }
            }
        }




    }

}
