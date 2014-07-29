puppet_run
==========

This package uses [r10k](https://github.com/adrienthebo/r10k) to update your modules from Git and / or the Puppet Forge and then runs ``puppet apply /etc/puppet/environments/manifests/site.pp`` every 30 minutes.

## Usage

* Install [The Luggage](https://github.com/unixorn/luggage)
* Edit ``r10k.yaml`` to match your 'primary' repository that contains a [Puppetfile](https://github.com/rodjek/librarian-puppet#the-puppetfile) with the modules you need and a ``site.pp`` that contains a default node.
* ``make pkg``
* Profit. 