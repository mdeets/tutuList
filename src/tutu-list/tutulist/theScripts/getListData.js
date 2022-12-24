.import "./databaseHeader.js" as DBheader

const tableName = "";


function getList(flagAllTasks,targetList,returnTypeFlag)
{
    /*
        This function will fetch and return as json/append data into the list.

        Argumants:
            flagAllTasks = to know is it perpering data for allTasks or not
                    reason: (bc of algorithm, if wants data for allTasks section it will execute sql code twice for table allTasks).

            targetList = that list we want to append data into
                    (optional).

            returnTypeFlag = is a flag to know with wich format return, json or append to targetList
                    (default: append into targetList)
    */


    var db = DBC.getDatabase();
    var res = "";

    db.transaction
    (
        function(tx)
        {

        }
     );
    return 0;
}


//tx.executeSql('CREATE TABLE IF NOT EXISTS '+tableName+' (eg_id INTEGER PRIMARY KEY AUTOINCREMENT,eg_name  TEXT, eg_prioirty INT, eg_tags TEXT)');
//var rs = tx.executeSql('INSERT OR REPLACE INTO '+tableName+' (eg_name,eg_prioirty,eg_tags) VALUES (?,?,?);',
//                                                                              [groupName,
//                                                                              groupPriority,
//                                                                              groupTags]);

//if (rs.rowsAffected > 0)
//{
//  res = "OK";
//}

//else
//{
//  res = "Error (saveLoadEventGroups.set)";
//}

function set(groupName,groupPriority,groupTags)
{

                  //eg= eventGroup
                  tx.executeSql('CREATE TABLE IF NOT EXISTS '+tableName+' (eg_id INTEGER PRIMARY KEY AUTOINCREMENT,eg_name  TEXT, eg_prioirty INT, eg_tags TEXT)');
                  var rs = tx.executeSql('INSERT OR REPLACE INTO '+tableName+' (eg_name,eg_prioirty,eg_tags) VALUES (?,?,?);',
                                                                                                [groupName,
                                                                                                groupPriority,
                                                                                                groupTags]);

                  if (rs.rowsAffected > 0)
                  {
                    res = "OK";
                  }

                  else
                  {
                    res = "Error (saveLoadEventGroups.set)";
                  }

  return res;
}

function get()
{
//    console.log("GET STARTED........................")
   var db = DBC.getDatabase();
   var res="";
    let result2 = '{ "eventGroups" : [';


   try
   {
     db.transaction
     (
       function(tx)
       {

         var rs = tx.executeSql('SELECT * FROM '+tableName+' ORDER BY eg_prioirty ASC;');
         var tableColumns = rs.rows.length;
         if (rs.rows.length > 0)
         {
                 for(var x=0; x<tableColumns; x++)
                 {
                     result2 +=
                             '{ "id":"'+ rs.rows.item(x).eg_id +
                             '", "name":"'+ rs.rows.item(x).eg_name +
                             '", "priority":"'+ rs.rows.item(x).eg_prioirty +
                             '", "tags":"'+ rs.rows.item(x).eg_tags + '" }';
//                     console.log("res=" + result2);
                     if(x<tableColumns-1)
                     {
                         result2 += ",";
                     }


                 }
             result2 += "]}";


//                 console.log("values stringfiy from saveloadeventgroup");
//                 console.log(JSON.stringify(result2));

         }

         else
         {
             res = "";
         }


       }
     )
   }

   catch (err)
   {
       console.log("Database (saveLoadEventGroups.get): " + err);
   };
   return result2;
}


function removeElement(targetId)
{
   var db = DBC.getDatabase();
   var res = "";

   db.transaction
   (
       function(tx)
       {
                  var rs = tx.executeSql('DELETE FROM '+tableName+' WHERE eg_id=?;',[targetId]);

                  if (rs.rowsAffected > 0)
                  {
                    res = "OK";
                  }

                  else
                  {
                    res = "Error (saveLoadEventGroups.removeElement)";
                  }
      }
   );
  return res;
}


function updateElement(targetId,newname,newtag,newpriority)
{
   var db = DBC.getDatabase();
   var res = "";
    newpriority = parseInt(newpriority,10);

   db.transaction
   (
       function(tx)
       {
                  var rs = tx.executeSql('UPDATE '+tableName+' SET eg_name = ? , eg_tags = ?, eg_prioirty = ? WHERE eg_id=?;',[newname,newtag,newpriority,targetId]);

                  if (rs.rowsAffected > 0)
                  {
                    res = "OK";
                  }

                  else
                  {
                    res = "Error (saveLoadEventGroups.updateElement)";
                  }
      }
   );
  return res;
}



/*
  DATABASE STRUCTURE:


  Event group:

        title (primery, uniq)  [short text , limited i.g 32char]
        tag [short text , limited i.g 32char]
        priority [int] [def 50] //lower number = highest pririoty


  Events:
        id [int] autoincrease
        title [short text , limited]
        tag (icon/color) [short text , limited]
        priority [int] //lower number = highest pririoty
        description [long text , limited]
        enable/active [int] default ture/1
        start + clock [time/date] default timestamp
        end + clock [time/date] defualt +1hour after start
        location [short text, limited]
        creation [timestamp]









        repeat type:  [int]
        repeat value: [text] for day,month,year is a number, for week and hmsr (hour,minute,seconds,rounds) is serial numbers



   List of event repeats
        id (auto_increase)
        eventId (with eventRouind not repeated, primery , refrecned from Events)
        eventRound (with eventID not repeated , primery , refrenced from Events) default 0 or 1
        date (date and time)
        status [int] (incomplete, completed, disabled)
        last modify [timestamp]




   Event Remind
        id
        eventId
        reminder type (int) [in app notification, in app alarm sound]
        date (date and time)
        status (int) (soon, dismissed, missed)
  */
