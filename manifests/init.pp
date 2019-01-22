# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include coredns
class coredns (
  $version                  = $coredns::params::version, # needs to be first for ordering reasons
  $archive_path             = $coredns::params::archive_path,
  $bin_dir                  = $coredns::params::bin_dir,
  $config_dir               = $coredns::params::config_dir,
  $config_file              = $coredns::params::config_file,
  $coredns_user             = $coredns::params::coredns_user,
  $coredns_group            = $coredns::params::coredns_group,
  $coredns_shell            = $coredns::params::coredns_shell,
  $extract_path             = "/opt/coredns-${version}",
  $init_style               = $coredns::params::init_style,
  $install_method           = $coredns::params::install_method,
  $manage_user              = $coredns::params::manage_user,

) inherits coredns::params {

  anchor { 'coredns_first': }
  ->
  class { 'coredns::install': } ->
  class { 'coredns::configure': } ->
  anchor { 'coredns_final': }

}
