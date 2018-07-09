class apache {
    package { "apache2":
	ensure => latest;
    }

    exec { "unlink 000-default.conf":
	creates => '/tmp/unlink.done',
	command => "/usr/bin/unlink /etc/apache2/sites-enabled/000-default.conf";
    }

    file { "info_php.conf":
	ensure => "present",
	owner => "root",
	group => "root",
	mode => "0644",
	path => "/etc/apache2/sites-enabled/info_php.conf",
	source => "puppet:///modules/apache/info_php.conf";
    }

    service { "apache2":
	ensure => running;
    } 
}


