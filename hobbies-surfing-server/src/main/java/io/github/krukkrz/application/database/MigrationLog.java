package io.github.krukkrz.application.database;

import com.github.mongobee.Mongobee;
import com.github.mongobee.changeset.ChangeLog;
import com.github.mongobee.changeset.ChangeSet;
import com.github.mongobee.exception.MongobeeException;
import com.mongodb.DB;

@ChangeLog
public class MigrationLog {
    //todo come back to that later
    public static void runMigrations() throws MongobeeException {
        Mongobee runner = new Mongobee("mongodb://[mongouser:mongopass@]localhost:27017/surfing_spots");
        runner.setDbName("surfing_spots");
        runner.setChangeLogsScanPackage("io.github.krukkrz.application.database");
        runner.execute();
    }

    @ChangeSet(order = "001", id = "initial migration", author = "krukkrz")
    public void initialMigration(DB db){
        // task implementation
    }
}
