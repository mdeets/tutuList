import QtQuick 2.15
import "."
import "../theScripts/config.js" as Configs

Item
{
    id: local_root;
    property string response : "wait";
    property string textMessage : "Are you sure?";
    property string textConfirmButton: "Yes";
    property string textCancelButton: "Cancel";
    anchors.fill: parent
    Rectangle
    {
        color:Configs.color_background;
        width:parent.width/1.25;
        height:200;
        anchors.centerIn:parent;
        radius:25;
        Rectangle
        {
            id:baseLabel;
            color:"transparent";
            anchors.fill:parent;
            clip:true;
            Text
            {
                color:Configs.color_font_text;
                font.bold: true;
                padding:25;
                font.pointSize: Configs.font_size_title/1.75;
                id:messagelabel;
                width:parent.width;
                height:parent.height;
                anchors.centerIn: parent;
                text:textMessage;
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            }
        }


        Rectangle
        {
            id:baseButtons;
            width:parent.width/1.25;
            height:40;
            color:"transparent"
            anchors
            {
                bottom: parent.bottom;
                bottomMargin:25;
                horizontalCenter:parent.horizontalCenter;
            }
            clip:true;
            TutuButton
            {
                setRightButtonText:"Delete";
                setRightButtonBackColor: Configs.color_bg_indicator//Configs.color_button_background;
                setRightButtonFontColor: Configs.color_button_text;
                setRightButtonBorderColor: "transparent";

                setLeftButtonText: "Cancel";
                setLeftButtonBackColor: Configs.color_button_background_cancel;
                setLeftButtonFontColor: Configs.color_button_text;
                setLeftButtonBorderColor: "transparent";

                onLeftButtonClicked:
                {
                    response="canceled";
                    console.log("source : ConfirmYesOrNo.qml -> button cancel pressed. " ,response);
                }
                onRightButtonClicked:
                {
                    response="confirmed";
                    console.log("source : ConfirmYesOrNo.qml -> button confirm pressed. ",response);
                }
            }
        }

    }

}
