<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the web site, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * Localized language
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** Database username */
define( 'DB_USER', 'wp_owner' );

/** Database password */
define( 'DB_PASSWORD', '1234' );

/** Database hostname */
define( 'DB_HOST', 'inception_mariadb' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',          '=xn4p?~9n]Z.W|!RF)${3MH<TptO4?m0Ad-Raw8txK[!OPxTmc:VjJ03x(yg8n=.' );
define( 'SECURE_AUTH_KEY',   'z#^IL}Dd(yN$xTuEWBk?%1Xr1lBbBJQCi*zW|&>X%HIQC]ZXy`/?OBWo}fIV=*%.' );
define( 'LOGGED_IN_KEY',     '%JuOiX:m72Y|.caJcTC|aVWdXVz7s8;?>LISHF`;yPMh_&3IRg%NbiJ?VE!nvDVV' );
define( 'NONCE_KEY',         'c7*KPY<v_6|s5=qj=qJ0p sN#5K_u3^;K.0IS-=B#5Q,=eMD7>ahn4%uX+BP`&cE' );
define( 'AUTH_SALT',         ':9eRf5]iw6xO^;fP;9Pqgg:`84N}cKEJ=5nB*L&12kHz)68_0g9LnpSD:|OOZO$g' );
define( 'SECURE_AUTH_SALT',  '-1U-F1)On%>jmUVXf+@PhI{4 ?*=a!nPY51BFwY,-mtfik.7u7cGVgQo_P^G.srT' );
define( 'LOGGED_IN_SALT',    'X9SLf;uD!7[cOkINQ^@=FiAk(6#X,]z=.R[qQA6,j29rm?a1~XB03EW}%;2W)9@c' );
define( 'NONCE_SALT',        'hB5)t(]S3ywI7`?v>~cpr9FPK|PrK$2[GVvW: fedh.J|uDcD^yp@9NJ-@y>JHz/' );
define( 'WP_CACHE_KEY_SALT', 'VNj)b6i7F6~CSXh`KWM3}J=Y Pr.BFY0FfdLAbO(S5|(<}ku)Wx;8u-tC^L{Q>,8' );


/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );


/* Add any custom values between this line and the "stop editing" line. */



/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
