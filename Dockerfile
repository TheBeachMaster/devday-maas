FROM ppatierno/qpid-proton:0.17.0
WORKDIR /
COPY client.py forever_recv.py server.py simple_send.py /
