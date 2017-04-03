FROM ditchitall/java:8

# Configuration variables.
ENV CROWD_INSTALL=/opt/atlassian/crowd \
    CROWD_HOME=/data/crowd \
    CROWD_VERSION=2.11.2 \
    BASE_ENTRYPOINT=/usr/local/bin/entrypoint.sh

# Install Atlassian Crowd and helper tools and setup initial home
# directory structure.
RUN set -x \
    && apt-get update \
    && apt-get install -y --no-install-recommends curl libtcnative-1 xmlstarlet \
    && apt-get clean \
    && mkdir -p                "${CROWD_INSTALL}" \
    && curl -Ls                "https://www.atlassian.com/software/crowd/downloads/binary/atlassian-crowd-${CROWD_VERSION}.tar.gz" | tar -xz --directory "${CROWD_INSTALL}" --strip-components=1 --no-same-owner \
    && echo -e                 "\ncrowd.home=${CROWD_HOME}" >> "${CROWD_INSTALL}/crowd-webapp/WEB-INF/classes/crowd-init.properties" \
    && touch -d "@0"           "${CROWD_INSTALL}/apache-tomcat/conf/server.xml" \
    && apt-get purge -y --auto-remove curl \
    && rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Set the default working directory as the installation directory.
WORKDIR ${CROWD_HOME}

# Create entrypoint
COPY docker-entrypoint.sh /usr/local/bin/crowd-entrypoint.sh
ENTRYPOINT ["/usr/local/bin/crowd-entrypoint.sh"]

# Run Atlassian CROWD as a foreground process by default.
CMD ["/opt/atlassian/crowd/apache-tomcat/bin/catalina.sh", "run"]