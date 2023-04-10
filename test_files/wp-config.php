<?php
//2023_03_31_20h55m06s
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * 
 * 
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

/*je suis une copie*/

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'hkfykeus_noproblemo' );

/** MySQL database username */
define( 'DB_USER', 'hkfykeus_noproblusr' );

/** MySQL database password */
define( 'DB_PASSWORD', 'GsN7fsZZ9Z7R2Gvn' );

/** MySQL hostname */
define( 'DB_HOST', 'localhost' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',          '!3D{Vdgiopp93TZ$<$+oiv5>grpcZ_/CH)5~u*vTK%7`W6Jt9z]uWgp}c/:fN6$:' );
define( 'SECURE_AUTH_KEY',   '[q^]yjy]xR[f3q54H&vH,R?Si|vRnf8wUwh&5n$&9?2DR(>C47aYq6,OdcHxYJ^Z' );
define( 'LOGGED_IN_KEY',     ';3Sf {&XbBDW3SVaw-B#A+c)^86P!Q?JQ}JG]uzR|56dItJk`WK=Q1VbPkP}JbGO' );
define( 'NONCE_KEY',         'd*sqv8Ry-]SeBy*s5d$EI+BoV+BU/*4KS6CS{pgFI^Em?;Cz5L4soZ=9`jTY0V,}' );
define( 'AUTH_SALT',         'XIBH *P3.~jI,nL<,bV&%>a41p4PRY>  18cSBJad58F%m}N2O*G.T-p.<0S,va+' );
define( 'SECURE_AUTH_SALT',  ':QKw@I3RIAO]:2X|?&{,^?@2[^_;4bWD1U?kc/aT? DC;l, 5SH~i&{1Y#z/O(M~' );
define( 'LOGGED_IN_SALT',    'VsJ@q>r`Dy--fK;}koOkf T559$aHDl;cM60!M(NgxiJMlp$?OGbkq(7YiM<,;h]' );
define( 'NONCE_SALT',        'VF=V`3BT1zU3L)RU^r9Xf`b!0}XO%4wQf?Ta-LQuKAFw7L9E`y3|J8R}flB)^_v=' );
define( 'WP_CACHE_KEY_SALT', '<w.v0.OdG-aJ@uP4^SJau%KwwC:o-kb0q|M8ej5!fB:NTxB>w|!6O.;*AMhD/$Xg' );

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'nop_';




/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', dirname( __FILE__ ) . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
