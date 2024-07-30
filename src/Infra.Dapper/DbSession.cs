using Infrastructure.Core;
using Microsoft.Extensions.Configuration;
using System.Data.SqlClient;
using System.Data;
using Npgsql;

namespace Infra.Dapper
{
    public class DbSession : IDisposable
    {
        private Guid _id;
        public IDbConnection Connection { get; }

        IConfiguration _configuration;
        public DbSession(Guid id, IDbConnection connection, IConfiguration configuration)
        {
            _id = Guid.NewGuid();
            _configuration = configuration;
            Connection = new NpgsqlConnection(new DataProvider(configuration).PostgresDbContext);
            Connection.Open();
        }


        public void Dispose() => Connection?.Dispose();
    }
}
