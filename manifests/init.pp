class apt-cacher-ng (
	$proxy = "",
    $broken_if_range = false) {

	package { apt-cacher-ng:
		ensure => present }

	file { "/etc/apt-cacher-ng":
        ensure => directory,
    }

	file { "/etc/apt-cacher-ng/acng.conf":
        content => template('apt-cacher-ng/acng.conf.erb'),
        require => File["/etc/apt-cacher-ng/"],
		notify => Exec["restart-apt-cacher-ng"]
    }

	exec { "restart-apt-cacher-ng":
		command => "/usr/sbin/service apt-cacher-ng restart",
		refreshonly => true,
		require => Package[apt-cacher-ng],
	}
}
