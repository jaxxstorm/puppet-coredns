class coredns::service {

  service { 'coredns':
    ensure => $coredns::service_ensure,
    enable => $coredns::service_enable,
  }


}
