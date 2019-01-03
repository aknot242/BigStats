#!/bin/bash
VERSION=$(echo $TRAVIS_TAG | cut -c 2-)
TMP_JOB_NUM=$(echo ${TRAVIS_JOB_NUMBER} | tr -d .)
RELEASE=$(printf "%04d\n" ${TMP_JOB_NUM})
RPM_NAME=BigStats-${VERSION}-${RELEASE}.noarch.rpm
rm -rf node_modules
npm install --production
rpmbuild -bb --define "main $(pwd)" --define '_topdir %{main}/build/rpmbuild' --define "_version ${VERSION}" --define "_release ${RELEASE}" build/bigstats.spec
pushd build/rpmbuild/RPMS/noarch
sha256sum ${RPM_NAME} > ${RPM_NAME}.sha256
popd