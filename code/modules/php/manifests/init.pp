class php {
    $packages = ['php5', 'libapache2-mod-php5', 'php5-mcrypt', 'php5-common', 'php5-cli', 'php5-fpm']

    package { $packages:
        ensure => latest;
    }

    file { '/var/www/html':
	ensure => 'directory',
    	owner  => 'root',
    	group  => 'root',
	recurse => true,
    	mode   => '0775';
    }

    file { "info.php":
	ensure => present,
	mode   => '0775',
	owner  => 'root',
        group  => 'root',
	source => "puppet:///modules/php/info.php",
	path => "/var/www/html/info.php",
	require => Package["php5"];
    }

    file { "index.html":
	ensure => absent,
	path => "/var/www/html/index.html";
    }
}
