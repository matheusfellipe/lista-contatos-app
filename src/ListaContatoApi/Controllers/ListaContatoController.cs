using Domain.Dto;
using Domain.Finders;
using Microsoft.AspNetCore.Mvc;

namespace ListaContatoApi.Controllers
{
    [ApiController]
    [Route("/api/Contatos")]
    public class ListaContatoController : ControllerBase
    {
      

        private readonly ILogger<ListaContatoController> _logger;
        private readonly IContatoFinder _contatoFinder;

        public ListaContatoController(ILogger<ListaContatoController> logger, IContatoFinder contatoFinder)
        {
            _logger = logger;
            _contatoFinder = contatoFinder;
        }

        [HttpGet("GetListaContatos")]
        public Task<List<ContatoItemDto>> Get([FromQuery] string? nome, [FromQuery] string? sigla, [FromQuery] string? order)
        {
            return _contatoFinder.GetContatos(nome, sigla?.ToUpper(), order);
        }


       

    }
}
