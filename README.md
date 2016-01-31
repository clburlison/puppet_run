puppet_run
==========

This package serves to replace the puppet agent for masterless puppet deployment. Using [r10k](https://github.com/adrienthebo/r10k) to update modules from Github. A LaunchDaemon runs the follow to apply changes on the client:  

````bash
puppet apply /etc/puppet/environments/%{environment}/manifests/site.pp
````

Fully tested and working with Puppet 4 and the new all-in-one Puppet agent package.

##Settings
This setup is using a masterless puppet environment. To test changes away from production we can modify the ``puppet.conf`` file. The 'environment' variable allows us to pick which branch our client is currently on. By default this is the ``production`` branch. We can also modify the heira path from the same ``puppet.conf`` file.

###Run Frequency
By default the ``puppet_run.py`` script will run every 20 minutes. This can be modified in the LaunchDaemon in the ``StartCalendarInterval`` key.

## Usage

* Install [The Luggage](https://github.com/unixorn/luggage)
* Edit ``r10k.yaml`` to match your 'control' repository.
* Create the package with ``make pkg``


#Credit
Initial creation of this script was by [Graham Gilbert](https://github.com/grahamgilbert/puppet_run) with modification by [Clayton Burlison](https://github.com/clburlison).