class nginx {
    package { "nginx":
	ensure => latest;
    }

    file { "/etc/nginx/sites-enabled/default":
	ensure => "absent"
    }

    exec { "php-fpm cgi.fix_pathinfo":
	command => "/bin/sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php5/fpm/php.ini",
	creates => '/tmp/php.ini.edit.done'
    }
    
    file { "info_php.conf":
	mode => "0644",
	owner => "root",
	group => "root",
	path => "/etc/nginx/sites-enabled/info_php.conf",
	source => "puppet:///modules/nginx/info_php.conf",
	ensure => present;
    }

    service { "php5-fpm":
	ensure => running;
    }

    service { "nginx":
	ensure => running;
    }
}

