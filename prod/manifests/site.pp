node 'puppet-node' {

class { '::mysql::server':
    root_password    => 'p@$$w0rd',
    override_options => { 'mysqld' => { 'max_connections' => '1024' } },
  }

  mysql_database { 'prod_mdb':
    ensure  => present,
    charset => 'utf8',
  }

  mysql_user { 'prod_user@localhost':
    ensure => present,
  }

  mysql_grant { 'prod_user@localhost/prod_mdb.*':
    ensure     => present,
    options    => ['GRANT'],
    privileges => ['ALL'],
    table      => 'prod_mdb.*',
    user       => 'prod_user@localhost',
  }

package { 'nginx':
  ensure => 'installed'}

service { 'nginx':
  ensure => 'running'}

}
