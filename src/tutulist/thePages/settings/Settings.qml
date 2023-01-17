import QtQuick 2.15
import "../../theScripts/config.js" as Configs
import QtQuick.Controls 2.15
Page
{
    signal goToMain;
    onGoToMain:
    {
        console.log("source: Settings.qml -> signal goBack called.)")
    }

    Rectangle
    {
        id:local_root;
        anchors.fill:parent;
        color:Configs.color_background;//"#403E42"
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
                    source:  Configs.icon_back;
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
                color:Configs.color_font_title;
                font.pointSize: Configs.font_size_title;
                anchors
                {
                    verticalCenter:parent.verticalCenter
                    left:baseBackButton.right;
                }
            }
        Rectangle
        {
            width:45; height:45;
            color:"red";
            anchors.verticalCenter: parent.verticalCenter;
            anchors.right:parent.right;
            anchors.rightMargin:25;
            Text
            {
                id:tempStatusTheme;
                text:Configs.color_font_title
            }
        }

        }



    }

}
