import java.sql.* ;
import java.util.Scanner;
import java.text.SimpleDateFormat;
import java.util.Calendar;


class GoBabbyApp
{
    public static void main ( String [ ] args ) throws SQLException {
        // Unique table names.  Either the user supplies a unique identifier as a command line argument, or the program makes one up.
        String tableName = "";
        int sqlCode = 0;      // Variable to hold SQLCODE
        String sqlState = "00000";  // Variable to hold SQLSTATE

        if (args.length > 0)
            tableName += args[0];
        else
            tableName += "exampletbl";

        // Register the driver.  You must register the driver before you can use it.
        try {
            DriverManager.registerDriver(new com.ibm.db2.jcc.DB2Driver());
        } catch (Exception cnfe) {
            System.out.println("Class not found");
        }

        // This is the url you must use for DB2.
        //Note: This url may not valid now ! Check for the correct year and semester and server name.
        String url = "jdbc:db2://winter2022-comp421.cs.mcgill.ca:50000/cs421";

        //REMEMBER to remove your user id and password before submitting your code!!
        String your_userid = "kyao8";
        String your_password = "gKF8by2N";
        //AS AN ALTERNATIVE, you can just set your password in the shell environment in the Unix (as shown below) and read it from there.
        //$  export SOCSPASSWD=yoursocspasswd
        if (your_userid == null && (your_userid = System.getenv("SOCSUSER")) == null) {
            System.err.println("Error!! do not have a password to connect to the database!");
            System.exit(1);
        }
        if (your_password == null && (your_password = System.getenv("SOCSPASSWD")) == null) {
            System.err.println("Error!! do not have a password to connect to the database!");
            System.exit(1);
        }
        Connection con = DriverManager.getConnection(url, your_userid, your_password);
        Statement stmt = con.createStatement();


        // menu starts

        a:
        while (true) {
            int pid = checkPID(stmt);
            switch (pid) {
                case 0:
                    System.out.println("Invalid practitioner id, please enter again");
                    continue;
                case -1:
                    exitMenu(stmt, con);
                    //break a;
                default: // found id
                    b:
                    while (true) {
                        int apt = checkDate(stmt, pid);
                        switch (apt) {
                            case 0:
                                continue b; //select date again
                            case -1:
                                exitMenu(stmt, con);
                            default:
                                break a;
                        }
                    }

            }
        }
        exitMenu(stmt, con);



    }

    public static void exitMenu(Statement stmt, Connection con) throws SQLException {
        stmt.close();
        con.close();
        System.out.println("Exit the menu");
        System.exit(0);
    }


    public static int checkPID(Statement stmt) throws SQLException {
        Scanner pid_sc = new Scanner(System.in);  // Create a Scanner object
        System.out.println("Please enter your practitioner id [E] to exit: ");

        if (pid_sc.hasNext("E")) {
            return -1;
        } else {
            int target_pid = pid_sc.nextInt();
            ResultSet rs = stmt.executeQuery("SELECT * FROM Midwives");

            while (rs.next()) {
                int pid = rs.getInt("pid");
                if (pid == target_pid) {
                    System.out.println("found id " + pid);
                    return pid;
                }
            }
            return 0;
        }

    }

    public static int checkDate(Statement stmt, int pid) throws SQLException {
        Scanner date_sc = new Scanner(System.in);  // Create a Scanner object
        System.out.println("Please enter the date for appointment list [E] to exit: ");

        if (date_sc.hasNext("E")) {
            return -1;
        } else {
            Date target_date = Date.valueOf(date_sc.next());
            ResultSet rs = stmt.executeQuery("SELECT * FROM Appointments WHERE pid = " + pid);
            while (rs.next()) {
                Date date = rs.getDate("date");
                if (date.compareTo(target_date) == 0) {
                    return displayApt(stmt, pid, date);
                }
            }
            System.out.println("No appointments found this date, please try another date");
            return 0;

        }
    }

    public static int displayApt(Statement stmt, int pid, Date date) throws SQLException{
        ResultSet rs1 = stmt.executeQuery(
                "             SELECT DISTINCT aptid, time, name, healthid, 'P' PorB\n" +
                        "             FROM Parents, Couples, Pregnancy, Appointments\n" +
                        "             WHERE Parents.healthid = Couples.mid\n" +
                        "               AND Couples.cid = Pregnancy.cid\n" +
                        "               AND Appointments.cid = Pregnancy.cid\n" +
                        "               AND Appointments.pid = " + pid +
                        "               AND Appointments.numofpreg = Pregnancy.numofpreg" +
                        "               AND Pregnancy.pid = " + pid + "\n" +
                        "               AND date = '" + date + "'" +
                        "                UNION" +
                        "             SELECT DISTINCT aptid, time, name, healthid, 'B' PorB\n" +
                        "             FROM Parents, Couples, Pregnancy, Appointments\n" +
                        "             WHERE Parents.healthid = Couples.mid\n" +
                        "               AND Couples.cid = Pregnancy.cid\n" +
                        "               AND Appointments.cid = Pregnancy.cid\n" +
                        "               AND Appointments.pid = " + pid +
                        "               AND Appointments.numofpreg = Pregnancy.numofpreg" +
                        "               AND Pregnancy.backuppid = " + pid + "\n" +
                        "               AND date = '" + date + "'ORDER BY time;"
        );
        System.out.println("Your appointments in date "+ date + ":\n");
        while (rs1.next()) {
            System.out.println(rs1.getInt("aptid") + " " + rs1.getTime("time") + " " + rs1.getString("name") + " " + rs1.getInt("healthid")
                    + " " + rs1.getString("PorB") );
        }
        // select number
        System.out.println("\r");
        System.out.println("Enter the appointment number that you would like to work on.\n" +
                "[E] to exit [D] to go back to another date :");

        Scanner aptselect_sc = new Scanner(System.in);

        if (aptselect_sc.hasNext("E")) {
            return -1;
        } else if (aptselect_sc.hasNext("D")) {
            return 0;
        }else {
            int apt = aptselect_sc.nextInt();
            return selectApt(stmt, apt, pid, date);
        }
    }

    public static int selectApt(Statement stmt, int aptid, int pid, Date date) throws SQLException{
        ResultSet rsprime = stmt.executeQuery("SELECT aptid, name, healthid FROM Parents, Couples, Pregnancy, Appointments\n" +
                "WHERE Parents.healthid = Couples.mid\n" +
                "AND Couples.cid = Pregnancy.cid\n" +
                "AND Pregnancy.cid = Appointments.cid\n" +
                "And Pregnancy.numofpreg = Appointments.numofpreg\n" +
                "AND aptid = " + aptid + ";");
        rsprime.next();
        if (rsprime.getInt("aptid") == aptid){
            System.out.println("For " + rsprime.getString("name") + " " + rsprime.getInt("healthid") + "\n");
            System.out.println("1. Review notes\n" +
                    "2. Review tests\n" +
                    "3. Add a note\n" +
                    "4. Prescribe a test\n" +
                    "5. Go back to the appointments.\n");
            System.out.println("Enter your choice: ");
        }
            //display apt menu
            ResultSet rs2 = stmt.executeQuery("SELECT cid, numofpreg FROM Appointments WHERE\n" +
                    "aptid = " + aptid + ";");
            rs2.next();

            int cid = rs2.getInt("cid");
            int numofpreg = rs2.getInt("numofpreg");

            // Functionality Specs
            Scanner num_sc = new Scanner(System.in);  // Create a Scanner object
            int num = num_sc.nextInt();

            switch (num){
                case 1: // notes
                    ResultSet rs3 = stmt.executeQuery("SELECT date, timestamp, content FROM Appointments, Notes\n" +
                            "WHERE Notes.aptid = Appointments.aptid\n" +
                            "AND Appointments.cid = " + cid + "\n" +
                            "AND Appointments.numofpreg = " + numofpreg + "\n" + "ORDER BY date DESC, timestamp DESC;" );
                    while (rs3.next()) {
                        System.out.println(rs3.getDate("date") + " " + rs3.getTime("timestamp") +
                                " " + rs3.getString("content"));
                    }
                    System.out.println("\r");
                    selectApt(stmt, aptid, pid, date);

                case 2: // tests
                    ResultSet rs4 = stmt.executeQuery("SELECT dateprescribed, type, coalesce(result, 'PENDING') FROM Treatments\n" +
                            "WHERE Treatments.cid = " + cid + "\n" +
                            "AND Treatments.numofpreg = " + numofpreg + "\n" +
                            "ORDER BY dateprescribed DESC\n" +
                            ";");
                    while (rs4.next()) {
                        System.out.println(rs4.getDate("dateprescribed") + " [" + rs4.getString("type") +
                                "] " + rs4.getString(3));
                    }
                    System.out.println("\r");
                    selectApt(stmt, aptid, pid, date);

                case 3: // add a note
                    System.out.println("Please type your observation: ");
                    Scanner add_note_sc = new Scanner(System.in);  // Create a Scanner object
                    String note = add_note_sc.nextLine();

                    SimpleDateFormat dateFormat = new SimpleDateFormat("hh:mm:ss");
                    Calendar calendar = Calendar.getInstance();
                    String time = dateFormat.format(calendar.getTime());

                    stmt.executeUpdate("INSERT INTO Notes VALUES (" + aptid + ", '" + time + "', '" + note + "');" );
                    System.out.println("\r");
                    selectApt(stmt, aptid, pid, date);

                case 4: // add a treatement
                    System.out.println("Please enter the type of test: ");
                    Scanner add_treatment_sc = new Scanner(System.in);  // Create a Scanner object
                    String type = add_treatment_sc.nextLine();

                    String date2 = String.valueOf(java.time.LocalDate.now());

                    ResultSet rs5 = stmt.executeQuery("SELECT COUNT(*) FROM Treatments WHERE cid = " + cid + " AND numofpreg = " + numofpreg + ";");
                    rs5.next();
                    int numoftr = rs5.getInt(1);

                    int trid = Integer.valueOf('8'+ Integer.toString(numofpreg)+ '0' + Integer.toString(cid) + '0' + Integer.toString(numoftr + 1));

                    stmt.executeUpdate("INSERT INTO Treatments VALUES (" + trid + ", '" + type + "', " + pid + "," +
                            cid + "," + numofpreg + ", null, null, '" + date2 + "', '" + date2 + "', null, null);" );
                    System.out.println("\r");
                    selectApt(stmt, aptid, pid, date);

                case 5: // go back to appointments
                    displayApt(stmt, pid, date );

        }
        return 0;
    }


}


