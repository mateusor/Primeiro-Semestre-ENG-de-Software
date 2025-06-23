# Sistema de Sustentabilidade Pessoal

Este projeto é um sistema em Python que permite o registro diário de práticas sustentáveis, calculando índices de sustentabilidade e armazenando as informações em um banco de dados MySQL com segurança por meio de criptografia.

---

## 🔒 Funcionalidades

- Registro de dados diários sobre:
  - Consumo de água e energia elétrica
  - Geração de resíduos recicláveis e não recicláveis
  - Uso de meios de transporte
- Cálculo automático de:
  - Nível de sustentabilidade para água, energia, resíduos e transporte
  - Índice de sustentabilidade geral (PLR - percentual de lixo reciclado)
- Criptografia dos dados sensíveis usando `cryptography.Fernet`
- Menu interativo com opções para:
  - Inserir, alterar, excluir e listar registros
- Conexão com banco de dados `MySQL`

---

## 🗄️ Estrutura do Banco de Dados

O sistema utiliza a tabela `registro_diario` no banco `sustentabilidade`. Campos incluem dados ambientais, booleanos de transporte e níveis criptografados de sustentabilidade.

▶️ [Clique aqui para visualizar o script SQL](./criar_tabela_sustentabilidade.sql)

---

## 📂 Código-Fonte

O código Python principal do sistema pode ser acessado no link abaixo:

▶️ [Clique aqui para visualizar o código Python](./sustentabilidade.py)

---

## 📦 Tecnologias Utilizadas

- Python
- MySQL (via `mysql.connector`)
- Criptografia com `cryptography.fernet`
- Armazenamento local da chave de criptografia (`chave.key`)

---

## 🧪 Exemplo de Execução

```bash
1 - Inserir dados
2 - Alterar dados
3 - Excluir dados
4 - Listar registros e calcular médias
5 - Sair
```

---

## 👥 Integrantes

- **Mateus Oliveira Rafael**
- **Rafael Mendes Valente**
- **Tiago Medeiros Salgado**
- **Henrique Leite de Camargo**
- **Kauan Aurelio Lasmar Dias**
- **Rodrigo Gabi**

---

## ⚠️ Observações

- Certifique-se de que o banco MySQL está ativo e o banco `sustentabilidade` foi criado.
- Execute o script `.sql` de criação da tabela antes de rodar o sistema.
- A chave de criptografia é gerada automaticamente na primeira execução e salva como `chave.key`.

