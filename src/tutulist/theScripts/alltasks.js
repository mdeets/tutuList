.import "databaseHeader.js" as DBC

function updatePartOfTask(taskId,partField,partValue)//return 1 means query OK, return etc means query failed
{
    //this is quick way to update just one field for that table.
    //becareful partfield ist caseSensetive and important
    try
    {
        var db = DBC.getDatabase();
        var result="0";
        db.transaction
                (
                    function(tx)
                    {
                        var rs = tx.executeSql('UPDATE '+DBC.table_allTasks+' SET ?=? WHERE t_id=?;'
                                               ,[partField,
                                                 partValue,
                                                 taskId]);

                        if (rs.rowsAffected > 0)
                        {
                            console.log("source : allTasks.js/updateWholeTask() -> query successfully exectured.");
                            result = 1;
                        }
                        else
                        {
                            console.log("source : allTasks.js/updateWholeTask() -> query failed.");
                            result= 0;
                        }

                    }
                );
        return result;
    }
    catch(error)
    {
        console.log("source : allTasks.js/updateWholeTask() -> error= "+error);
        return "source : allTasks.js/updateWholeTask() -> error= "+error;
    }
}

function updateWholeTask(taskId,title,desc,priority=100,timeToPerform=0,deadline=0)
{
    try
    {
        var db = DBC.getDatabase();
        var result="0";
        db.transaction
                (
                    function(tx)
                    {
                        var rs = tx.executeSql('UPDATE '+DBC.table_allTasks+' SET t_title=?, t_description=?, t_timeToPerform=?, t_priority=?, t_deadline=? WHERE t_id=?;'
                                               ,[title,
                                                 desc,
                                                 priority,
                                                 timeToPerform,
                                                 deadline,
                                                 taskId]);

                        if (rs.rowsAffected > 0)
                        {
                            console.log("source : allTasks.js/updateWholeTask() -> query successfully exectured.");
                            result = 1;
                        }
                        else
                        {
                            console.log("source : allTasks.js/updateWholeTask() -> query failed.");
                            result = 0;
                        }

                    }
                );
        return result;
    }
    catch(error)
    {
        console.log("source : allTasks.js/updateWholeTask() -> error= "+error);
        return "source : allTasks.js/updateWholeTask() -> error= "+error;
    }
}

function deleteTask(taskId)//return 1 means Query is successfuly executed, etc means error.
{
    try
    {
        var result="0";
        var db = DBC.getDatabase();
        db.transaction
                (
                    function(tx)
                    {
                        var rs = tx.executeSql('DELETE FROM '+DBC.table_allTasks+' WHERE t_id=?;',[taskId]);
                        if (rs.rowsAffected > 0)
                        {
                            console.log("source : allTasks.js/deleteTask() -> query successfully exectured.");
                            result= 1;
                        }
                        else
                        {
                            console.log("source : allTasks.js/deleteTask() -> query failed.");
                            result= 0;
                        }

                    }
                );
        return result;
    }
    catch(error)
    {
        console.log("source : allTasks.js/deleteTask() -> error= "+error);
        return "source : allTasks.js/deleteTask() -> error= "+error;
    }
}

function addQuicklyNewTask(title)
{
    return addNewTask(title,"0",0,"0","0");
}

function addNewTask(title,desc,priority,deadline,timeToPerform) //return 1 means Query is OK, etc is failure
{
    try
    {
        var db = DBC.getDatabase();
        var result = "0";
        db.transaction
                (
                    function(tx)
                    {
                        const tabl = DBC.table_allTasks;
                        var rs = tx.executeSql('INSERT INTO '+tabl+' (t_title,t_description,t_priority,t_timeToPerform,t_deadline) VALUES (?,?,?,?,?);',
                                                                             [title,
                                                                              desc,
                                                                              priority,
                                                                              timeToPerform,
                                                                              deadline]);

                        if (rs.rowsAffected > 0)
                        {
                            console.log("source : allTasks.js/addNewTask() -> query successfully exectured.");
                            result = "1";
                        }
                        else
                        {
                            console.log("source : allTasks.js/addNewTask() -> query failed.");
                            result = "0";
                        }

                    }
                );
        return result;
    }
    catch(error)
    {
        console.log("source : allTasks.js/addNewTask() -> error= "+error);
        return "source : allTasks.js/addNewTask() -> error= "+error;
    }
}

function getList(targetList,returnType="json") //return ETC means OK, return 1 is error
{
    /*
        This function will fetch and return as json OR append data into the list.

        Argumants:
            targetList = that list we want to append data into
                    (optional).

            returnType = is a flag to know with wich format return, json or append to targetList
                    values = ['json',''] json or etc -> appendToList
                    (default: return as json)


        Output:
                Json:
                            tasks =>
                                    id,title,description,
                                    timeToPerform,deadline,creationDate,
                                    priority,childCount(*NOTE-1*),childX(*NOTE-2*)

                            (*NOTE-1*) childCount -> when json paresed you need to get this and make a loop untill this value to know how much child has.


                            (*NOTE-2*) childX -> X means a number, for exmaple our task has 10 step, so we read from childCount then looking for child1[i] to child10[i].
                                    to access childX values needs to do childX[y] y from 0 to 5
                                              for example:

                                              {
                                                "tasks":
                                                [
                                                    {
                                                      "id": "33",
                                                      "title": "something",
                                                      "description": "helloworld",
                                                      , ETC... ,
                                                      "child1":
                                                      [
                                                        "id",
                                                        10,
                                                        "title",
                                                        12,
                                                        "description",
                                                        "thi is the taskStep Description",
                                                        "completeDate",
                                                        "10-2-2000 10:22:14"
                                                      ]
                                                      "child2":
                                                      [
                                                        "id",
                                                        11,
                                                        "title",
                                                        13,
                                                        "description",
                                                        "write the code",
                                                        "completeDate",
                                                        "14-2-2000 10:11:11"
                                                      ]
                                                    }
                                                  ]
                                                }
    */


    try
    {
        var db = DBC.getDatabase();
        var result = "1";

        db.transaction
                (
                    function(tx)
                    {
                        var rs = tx.executeSql('SELECT * FROM '+DBC.table_allTasks+' ORDER BY t_creationDate ASC;');
                        var tableColumns = rs.rows.length;

                        if (rs.rows.length > 0)
                        {
                            if(returnType==="json")
                            {
                                result+= '{ "tasks" : [';
                                //pepear the json with tasks data:
                                for(var x=0; x<tableColumns; x++)
                                {
                                    var stepCounter=0;
                                    const theTaskId = rs.rows.item(x).t_id;
                                    result +=
                                            //task details are:
                                            '{ "id":"'+ theTaskId +
                                            '", "title":"'+ rs.rows.item(x).t_title +
                                            '", "description":"'+ rs.rows.item(x).t_description +
                                            '", "timeToPerform":"'+ rs.rows.item(x).t_timeToPerform +
                                            '", "deadline":"'+ rs.rows.item(x).t_deadline +
                                            '", "creationDate":"'+ rs.rows.item(x).t_creationDate +
                                            '", "priority":"'+ rs.rows.item(x).t_priority;


                                    /*task steps:
                                    var res_taskSteps = tx.executeSql('SELECT * FROM '+DBC.table_taskSteps+' WHERE t_id = '+ theTaskId);
                                    var table_taskSteps_Columns = res_taskSteps.rows.length;
                                    if (rs.rows.length > 0)
                                    {
                                        for(var y=0; y<table_taskSteps_Columns; y++)
                                        {
                                            stepCounter++;
                                            result+='", "child'+stepCounter+'":" ['+res_taskSteps.rows.item(y).ts_id +
                                                    ','+res_taskSteps.rows.item(y).ts_title+
                                                    ','+res_taskSteps.rows.item(y).ts_description+
                                                    ','+res_taskSteps.rows.item(y).ts_completeDate+
                                                    '"]';
                                            if(y<table_taskSteps_Columns-1)
                                                result += ",";
                                        }
                                    }
                                    //end of task steps.*/
                                    result += '}';


                                    if(x<tableColumns-1)
                                        result += ",";
                                }
                                result += "]}";
                                console.log("\nsource : allTasks.js/getList(json) -> json result values are =" + result+"\n");
                                return result;
                            }


//                            else
//                            {
//                                //append into the list.
//                                for(var y=0; y<tableColumns; y++)
//                                {
//                                    targetList.append({
//                                                          tId: rs.rows.item(y).t_id,
//                                                          tTitle : rs.rows.item(y).t_title > 15 ? rs.rows.item(y).t_title.slice(0,12) + ".." :  rs.rows.item(y).t_title,
//                                                          tDesc: rs.rows.item(y).t_description,
//                                                          tTimerToPerForm: rs.rows.item(y).t_timeToPerform,
//                                                          tDeadline: rs.rows.item(y).t_deadline,
//                                                          tCreation: rs.rows.item(y).t_creationDate,
//                                                          tPriority: rs.rows.item(y).t_priority,
//                                                      });
//                                }
//                                console.log("\nsource : allTasks.js/getList(json) -> json result values are =" + result+"\n");
//                                return 0;
//                            }

                        }

                        else
                        {
                            console.log("source : allTasks.js/getList(json) -> row data is less than 0.");
                            return result;
                        }

                    }
                    );

    }
    catch(error)
    {
        console.log("source : allTasks.js/getList() -> error= "+error);
        return "source : allTasks.js/getList() -> error= "+error;
    }


}



