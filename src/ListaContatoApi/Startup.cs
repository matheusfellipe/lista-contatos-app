using Infra.Dapper;
using ListaContatoApi.Middleware;
using Swashbuckle.AspNetCore.SwaggerUI;
using System.Globalization;

namespace Web.Api
{
    public class Startup
    {
        public IConfiguration Configuration { get; }

        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public void ConfigureServices(IServiceCollection services)
        {
           

            services.AddControllers();
            
            services.AddCors(options =>
            {

                options.AddDefaultPolicy(builder =>
                {
                    builder.SetIsOriginAllowed(origin => new Uri(origin).Host == "localhost");
                });
               
            });


            services.AddSwaggerGen(c =>
            {
                c.OperationFilter<CustomHeaderOperationFilter>();
            });
            services.AddFinders();
          
        }

        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
            app.UseRouting();
            app.UseCors();

            app.UseSwagger();
            app.UseSwaggerUI(sw =>
            {
                sw.SwaggerEndpoint("/swagger/v1/swagger.json", "Lista Contatos v1.0");
                sw.ConfigObject.DocExpansion = DocExpansion.None;
            });

            app.UseMiddleware<HashValidationMiddleware>();
            app.UseAuthorization();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllers();
            });
        }



    }
}
