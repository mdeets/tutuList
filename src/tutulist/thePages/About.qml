import QtQuick 2.15
import "../theScripts/config.js" as Configs

Item
{
    width:300;
    height:150;
    signal goToMain;

    Rectangle
    {
        id:local_root;
        anchors.fill:parent;
        color:appColors.c_background;//"#403E42"
        MouseArea //to avoid click on items placed under this ppage.
        {
            anchors.fill:parent;
        }
        Rectangle
        {
            id:baseHeaderSettings;
            width:parent.width;
            height:50;
            color:"transparent";

            Rectangle
            {
                id:baseBackButton;
                width:45;
                height:45;
                color:"transparent";
                anchors
                {
                    left:parent.left;
                    leftMargin:10;
                    verticalCenter: parent.verticalCenter;
                }

                Image
                {
                    width:24; height:24;
                    source:  appIcons.icon_back;
                    anchors.centerIn:parent;
                }
                MouseArea
                {
                    anchors.fill: parent;
                    onClicked:
                    {
                        goToMain();
                    }
                }
            }

            Text
            {
                id:titleSetting;
                text: "Settings";
                color:appColors.c_font_title;
                font.pointSize: Configs.font_size_text;
                anchors
                {
                    verticalCenter:parent.verticalCenter
                    left:baseBackButton.right;
                }
            }

}
    }
    Rectangle
    {
        id:aboutApp;
        width:parent.width;
        height: parent.height/5;
        anchors.centerIn:parent;
        color:appColors.c_background;
        Text
        {
            text:"Source Code (github.com)\n/iwantamouse/tutu-list";
            anchors.verticalCenter: parent.verticalCenter;
            anchors.left:parent.left;
            anchors.leftMargin:25;
            color:appColors.c_font_title;
            font.pointSize: 15;
//                        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        }
        Rectangle
        {
            id:baseiconBuiltWithQt
            width:150;
            height:parent.height;
            anchors.right: parent.right;
            anchors.verticalCenter: parent.verticalCenter
            color:"white";
            Image
            {
                source:appIcons.icon_built_with_qt;
                width:125;
                height:100;
                anchors.centerIn:parent;
            }

        }

    }
}
