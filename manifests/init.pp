node 'servera.nodex.example.com' {
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
node 'serverb.nodex.example.com' {
	notify{ 'serverb_notify' :
	message => "********** serverb ***********"
}
	include mysql
	include apache
	include vsftpd
	include basic
}

node 'serverc.nodex.example.com' {
  include ::haproxy
  haproxy::listen { 'lb-01':
    collect_exported => false,
    ipaddress        => $::ipaddress,
    ports            => '5000',
  }
  haproxy::balancermember { 'servera':
    listening_service => 'lb-01',
    server_names      => 'servera.nodex.example.com',
    ipaddresses       => '192.168.100.11',
    ports             => '80',
    options           => 'check',
  }
  haproxy::balancermember { 'serverb':
    listening_service => 'lb-01',
    server_names      => 'serverb.nodex.example.com',
    ipaddresses       => '192.168.100.12',
    ports             => '80',
    options           => 'check',
  }
}

node 'default' {
	notify{ 'default_notify' :
	message => "********** default ***********"
}
	include java
	include basic
}
