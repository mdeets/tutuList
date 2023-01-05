.import "databaseHeader.js" as DBC

function uncompleteTask(taskId)
{
    try
    {
        var db = DBC.getDatabase();
        var result="0";
        db.transaction
                (
                    function(tx)
                    {
                        var rs = tx.executeSql('DELETE FROM '+DBC.table_completedTasks+' WHERE t_id=?;',[taskId]);
                        if (rs.rowsAffected > 0)
                        {
                            console.log("source : completedTasks.js/uncompleteTask() -> query successfully exectured.");
                            result = 1;
                        }
                        else
                        {
                            console.log("source : completedTasks.js/uncompleteTask()  -> query failed.");
                            result= 0;
                        }

                    }
                );
        return result;
    }
    catch(error)
    {
        console.log("source : completedTasks.js/uncompleteTask()  -> error= "+error);
        return "source : completedTasks.js/uncompleteTask()  -> error= "+error;
    }
}

function completeTask(taskId)//return 1 means query DONE, return etc means failure
{
    try
    {
        var db = DBC.getDatabase();
        var result=0;
        db.transaction
                (
                    function(tx)
                    {
                        var rs = tx.executeSql('INSERT INTO '+DBC.table_completedTasks+
                                               ' (t_id) VALUES (?);',
                                               [taskId]);

                        if (rs.rowsAffected > 0)
                        {
                            console.log("source : completedTasks.js/completeTask() -> query successfully exectured.");
                            result = 1;
                        }
                        else
                        {
                            console.log("source : completedTasks.js/completeTask()  -> query failed.");
                            result= 0;
                        }

                    }
                );
        return result;
    }
    catch(error)
    {
        console.log("source : completedTasks.js/completeTask()  -> error= "+error);
        return "source : completedTasks.js/completeTask()  -> error= "+error;
    }
}





function getList(targetList,returnType="json") //return ETC means OK, return 1 is error
{
    /*
      function copied from allTasks.js
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
                                              for EXAMPLE:

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
                                                    {
                                                      "id": "44",
                                                      "title": "something2",
                                                      "description": "33 3 3 helloworld3",
                                                      , ETC... ,
                                                      "child1":
                                                      [
                                                        "id",
                                                        14,
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
                                                        1222,
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
                        //fetch todayTask ids
                        //then fetch task detials via that id
                        var rs = tx.executeSql('SELECT * FROM '+DBC.table_allTasks+' WHERE t_id IN (SELECT t_id FROM '+DBC.table_completedTasks+') ORDER BY t_creationDate DESC;');
                        var tableColumns = rs.rows.length;

                        if (rs.rows.length > 0)
                        {
                            if(returnType==="json")
                            {
                                result= '{ "tasks" : [';
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
                                            '", "priority":"'+ rs.rows.item(x).t_priority+'"';


                                    //task steps:
                                    var res_taskSteps = tx.executeSql('SELECT * FROM '+DBC.table_taskSteps+' WHERE t_id = '+ theTaskId);
                                    var table_taskSteps_Columns = res_taskSteps.rows.length;
                                    if (table_taskSteps_Columns > 0)
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
                                    //end of task steps.
                                    result += '}';


                                    if(x<tableColumns-1)
                                        result += ",";
                                }
                                result += "]}";
//                                console.log("\nsource : completedTasks.js/getList(json) -> json result values are =" + result+"\n");
                            }


                            else
                            {
                                for(var k=0; k<tableColumns; k++)
                                {

                                    const theTaskId = rs.rows.item(k).t_id;
                                    const resultForAppendToList =
                                    {
                                        tId: theTaskId,
                                        tsId:0, //means this is not task Step, to known wich is task or Wich one is TaskStep for ui.
                                        tTitle : rs.rows.item(k).t_title > 15 ? rs.rows.item(k).t_title.slice(0,12) + ".." :  rs.rows.item(k).t_title,
                                        tDesc: rs.rows.item(k).t_description,
                                        tTimerToPerForm: rs.rows.item(k).t_timeToPerform,
                                        tDeadline: rs.rows.item(k).t_deadline,
                                        tCreation: rs.rows.item(k).t_creationDate,
                                        tPriority: Number(rs.rows.item(k).t_priority),
                                    };
                                    targetList.append(resultForAppendToList);


//                                    console.log("source: allTasks.js -> print data -> id=",rs.rows.item(k).t_id, " title=", rs.rows.item(k).t_title, " desc=",
//                                                rs.rows.item(k).t_description, " deadline=",rs.rows.item(k).t_deadline,
//                                                " creation=",rs.rows.item(k).t_creationDate," priority=",rs.rows.item(k).t_priority,
//                                                " ttp=",rs.rows.item(k).t_timeToPerform);


                                    var rsStep = tx.executeSql('SELECT * FROM '+DBC.table_taskSteps+' WHERE t_id = '+ theTaskId + ' ORDER BY ts_id ASC');
                                    var tblStep = rsStep.rows.length;
                                    if (tblStep > 0)
                                    {
                                        for(var u=0; u<tblStep; u++)
                                        {
                                            const stepTaskList =
                                            {
                                                tId: theTaskId,
                                                tsId: rsStep.rows.item(u).ts_id,
                                                tsTitle: rsStep.rows.item(u).ts_title,
                                                tsDesc: rsStep.rows.item(u).ts_description,
                                                tsCompeteDate:  rsStep.rows.item(u).ts_completeDate,
                                            };
                                            targetList.append(stepTaskList);
                                        }
                                    }
                                    else
                                    {
                                        //no child (step Task).
                                        console.log('source : completedTasks.js/getList(list append) -> no step found.');
                                    }


                                }
//                                //end of task steps.

                                console.log("source : completedTasks.js/getList(list append) -> appended.");
                                return 0;
                            }

                        }

                        else
                        {
                            console.log("source : completedTasks.js/getList(json) -> row data is less than 0.");
                        }

                    }
                    );
        return result;

    }
    catch(error)
    {
        console.log("source : completedTasks.js/getList() -> error= "+error);
        return "source : completedTasks.js/getList() -> error= "+error;
    }


}






//function getList(targetList,returnType="json") //return ETC means OK, return 1 is error
//{
//    /*
//      copied from AllTasks.js/getlist() but modified.
//        This function will fetch completedTasks then fetch those tasks info then fetch tasksteps then return as json OR append data into the list.

//        Argumants:
//            targetList = that list we want to append data into
//                    (optional).

//            returnType = is a flag to know with wich format return, json or append to targetList
//                    values = ['json',''] json or etc -> appendToList
//                    (default: return as json)


//        Output:
//                Json:
//                            tasks =>
//                                    id,title,description,
//                                    timeToPerform,deadline,creationDate,
//                                    priority,childCount(*NOTE-1*),childX(*NOTE-2*)

//                            (*NOTE-1*) childCount -> when json paresed you need to get this and make a loop untill this value to know how much child has.


//                            (*NOTE-2*) childX -> X means a number, for exmaple our task has 10 step, so we read from childCount then looking for child1[i] to child10[i].
//                                    to access childX values needs to do childX[y] y from 0 to 5
//                                              for EXAMPLE:

//                                              {
//                                                "tasks":
//                                                [
//                                                    {
//                                                      "id": "33",
//                                                      "title": "something",
//                                                      "description": "helloworld",
//                                                      , ETC... ,
//                                                      "childss1":
//                                                      [
//                                                        "id",
//                                                        10,
//                                                        "title",
//                                                        12,
//                                                        ...
//                                                      ]
//                                                      "child2":
//                                                      [
//                                                        "id",
//                                                        11,
//                                                        ....
//                                                      ]
//                                                    }
//                                                    {
//                                                      "id": "44",
//                                                      "title": "something2",
//                                                      "description": "33 3 3 helloworld3",
//                                                      , ETC... ,
//                                                      "child1":
//                                                      [
//                                                        "id",
//                                                        14,
//                                                     ...
//    */


//    try
//    {
//        var db = DBC.getDatabase();
//        var result = 1;

//        db.transaction
//                (
//                    function(tx)
//                    {
//                        //fetch tasks from table completedTasks
//                        var rs_completedTasks = tx.executeSql('SELECT * FROM '+DBC.table_completedTasks+' ORDER BY ct_completeDate ASC;');
//                        const tableColumns_completedTasks = rs_completedTasks.rows.length;
//                        if (tableColumns_completedTasks > 0)
//                        {
//                            if(returnType==="json")
//                            {
//                                for(var y=0; y<tableColumns_completedTasks; y++)
//                                {
//                                    const theTaskId = rs_completedTasks.rows.item(y).t_id;
//                                    const theTaskCompleteDate = rs_completedTasks.rows.item(y).ct_completeDate;


//                                    //fetch task detials from table allTasks via id.
//                                    var rs = tx.executeSql('SELECT * FROM '+DBC.table_allTasks+' WHERE t_id = '+theTaskId+' ORDER BY t_creationDate ASC;');
//                                    const tableColumns = rs.rows.length;

//                                    if (tableColumns > 0)
//                                    {
//                                        if(returnType==="json")
//                                        {
//                                            result= '{ "tasks" : [';
//                                            //pepear the json with tasks data:
//                                            for(var x=0; x<tableColumns; x++)
//                                            {
//                                                var stepCounter=0;
//                                                const theTaskId = rs.rows.item(x).t_id;
//                                                result +=
//                                                        //task details are:
//                                                        '{ "id":"'+ theTaskId +
//                                                        '", "title":"'+ rs.rows.item(x).t_title +
//                                                        '", "description":"'+ rs.rows.item(x).t_description +
//                                                        '", "timeToPerform":"'+ rs.rows.item(x).t_timeToPerform +
//                                                        '", "deadline":"'+ rs.rows.item(x).t_deadline +
//                                                        '", "creationDate":"'+ rs.rows.item(x).t_creationDate +
//                                                        '", "completedDate":"'+ theTaskCompleteDate +
//                                                        '", "priority":"'+ rs.rows.item(x).t_priority+'"';


//                                                //task steps:
//                                                var res_taskSteps = tx.executeSql('SELECT * FROM '+DBC.table_taskSteps+' WHERE t_id = '+ theTaskId);
//                                                const table_taskSteps_Columns = res_taskSteps.rows.length;
//                                                if (table_taskSteps_Columns > 0)
//                                                {
//                                                    for(var z=0; z<table_taskSteps_Columns; z++)
//                                                    {
//                                                        stepCounter++;
//                                                        result+='", "child'+stepCounter+'":" ['+res_taskSteps.rows.item(z).ts_id +
//                                                                ','+res_taskSteps.rows.item(z).ts_title+
//                                                                ','+res_taskSteps.rows.item(z).ts_description+
//                                                                ','+res_taskSteps.rows.item(z).ts_completeDate+
//                                                                '"]';
//                                                        if(y<table_taskSteps_Columns-1)
//                                                            result += ",";
//                                                    }
//                                                }
//                                                //end of task steps.
//                                                result += '}';


//                                                if(x<tableColumns-1)
//                                                    result += ",";
//                                            }
//                                            result += "]}";
//            //                                console.log("\nsource : completedTask.js/getList(json) -> json result values are =" + result+"\n");
//                                        }


//            //                            else
//            //                            {
//            //                                //append into the list.
//            //                                for(var y=0; y<tableColumns; y++)
//            //                                {
//            //                                    targetList.append({
//            //                                                          tId: rs.rows.item(y).t_id,
//            //                                                          tTitle : rs.rows.item(y).t_title > 15 ? rs.rows.item(y).t_title.slice(0,12) + ".." :  rs.rows.item(y).t_title,
//            //                                                          tDesc: rs.rows.item(y).t_description,
//            //                                                          tTimerToPerForm: rs.rows.item(y).t_timeToPerform,
//            //                                                          tDeadline: rs.rows.item(y).t_deadline,
//            //                                                          tCreation: rs.rows.item(y).t_creationDate,
//            //                                                          tPriority: rs.rows.item(y).t_priority,
//            //                                                      });
//            //                                }
//            //                                console.log("\nsource : completedTask.js/getList(json) -> json result values are =" + result+"\n");
//            //                                return 0;
//            //                            }

//                                    }

//                                    else
//                                    {
//                                        console.log("source : completedTask.js/getList(json) -> row data is less than 0.");
//                                    }

//                                    //fetch taskSteps from table taskSteps if id has step.
//                                }
//                            }
//                        }



//                    }
//                    );
//        return result;

//    }
//    catch(error)
//    {
//        console.log("source : completedTask.js/getList() -> error= "+error);
//        return "source : completedTask.js/getList() -> error= "+error;
//    }


//}



