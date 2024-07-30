using CPObjects.Infrastructure.Finder;
using Microsoft.Extensions.DependencyInjection;
using System.Reflection;

namespace Infra.Dapper
{
    public static class ServiceCollectionExtensions
    {
        public static IServiceCollection AddFinders(this IServiceCollection services)
        {
            var types = Assembly.GetExecutingAssembly().GetTypes()
                .Where(t => t.BaseType == typeof(FinderBase))
                .ToDictionary(i => i.GetInterfaces().First(), t => t);

            foreach (var (service, implementation) in types)
            {
                services.AddTransient(service, implementation);
            }

            return services;
        }
    }
}
