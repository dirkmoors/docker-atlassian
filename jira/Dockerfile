FROM ditchitall/java:8

# Configuration variables.
ENV JIRA_INSTALL=/opt/atlassian/jira \
    JIRA_HOME=/data/jira \
    JIRA_VERSION=7.3.1 \
    BASE_ENTRYPOINT=/usr/local/bin/entrypoint.sh

# Install Atlassian JIRA and helper tools and setup initial home
# directory structure.
RUN set -x \
    && apt-get update \
    && apt-get install -y --no-install-recommends curl libtcnative-1 xmlstarlet \
    && apt-get clean \
    && mkdir -p                "${JIRA_HOME}" \
    && mkdir -p                "${JIRA_HOME}/caches/indexes" \
    && mkdir -p                "${JIRA_INSTALL}/conf/Catalina" \
    && curl -Ls                "https://www.atlassian.com/software/jira/downloads/binary/atlassian-jira-software-${JIRA_VERSION}.tar.gz" | tar -xz --directory "${JIRA_INSTALL}" --strip-components=1 --no-same-owner \
    && echo -e                 "\njira.home=$JIRA_HOME" >> "${JIRA_INSTALL}/atlassian-jira/WEB-INF/classes/jira-application.properties" \
    && touch -d "@0"           "${JIRA_INSTALL}/conf/server.xml" \
    && apt-get purge -y --auto-remove curl \
    && rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Set the default working directory as the installation directory.
WORKDIR ${JIRA_HOME}

# Create entrypoint
COPY docker-entrypoint.sh /usr/local/bin/jira-entrypoint.sh
ENTRYPOINT ["/usr/local/bin/jira-entrypoint.sh"]

# Run Atlassian JIRA as a foreground process by default.
CMD ["/opt/atlassian/jira/bin/catalina.sh", "run"]