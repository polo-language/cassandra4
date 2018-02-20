# $FreeBSD$

PORTNAME=	cassandra
PORTVERSION=	3.11.1
CATEGORIES=	databases 
MASTER_SITES=	https://github.com/apache/cassandra/archive/
PKGNAMESUFFIX=	3
# DISTNAME=	apache-cassandra-${PORTVERSION}
# EXTRACT_SUFX=	-bin.tar.gz
# USE_GITHUB=     yes
# GH_ACCOUNT=     apache
# DISTVERSIONPREFIX= cassandra
# GH_TAGNAME=     cassandra-3.11.1

MAINTAINER=	language.devel@gmail.com
COMMENT=	TODO: Open source distributed database management system

LICENSE=	APACHE20

JAVA_VERSION=	1.8
JAVA_VENDOR=	openjdk
# REINPLACE_ARGS=	-i ''
USE_JAVA=	yes
USE_ANT=        yes
# USE_RC_SUBR=	cassandra  # TODO: Should be an 'install as daemon option'.

.include <bsd.port.mk>
