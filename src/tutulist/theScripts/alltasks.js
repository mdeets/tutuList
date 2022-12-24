.import "databaseHeader.js" as DBC

function addNewTask(title,desc,priority,deadline,timeToPerform) //return 1 means Query is OK, etc is failure
{
    try
    {

    }
    catch(error)
    {
        console.log("source : getListData/addNewTask() -> error= "+error);
        return "source : getListData/addNewTask() -> error= "+error;
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
        var result = "";

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
                                console.log("\nsource : alltasks/getList(json) -> json result values are =" + result+"\n");
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
//                                console.log("\nsource : alltasks/getList(json) -> json result values are =" + result+"\n");
//                                return 0;
//                            }

                        }

                        else
                        {
                            console.log("source : alltasks/getList(json) -> row data is less than 0.");
                        }

                    }
                    );

    }
    catch(error)
    {
        console.log("source : getListData/getList() -> error= "+error);
        return "source : getListData/getList() -> error= "+error;
    }


}



