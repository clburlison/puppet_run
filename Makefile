USE_PKGBUILD=1
include /usr/local/share/luggage/luggage.make

TITLE=puppet_run
PACKAGE_NAME=${TITLE}
REVERSE_DOMAIN=com.grahamgilbert
PACKAGE_VERSION=1.7.4
PAYLOAD=\
	pack-Library-Management-bin-puppet_run.py \
	pack-Library-LaunchDaemons-com.grahamgilbert.puppet_run.plist \
	pack-puppetconf \
	pack-r10kconf

pack-puppetconf: l_private_etc
	@sudo mkdir -p ${WORK_D}/private/etc/puppet/
	@sudo ${CP} puppet.conf ${WORK_D}/private/etc/puppet/puppet.conf
	@sudo chown -R root:wheel ${WORK_D}/private/etc/puppet/puppet.conf

pack-r10kconf: l_private_etc
	@sudo ${CP} r10k.yaml ${WORK_D}/private/etc/r10k.yaml
	@sudo chown -R root:wheel ${WORK_D}/private/etc/r10k.yaml