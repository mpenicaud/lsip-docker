<?php

/*
 * CommonProperties to store variables used for connexion etc.
 * @author nicolas malservet
 * @since version 0.16
 */

class CommonProperties
{
    /*
     * database connection properties
     */
    public static $CONNECTION_STRING = 'mysql:host=127.0.0.1;dbname=SIP';
    public static $CONNECTION_USERNAME = 'root';
    public static $CONNECTION_PASSWORD = 'root';
    /**
     * webmaster email
     */
    public static $ADMIN_EMAIL = 'admin@server.com';
    /**
     *
     * import folder.
     *
     * Be sure to end this string by a directory separator
     */
    public static $MASS_IMPORT_FOLDER = "/var/www/SIP/protected/data/import/";
}
