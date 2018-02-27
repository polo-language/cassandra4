# $FreeBSD$

PORTNAME=	cassandra
PORTVERSION=	3.11.1
CATEGORIES=	databases java
MASTER_SITES=	https://github.com/apache/cassandra/archive/
PKGNAMESUFFIX=	3
WRKSRC=         ${WRKDIR}/cassandra-${PORTNAME}-${PORTVERSION}

MAINTAINER=	polo.language@gmail.com
COMMENT=	A highly scalable second-generation distributed database, bringing together Dynamo\'s fully distributed design and Bigtable\'s ColumnFamily-based data model.
LICENSE=	APACHE20

JAVA_VERSION=	1.8
JAVA_VENDOR=	openjdk
USE_JAVA=	yes
USE_ANT=        yes

OPTIONS_DEFINE= DOCS
PYTHON_PKGNAMEPREFIX= py27-
USES=            python:2.7
DOCS_BUILD_DEPENDS=   ${PYTHON_PKGNAMEPREFIX}sphinx>0:textproc/py-sphinx \
                      ${PYTHON_PKGNAMEPREFIX}sphinx_rtd_theme>0:textproc/py-sphinx_rtd_theme
PORTDOCS=       *

DATADIR=        ${JAVASHAREDIR}/${PORTNAME}
DIST_DIR=       ${WRKSRC}/build/dist

CONFIG_FILES=   cassandra-env.sh \
		cassandra-jaas.config \
		cassandra-rackdc.properties \
		cassandra-topology.properties \
		cassandra.yaml \
		commitlog_archiving.properties \
		hotspot_compiler \
		jvm.options \
		logback-tools.xml \
		logback.xml

SCRIPT_FILES=   cassandra \
		cqlsh \
		nodetool \
		sstableloader \
		sstablescrub \
		sstableupgrade \
		sstableutil \
		sstableverify

do-build-DOCS-on:
	cd ${WRKSRC} && ${ANT} -Dpycmd=${PYTHON_CMD} freebsd-stage-doc

do-build-DOCS-off:
	cd ${WRKSRC} && ${ANT} freebsd-stage

post-build:
.for f in ${CONFIG_FILES}
	${MV} ${DIST_DIR}/conf/${f} ${DIST_DIR}/conf/${f}.sample
.endfor
	# @chmod 755 ${WRKSRC}/build/dist/bin/*
	# @chmod 644 ${WRKSRC}/build/dist/bin/*.in.sh
	# @chmod 755 ${WRKSRC}/build/dist/tools/bin/*

do-install:
.for d in interface lib pylib tools
        cd ${DIST_DIR} && ${COPYTREE_SHARE} ${d} ${STAGEDIR}${DATADIR}/ "! -path '*/bin/*'"
.endfor
	# cd ${DIST_DIR} && ${COPYTREE_SHARE} . ${STAGEDIR}${DATADIR} "! \( -path '*/bin/*' -o -name bin \)"
	${MKDIR} ${STAGEDIR}${DATADIR}/bin
	cd ${DIST_DIR} && ${COPYTREE_BIN} bin/* ${STAGEDIR}${DATADIR}/bin "! -name *.in.sh"
	cd ${DIST_DIR} && ${INSTALL_DATA} bin/*.in.sh ${STAGEDIR}${DATADIR}/bin
	${MKDIR} ${STAGEDIR}${DATADIR}/tools/bin
	cd ${DIST_DIR} && ${COPYTREE_BIN} tools/bin/* ${STAGEDIR}${DATADIR}/tools/bin "! -name *.in.sh"
	cd ${DIST_DIR} && ${INSTALL_DATA} tools/bin/*.in.sh ${STAGEDIR}${DATADIR}/tools/bin
.for f in ${SCRIPT_FILES}
	${LN} -sf ${STAGEDIR}${DATADIR}/bin/${f} ${STAGEDIR}${PREFIX}/bin/${f}
.endfor

post-install-DOCS-on:
	${MKDIR} ${STAGEDIR}${DOCSDIR}
.for d in doc javadoc
	cd ${DIST_DIR} && ${COPYTREE_SHARE} ${d} ${STAGEDIR}${DOCSDIR}/
.endfor

.include <bsd.port.mk>
