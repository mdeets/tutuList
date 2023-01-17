
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
        searchAllowed:true;
        setPageTitle: "Completed Tasks";
        addNewTaskAllowed:false;
        setIconDelete: ""; //this section dont need delete button right now.
        setIconLeft: Configs.icon_back;//Configs.icon_addTodayTask;
        setIconRight: Configs.icon_uncompleteTasks;
        onSearchTextChanged:  function(text)
        {
            console.log("source : completedTasks.qml -> search allowed here. text="+text);
            showCompletedTasks.listModelAccessForOutSide.clear();
            CompletedTasks.getList(showCompletedTasks.listModelAccessForOutSide,"appendToList","searchOn","likeOn",text);
        }

//        onATaskCreatedViaQuicklyCreation: function(tId)
//        {
//            console.log("source: completedTasks.qm -> aTaskCreatedViaQuicklyCreation called. tId=" + tId)
//        }

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

