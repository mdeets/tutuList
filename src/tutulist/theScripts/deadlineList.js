.import "databaseHeader.js" as DBC

function getList(targetList,returnType="json",isSearching="searchOn",isSearchLikeOn="likeOn",searchingText="") //return ETC means OK, return 1 is error
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
                        //fetch complete tasks id to avoid lising completeTasks inside of allTasks.
                        //fetch today tasks id to avoid lising today tasks inside of allTasks.
                        //then fetch all tasks details.
                        var rs;//query
//                        var rs = tx.executeSql('SELECT * FROM '+DBC.table_allTasks+' INNER JOIN '+DBC.table_taskSteps+' ON '+DBC.table_allTasks+'.t_id='+DBC.table_taskSteps+'.t_id WHERE '+DBC.table_allTasks+'.t_id NOT IN (SELECT t_id FROM '+DBC.table_completedTasks+') AND '+DBC.table_allTasks+'.t_id NOT IN (SELECT t_id FROM '+DBC.table_todayTasks+') ORDER BY t_creationDate DESC;');

                        //is it get list for search or normal?
//                        if(isSearching==="searchOn")
//                        {
//                            if(isSearchLikeOn==="likeOn")
//                            {//searchingText
//                                rs = tx.executeSql("SELECT * FROM "+DBC.table_allTasks+" WHERE t_title LIKE '%"+searchingText+"%' AND t_id NOT IN (SELECT t_id FROM "+DBC.table_completedTasks+") AND t_id NOT IN (SELECT t_id FROM "+DBC.table_todayTasks+") ORDER BY t_priority ASC;");
//                            }
//                            else
//                            {
//                                rs = tx.executeSql('SELECT * FROM '+DBC.table_allTasks+' WHERE t_title LIKE '+searchingText+' AND t_id NOT IN (SELECT t_id FROM '+DBC.table_completedTasks+') AND t_id NOT IN (SELECT t_id FROM '+DBC.table_todayTasks+') ORDER BY t_priority ASC;');
//                            }
//                        }
//                        else
//                        {
                             rs = tx.executeSql('SELECT * FROM '+DBC.table_allTasks+' WHERE t_id NOT IN (SELECT t_id FROM '+DBC.table_completedTasks+') AND t_deadline >= (SELECT CURRENT_TIMESTAMP) ORDER BY t_deadline ASC'); // ORDER BY  AND t_priority ASC //AND t_id NOT IN (SELECT t_id FROM '+DBC.table_todayTasks+')
                            //up code means 111 (JAPAN) ->  https://learn.microsoft.com/en-us/sql/t-sql/functions/cast-and-convert-transact-sql?redirectedfrom=MSDN&view=sql-server-ver16
//                        }


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
                                    var res_taskSteps = tx.executeSql('SELECT * FROM '+DBC.table_taskSteps+' WHERE t_id = '+ theTaskId + ' ORDER BY ts_id ASC');
                                    var table_taskSteps_Columns = res_taskSteps.rows.length;
                                    if (table_taskSteps_Columns > 0)
                                    {
                                        result+= ', "childCount":"' + table_taskSteps_Columns + '"';
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
                                    else
                                    {
                                        //no child (step Task).
                                        result+= ', "childCount":"0"';
                                    }

                                    //end of task steps.
                                    result += '}';


                                    if(x<tableColumns-1)
                                        result += ",";
                                }
                                result += "]}";
                                console.log("\nsource : deadlineList.js/getList(json) -> json result values are =" + result+"\n");
                            }


                            else
                            {
                                var LargDate = "0000/00/00"; //to sort as date.
                                for(var k=0; k<tableColumns; k++)
                                {
                                    const dline = rs.rows.item(k).t_deadline;

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


//                                    console.log("source: deadlineList.js -> print data -> id=",rs.rows.item(k).t_id, " title=", rs.rows.item(k).t_title, " desc=",
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
                                        console.log('source : deadlineList.js/getList(list append) -> no step found.');
                                    }


                                }
//                                //end of task steps.

                                console.log("source : deadlineList.js/getList(list append) -> appended.");
                                return 0;
                            }

                        }

                        else
                        {
                            console.log("source : deadlineList.js/getList(json) -> row data is less than 0.");
                        }

                    }
                    );
        return result;

    }
    catch(error)
    {
        console.log("source : deadlineList.js/getList() -> error= "+error);
        return "source : deadlineList.js/getList() -> error= "+error;
    }
}




