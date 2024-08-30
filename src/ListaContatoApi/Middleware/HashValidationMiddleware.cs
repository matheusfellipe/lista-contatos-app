namespace ListaContatoApi.Middleware
{
    public class HashValidationMiddleware
    {
        private readonly RequestDelegate _next;
        private readonly IConfiguration _configuration;

        public HashValidationMiddleware(RequestDelegate next, IConfiguration configuration)
        {
            _next = next;
            _configuration = configuration;
        }

        public async Task InvokeAsync(HttpContext context)
        {
            if (!context.Request.Headers.ContainsKey("x-hash"))
            {
                context.Response.StatusCode = StatusCodes.Status401Unauthorized;
                await context.Response.WriteAsync("Missing x-hash header");
                return;
            }

            var providedHash = context.Request.Headers["x-hash"].ToString();
            if (!ValidateHash(providedHash))
            {
                context.Response.StatusCode = StatusCodes.Status401Unauthorized;
                await context.Response.WriteAsync("Invalid x-hash header value");
                return;
            }

            await _next(context);
        }

        private bool ValidateHash(string hashValue)
        {
            var expectedHash = _configuration.GetValue<string>("Hashinteg");
            return hashValue.Equals(expectedHash, StringComparison.OrdinalIgnoreCase);
        }
    }
}
