import QtQuick 2.15
import "../theScripts/config.js" as Configs
import QtQuick.Controls 2.15


Page
{

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
                id:titlePage;
                text: "Deadlines";
                color:appColors.c_font_title;
                font.pointSize: Configs.font_size_text;
                anchors
                {
                    verticalCenter:parent.verticalCenter
                    left:baseBackButton.right;
                }
            }

        }//button back.





        //content
        Rectangle
        {
            id:pageContent;
            width:parent.width;
            height: parent.height-baseHeaderSettings.height;
            anchors
            {
                top:parent.top;
                topMargin:baseHeaderSettings.height
            }
            color:appColors.c_background;

            Item
            {
                width:parent.width;
                height:parent.height;
                Loader
                {
                    id:pageLoader;
                    anchors.fill: parent;
                }
                Component.onCompleted:
                {
                    console.log("source: DeadlineList.qml -> ComponentCompleted. lets setSource for pageloader.");
                    pageLoader.setSource("./AllTasks.qml",
                                         {"statusQueryDeadlines":"queryDeadlines",
                                         "pageSearchStatus":false,
                                         "pageTitle":"Coming Up"});
                }
            }

        }
    }

}
