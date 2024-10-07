# Use uma imagem base que já tenha o Java instalado
FROM openjdk:11-jdk

# Crie um usuário dedicado para o SonarQube
RUN useradd -ms /bin/bash sonar

# Instale utilitários necessários e faça o download do SonarQube
RUN apt-get update && apt-get install -y wget unzip \
    && wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.1.0.47736.zip \
    && unzip sonarqube-9.1.0.47736.zip -d /opt/ \
    && mv /opt/sonarqube-9.1.0.47736 /opt/sonarqube \
    && chown -R sonar:sonar /opt/sonarqube \
    && rm sonarqube-9.1.0.47736.zip

# Instale o SonarScanner
RUN wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.6.2.2472-linux.zip \
    && unzip sonar-scanner-cli-4.6.2.2472-linux.zip -d /opt/ \
    && mv /opt/sonar-scanner-4.6.2.2472-linux /opt/sonar-scanner \
    && chown -R sonar:sonar /opt/sonar-scanner \
    && echo 'export PATH=$PATH:/opt/sonar-scanner/bin' >> /etc/profile

# Instale o Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_14.x | bash - \
    && apt-get install -y nodejs

# Configure o serviço do SonarQube
COPY sonar.service /etc/systemd/system/sonar.service

# Defina as permissões para o usuário sonar
RUN chown -R sonar:sonar /opt/sonarqube

# Mude o usuário para sonar antes de executar
USER sonar

# Configurações de memória do Elasticsearch
ENV ES_JAVA_OPTS="-Xms512m -Xmx512m"

# Exponha a porta usada pelo SonarQube
EXPOSE 9000

# Inicie o serviço do SonarQube
CMD ["/opt/sonarqube/bin/linux-x86-64/sonar.sh", "console"]
