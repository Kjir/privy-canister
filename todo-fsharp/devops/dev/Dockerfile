FROM microsoft/dotnet:2.1-sdk AS build
WORKDIR /app

# copy fsproj and restore as distinct layers
COPY *.sln .
COPY src/app/*.fsproj ./src/app/
COPY tests/app.Tests/*.fsproj ./tests/app.Tests/
RUN dotnet restore

# copy everything else and build app
COPY . .
WORKDIR /app/src/app
RUN dotnet build


FROM build AS testrunner
WORKDIR /app/tests
ENTRYPOINT ["dotnet", "test", "--logger:trx"]


FROM build AS test
WORKDIR /app/tests/app.Tests
RUN dotnet test


FROM build AS publish
WORKDIR /app/src/app
RUN dotnet publish -c Release -o out


FROM microsoft/dotnet:2.1-runtime AS runtime
WORKDIR /app
COPY --from=publish /app/src/app/out ./
ENTRYPOINT ["dotnet", "app.dll"]
