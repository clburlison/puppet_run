#!/usr/bin/python
# Puppet Wrapper to make sure it runs as expected 

import subprocess
import logging
import os
import random
import sys
import time
import ConfigParser

logging.basicConfig(filename='/var/log/puppet_run.log',level=logging.INFO)
logger = logging.getLogger('puppet_run')
config = ConfigParser.SafeConfigParser()
config.read("/private/etc/puppetlabs/puppet/puppet.conf")
environment = config.get("main", "environment")
# environment = 'production'
puppet = '/opt/puppetlabs/bin/puppet'
r10k = '/opt/puppetlabs/puppet/bin/r10k'
puppet_cmd = [puppet, 'apply', '--verbose', '/private/etc/puppetlabs/code/environments/' + environment + '/manifests/site.pp']
r10k_cmd = [r10k, 'deploy', 'environment', '-p', '--verbose']
max_delay = 1200


def random_delay():
    randomized_delay = random.randrange(0, max_delay)
    logger.info("Delaying run by %s seconds" % randomized_delay)
    time.sleep(randomized_delay)

def ip_addresses():
    command = "ifconfig  | grep -E 'inet.[0-9]' | grep -v '127.0.0.1' | awk '{ print $2}' | wc -l"
    proc = subprocess.Popen(command, shell=True,stdout=subprocess.PIPE)
    return proc.communicate()[0].replace('\n', '')

def checkNetwork():
    for i in range(5):
        if ip_addresses().strip() != "0":
            logger.info('Network connection is active. ')
            break
        else:
            logger.info('Network connection is inactive. ')
        time.sleep(3)

def run_puppet():
    if os.path.isfile(r10k):
        logger.info("Running r10k...")
        returncode = subprocess.call(r10k_cmd)
    else:
        logger.info("r10k not found")
    if os.path.isfile(puppet):
        logger.info("Running Puppet...")
        returncode = subprocess.call(puppet_cmd)
    else:
        logger.info("puppet not found")

def main():
    # Need to be running as root
    if os.geteuid() != 0:
        print >> sys.stderr, 'You must run this as root, or via sudo!'
        sys.exit(-1)
    #random_delay()
    checkNetwork()
    run_puppet()


if __name__ == "__main__":
    main()
