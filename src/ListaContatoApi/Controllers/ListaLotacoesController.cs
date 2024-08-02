using Domain.Dto;
using Domain.Finders;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace ListaContatoApi.Controllers
{
    [Route("api/Lotacoes")]
    [ApiController]
    public class ListaLotacoesController : ControllerBase
    {

        private readonly ILogger<ListaLotacoesController> _logger;


        private readonly IContatoFinder _contatoFinder;

        public ListaLotacoesController(ILogger<ListaLotacoesController> logger, IContatoFinder contatoFinder)
        {
            _logger = logger;
            _contatoFinder = contatoFinder;
        }

        [HttpGet("GetListaLotacoes")]
        public Task<List<LotacaoItemDto>> GetLotacoes()
        {
            return _contatoFinder.ListaDepartamento();
        }

    }
}
