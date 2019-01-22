# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include coredns::params
class coredns::params {

  $archive_path             = '/tmp/coredns.tgz'
  $bin_dir                  = '/usr/local/bin'
  $config_dir               = '/etc/coredns'
  $config_file              = "${config_dir}/Corefile"
  $install_method           = 'url'
  $version                  = '1.3.1'


  case $::operatingsystem {
    'RedHat', 'CentOS': {
      if versioncmp($::operatingsystemrelease, '7.0') < 0 {
        fail('OS is currently not supported')
      } else {
        $init_style  = 'systemd'
      }
    }
    'Debian': {
      if versioncmp($::operatingsystemrelease, '8.0') < 0 {
        fail('OS is currently not supported')
      } else {
        $init_style = 'systemd'
      }
    }
    'Ubuntu': {
      if versioncmp($::operatingsystemrelease, '15.04') < 0 {
        fail('OS is currently not supported')
      } else {
        $init_style = 'systemd'
      }
    }
    default: { fail('Unsupported OS') }
  }


}
