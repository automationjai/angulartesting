package com.salmon.test.framework.helpers;

import com.jcraft.jsch.JSchException;
import com.salmon.test.framework.helpers.utils.SSHClient;
import org.apache.commons.dbutils.DbUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.ResultSetHandler;
import org.apache.commons.dbutils.handlers.ArrayListHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.MapListHandler;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.FileSystemResource;
import org.springframework.jdbc.datasource.init.ScriptUtils;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import static com.eviware.soapui.support.StringUtils.createFileName;

public class DatabaseHelper {

    private static final Logger LOG = LoggerFactory.getLogger(DatabaseHelper.class);
    private static final String jdbcUrl;
    private static final String jdbcDriver;
    private static final String jdbcUser;
    private static final String jdbcPwd;
    private static final String jdbcSchema;
    private static final String RUN_CONFIG_PROPERTIES = "/environment.properties";
    private static Connection conn = null;
    private static QueryRunner run;
    private static SSHClient sshClient = null;
    private static String profileId;

    static {
        Props.loadRunConfigProps(RUN_CONFIG_PROPERTIES);

        jdbcUrl = Props.getProp("jdbcUrl");
        jdbcDriver = Props.getProp("jdbcDriver");
        jdbcUser = Props.getProp("jdbcUser");
        jdbcPwd = Props.getProp("jdbcPwd");
        jdbcSchema = Props.getProp("jdbcSchema");
        sshClient = new SSHClient();

        LOG.info("ssh client object is created + al DB properties are loaded from config file");
    }

    public static Connection setUpConnection() {

        profileId = UrlBuilder.readValueFromConfig("profile.id");
        try {
//            if (!profileId.equalsIgnoreCase("dev")) {
//                String bastionIp = UrlBuilder.readValueFromConfig("bastion.ip");
//                String bastionUser = UrlBuilder.readValueFromConfig("bastion.user");
//
//                sshClient.connectSystestWithProxy(bastionIp, bastionUser);
//            }
            DbUtils.loadDriver(jdbcDriver);
            conn = DriverManager.getConnection(jdbcUrl, jdbcUser, jdbcPwd);
            conn.createStatement().execute("ALTER SESSION SET CURRENT_SCHEMA = " + jdbcSchema + "");

            //} catch (SQLException | IOException e) {
        } catch (SQLException e) {

            LOG.info(e.getMessage());
            return null;
        }
        return conn;
    }

    /**
     * Executes the sql Query and returns the results in list format
     *
     * @param sqlQuery Specify sql query in String format
     */
    public static List executeQuery(String sqlQuery) throws SQLException {
        try {
            conn = setUpConnection();
            return getQueryRunner().query(conn, sqlQuery, new MapListHandler());
        } catch (SQLException e) {
            LOG.error("Exception", e);
        } finally {
            DbUtils.closeQuietly(conn);
            if (!profileId.equalsIgnoreCase("dev")) {
                // sshClient.disconnect();
            }

        }
        return null;
    }

    public static void executeQueryFromFile(String dirPath) throws SQLException {
        conn = setUpConnection();
        File[] files = new File(dirPath).listFiles();
        if ((files != null) && (files.length != 0)) {
            Arrays.stream(files).forEach((file) -> {
                ScriptUtils.executeSqlScript(conn, new FileSystemResource(file.getPath()));
            });
            DbUtils.closeQuietly(conn);
            if (!profileId.equalsIgnoreCase("dev")) {
                // sshClient.disconnect();
            }
        } else {
            LOG.info("Skipping Inventory as there were no SQL files to load");
        }
    }

    public static List executeQueryWithParams(String sqlQuery,String... params) throws SQLException {
        try {
            conn = setUpConnection();
            return getQueryRunner().query(
                    conn, sqlQuery, params,new MapListHandler());
        } catch (SQLException e) {
            LOG.error("Exception", e);
        } finally {
            DbUtils.closeQuietly(conn);
            if (!profileId.equalsIgnoreCase("dev")) {
                // sshClient.disconnect();
            }

        }
        return null;
    }

    public static List<Map<String, Object>> executeDatabaseQuery(String sqlQuery) throws SQLException {
        List<Map<String, Object>> resultMap = null;
        try {
            conn = setUpConnection();
            resultMap = getQueryRunner().query(conn, sqlQuery, new MapListHandler());
            return resultMap;
        } finally {
            DbUtils.closeQuietly(conn);
            /*if (!profileId.equalsIgnoreCase("dev")) {
                sshClient.disconnect();
            }*/
        }
    }

    public static List<Object[]> executeQueryToArray(String sqlQuery) throws SQLException {
        List<Object[]> resultList = null;
        try {
            conn = setUpConnection();
            resultList = getQueryRunner().query(conn, sqlQuery, new ArrayListHandler());
            return resultList;
        } finally {
            DbUtils.closeQuietly(conn);
            /*if (!profileId.equalsIgnoreCase("dev")) {
                sshClient.disconnect();
            }*/
        }
    }

    public static <T> List<T> executeQueryToObject(Class<T> c, String query) {
        conn = setUpConnection();
        ResultSetHandler<List<T>> h = new BeanListHandler<T>(c);
        try {
            return getQueryRunner().query(
                    conn, query, h);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (!profileId.equalsIgnoreCase("dev")) {
                //       sshClient.disconnect();
            }
        }
        return null;
    }

    public static <T> List<T> executeParamQueryToObject(Class<T> c, String query, String... params) {
        conn = setUpConnection();
        ResultSetHandler<List<T>> h = new BeanListHandler<T>(c);
        try {
            return getQueryRunner().query(
                    conn, query, h, params);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (!profileId.equalsIgnoreCase("dev")) {
                //          sshClient.disconnect();
            }
        }
        return null;
    }

    protected static QueryRunner getQueryRunner() {
        return new QueryRunner();
    }

    private static void createTunneling() throws IOException {
        try {
            sshClient = new SSHClient();

            //for (int i = 0; i < 5; i++) {
            sshClient.connect(UrlBuilder.getSystestIP().toString(), UrlBuilder.readValueFromConfig("host.sudo.user"), UrlBuilder.getSystestPassword().toString());
            //  Thread.sleep(2000);
            //   if(sshClient.)
            //}

            LOG.info("Connected to Unix machine...... ");
            sshClient.sshTunneling();
            LOG.info("Tunneling created..... ");
        } catch (JSchException e) {
            e.printStackTrace();
            sshClient.disconnect();
        }
    }


}