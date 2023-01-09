import QtQuick 2.15
import "../theComponents/"
import "../theScripts/todaytasks.js" as TodayTasks
import "../theScripts/config.js" as Configs
import "../theScripts/steptasks.js" as StepTaskManager
import "../theScripts/completedtasks.js" as AddToCompletedTasks //just addToCompletedTasks used.


Item
{
    anchors.fill:parent;
//    signal mainQMLpleaseOpenSetupTaskForm;
    signal mainQMLpleaseOpenTheModifyTaskForm(int id, string title, string desc, string timeToPerform, string creationDate, string priority,string deadline);

    ShowTasks
    {
        id:showTodayTasks
        componentType: "todaytasks";
        searchAllowed:false;
        addNewTaskAllowed:false;
        setIconLeft: Configs.icon_backward;
        setIconRight:Configs.icon_completeTasks;
        //        onSearchAllowedChanged:  function(text)
        //        {

        //        }

        onButtonRightClicked: function(tId,tsId,tsCompeteDate)
        {
            console.log("source : todayTasks.qml -> right button clicked");
            console.log("source : todayTasks.qml -> complete this task clicked, id="+tId);
            const res = AddToCompletedTasks.completeTask(tId);
            if(res)
            {
                const res_removeTaskFromToday = TodayTasks.removeTaskFromToday(tId);
                if(res_removeTaskFromToday)
                {
                    //                                            completeImage.source = Configs.icon_uncompleteTasks;
                    console.log("source : todayTasks.qml -> i confirm the task is removed from todaytask and added into completed tasks.");
                    reloadAllTasks();
                }
                else
                    console.log("source : todayTasks.qml -> something went wrong error="+res_removeTaskFromToday);

            }
            else
                console.log("source : todayTasks.qml -> something went wrong error="+res)

        }

        onButtonLeftClicked: function(tId,tsId,tsCompeteDate)
        {
            console.log("source : todayTasks.qml -> left button clicked");
            try
            {
                if(tsId>0)
                {
                    if(tsCompeteDate==="0")
                    {
                        console.log("source : todayTasks.qml -> complete this step task clicked, tasKStepId="+tsId);
                        const queryResult = StepTaskManager.completeStep(tId,tsId);
                        if(queryResult)
                        {
                            console.log("source: todayTasks.qml -> taskStep completed successfully.");
                            reloadAllTasks()
                        }
                        else
                        {
                            console.log("source: todayTasks.qml -> taskStep failed to complete.");
                        }
                    }
                    else
                    {
                        console.log("source : todayTasks.qml -> lets uncomplete this taskStep. tsId="+tsId);
                        const queryResult = StepTaskManager.uncompleteStep(tId,tsId);
                        if(queryResult)
                        {
                            console.log("source: todayTasks.qml -> taskStep uncompleted successfully.");
                            reloadAllTasks();
                        }
                        else
                        {
                            console.log("source: todayTasks.qml -> taskStep failed to uncomplete.");
                        }
                    }
                }
                else
                {
                    console.log("source : todayTasks.qml -> remove this task from today clicekd., id="+tId);
                    const res = TodayTasks.removeTaskFromToday(tId);
                    if(res)
                    {
                        console.log("source : todayTasks.qml -> i confirm the task is removed from todaytasks.");
                        reloadAllTasks();
                    }
                    else
                        console.log("source : todayTasks.qml -> something went wrong error="+res)
                }
            }
            catch(error)
            {
                console.log("source: todayTasks.qml -> error = " + error);
            }
        }
    }
    Connections //make connection with page showTasks.qml and the showTodayTasks. then this will recive by main.qml
    {
        id:connectionWithShowTodayTasks
        ignoreUnknownSignals: true
        target: showTodayTasks;
//        function onOpenTheSetupTaskForm()
//        {
//            console.log("source : TodayTasks.qml -> signal setupTaskForm recived from showTasks.qml");
//            mainQMLpleaseOpenSetupTaskForm();
//        }
        function onOpenTheModifyTaskForm(id,title, desc, timeToPerform, creationDate,priority,deadline)
        {
            console.log("source : TodayTasks.qml -> signal open-modifytaskform recived from showTasks.qml");
            mainQMLpleaseOpenTheModifyTaskForm(id,title,desc,timeToPerform,creationDate,priority,deadline);
        }
    }
}

//import QtQuick 2.15
//import QtQuick.Controls 2.15
////import "../theScripts/TodayTasks.js" as AllTasks
//import "../theScripts/config.js" as Configs
//import "../theScripts/completedtasks.js" as AddToCompletedTasks //just addToCompletedTasks used.
//import "../theScripts/todaytasks.js" as TodayTasks
//import "../theScripts/steptasks.js" as StepTaskManager
//Item
//{
//    signal reloadAllTasks;
//    onReloadAllTasks:
//    {
////        console.log("source: todayTasks.qml -> signal reloadAllTasks -> result TodayTasks.getlist() -> " +TodayTasks.getList());
//        console.log("source : todayTasks.qml -> signal reloadAllTasks called.");
//        listModelMain.clear();
//        TodayTasks.getList(listModelMain,"appendToList");
//    }

//    anchors.fill:parent;
//    Component.onCompleted:
//    {
//        console.log("source : todayTasks.qml -> im completelly loaded.");
//        reloadAllTasks();
//    }

//    Rectangle
//    {
//        id:theListBase;
//        anchors
//        {
//            fill:parent
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
//                            id:completeTask;
//                            width:45;
//                            height:parent.height;
//                            anchors.right:parent.right;
//                            color:"transparent";
//                            Image
//                            {
////                                id:completeImage;
//                                anchors.centerIn:parent;
//                                source: tsId>0 ? tsCompeteDate==="0" ? Configs.icon_completeTasks : Configs.icon_uncompleteTasks :Configs.icon_completeTasks;
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
//                                            console.log("source : todayTasks.qml -> complete this step task clicked, tasKStepId="+tsId+ " tId="+tId);
//                                            const queryResult = StepTaskManager.completeStep(tId,tsId);
//                                            if(queryResult)
//                                            {
//                                                console.log("source: todayTasks.qml -> taskStep completed successfully.");
//                                                reloadAllTasks();
//                                            }
//                                            else
//                                            {
//                                                console.log("source: todayTasks.qml -> taskStep failed to complete.");
//                                            }
//                                        }
//                                        else
//                                        {
//                                            console.log("source : todayTasks.qml -> lets uncomplete this taskStep. tsId="+tsId);
//                                            const queryResult = StepTaskManager.uncompleteStep(tId,tsId);
//                                            if(queryResult)
//                                            {
//                                                console.log("source: todayTasks.qml -> taskStep uncompleted successfully.");
//                                                reloadAllTasks();
//                                            }
//                                            else
//                                            {
//                                                console.log("source: todayTasks.qml -> taskStep failed to uncomplete.");
//                                            }
//                                        }


//                                    }
//                                    else
//                                    {
//                                        console.log("source : todayTasks.qml -> complete this task clicked, id="+tId);
//                                        const res = AddToCompletedTasks.completeTask(tId);
//                                        if(res)
//                                        {
//                                            const res_removeTaskFromToday = TodayTasks.removeTaskFromToday(tId);
//                                            if(res_removeTaskFromToday)
//                                            {
//    //                                            completeImage.source = Configs.icon_uncompleteTasks;
//                                                console.log("source : todayTasks.qml -> i confirm the task is removed from todaytask and added into completed tasks.");
//                                                reloadAllTasks();
//                                            }
//                                            else
//                                                console.log("source : todayTasks.qml -> something went wrong error="+res_removeTaskFromToday);

//                                        }
//                                        else
//                                            console.log("source : todayTasks.qml -> something went wrong error="+res)
//                                    }

//                                }
//                            }
//                        }


//                        Rectangle
//                        {
//                            id:removeFromToday;
//                            width:tsId>0 ? 0: 45;
//                            height:tsId> 0 ? 0 : parent.height;
//                            visible: tsId>0? false:true;
//                            anchors.right:completeTask.left;
//                            color:"gray";
//                            Image
//                            {
//                                anchors.centerIn: parent;
//                                source: Configs.icon_removeTodayTask;
//                            }

//                            MouseArea
//                            {
//                                anchors.fill:parent;
//                                onClicked:
//                                {
//                                    console.log("source : todayTasks.qml -> remove this task from today clicekd., id="+tId);
//                                    const res = TodayTasks.removeTaskFromToday(tId);
//                                    if(res)
//                                    {
//                                            console.log("source : todayTasks.qml -> i confirm the task is removed from todaytasks.");
//                                            reloadAllTasks();
//                                    }
//                                    else
//                                        console.log("source : todayTasks.qml -> something went wrong error="+res)
//                                }
//                            }
//                        }



//                    }


//                }

//            }//end of item delegate

//        }//end of list view


//    }




//}
