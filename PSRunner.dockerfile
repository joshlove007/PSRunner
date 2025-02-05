# To enable ssh & remote debugging on app service change the base image to the one below
# FROM mcr.microsoft.com/azure-functions/powershell:4-powershell7.2-appservice
FROM mcr.microsoft.com/azure-functions/powershell:4-powershell7.2-appservice

ARG ConnectionString=DefaultEndpointsProtocol=http;AccountName=devstoreaccount1;AccountKey=Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw==;BlobEndpoint=http://127.0.0.1:10000/devstoreaccount1;QueueEndpoint=http://127.0.0.1:10001/devstoreaccount1;TableEndpoint=http://127.0.0.1:10002/devstoreaccount1

#Other Option Is 'Azure'
ARG StorageType=Azurite

ARG LogInvocations=true

ENV AzureWebJobsScriptRoot=/home/site/wwwroot \
    AzureFunctionsJobHost__Logging__Console__IsEnabled=true \
    AzureWebJobsStorage=${ConnectionString} \
    WEBSITE_CONTENTAZUREFILECONNECTIONSTRING=${ConnectionString} \
    WEBSITE_HOSTNAME=localhost:80 \
    ExternalDurablePowerShellSDK=true \
    AzureWebJobsDashboard=${ConnectionString} \
    LOG_PSRUNNER_INVOCATIONS=${LogInvocations} \
    STORAGE_TYPE=${StorageType} \
    CONNECTION_STRING=${ConnectionString} \
    WEBSITE_SITE_NAME=PSRunner

EXPOSE 2222 80

COPY . /home/site/wwwroot

RUN apt-get install -y wget apt-transport-https software-properties-common \
    && wget -q https://github.com/PowerShell/PowerShell/releases/download/v7.2.1/powershell-lts_7.2.1-1.deb_amd64.deb -O powershell-lts_7.2.1-1.deb_amd64.deb \
    && dpkg -i powershell-lts_7.2.1-1.deb_amd64.deb \
    && rm powershell-lts_7.2.1-1.deb_amd64.deb \
    && rm -rf /home/site/wwwroot/Modules \
    #&& rm -rf /home/site/wwwroot/PSRunnerStart \
    && mv /home/site/wwwroot/Linux/Modules /home/site/wwwroot/Modules \
    #&& mv /home/site/wwwroot/Linux/PSRunnerStart /home/site/wwwroot/PSRunnerStart \
    && rmdir /home/site/wwwroot/Linux
