import QtQuick 2.15
//import QtQuick.Window 2.15
import QtQuick.Controls 2.15

//configs
import "theScripts/config.js" as ConfigFile
import "theComponents"
import "theScripts/databaseHeader.js" as DBheader
import "theScripts/alltasks.js" as AllTasksJs
/*
  update document MIRO.com
    diagram database working on tasks -> today settings
    settings database add.
    function getList add new arguman.
    add creation date for tasks.
    update completed tasks , today tasks -> taskId is primary too
    table complete, today -> remove id, make t_id primary
  */
Window
{

    id:mainWindow;
    width: ConfigFile.application_width;
    height: ConfigFile.application_height;
    visible: true;
    title: qsTr(ConfigFile.application_title);

    signal pageAllTasksPleaseRefreshYourSelf;
    onPageAllTasksPleaseRefreshYourSelf:
    {
        pageLoader.active=false;
//        pageLoader.source = "./thePages/AllTasks.qml";
        pageLoader.active=true;
    }

    Component.onCompleted:
    {
        console.log("source : main.qml -> Application started successfully.");


        //check connection with database then init tables.
        const res_testDB = DBheader.testDatabaseConnection();//this table isnt include inside the function DBheader.deleteTables..() so it run even main tables are removed.
        if(res_testDB)
        {
            console.log("source : main.qml -> result databsae connection check = OK , response="+res_testDB);
            DBheader.initDatabaseTables();
            tutu_bottonMenu.setCurrentPage= 1;//set as home page.
        }
        else
            console.log("source : main.qml -> result database connection = failed, response=" + res_testDB);

    }

    onClosing:
    {
        console.log("source : main.qml -> user is trying to close app, mainStackView Dep = "+ mainStackView.depth);
        if(mainStackView.depth===1)
        {
           console.log("source : main.qml -> SAFE EXIT.");
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

        MouseArea
        {
            anchors.fill:parent; onClicked:
            {
                console.log("source : main.qml -> on root clicked");
//                if(mainStackView.depth===1)
//                {
//                    mainStackView.push("./theForms/setupTask.qml");
//                }

            }}

        TuTuTitleBar
        {
            id:tutu_titleBar;
            onButtonMainMenuClicked:
            {
                mainStackView.push("./thePages/settings/Settings.qml");
            }
        }

        Rectangle
        {
            id:centerPageBase;
            anchors
            {
                top: tutu_titleBar.bottom;
//                bottom: tutu_bottonMenu.top;
                bottom:parent.bottom;
                left:parent.left;
                right:parent.right;
            }
            color:"white";



            Loader
            {
                id:pageLoader;
                visible:  mainStackView.depth===1;
                anchors.fill: parent;
                source: "./thePages/TodayTasks.qml";
                property bool valid: item !== null;
            }

            Connections //make connection with page AllTasks.qml & TodayTasks.qml & CompletedTasks.qml and the PageLoader
            {
                id:connectionWithPageLoader
                ignoreUnknownSignals: true
                target: pageLoader.valid? pageLoader.item : null

                //callable by AllTasks.qml for now.
                function onMainQMLpleaseOpenSetupTaskForm()
                {
                    console.log("source : main.qml -> signal mainQMLpleaseOpenSetupTaskForm recived from AllTasks.qml.");
                    mainStackView.push("./theForms/setupTask.qml");
                }

                //callable by AllTasks.qml or TodayTasks.qml or CompletedTasks.qml for now.
                function onMainQMLpleaseOpenTheModifyTaskForm(id,title, desc, timeToPerform, creationDate,priority,deadline)
                {
                    console.log("source : main.qml -> signal mainQMLpleaseOpenTheModifyTaskForm recived from AllTasks.qml or TodayTasks.qml or CompletedTasks.qml");


                    mainStackView.push(Qt.resolvedUrl("./theForms/modifyTask.qml"),
                                       {
                                           idValue: Qt.binding(function() { return id }),
                                           titleValue: Qt.binding(function() { return title}),
                                           descriptionValue: Qt.binding(function() { return desc}),
                                           timeToPerformValue: Qt.binding(function() { return timeToPerform}),
                                           priorityValue:Qt.binding(function() { return priority}),
                                           deadlineValue:Qt.binding(function() { return deadline}),
                                           creationdateValue:Qt.binding(function() { return creationDate})
                                       })
                }

            }
            Connections //make connection with page setupTask.qml to quit after new task saved successfully.
            {
                id:connectionWithMainStackView;
                ignoreUnknownSignals: true;
                target: mainStackView.currentItem;
                function onQuitTheSetupTaskFrom()
                {
                    console.log("source : main.qml -> signal quit the setup task recived from setupTask.qml");
                    mainStackView.pop();
                    pageAllTasksPleaseRefreshYourSelf();
                }
                function onQuitFromModifyTaskForm()
                {
                    console.log("source : main.qml -> close-modifytaskform signal recived from modifyTask.qml");
                    mainStackView.pop();
                    pageAllTasksPleaseRefreshYourSelf();
                }
            }


        }
        StackView
        {
            id:mainStackView;
            visible:mainStackView.depth>1;
            onVisibleChanged:
            {
                if(visible)
                    tutu_bottonMenu.hide();
                else
                    tutu_bottonMenu.show();
            }

            initialItem: "./thePages/LoadingPage.qml";
            anchors.fill:parent;
        }


        TutuIndicator
        {
            id:tutu_bottonMenu;
            anchors
            {
                bottom:parent.bottom;
                bottomMargin:25;
            }

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
                console.log("source : main.qml -> bottomMenu-> allTasks Clicked");
            }
            onTodayTasksClicked:
            {
                pageLoader.source = "./thePages/TodayTasks.qml";
                console.log("source : main.qml -> bottomMenu-> todayTasks Clicked");
            }
            onCompletedTasksClicked:
            {
                pageLoader.source = "./thePages/CompletedTasks.qml";
                console.log("source : main.qml -> bottomMenu-> completedTasks Clicked");
            }
        }
    }



}
