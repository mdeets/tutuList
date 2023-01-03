.import "databaseHeader.js" as DBC


//function deleteStep()
//{

//}

//function completeStep()
//{

//}

//function updateStep()
//{

//}

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
