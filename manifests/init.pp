class apt-cacher-ng (
	$proxy = "",
    $dont_cache_volatile = false,
    $avoid_if_range = false) {

    package { apt-cacher-ng:
	ensure => present
    }

    file { "/etc/apt-cacher-ng":
        ensure => directory,
    }

    file { "/etc/apt-cacher-ng/acng.conf":
        content => template('apt-cacher-ng/acng.conf.erb'),
        require => File["/etc/apt-cacher-ng/"],
	notify => Service['apt-cacher-ng'],
    }

    service { 'apt-cacher-ng':
	ensure => running,
	enable => true,
	require => Package[apt-cacher-ng],
    }
}
