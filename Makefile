# $FreeBSD$

PORTNAME=	cassandra
PORTVERSION=	3.11.1
CATEGORIES=	databases java
MASTER_SITES=	https://github.com/apache/cassandra/archive/
PKGNAMESUFFIX=	3
WRKSRC=         ${WRKDIR}/cassandra-${PORTNAME}-${PORTVERSION}
# DISTNAME=	apache-cassandra-${PORTVERSION}
# EXTRACT_SUFX=	-bin.tar.gz
# USE_GITHUB=     yes
# GH_ACCOUNT=     apache
# DISTVERSIONPREFIX= cassandra
# GH_TAGNAME=     cassandra-3.11.1

MAINTAINER=	polo.language@gmail.com
COMMENT=	A highly scalable second-generation distributed database, bringing together Dynamo\'s fully distributed design and Bigtable\'s ColumnFamily-based data model.
LICENSE=	APACHE20

JAVA_VERSION=	1.8
JAVA_VENDOR=	openjdk
# REINPLACE_ARGS=	-i ''
USE_JAVA=	yes
USE_ANT=        yes
# ALL_TARGET=     artifacts

OPTIONS_DEFINE= DOCS
PYTHON_PKGNAMEPREFIX= py27-
DOCS_USES=            python:2.7
DOCS_BUILD_DEPENDS=   ${PYTHON_PKGNAMEPREFIX}sphinx>0:textproc/py-sphinx@${FLAVOR} \
                      ${PYTHON_PKGNAMEPREFIX}sphinx_rtd_theme>0:textproc/py-sphinx_rtd_theme@${FLAVOR}

# USE_RC_SUBR=	cassandra  # TODO: Should be an 'install as daemon option'.

do-build-DOCS-on:
	cd ${WRKSRC} && ${ANT} -Dpycmd=${PYTHON_CMD} freebsd-stage-doc

do-build-DOCS-off:
	cd ${WRKSRC} && ${ANT} freebsd-stage

post-build:
	chmod 755 ${WRKSRC}/build/dist/bin/*
	chmod 644 ${WRKSRC}/build/dist/bin/*.in.sh
	chmod 755 ${WRKSRC}/build/dist/tools/bin/*

# May need this for do-install-DOCS-on:
# mkdir build/javadoc

.include <bsd.port.mk>
