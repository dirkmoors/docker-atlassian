FROM ditchitall/java:8

# Configuration variables.
ENV BAMBOO_INSTALL=/opt/atlassian/bamboo \
    BAMBOO_HOME=/data/bamboo \
    BAMBOO_VERSION=5.15.5 \
    BASE_ENTRYPOINT=/usr/local/bin/entrypoint.sh

# Install Atlassian Bamboo and helper tools and setup initial home
# directory structure.
RUN set -x \
    && apt-get update --quiet \
    && apt-get install --quiet --yes --no-install-recommends libtcnative-1 git-core xmlstarlet \
    && apt-get clean \
    && mkdir -p               "${BAMBOO_HOME}/lib" \
    && mkdir -p               "${BAMBOO_INSTALL}" \
    && curl -Ls               "https://www.atlassian.com/software/bamboo/downloads/binary/atlassian-bamboo-${BAMBOO_VERSION}.tar.gz" | tar -zx --directory  "${BAMBOO_INSTALL}" --strip-components=1 --no-same-owner \
    && curl -Ls                "https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.38.tar.gz" | tar -xz --directory "${BAMBOO_INSTALL}/lib" --strip-components=1 --no-same-owner "mysql-connector-java-5.1.38/mysql-connector-java-5.1.38-bin.jar" \
    && sed --in-place         's/^# umask 0027$/umask 0027/g' "${BAMBOO_INSTALL}/bin/setenv.sh" \
    && xmlstarlet             ed --inplace \
        --delete              "Server/Service/Engine/Host/@xmlValidation" \
        --delete              "Server/Service/Engine/Host/@xmlNamespaceAware" \
                              "${BAMBOO_INSTALL}/conf/server.xml" \
    && touch -d "@0"          "${BAMBOO_INSTALL}/conf/server.xml"

# Set the default working directory as the Bamboo home directory.
WORKDIR ${BAMBOO_HOME}

COPY docker-entrypoint.sh /usr/local/bin/bamboo-entrypoint.sh
ENTRYPOINT ["/usr/local/bin/bamboo-entrypoint.sh"]

# Run Atlassian Bamboo as a foreground process by default.
CMD ["/opt/atlassian/bamboo/bin/start-bamboo.sh", "-fg"]