class mysql {
    $packages_list = ['mysql-server-5.6', 'php5-mysql']

    package { $packages_list:
        ensure => latest,
    }

    service { "mysql":
        ensure => running,
        require => [
            Package["mysql-server-5.6"]
        ],
    }

    exec { "mysql_autostart":
        command => "/usr/sbin/update-rc.d mysql defaults";
    }

    file { "mysql_autosecure":
        owner => "root",
        group => "root",
        mode => "755",
        ensure => present,
        path => "/opt/mysql-autosecure.sh",
        source => "puppet:///modules/mysql/mysql-autosecure.sh",
        require => Service["mysql"];
    }

    $password = "dbpassword"

    exec { "mysql_autosecure":
        command => "sh /opt/mysql-autosecure.sh $password",
        path => "/usr/bin:/bin/",
        creates => "/usr/bin/mysql_secure_installation.ran",
        logoutput => true,
        require => File["mysql_autosecure"];
    }

    file { "my-default.cnf":
	ensure  => present,
	path    => '/usr/share/mysql/my-default.cnf',
	source  => 'file:///etc/mysql/my.cnf',
	recurse => true;
    }

    exec { "data_dir":
	command => "/usr/bin/sudo mysql_install_db --base-dir=/usr/share/mysql",
	creates => "/usr/share/mysql/data_dir.ran";
    }
}
