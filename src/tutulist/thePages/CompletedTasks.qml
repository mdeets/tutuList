
import QtQuick 2.15
import "../theComponents/"
import "../theScripts/config.js" as Configs
import "../theScripts/completedtasks.js" as CompletedTasks //just addToCompletedTasks used from CompletedTasks.js
import "../theScripts/todaytasks.js" as AddToTodayTasks

import "../theScripts/steptasks.js" as StepTaskManager
Item
{
    anchors.fill:parent;
////    signal mainQMLpleaseOpenSetupTaskForm;
    signal mainQMLpleaseOpenTheModifyTaskForm(int id, string title, string desc, string timeToPerform, string creationDate, string priority,string deadline);

    ShowTasks
    {
        id:showCompletedTasks
        componentType: "completedtasks";
        searchAllowed:false;
        addNewTaskAllowed:false;
        setIconDelete: ""; //this section dont need delete button right now.
        setIconLeft: Configs.icon_addTodayTask;
        setIconRight: Configs.icon_uncompleteTasks;
//                onSearchAllowedChanged:  function(text)
//                {

//                }

        onButtonRightClicked: function(tId,tsId,tsCompeteDate)
        {
            console.log("source : completedTasks.qml -> right button clicked");
            try
            {
                console.log("source : CompletedTasks.qml -> uncomplete this task clicked, id="+tId);
                const res = CompletedTasks.uncompleteTask(tId);
                if(res)
                {
                    console.log("source : CompletedTasks.qml -> i confirm the task is uncompleted.");
                    reloadAllTasks();
                }
                else
                    console.log("source : CompletedTasks.qml -> something went wrong error="+res)
            }
            catch(error)
            {
                console.log("source: completedTasks.qml -> error="+error)
            }

        }

        onButtonLeftClicked: function(tId,tsId,tsCompeteDate)
        {
            console.log("source : completedTasks.qml -> left button clicked");
            try
            {
                if(tsId>0)
                {
                    if(tsCompeteDate==="0")
                    {
                        console.log("source : CompletedTasks.qml -> complete this step task clicked, tasKStepId="+tsId+ " tId="+tId);
                        const queryResult = StepTaskManager.completeStep(tId,tsId);
                        if(queryResult)
                        {
                            console.log("source: CompletedTasks.qml -> taskStep completed successfully.");
                            reloadAllTasks()
                        }
                        else
                        {
                            console.log("source: CompletedTasks.qml -> taskStep failed to complete.");
                        }
                    }
                    else
                    {
                        console.log("source : CompletedTasks.qml -> lets uncomplete this taskStep. tsId="+tsId);
                        const queryResult = StepTaskManager.uncompleteStep(tId,tsId);
                        if(queryResult)
                        {
                            console.log("source: CompletedTasks.qml -> taskStep uncompleted successfully.");
                            reloadAllTasks();
                        }
                        else
                        {
                            console.log("source: CompletedTasks.qml -> taskStep failed to uncomplete.");
                        }
                    }


                }
                else
                {
                    console.log("source : CompletedTasks.qml -> add to today task clicked., id="+tId);
                    const res = CompletedTasks.uncompleteTask(tId);
                    if(res)
                    {
                        const res_addToTodayTask = AddToTodayTasks.addTaskToToday(tId);
                        if(res_addToTodayTask)
                        {
                            console.log("source : CompletedTasks.qml -> i confirm the task is uncompleted and added into today tasks.");
                            reloadAllTasks();
                        }
                        else
                            console.log("source : CompletedTasks.qml -> something went wrong error="+res_addToTodayTask)

                    }
                    else
                        console.log("source : CompletedTasks.qml -> something went wrong error="+res)
                }

            }
            catch(error)
            {
                console.log("source: CompletedTasks.qml -> error = " + error);
            }


        }
    }

    Connections //make connection with page showTasks.qml and the showCompletedTasks. then this will recive by main.qml
    {
        id:connectionWithShowCompletedTasks
        ignoreUnknownSignals: true
        target: showCompletedTasks;
/*//        function onOpenTheSetupTaskForm()
//        {
//            console.log("source : CompletedTasks.qml -> signal setupTaskForm recived from showTasks.qml");
//            mainQMLpleaseOpenSetupTaskForm();
//        }*/
        function onOpenTheModifyTaskForm(id,title, desc, timeToPerform, creationDate,priority,deadline)
        {
            console.log("source : CompletedTasks.qml -> signal open-modifytaskform recived from showTasks.qml");
            mainQMLpleaseOpenTheModifyTaskForm(id,title,desc,timeToPerform,creationDate,priority,deadline);
        }
    }
}


//import QtQuick 2.15
//import QtQuick.Controls 2.15
////import "../theScripts/TodayTasks.js" as AllTasks
//import "../theScripts/config.js" as Configs
//import "../theScripts/completedtasks.js" as CompletedTasks //just addToCompletedTasks used from CompletedTasks.js
//import "../theScripts/todaytasks.js" as AddToTodayTasks

//import "../theScripts/steptasks.js" as StepTaskManager

//Item
//{
//    signal reloadAllTasks;
//    onReloadAllTasks:
//    {
////        console.log("source: CompletedTasks.qml -> signal reloadAllTasks -> result TodayTasks.getlist() -> " +TodayTasks.getList());
//        console.log("source : CompletedTasks.qml -> signal reloadAllTasks called.");
//        listModelMain.clear();
//        if(CompletedTasks.getList(listModelMain,"appendToList")!==1)
//        {
//            console.log("source:completedtasks.qml -> i confirm getlist is successfully done.");
//        }
//    }

//    anchors.fill:parent;
//    Component.onCompleted:
//    {
//        console.log("source : CompletedTasks.qml -> im completelly loaded.");
//        reloadAllTasks();
//    }

//    Rectangle
//    {
//        id:theListBase;
//        anchors
//        {
//            fill:parent;
//        }
//        color:"transparent";

//        ListView
//        {
//            id:listViewMain;
//            anchors.fill:parent;
////            anchors.topMargin:35;
//            clip:true;
//            model:
//            ListModel
//            {
//                id:listModelMain;
//            }
//            delegate:
//            Item
//            {
//                width: listViewMain.width;
//                height: tsId> 0 ? 35:70;
//                Rectangle
//                {
//                    anchors.fill: parent;
//                    color:"transparent";
//                    Rectangle
//                    {
//                        id:itemmm2;
//                        width: tsId > 0 ? parent.width/1.50 : parent.width/1.10;
//                        height: tsId > 0 ? parent.height/1.50 : 50; //tsId >0 means this is task Step. not a task
//                        color: tsId > 0 ? "cyan" : "gray"; //tsId >0 means this is task Step. not a task
//                        radius:15;
//                        anchors.horizontalCenter: parent.horizontalCenter;

//                        MouseArea
//                        {
//                            anchors.fill:parent;
//                            onClicked:
//                            {
//                                if(tsId === 0)
//                                    console.log("source: CompletedTasks.qml -> on task clicked.");
//                                else
//                                    console.log("source: CompletedTasks.qml -> on stepTask clicked.");
//                            }
//                        }

//                        Text
//                        {
//                            text: tsId>0 ? tsTitle : tTitle;
//                            color: tsId > 0 ? "black":"white";
//                            font.pointSize: tsId>0 ? 10 : 18;
//                            width:parent.width/3;
//                            clip:true;
//                            anchors
//                            {
//                                verticalCenter:parent.verticalCenter;
//                                left:parent.left;
//                                leftMargin: 30;
//                            }

//                        }
//                        Rectangle
//                        {
//                            id:uncompleteTask;
//                            width:45;
//                            height:parent.height;
//                            anchors.right:parent.right;
//                            color:"transparent";
//                            Image
//                            {
//                                anchors.centerIn:parent;
//                                source: tsId>0 ? tsCompeteDate==="0" ? Configs.icon_completeTasks : Configs.icon_uncompleteTasks :Configs.icon_uncompleteTasks;
//                            }

//                            MouseArea
//                            {
//                                anchors.fill:parent;
//                                onClicked:
//                                {
//                                    if(tsId>0)
//                                    {
//                                        if(tsCompeteDate==="0")
//                                        {
//                                            console.log("source : CompletedTasks.qml -> complete this step task clicked, tasKStepId="+tsId+ " tId="+tId);
//                                            const queryResult = StepTaskManager.completeStep(tId,tsId);
//                                            if(queryResult)
//                                            {
//                                                console.log("source: CompletedTasks.qml -> taskStep completed successfully.");
//                                                reloadAllTasks();
//                                            }
//                                            else
//                                            {
//                                                console.log("source: CompletedTasks.qml -> taskStep failed to complete.");
//                                            }
//                                        }
//                                        else
//                                        {
//                                            console.log("source : CompletedTasks.qml -> lets uncomplete this taskStep. tsId="+tsId);
//                                            const queryResult = StepTaskManager.uncompleteStep(tId,tsId);
//                                            if(queryResult)
//                                            {
//                                                console.log("source: CompletedTasks.qml -> taskStep uncompleted successfully.");
//                                                reloadAllTasks();
//                                            }
//                                            else
//                                            {
//                                                console.log("source: CompletedTasks.qml -> taskStep failed to uncomplete.");
//                                            }
//                                        }


//                                    }
//                                    else
//                                    {
//                                        console.log("source : CompletedTasks.qml -> uncomplete this task clicked, id="+tId);
//                                        const res = CompletedTasks.uncompleteTask(tId);
//                                        if(res)
//                                        {
//                                                console.log("source : CompletedTasks.qml -> i confirm the task is uncompleted.");
//                                                reloadAllTasks();
//                                        }
//                                        else
//                                            console.log("source : CompletedTasks.qml -> something went wrong error="+res)
//                                    }
//                                }
//                            }
//                        }
//                        Rectangle
//                        {
//                            id:addToToday;
//                            width:tsId>0 ? 0: 45;
//                            height:tsId> 0 ? 0 : parent.height;
//                            visible: tsId>0? false:true;
//                            anchors.right:uncompleteTask.left;
//                            color:"transparent";
//                            Image
//                            {
//                                source : Configs.icon_addTodayTask;
//                                anchors.centerIn: parent;
//                            }

//                            MouseArea
//                            {
//                                anchors.fill:parent;
//                                onClicked:
//                                {
//                                    console.log("source : CompletedTasks.qml -> add to today task clicked., id="+tId);
//                                    const res = CompletedTasks.uncompleteTask(tId);
//                                    if(res)
//                                    {
//                                        const res_addToTodayTask = AddToTodayTasks.addTaskToToday(tId);
//                                        if(res_addToTodayTask)
//                                        {
//                                            console.log("source : CompletedTasks.qml -> i confirm the task is uncompleted and added into today tasks.");
//                                            reloadAllTasks();
//                                        }
//                                        else
//                                            console.log("source : CompletedTasks.qml -> something went wrong error="+res_addToTodayTask)

//                                    }
//                                    else
//                                        console.log("source : CompletedTasks.qml -> something went wrong error="+res)
//                                }
//                            }
//                        }



//                    }


//                }

//            }//end of item delegate

//        }//end of list view


//    }

//}
