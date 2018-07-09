class linux {
    # Delete the cached apt-get lists
    exec { "cleanup-apt-get-lists":
        command => "/bin/rm -rf /var/lib/apt/lists/*",
    }

    # Run apt-get clean
    exec { "apt-clean":
        require => Exec["cleanup-apt-get-lists"],
	command => "/usr/bin/apt-get clean";
    }

    # Updates the local machine with the online repository
    exec { "apt-update":
	require => Exec["apt-clean"],
        command => "/usr/bin/apt-get update";
    }

    # Variable Declaration : Packages to the installed
    $packages_list = ['vim', 'wget', 'zip', 'unzip', 'expect']

    # Iterating though the packages_list variable and installing/updating the packages
    package { $packages_list:
	ensure => latest,
    }
}
