# == Class: puppetmaster
class puppetmaster {

  include puppetmaster::install
  include puppetmaster::config
  include puppetmaster::service

}
