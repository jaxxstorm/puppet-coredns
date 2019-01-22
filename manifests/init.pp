# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include coredns
class coredns (
  $bin_dir                  = $coredns::params::bin_dir,
  $version                  = $coredns::params::version,
  $archive_path             = $coredns::params::archive_path,
  $extract_path             = "/opt/coredns-${version}",
  $init_style               = $coredns::params::init_style,
  $install_method           = $coredns::params::install_method,

) inherits coredns::params {

  anchor { 'coredns_first': }
  ->
  class { 'coredns::install': } ->
  class { 'coredns::configure': } ->
  anchor { 'coredns_final': }

}
