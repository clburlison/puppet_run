# Required gems that osx nodes must have to work with out masterless setup
class osx_gems (
  $options = [ '--install-dir', '/opt/puppetlabs/puppet/lib/ruby/gems/2.1.0', '--bindir', '/opt/puppetlabs/puppet/bin' ],
  $ruby_gem_url = 'https://production.cf.rubygems.org'
){
  package { 'r10k':
    ensure          => '2.1.1',
    provider        => 'puppet_gem',
    source          => $ruby_gem_url,
    install_options => $options,
  }

  package { 'hiera-eyaml':
    ensure          => '2.0.8',
    provider        => 'puppet_gem',
    source          => $ruby_gem_url,
    install_options => $options,
  }
  
  package { 'sqlite3':
    ensure          => '1.3.11',
    provider        => 'puppet_gem',
    source          => $ruby_gem_url,
    install_options => $options,
  }
  
  package { 'CFPropertyList':
    ensure          => '2.3.2',
    provider        => 'puppet_gem',
    source          => $ruby_gem_url,
    install_options => $options,
  }
}

# Define default node
node default {
  if $::osfamily == 'Darwin' {
      Class {'osx_gems':}
  }
}