dotnet restore src/app
dotnet build src/app

dotnet restore tests/app.Tests
dotnet build tests/app.Tests
dotnet test tests/app.Tests
