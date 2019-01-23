# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include coredns::install
class coredns::install {

  case $coredns::install_method {

    'url': {
      # install with puppet-archive

      include ::archive

      file { $coredns::extract_path:
        ensure => directory,
        owner  => $coredns::coredns_owner,
        group  => $coredns::coredns_group,
      }
      -> archive { $coredns::archive_path:
        ensure       => present,
        extract      => true,
        extract_path => $coredns::extract_path,
        source       => "https://github.com/coredns/coredns/releases/download/v${coredns::version}/coredns_${coredns::version}_linux_amd64.tgz",
        creates      => "${coredns::extract_path}/coredns"
      }
      -> file { "${coredns::bin_dir}/coredns":
        ensure => link,
        target => "${coredns::extract_path}/coredns";
      }
    }

    'package': {
      # install with package manager
    }

    default: {
      fail("The provided install method ${coredns::install_method} is invalid")
    }

  }

  if $coredns::manage_user {
    group {$coredns::coredns_group:
      ensure => present,
      system => true,
    }

    user {$coredns::coredns_user:
      ensure => present,
      shell  => $coredns::coredns_shell,
      system => true,
    }

    if $coredns::coredns_user != 'root' {
      file_capability { "${coredns::extract_path}/coredns":
        ensure     => present,
        capability => 'cap_net_bind_service=ep',
      }
    }
  }

}
