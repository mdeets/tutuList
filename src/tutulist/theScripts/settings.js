.import "databaseHeader.js" as DBC

function set(setting, value)//retrun 1 means inserted/updated fine. else error
{
    try
    {
        var db = DBC.getDatabase();
        var res = "";
        db.transaction
        (
            function(tx)
            {
                var rs = tx.executeSql('INSERT OR REPLACE INTO '+DBC.table_settings+' VALUES (?,?);', [setting,value]);
                if (rs.rowsAffected > 0)
                {
                    console.log("source : settings.js/set() -> query successfully exectured.");
                    res = 1;
                }

                else
                {
                    console.log("source : settings.js/set() -> query failed.");
                    res = 0;
                }
           }
        );
       return res;
    }
    catch(error)
    {
        console.log("source : settings.js/set() -> error= "+error);
        return "source : settings.js/set() -> error= "+error;
    }
}

function get(setting)//return `error means error. else is the value of setting
{
   var db = DBC.getDatabase();
   var res="";
   try
   {
     db.transaction
     (
       function(tx)
       {
         var rs = tx.executeSql('SELECT value FROM '+DBC.table_settings+' WHERE setting=?;', [setting]);
         if (rs.rows.length > 0)
         {
              res = rs.rows.item(0).value;
         }

         else
         {
             res = "`error‍";
         }
       }
     )
   }

   catch (error)
   {
       console.log("source : settings.js/get() -> error= "+error);
       return "`error";
   };
}
