# $FreeBSD$

PORTNAME=	cassandra
PORTVERSION=	3.11.2
CATEGORIES=	databases java
MASTER_SITES=	APACHE/cassandra/${PORTVERSION}
PKGNAMESUFFIX=	3
DISTNAME=	apache-${PORTNAME}-${PORTVERSION}-src

MAINTAINER=	language.devel@gmail.com
COMMENT=	Highly scalable distributed database

LICENSE=	APACHE20

RUN_DEPENDS=		snappyjava>=0:archivers/snappy-java

OPTIONS_DEFINE=		DOCS SIGAR
OPTIONS_DEFAULT=	SIGAR
OPTIONS_SUB=		yes
PYTHON_PKGNAMEPREFIX=	py27-
USES=			python:2.7
DOCS_BUILD_DEPENDS=	${PYTHON_PKGNAMEPREFIX}sphinx>0:textproc/py-sphinx \
			${PYTHON_PKGNAMEPREFIX}sphinx_rtd_theme>0:textproc/py-sphinx_rtd_theme
PORTDOCS=		*
SIGAR_RUN_DEPENDS=	java-sigar>=1.6.4:java/sigar
SIGAR_DESC=		Use SIGAR to collect system information
PLIST_SUB=		PORTVERSION=${PORTVERSION}

JAVA_VERSION=	1.8
JAVA_VENDOR=	openjdk
USE_JAVA=	yes
USE_ANT=	yes
REINPLACE_ARGS=	-i ''

DATADIR=	${JAVASHAREDIR}/${PORTNAME}
DIST_DIR=	${WRKSRC}/build/dist

CONFIG_FILES=	cassandra-env.sh \
		cassandra-jaas.config \
		cassandra-rackdc.properties \
		cassandra-topology.properties \
		cassandra.yaml \
		commitlog_archiving.properties \
		hotspot_compiler \
		jvm.options \
		logback-tools.xml \
		logback.xml

SCRIPT_FILES=	cassandra \
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
.for f in ${SCRIPT_FILES}
	${REINPLACE_CMD} -e 's|/usr/share/cassandra|${DATADIR}/bin|' ${DIST_DIR}/bin/${f}
.endfor
	${REINPLACE_CMD} -e 's|\`dirname "\$$\0"\`/..|${DATADIR}|' ${DIST_DIR}/bin/cassandra.in.sh
	${REINPLACE_CMD} -e 's|\$$\CASSANDRA_HOME/lib/sigar-bin|${JAVAJARDIR}|' ${DIST_DIR}/bin/cassandra.in.sh
	${REINPLACE_CMD} -e 's|\$$\CASSANDRA_HOME/lib/sigar-bin|${JAVAJARDIR}|' ${DIST_DIR}/conf/cassandra-env.sh
	${REINPLACE_CMD} -e 's|\$$\CASSANDRA_HOME/conf|${ETCDIR}|' ${DIST_DIR}/bin/cassandra.in.sh
	${REINPLACE_CMD} -e 's|\$$\CASSANDRA_HOME/conf|${ETCDIR}|' ${DIST_DIR}/conf/cassandra-env.sh
.for f in ${CONFIG_FILES}
	${MV} ${DIST_DIR}/conf/${f} ${DIST_DIR}/conf/${f}.sample
.endfor

do-install:
	${MKDIR} ${STAGEDIR}${DATADIR}
.for f in CHANGES LICENSE NEWS NOTICE
	cd ${DIST_DIR} && ${INSTALL_DATA} ${f}.txt ${STAGEDIR}${DATADIR}/
.endfor
.for d in interface lib pylib tools
	cd ${DIST_DIR} && ${COPYTREE_SHARE} ${d} ${STAGEDIR}${DATADIR}/ "! -path '*/bin/*'"
.endfor
	${MKDIR} ${STAGEDIR}${ETCDIR}
	cd ${DIST_DIR}/conf && ${COPYTREE_SHARE} . ${STAGEDIR}${ETCDIR}/
	cd ${DIST_DIR} && ${COPYTREE_BIN} bin ${STAGEDIR}${DATADIR}
	cd ${DIST_DIR} && ${INSTALL_DATA} bin/cassandra.in.sh ${STAGEDIR}${DATADIR}/bin/
	cd ${DIST_DIR} && ${COPYTREE_BIN} tools/bin ${STAGEDIR}${DATADIR}/tools
	cd ${DIST_DIR} && ${INSTALL_DATA} tools/bin/cassandra.in.sh ${STAGEDIR}${DATADIR}/tools/bin/
.for f in ${SCRIPT_FILES}
	${RLN} ${STAGEDIR}${DATADIR}/bin/${f} ${STAGEDIR}${PREFIX}/bin/${f}
.endfor
	${LN} -s ${JAVAJARDIR}/snappy-java.jar ${STAGEDIR}${DATADIR}/lib/snappy-java.jar

post-install-DOCS-on:
	${MKDIR} ${STAGEDIR}${DOCSDIR}
.for d in doc javadoc
	cd ${DIST_DIR} && ${COPYTREE_SHARE} ${d} ${STAGEDIR}${DOCSDIR}/
.endfor

post-install-SIGAR-on:
	${LN} -s ${JAVAJARDIR}/sigar.jar ${STAGEDIR}${DATADIR}/lib/sigar.jar

.include <bsd.port.mk>
