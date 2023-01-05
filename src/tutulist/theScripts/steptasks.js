.import "databaseHeader.js" as DBC


//function updateStep()
//{

//}

function deleteStepTask(taskId,taskStepId)//return 1 means all done. else error.
{
    try
    {
        var db = DBC.getDatabase();
        var result = 0;
        db.transaction
                (
                    function(tx)
                    {
                        var rs = tx.executeSql('DELETE FROM '+DBC.table_taskSteps+' WHERE t_id=? AND ts_id = ?;',
                                                                             [taskId,
                                                                              taskStepId]);

                        if (rs.rowsAffected > 0)
                        {
                            console.log("source : steptasks.js/deleteStepTask() -> query successfully exectured.");
                            result = "1";
                        }
                        else
                        {
                            console.log("source : steptasks.js/deleteStepTask() -> query failed.");
                            result = "0";
                        }

                    }
                );
        return result;
    }
    catch(error)
    {
        console.log("source : steptasks.js/deleteStepTask() -> error= "+error);
        return "source : steptasks.js/deleteStepTask() -> error= "+error;
    }
}




function completeStep(taskId,taskStepId) //reutrn 1 means all done, else error.
{
    try
    {
        var db = DBC.getDatabase();
        var result = 0;
        db.transaction
                (
                    function(tx)
                    {
                        var rs = tx.executeSql('UPDATE '+DBC.table_taskSteps+' SET ts_completeDate=? WHERE t_id=? AND ts_id = ?;',
                                                                             [DBC.getCurrentDateAndTime(),
                                                                              taskId,
                                                                              taskStepId]);

                        if (rs.rowsAffected > 0)
                        {
                            console.log("source : steptasks.js/completeStep() -> query successfully exectured.");
                            result = "1";
                        }
                        else
                        {
                            console.log("source : steptasks.js/completeStep() -> query failed.");
                            result = "0";
                        }

                    }
                );
        return result;
    }
    catch(error)
    {
        console.log("source : steptasks.js/completeStep() -> error= "+error);
        return "source : steptasks.js/completeStep() -> error= "+error;
    }
}


function uncompleteStep(taskId,taskStepId) //reutrn 1 means all done, else error.
{
    try
    {
        var db = DBC.getDatabase();
        var result = 0;
        db.transaction
                (
                    function(tx)
                    {
                        var rs = tx.executeSql('UPDATE '+DBC.table_taskSteps+' SET ts_completeDate=0 WHERE t_id=? AND ts_id = ?;',
                                                                             [taskId,
                                                                              taskStepId]);

                        if (rs.rowsAffected > 0)
                        {
                            console.log("source : steptasks.js/uncompleteStep() -> query successfully exectured.");
                            result = "1";
                        }
                        else
                        {
                            console.log("source : steptasks.js/uncompleteStep() -> query failed.");
                            result = "0";
                        }

                    }
                );
        return result;
    }
    catch(error)
    {
        console.log("source : steptasks.js/uncompleteStep() -> error= "+error);
        return "source : steptasks.js/uncompleteStep() -> error= "+error;
    }
}


function quicklyAddNewStep(taskId,stepText)
{
    return addNewStep(taskId,stepText,"empty","0");
}

function addNewStep(taskId,stepText,stepDesc,stepCompleteDate="0") //return 1 means all done. else error.
{
    try
    {
        var db = DBC.getDatabase();
        var result = 0;
        db.transaction
                (
                    function(tx)
                    {
                        var rs = tx.executeSql('INSERT INTO '+DBC.table_taskSteps+' (t_id,ts_title,ts_description,ts_completeDate) VALUES (?,?,?,?);',
                                                                             [taskId,
                                                                              stepText,
                                                                              stepDesc,
                                                                              stepCompleteDate]);

                        if (rs.rowsAffected > 0)
                        {
                            console.log("source : steptasks.js/addNewStep() -> query successfully exectured.");
                            result = "1";
                        }
                        else
                        {
                            console.log("source : steptasks.js/addNewStep() -> query failed.");
                            result = "0";
                        }

                    }
                );
        return result;
    }
    catch(error)
    {
        console.log("source : steptasks.js/addNewStep() -> error= "+error);
        return "source : steptasks.js/addNewStep() -> error= "+error;
    }
}
