FROM openfrontier/gerrit

ENV GERRIT_INIT_ARGS='--install-plugin=replication --install-plugin=download-commands'

COPY wait-for-it.sh /

# Replication config
COPY replication/replication.config ${GERRIT_SITE}/etc/

COPY replication/ssh ${GERRIT_HOME}/.ssh

# VOLUME ${GERRIT_HOME}/.ssh/id_rsa


ENTRYPOINT ["/wait-for-it.sh", "db:5432", "--", "/gerrit-entrypoint.sh"]

CMD ["/gerrit-start.sh"]
