//code from https://github.com/fecub/HelloQtLocalStorage
.import QtQuick.LocalStorage 2.0 as Storage

function getDatabase()
{
     return Storage.LocalStorage.openDatabaseSync("tutuList_DataBase", "0.1", "tutuList database is localdatabse to save application data, later can sync these data into API for backup/sync with other devices", 100);
}


const table_allTasks = "tutu_allTasks";
const table_completedTasks = "tutu_completedTasks";
const table_todayTasks = "tutu_todayTasks";
const table_taskSteps = "tutu_taskSteps";
const table_settings = "tutu_settings";

function testDatabaseConnection() //return 0 means connection failed , return 1 means connection is ok
{
    var finalResult = 0;
    try
    {
        var db = getDatabase();
        db.transaction
        (
            function(tx)
            {
                const result_AllTasks = tx.executeSql('CREATE TABLE IF NOT EXISTS testconnection (t_id INTEGER PRIMARY KEY AUTOINCREMENT,t_title  TEXT);');
                var rs = tx.executeSql('INSERT OR REPLACE INTO testconnection (t_title) VALUES (?);', "okimdone");
                if (rs.rowsAffected > 0)
                {
                    console.log("source : databaseHeader/testDatabaseConnection() -> connection with database is OK");
                    var res_search = tx.executeSql('SELECT * FROM testconnection;');
                    var tableColumns = res_search.rows.length;
                    if (res_search.rows.length > 0)
                    {
//                        for(var x=0; x<tableColumns; x++)
//                            console.log('t_title='+ res_search.rows.item(x).t_title);
                        console.log("source : databaseHeader/testDatabaseConnection() -> connection db, access db, are OK");
                        finalResult=1;
                    }
                    else
                    {
                        console.log("source : databaseHeader/testDatabaseConnection() -> connection with databse is ok, insert was OK but search query failed.");
                        finalResult=0;
                    }
                }

                else
                {
                    console.log("source : databaseHeader/testDatabaseConnection() ->  connection with databse is failed");
                    finalResult=0;
                }

            }

        );
        return finalResult;
    }
    catch(error)
    {
        return 0 + " , error=" + error;
    }
}

function initDatabaseTables()
{
    var db = getDatabase();
    db.transaction
    (
        function(tx)
        {
            const result_AllTasks = tx.executeSql('CREATE TABLE IF NOT EXISTS '+table_allTasks+' (t_id INTEGER PRIMARY KEY AUTOINCREMENT,t_title  TEXT, t_description TEXT, t_priority INT, t_timeToPerform TEXT, t_deadline TEXT, t_creationDate DATETIME DEFAULT CURRENT_TIMESTAMP)');
            if (result_AllTasks.rowsAffected > 0)
                console.log("source : databaseHeader/initDatabaseTable() -> table tutu_allTasks created succesfully.");
            else
                console.log("source : databaseHeader/initDatabaseTable() -> table tutu_allTasks failed to create.");




            const result_completedTasks = tx.executeSql('CREATE TABLE IF NOT EXISTS '+table_completedTasks+' (ct_id INTEGER PRIMARY KEY AUTOINCREMENT,t_id INT, ct_completeDate TEXT, FOREIGN KEY(t_id) REFERENCES '+table_allTasks+'(t_id) ON DELETE CASCADE );');
            if (result_completedTasks.rowsAffected > 0)
                console.log("source : databaseHeader/initDatabaseTable() -> table tutu_completedTasks created succesfully.");
            else
                console.log("source : databaseHeader/initDatabaseTable() -> table tutu_completedTasks failed to create.");




            const result_todayTasks = tx.executeSql('CREATE TABLE IF NOT EXISTS '+table_todayTasks+' (tt_id INTEGER PRIMARY KEY AUTOINCREMENT,t_id INT, FOREIGN KEY(t_id) REFERENCES '+table_allTasks+'(t_id) ON DELETE CASCADE );');
            if (result_todayTasks.rowsAffected > 0)
                console.log("source : databaseHeader/initDatabaseTable() -> table tutu_todayTasks created succesfully.");
            else
                console.log("source : databaseHeader/initDatabaseTable() -> table tutu_todayTasks failed to create.");




            const result_taskSteps = tx.executeSql('CREATE TABLE IF NOT EXISTS '+table_taskSteps+' (ts_id INTEGER PRIMARY KEY AUTOINCREMENT,t_id INT, ts_title TEXT, ts_description TEXT, ts_completeDate TEXT, FOREIGN KEY(t_id) REFERENCES '+table_allTasks+'(t_id) ON DELETE CASCADE );');
            if (result_todayTasks.rowsAffected > 0)
                console.log("source : databaseHeader/initDatabaseTable() -> table tutu_taskSteps created succesfully.");
            else
                console.log("source : databaseHeader/initDatabaseTable() -> table tutu_taskSteps failed to create.");



//            const result_settings = tx.executeSql('CREATE TABLE IF NOT EXISTS '+table_settings+' ();');
//            if (result_settings.rowsAffected > 0)
//                console.log("source : databaseHeader/initDatabaseTable() -> table tutu_settings created succesfully.");
//            else
//                console.log("source : databaseHeader/initDatabaseTable() -> table tutu_settings failed to create.");


        }
     );
    return 0;
}
