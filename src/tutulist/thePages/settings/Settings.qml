import QtQuick 2.15
import "../../theScripts/config.js" as Configs
import QtQuick.Controls 2.15
Page
{
    Rectangle
    {
        id:local_root;
        anchors.fill:parent;
        color:"#403E42";//Configs.color_background;
        MouseArea //to avoid click on items placed under this ppage.
        {
            anchors.fill:parent;
        }
        Rectangle
        {
            id:baseHeaderSettings;
            width:parent.width;
            height:50;
            color:"black"
            Text
            {
                id:titleSetting;
                text: "Settings";
                color:"white";
                font.pointSize: 20;
                anchors
                {
                    verticalCenter:parent.verticalCenter
                    left:parent.left;
                    leftMargin:25;
                }
            }
            Rectangle
            {
                id:baseChangeThemeRadioButton;
                width:100;
                height:24;
                color:"red";
                anchors
                {
                    right:parent.right;
                    verticalCenter: parent.verticalCenter;
                }
                Image
                {
                    width:24;
                    height:24;
                    source: Configs.icon_backward;
                    anchors
                    {
                        verticalCenter:parent.verticalCenter
                    }
                }
                Image
                {
                    width:24;
                    height:24;
                    source: Configs.icon_back;
                    anchors.right: parent.right;
                    anchors
                    {
                        verticalCenter:parent.verticalCenter
                    }
                }

            }
        }



    }

}
