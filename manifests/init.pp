node 'serverd.nodex.example.com' {
notify{ 'Dev env ' :
        message => "********** dev_serverd ***********"
}

	include mysql
       include vsftpd
	include basic
	include apache
	basic::useradd { "ramesh":
		pv_username => 'ramesh',
                }
	basic::useradd { "ganesh":
		pv_username => 'ganesh',
		pv_passwd	=> 'redhat',
                }
}
node 'default' {
	notify{ 'dev_default' :
	message => "********** dev_default ***********"
}
	include java
	include basic
}
