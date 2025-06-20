# 🚗 Sistema de Loja de Carros

**👨‍💻 Autor:** Mateus Oliveira Rafael - RA: 25001369  
**📅 Data:** Junho/2025  

## 📋 Descrição
Sistema completo para gestão de concessionária de veículos com:
- ✨ Cadastro de clientes (CPF, contato, endereço)
- 🚘 Controle de estoque (modelo, marca, status de venda)
- 💰 Registro de transações comerciais

## 🛠 Tecnologias
- MySQL 8.0
- SQL (DDL, DML, DQL)
- MySQL Workbench

## 🏗️ Estrutura do Banco
```mermaid
erDiagram
    CLIENTES ||--o{ VENDAS : realiza
    VEICULOS ||--o{ VENDAS : referente