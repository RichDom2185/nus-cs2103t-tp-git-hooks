FROM --platform=linux/amd64 azul/zulu-openjdk:11

RUN apt-get update
RUN apt install -y wget unzip curl bash jq
RUN mkdir -p /usr/bin

RUN cd /usr/bin \
      && export PMD_URL=$(curl --silent https://api.github.com/repos/pmd/pmd/releases/latest | jq '.assets[] | select(.name | contains("pmd-bin-") and contains(".zip")) | .browser_download_url' | sed -e 's/^"//' -e 's/"$//') \
      && wget -nc -O pmd.zip ${PMD_URL} \
      && unzip pmd.zip \
      && rm pmd.zip \
      && mv pmd-bin* pmd

RUN cd /usr/bin \
      && export CS_URL=$(curl --silent https://api.github.com/repos/checkstyle/checkstyle/releases/latest | jq '.assets[] | select(.name | contains("checkstyle-") and contains(".jar")) | .browser_download_url' | sed -e 's/^"//' -e 's/"$//') \
      && wget -nc -O checkstyle.jar ${CS_URL}

COPY run_cpd.sh /usr/bin
COPY check-no-tabs.sh /usr/bin
COPY check-eof-newline.sh /usr/bin
COPY check-trailing-whitespace.sh /usr/bin
COPY run_checkstyle.sh /usr/bin
