USE_PKGBUILD=1
include /usr/local/share/luggage/luggage.make

TITLE=puppet_run
PACKAGE_NAME=${TITLE}
REVERSE_DOMAIN=com.clburlison
PACKAGE_VERSION=1.7.5
PAYLOAD=\
	pack-puppet_run \
	pack-Library-LaunchDaemons-com.clburlison.puppet_run.plist \
	pack-puppetconf \
	pack-r10kconf

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