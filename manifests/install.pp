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

}
