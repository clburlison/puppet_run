USE_PKGBUILD=1
include /usr/local/share/luggage/luggage.make

TITLE=clburlison_puppet_run
REVERSE_DOMAIN=com.clburlison
PAYLOAD=\
	pack-puppet_run \
	pack-supervisor \
	pack-Library-LaunchDaemons-com.clburlison.puppet_run.plist \
	pack-puppetconf \
	pack-r10kconf \
	pack-keys

pack-puppet_run: l_usr
	@sudo mkdir -p ${WORK_D}/usr/local/bin/
	@sudo ${CP} puppet_run.py ${WORK_D}/usr/local/bin/puppet_run.py
	@sudo chown -R root:wheel ${WORK_D}/usr/local/bin/puppet_run.py
	@sudo chmod 700 ${WORK_D}/usr/local/bin/puppet_run.py
  
pack-puppetconf: l_private_etc
	@sudo mkdir -p ${WORK_D}/private/etc/puppet/
	@sudo ${CP} puppet.conf ${WORK_D}/private/etc/puppet/puppet.conf
	@sudo chown -R root:wheel ${WORK_D}/private/etc/puppet/puppet.conf

pack-r10kconf: l_private_etc
	@sudo ${CP} r10k.yaml ${WORK_D}/private/etc/r10k.yaml
	@sudo chown -R root:wheel ${WORK_D}/private/etc/r10k.yaml

pack-keys: l_private_etc
	@sudo mkdir -p ${WORK_D}/private/etc/puppet/keys
	@sudo ${CP} keys/* ${WORK_D}/private/etc/puppet/keys/
	@sudo chown -R puppet:puppet ${WORK_D}/private/etc/puppet/keys
	@sudo chmod -R 0500 ${WORK_D}/private/etc/puppet/keys
	@sudo chmod 0400 ${WORK_D}/private/etc/puppet/keys/private_key.pkcs7.pem
	@sudo chmod 0400 ${WORK_D}/private/etc/puppet/keys/public_key.pkcs7.pem  