# syntax=docker/dockerfile:1
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
USER ubuntu
WORKDIR /home/ubuntu/harbor
COPY *.csproj ./
RUN dotnet restore
COPY --chown=ubuntu:ubuntu . ./
RUN dotnet publish -c Release --no-restore

FROM mcr.microsoft.com/dotnet/runtime:10.0 AS runtime
USER ubuntu
WORKDIR /home/ubuntu/harbor
COPY --chown=ubuntu:ubuntu --from=build /home/ubuntu/harbor/bin/Release/net10.0/ .
ENTRYPOINT ["dotnet", "harbor.dll"]
