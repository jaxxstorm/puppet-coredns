# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include coredns::plugin
define coredns::plugin(
  Optional[String] $source = undef,
  Optional[String] $content = undef,
){

  file { "/etc/coredns/${title}.conf":
    ensure    => file,
    content   => $content,
    source    => $source,
    owner     => $coredns::coredns_user,
    group     => $coredns::coredns_group,
    mode      => '0444',
    require   => Class['coredns::configure'],
  }

}
