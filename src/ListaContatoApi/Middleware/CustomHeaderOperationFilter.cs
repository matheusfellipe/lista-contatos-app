using Microsoft.OpenApi.Models;
using Swashbuckle.AspNetCore.SwaggerGen;

namespace ListaContatoApi.Middleware
{
    public class CustomHeaderOperationFilter : IOperationFilter
    {
        public void Apply(OpenApiOperation operation, OperationFilterContext context)
        {
            if (operation.Parameters == null)
            {
                operation.Parameters = new List<OpenApiParameter>();
            }

            operation.Parameters.Add(new OpenApiParameter
            {
                Name = "x-hash",
                In = ParameterLocation.Header,
                Required = true, // Specify whether the header is required
                Description = "Custom hash header",
                Schema = new OpenApiSchema
                {
                    Type = "string"
                }
            });
        }
    }
}
