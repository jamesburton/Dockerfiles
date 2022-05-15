#FROM amazonlinux:latest
FROM public.ecr.aws/amazonlinux/amazonlinux:2022

# Install required tools in a chain for a single layer
RUN rpm -Uvh https://packages.microsoft.com/config/centos/7/packages-microsoft-prod.rpm \
 && yum update -y \
 && yum install -y curl git nano less wget unzip \
 && yum install -y dotnet-sdk-6.0 \
 && dotnet --version \
 && mkdir -p /opt/dotnet/tools && chmod +r /opt/dotnet \
 && chmod -R +rx /opt/dotnet/tools \
 && dotnet tool install Amazon.Lambda.Tools --tool-path /opt/dotnet/tools \
 && dotnet tool install Amazon.Lambda.TestTool-6.0 --tool-path /opt/dotnet/tools \
 && yum install -y nodejs npm \
 && node --version \
 && npm --version \
 && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o awscliv2.zip \
 && unzip awscliv2.zip \
 && ./aws/install \
 && wget https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-linux-x86_64.zip \
 && unzip aws-sam-cli-linux-x86_64.zip -d sam-installation \
 && ./sam-installation/install \
 && sam --version
ENV PATH=${PATH}:/opt/dotnet/tools
