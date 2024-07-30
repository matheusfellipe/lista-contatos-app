using Domain.Finders;
using Microsoft.AspNetCore.Mvc;

namespace ListaContatoApi.Controllers
{

    [ApiController]
    [Route("/api/Auth")]
    public class AuthController
    {
        private readonly ILogger<AuthController> _logger;
        private readonly IContatoFinder _contatoFinder;

        public AuthController(ILogger<AuthController> logger, IContatoFinder contatoFinder)
        {
            _logger = logger;
            _contatoFinder = contatoFinder;
        }


        [HttpPost("Login")]
        public async Task<string> GetUsuarioExistente([FromQuery] string cpf)
        {
            var flag = await _contatoFinder.ContatoExistente(cpf);
            if (flag == true) return "Autorizado";
            else return "Negado";

        }
    }
}
