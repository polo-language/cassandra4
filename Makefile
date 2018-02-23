# $FreeBSD$

PORTNAME=	cassandra
PORTVERSION=	3.11.1
CATEGORIES=	databases 
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
COMMENT=	TODO: Open source distributed database management system

LICENSE=	APACHE20

JAVA_VERSION=	1.8
JAVA_VENDOR=	openjdk
# REINPLACE_ARGS=	-i ''
USE_JAVA=	yes
USE_ANT=        yes
ALL_TARGET=     artifacts

OPTIONS_DEFINE= DOCS
PYTHON_PKGNAMEPREFIX= py27-
DOCS_USES=            python:2.7
DOCS_BUILD_DEPENDS=   ${PYTHON_PKGNAMEPREFIX}sphinx>0:textproc/py-sphinx@${FLAVOR} \
                      ${PYTHON_PKGNAMEPREFIX}sphinx_rtd_theme>0:textproc/py-sphinx_rtd_theme@${FLAVOR}

# USE_RC_SUBR=	cassandra  # TODO: Should be an 'install as daemon option'.

do-build:
	cd ${WRKSRC} && ${ANT} jar

do-build-DOCS-on:
	cd ${WRKSRC} && ${ANT} javadoc
	cd ${WRKSRC} && ${ANT} maven-ant-tasks-init
	cd ${WRKSRC}/doc && ${MAKE} html PYTHON_CMD=${PYTHON_CMD}

.include <bsd.port.mk>
