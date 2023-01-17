import QtQuick 2.15
import "../theScripts/config.js" as Configs

Item
{
    width:parent.width;
    height: Configs.topTitleBar_height;
    signal buttonMainMenuClicked;

    Rectangle
    {
        id:local_root;
        anchors.fill:parent;
        color:appColors.c_background;
    }
    Rectangle
    {
        id:baseMenuBarIcon
        height:parent.height
        width:height
        color:"transparent";
        anchors
        {
            leftMargin:10;
            left:parent.left
        }
        Image
        {
            anchors.fill: parent;
            source: appIcons.icon_menubar;
        }
        MouseArea
        {
            anchors.fill: parent;
            onClicked:
            {
                console.log("source : TutuTitleBar.qml -> on menubar clicked");
                buttonMainMenuClicked();
            }
        }
    }
    Text
    {
        function todayDate()
        {
            const tempDate = new Date();
            const daynum = tempDate.getDate();
            switch(tempDate.getMonth())
            {
                case 0: return "January "+daynum;
                case 1: return "February "+daynum;
                case 2: return "March "+daynum;
                case 3: return "April "+daynum;
                case 4: return "May "+daynum;
                case 5: return "June "+daynum;
                case 6: return "July "+daynum;
                case 7: return "August "+daynum;
                case 8: return "September "+daynum;
                case 9: return "October "+daynum;
                case 10:return "November "+daynum;
                case 11:return "December "+daynum;
                default : return -1; //error
            }
        }

        text:todayDate();
        color:appColors.c_font_title;
        font.pointSize: Configs.font_size_text;
        anchors
        {
            verticalCenter:parent.verticalCenter;
            right:parent.right
            rightMargin:15;
        }
    }
}
