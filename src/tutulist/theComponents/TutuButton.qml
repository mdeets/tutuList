import QtQuick 2.15
import QtQuick.Window 2.15
Item
{
    id:local_root;
    anchors.fill: parent;
    Rectangle
    {
        anchors.fill: parent;
        color:"transparent"
    }

    property bool isSingleButton: false;
    property int setButtonsBorderWidth: 1;
    property int setRadius: 10;
    property int setWidthButtons: local_root.width/2.50;
    property int setHeightButtons: local_root.height;

    property string setRightButtonText: "Right button";
    property color setRightButtonFontColor: "green";
    property color setRightButtonBackColor: "#dedede";
    property color setRightButtonBorderColor: "black";
    signal rightButtonClicked;


    property string setLeftButtonText: "Left button";
    property color setLeftButtonFontColor: "yellow";
    property color setLeftButtonBackColor: "purple";
    property color setLeftButtonBorderColor: "red";
    signal leftButtonClicked;


    Component
    {
        id: buttonComponent
        Rectangle
        {
            id:baseButtons;
            width:local_root.width;
            height:local_root.height;
            color:"transparent";

            Rectangle
            {
                id:leftButton;//left button
                width:setWidthButtons;
                height:setHeightButtons;
                color:setLeftButtonBackColor;
                border.color:setLeftButtonBorderColor;
                border.width: setButtonsBorderWidth;
                radius: setRadius;
                Text
                {
                    text:setLeftButtonText;
                    anchors.centerIn:parent;
                    color:setLeftButtonFontColor;
                }
                MouseArea
                {
                    anchors.fill:parent;
                    onClicked:
                    {
                        leftButtonClicked()
                    }
                }
            }

            Rectangle
            {
                id:rightButton;//right button
                width:setWidthButtons;
                height:setHeightButtons;
                color: setRightButtonBackColor;
                border.color : setRightButtonBorderColor;
                border.width: setButtonsBorderWidth;
                anchors.right:parent.right;
                radius: setRadius;
                Text
                {
                    text:setRightButtonText;
                    anchors.centerIn:parent;
                    color:setRightButtonFontColor
                }
                MouseArea
                {
                    anchors.fill:parent;
                    onClicked:
                    {
                        rightButtonClicked();
                    }
                }
            }



        }


    }

    Loader
    {
        sourceComponent: buttonComponent;
    }
    //    Loader { sourceComponent: redSquare; x: 20 }
}
