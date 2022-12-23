import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

//configs
import "theScripts/config.js" as ConfigFile
import "theComponents"

Window
{
    id:mainWindow;
    width: ConfigFile.application_width;
    height: ConfigFile.application_height;
    visible: true;
    title: qsTr(ConfigFile.application_title);
    onClosing:
    {
        console.log("user is trying to close app. mainStackView Dep = "+ mainStackView.depth);
        if(mainStackView.depth===1)
        {
           console.log("SAFE EXIT.");
           mainWindow.close();
        }
        else
        {
            mainStackView.pop();
            close.accepted = false;
        }
    }


    Rectangle
    {
        id:root;
        anchors.fill:parent;
        color: ConfigFile.color_background;

        MouseArea { anchors.fill:parent; onClicked:
            { console.log("on root clicked");
                if(mainStackView.depth===1)
                {
                    mainStackView.push("./theForms/setupTask.qml");
                }

            }}

        TuTuTitleBar
        {
            id:tutu_titleBar;
        }

        Rectangle
        {
            id:centerPageBase;
            anchors
            {
                top: tutu_titleBar.bottom;
                bottom: tutu_bottonMenu.top;
                left:parent.left;
                right:parent.right;
            }
            color:"cyan";



            Loader
            {
                visible:  mainStackView.depth===1;
                id:pageLoader;
                anchors.fill: parent;
                source: "./thePages/AllTasks.qml";
            }
        }
        StackView
        {
            id:mainStackView;
            visible:  mainStackView.depth>1;
            onVisibleChanged:
            {
                if(visible)
                    tutu_bottonMenu.hide();
                else
                    tutu_bottonMenu.show();
            }

            initialItem: "./thePages/LoadingPage.qml";
            anchors
            {
                top:tutu_titleBar.bottom;
                left:parent.left;
                right:parent.right;
                bottom:parent.bottom;
            }
        }


        TutuBottomMenu
        {
            id:tutu_bottonMenu;
            anchors.bottom:parent.bottom;
            onHide:
            {
                this.visible=false;
            }
            onShow:
            {
                this.visible=true;
            }

            onAllTasksClicked:
            {
                pageLoader.source = "./thePages/AllTasks.qml";
                console.log("bottomMenu-> allTasks Clicked");
            }
            onTodayTasksClicked:
            {
                pageLoader.source = "./thePages/TodayTasks.qml";
                console.log("bottomMenu-> todayTasks Clicked");
            }
            onCompletedTasksClicked:
            {
                pageLoader.source = "./thePages/CompletedTasks.qml";
                console.log("bottomMenu-> completedTasks Clicked");
            }
        }
    }
}
