USE_PKGBUILD=1
include /usr/local/share/luggage/luggage.make
PB_EXTRA_ARGS+= --sign "Developer ID Installer: Clayton Burlison"

INSTALL_DIR='pkgroot/opt/puppetlabs/puppet/lib/ruby/gems/2.1.0'
BINARY_DIR='pkgroot/opt/puppetlabs/puppet/bin'
GEM='/opt/puppetlabs/puppet/bin/gem'

TITLE=clburlison_puppet_run
REVERSE_DOMAIN=com.clburlison
PAYLOAD=\
	pack-puppet_run \
	pack-Library-LaunchDaemons-com.clburlison.puppet_run.plist \
	pack-r10kconf \
	pack-pathsd \
	pack-keys \
	pack-site.pp \
	pack-script-postinstall \
	# pack-gems
	# pack-puppetconf \

pack-puppet_run: l_usr
	@sudo mkdir -p ${WORK_D}/usr/local/bin/
	@sudo ${CP} puppet_run.py ${WORK_D}/usr/local/bin/puppet_run.py
	@sudo chown -R root:wheel ${WORK_D}/usr/local/bin/puppet_run.py
	@sudo chmod 700 ${WORK_D}/usr/local/bin/puppet_run.py

pack-puppetconf: l_private_etc
	@sudo mkdir -p ${WORK_D}/private/etc/puppetlabs/puppet/
	@sudo ${CP} puppet.conf ${WORK_D}/private/etc/puppetlabs/puppet/puppet.conf
	@sudo chown -R root:wheel ${WORK_D}/private/etc/puppetlabs/puppet/puppet.conf

pack-r10kconf: l_private_etc
	@sudo mkdir -p ${WORK_D}/private/etc/puppetlabs/r10k
	@sudo ${CP} r10k.yaml ${WORK_D}/private/etc/puppetlabs/r10k/r10k.yaml
	@sudo chown -R root:wheel ${WORK_D}/private/etc/puppetlabs/r10k/r10k.yaml

pack-pathsd: l_private_etc
	@sudo mkdir -p ${WORK_D}/private/etc/paths.d
	@sudo ${CP} paths.d/puppet4 ${WORK_D}/private/etc/paths.d/puppet4
	@sudo chown -R root:wheel ${WORK_D}/private/etc/paths.d/puppet4

pack-keys: l_private_etc
	@sudo mkdir -p ${WORK_D}/private/etc/puppetlabs/puppet/keys
	@sudo ${CP} keys/* ${WORK_D}/private/etc/puppetlabs/puppet/keys/
	# @sudo chown -R puppet:puppet ${WORK_D}/private/etc/puppetlabs/puppet/keys
	@sudo chown -R root:wheel ${WORK_D}/private/etc/puppetlabs/puppet/keys
	@sudo chmod -R 0500 ${WORK_D}/private/etc/puppetlabs/puppet/keys
	@sudo chmod 0400 ${WORK_D}/private/etc/puppetlabs/puppet/keys/private_key.pkcs7.pem
	@sudo chmod 0400 ${WORK_D}/private/etc/puppetlabs/puppet/keys/public_key.pkcs7.pem

pack-site.pp: l_Library
	@sudo mkdir -p ${WORK_D}/Library/Puppet/
	@sudo ${CP} ./site.pp ${WORK_D}/Library/Puppet/
	@sudo chown -R root:wheel ${WORK_D}/Library/Puppet/
	@sudo chmod 0644 ${WORK_D}/Library/Puppet/site.pp





# This is to embed the ruby gems which I really don't want to do.
pack-gems: r10k hiera-eyaml sqlite3 CFPropertyList
	@sudo ${CP} -R pkgroot/* ${WORK_D}

pack-gems-no-build:
	@sudo ${CP} -R pkgroot/* ${WORK_D}

ruby-paths:
	rm -rf pkgroot
	mkdir -p $(INSTALL_DIR)
	mkdir -p $(BINARY_DIR)

r10k: ruby-paths
	@sudo $(GEM) install r10k --platform 'Darwin' --install-dir $(INSTALL_DIR) --bindir $(BINARY_DIR)

hiera-eyaml: ruby-paths
	@sudo $(GEM) install hiera-eyaml --platform 'Darwin' --install-dir $(INSTALL_DIR) --bindir $(BINARY_DIR)

sqlite3: ruby-paths
	@sudo $(GEM) install sqlite3 --platform 'Darwin' --install-dir $(INSTALL_DIR) --bindir $(BINARY_DIR)

CFPropertyList: ruby-paths
	@sudo $(GEM) install CFPropertyList --platform 'Darwin' --install-dir $(INSTALL_DIR) --bindir $(BINARY_DIR)