
### 3. 🐾 ClinicaVeterinaria/README.md
```markdown
# 🏥 Clínica Veterinária

**👨‍💻 Autor:** Mateus Oliveira Rafael - RA: 25001369  
**📅 Data:** Junho/2025  

## 📋 Descrição
Sistema completo para:
- 👨‍⚕️ Cadastro de tutores e animais
- 🩺 Histórico de consultas
- 💊 Controle de procedimentos

## 🛠 Tecnologias
- MySQL 5.7+
- Consultas JOIN
- Subconsultas

## 📊 Estatísticas
```sql
-- Média de gastos por animal
SELECT a.nome_m, AVG(c.valor_m) FROM animais_m a JOIN consultas_m c ON a.id_animal_m = c.id_animal_m GROUP BY a.nome_m;