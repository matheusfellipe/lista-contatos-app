using Microsoft.Extensions.Configuration;

namespace Infrastructure.Core
{
    public class DataProvider
    {
        public string PostgresDbContext { get; set; }

        public DataProvider(IConfiguration configuration)
        {
            PostgresDbContext = configuration.GetSection("ConnectionStrings:postgres").Value;
        }
    }
}
