puppet_run
==========

This package serves to replace the puppet agent for masterless puppet deployment. Using [r10k](https://github.com/adrienthebo/r10k) to update modules from Github and the Puppet Forge. A LaunchDaemon runs the follow to apply changes on the client:  

````bash
puppet apply /etc/puppet/environments/%{environment}/manifests/site.pp
````

##Settings
This setup is using a masterless puppet environment. To test changes away from production we can modify the ``puppet.conf`` file. The 'environment' variable allows us to pick which branch our client is currently on. By default this is the ``production`` branch. We can also modify the heira path from the same ``puppet.conf`` file.

###Delay
By default the delay is set to 20 minutes (see delayrandom in LauchDaemon). This makes sure that all clients don't try to do a git pull at the same time, saturating the network.

###Run Frequency
By default the ``puppet_run.py`` script will run twice per hour. This can be modified in the LaunchDaemon in the ``StartCalendarInterval`` key.

## Usage

* Install [The Luggage](https://github.com/unixorn/luggage)
* Edit ``r10k.yaml`` to match your 'primary' repository that contains a [Puppetfile](https://github.com/rodjek/librarian-puppet#the-puppetfile) with the modules you need and a ``site.pp`` that contains a default node. Optionally include your hiera data and modify ``puppet.conf`` as needed.
* Create the package with ``make pkg``


#Credit
Initial creation of this script was by [Graham Gilbert](https://github.com/grahamgilbert/puppet_run) with modification by [Clayton Burlison](https://github.com/clburlison).

The random delay is courtesy of Google's ``supervisor`` python script.
