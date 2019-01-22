# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include coredns::configure
class coredns::configure {


  case $coredns::init_style {
    'systemd': {
      systemd::unit_file{'coredns.service':
        content => template('coredns/coredns.systemd.erb'),
      }
    }
    default: {
      fail("I don't know how to create an init script for style ${coredns::init_style}")
    }
  }

}
