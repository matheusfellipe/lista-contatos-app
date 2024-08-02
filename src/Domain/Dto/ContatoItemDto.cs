using System.Text.Json.Serialization;

namespace Domain.Dto
{
    public class ContatoItemDto
    {

        [JsonPropertyName("id_pessoa")]
        public long IdPessoa { get; set; }

        [JsonPropertyName("cpf")]
        public string Cpf { get; set; }

        [JsonPropertyName("nome")]
        public string Nome { get; set; }

        [JsonPropertyName("dt_nascimento")]
        public DateTimeOffset DtNascimento { get; set; }

        [JsonPropertyName("telefone")]
        public string Telefone { get; set; }

        [JsonPropertyName("id_lotacao")]
        public long IdLotacao { get; set; }

        [JsonPropertyName("departamento")]
        public string Departamento { get; set; }

        [JsonPropertyName("sigla")]
        public string Sigla { get; set; }
    }
}
