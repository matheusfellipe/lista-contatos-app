using Infra.Dapper;
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


                options.AddPolicy(name: "ContatoPolicy",
                    builder =>
                    {
                        builder.WithOrigins("*")
                        .AllowAnyMethod()
                        .AllowAnyHeader()
                        .AllowCredentials()
                        .SetIsOriginAllowed(host => true);
                    });
            });


            services.AddSwaggerGen();
            services.AddFinders();
          
        }

        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            app.UseRouting();
            app.UseCors("ContatoPolicy");

            app.UseSwagger();
            app.UseSwaggerUI(sw =>
            {
                sw.SwaggerEndpoint("/swagger/v1/swagger.json", "Lista Contatos v1.0");
                sw.ConfigObject.DocExpansion = DocExpansion.None;
            });

            app.UseAuthorization();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllers();
            });
        }



    }
}
