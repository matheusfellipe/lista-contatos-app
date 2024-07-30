
using CPObjects.Infrastructure.Finder;
using Dapper;
using Domain.Dto;
using Domain.Finders;
using Infrastructure.Core;
using Microsoft.Extensions.Configuration;
using System.Collections.Generic;


namespace Infra.Dapper.Finders
{
    public class GetContatoFinder : FinderBase, IContatoFinder
    {
        public GetContatoFinder(IConfiguration configuration) : base(new DataProvider(configuration).PostgresDbContext)
        {
        }

        public async Task<bool> ContatoExistente(string cpf)
        {
            const string QUERY = @"
			              select * from pessoa p where cpf = @cpf;";

            try
            {
                using var conn = CreateNpgsqlConnection();
                var results = await conn.QueryAsync<ContatoItemDto>(
                    QUERY,
                    new
                    {
                        @cpf
                    }
                    );

                if ( results.FirstOrDefault() != null ) {
                    return true;
                }

                else
                {
                    return false;
                }
               
            }
            catch (Exception ex)
            {

                throw new ArgumentNullException(ex.Message);
            }
        }

        public async Task<List<ContatoItemDto>> GetContatos(string? nome,string? sigla,string? order)
        {
             string QUERY = @"
			               select p.*,l.departamento,l.sigla  from pessoa p 
                                inner join lotacao l on p.id_lotacao = l.id_lotacao 
                                WHERE 1=1";



            if (!string.IsNullOrEmpty(nome))
            {
                QUERY += " AND p.nome like @nome";
            }


            if (!string.IsNullOrEmpty(sigla))
            {
                
                QUERY += " AND l.sigla = @sigla";
            }

            if (order!= null)
            {
                QUERY += "AND p.nome LIKE @order";
            }

            try
            {
                using var conn = CreateNpgsqlConnection();
                var parameters = new DynamicParameters();

                parameters.Add("@nome", $"%{nome}%");
                parameters.Add("@sigla", sigla);
                parameters.Add("@order", $"{order}%");

                var results = await conn.QueryAsync<ContatoItemDto>(
                    QUERY, parameters
                    );

                return results.ToList();
            }
            catch (Exception ex)
            {

                throw new ArgumentNullException(ex.Message);
            }
        }

        public async Task<List<LotacaoItemDto>> ListaDepartamento()
        {
            const string QUERY = @"
			              select l.sigla,l.departamento  from lotacao l;";

            try
            {
                using var conn = CreateNpgsqlConnection();
                var results = await conn.QueryAsync<LotacaoItemDto>(
                    QUERY
                    );

                return results.ToList();

            }
            catch (Exception ex)
            {

                throw new ArgumentNullException(ex.Message);
            }
        }
    }
}
