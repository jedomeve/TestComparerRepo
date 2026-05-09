# Etapa 1: Build
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src

COPY *.csproj .
RUN dotnet restore

COPY . .
RUN dotnet publish -c Release -o /app/publish

# Etapa 2: Runtime (imagen más liviana)
FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS runtime
WORKDIR /app

COPY --from=build /app/publish .

EXPOSE 8083
ENV ASPNETCORE_URLS=http://+:8083

ENTRYPOINT ["dotnet", "TestComparerApi.dll"]