using Domain.Dto;

namespace Domain.Finders
{
    public interface IContatoFinder
    {
        Task<List<ContatoItemDto>> GetContatos(string? nome, string? sigla,string? order);

        Task<bool> ContatoExistente(string cpf);

        Task<List<LotacaoItemDto>> ListaDepartamento();
    }
}

