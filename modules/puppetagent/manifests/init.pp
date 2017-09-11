# == Class: puppetagent
class puppetagent {

  include puppetagent::install
  include puppetagent::config
  include puppetagent::service

}
