FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build-env
WORKDIR /src
RUN git clone https://github.com/tomchavakis/nuget-license.git && \
    cd nuget-license && \
    git checkout v2.7.1

WORKDIR /src/nuget-license
RUN dotnet publish -o /src/publish -f net7.0 --runtime linux-x64 -c Release --self-contained true /p:InvariantGlobalization=true

FROM debian:bullseye-slim
WORKDIR /src
COPY --from=build-env /src/publish .
ENTRYPOINT ["/src/NugetUtility"]
CMD ["-h"]