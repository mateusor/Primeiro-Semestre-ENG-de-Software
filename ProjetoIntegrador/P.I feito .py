import mysql.connector
from cryptography.fernet import Fernet
import os

def gerar_chave():
    chave = Fernet.generate_key()
    with open("chave.key", "wb") as chave_arquivo:
        chave_arquivo.write(chave)
    print("Chave de criptografia gerada com sucesso!")

def carregar_chave():
    if not os.path.exists("chave.key"):
        gerar_chave()
    return open("chave.key", "rb").read()


def criptografar_dado(dado: str) -> bytes:
    chave = carregar_chave()
    f = Fernet(chave)
    dado_criptografado = f.encrypt(dado.encode())
    return dado_criptografado

def descriptografar_dado(dado_criptografado: bytes) -> str:
    chave = carregar_chave()
    f = Fernet(chave)
    dado_descriptografado = f.decrypt(dado_criptografado).decode()
    return dado_descriptografado

def calcular_niveis_sustentabilidade(agua, energia, residuos_nao_reciclaveis, residuos_reciclaveis, transporte):
    if agua <= 50:
        nivel_agua = "Alta Sustentabilidade"
    elif agua <= 100:
        nivel_agua = "Moderada Sustentabilidade"
    else:
        nivel_agua = "Baixa Sustentabilidade"
    
    if energia <= 5:
        nivel_energia = "Alta Sustentabilidade"
    elif energia <= 10:
        nivel_energia = "Moderada Sustentabilidade"
    else:
        nivel_energia = "Baixa Sustentabilidade"

    total_residuos = residuos_nao_reciclaveis + residuos_reciclaveis
    plr = (residuos_reciclaveis * 100) / total_residuos if total_residuos > 0 else 0

    if plr >= 70:
        nivel_residuos = "Alta Sustentabilidade"
    elif plr >= 40:
        nivel_residuos = "Moderada Sustentabilidade"
    else:
        nivel_residuos = "Baixa Sustentabilidade"

    usou_sustentavel = transporte['publico'] or transporte['bicicleta'] or transporte['caminhada'] or transporte['eletrico']
    usou_fosseis = transporte['combustivel'] or transporte['carona']

    if usou_sustentavel and not usou_fosseis:
        nivel_transporte = "Alta Sustentabilidade"
    elif usou_sustentavel and usou_fosseis:
        nivel_transporte = "Moderada Sustentabilidade"
    else:
        nivel_transporte = "Baixa Sustentabilidade"

    return {
        'nivel_agua': nivel_agua,
        'nivel_energia': nivel_energia,
        'nivel_residuos': nivel_residuos,
        'nivel_transporte': nivel_transporte,
        'plr': plr
    }

def listar_registros():
    conexao = mysql.connector.connect(
        host='localhost',
        user='root',
        password='310107',
        database='sustentabilidade'
    )
    cursor = conexao.cursor()

    cursor.execute("SELECT * FROM registro_diario")
    registros = cursor.fetchall()

    print("\n=== REGISTROS ===")
    for registro in registros:
        agua = float(registro[2])
        energia = float(registro[3])
        residuos_nao_reciclaveis = float(registro[4])
        residuos_reciclaveis = float(registro[5])

        nivel_agua = descriptografar_dado(registro[12])
        nivel_energia = descriptografar_dado(registro[13])
        nivel_residuos = descriptografar_dado(registro[14])
        nivel_transporte = descriptografar_dado(registro[15])

        print(f"\nID: {registro[0]}")
        print(f"Data: {registro[1]}")
        print(f"Água: {agua} litros - Nível: {nivel_agua}")
        print(f"Energia: {energia} kWh - Nível: {nivel_energia}")
        print(f"Resíduos não recicláveis: {residuos_nao_reciclaveis} kg")
        print(f"Resíduos recicláveis: {residuos_reciclaveis} kg - Nível: {nivel_residuos}")
        print(f"Transporte - Nível: {nivel_transporte}")
        print(f"Índice de Reciclagem (PLR): {registro[16]:.2f}%")

    cursor.close()
    conexao.close()

while True:
    print("\n=== MENU PRINCIPAL ===")
    print("1 - Inserir dados")
    print("2 - Alterar dados")
    print("3 - Excluir dados")
    print("4 - Listar registros e calcular médias")
    print("5 - Sair")

    opcao = input("Escolha uma opção: ")

    if opcao == '1':
        data = input("Digite a data do dia de hoje (AAAA-MM-DD): ")

        A = float(input("Digite quantos litros de Água você consumiu hoje: "))
        E = float(input("Digite quantos kWh de Energia Elétrica você consumiu hoje: "))
        LT = float(input("Digite os kgs de Resíduos Não Recicláveis que você gerou hoje: "))
        LR = float(input("Digite os kgs de Resíduos Recicláveis que você gerou hoje: "))

        print("\nResponda com S (Sim) ou N (Não):")

        transporte_publico = input("Você usou Transporte Público (S/N): ").upper() == 'S'
        bicicleta = input("Você usou Bicicleta (S/N): ").upper() == 'S'
        caminhada = input("Você fez Caminhada (S/N): ").upper() == 'S'
        carro_combustivel = input("Você usou Carro/moto a Combustível Fóssil (S/N): ").upper() == 'S'
        carro_eletrico = input("Você usou Carro/moto Elétrico (S/N): ").upper() == 'S'
        carona = input("Você usou Carona Compartilhada (S/N): ").upper() == 'S'

        niveis = calcular_niveis_sustentabilidade(
            A, E, LT, LR,
            {
                'publico': transporte_publico,
                'bicicleta': bicicleta,
                'caminhada': caminhada,
                'eletrico': carro_eletrico,
                'combustivel': carro_combustivel,
                'carona': carona
            }
        )

        nivel_agua_crip = criptografar_dado(niveis['nivel_agua'])
        nivel_energia_crip = criptografar_dado(niveis['nivel_energia'])
        nivel_residuos_crip = criptografar_dado(niveis['nivel_residuos'])
        nivel_transporte_crip = criptografar_dado(niveis['nivel_transporte'])

        conexao = mysql.connector.connect(
            host='localhost',
            user='root',
            password='310107',
            database='sustentabilidade'
        )
        cursor = conexao.cursor()

        sql = """
        INSERT INTO registro_diario (
            data, agua, energia, residuos_nao_reciclaveis, residuos_reciclaveis,
            transporte_publico, bicicleta, caminhada, carro_combustivel, carro_eletrico, carona,
            nivel_agua, nivel_energia, nivel_residuos, nivel_transporte, indice_sustentabilidade
        ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """
        valores = (
            data, A, E, LT, LR,
            transporte_publico, bicicleta, caminhada, carro_combustivel, carro_eletrico, carona,
            nivel_agua_crip, nivel_energia_crip, nivel_residuos_crip, nivel_transporte_crip, niveis['plr']
        )

        cursor.execute(sql, valores)
        conexao.commit()
        print("\nDados inseridos com sucesso!")

        cursor.close()
        conexao.close()

    elif opcao == '2':
        id_registro = input("Digite o ID do registro que deseja alterar: ")

        print("\nO que você deseja alterar?")
        print("1 - Água")
        print("2 - Energia")
        print("3 - Resíduos não recicláveis")
        print("4 - Resíduos recicláveis")
        print("5 - Alterar todos")
        escolha = input("Escolha uma opção: ")

        conexao = mysql.connector.connect(
            host='localhost',
            user='root',
            password='310107',
            database='sustentabilidade'
        )
        cursor = conexao.cursor()

        if escolha == '1':
            novo_agua = float(input("Digite o novo valor de Água consumida (litros): "))
            sql = "UPDATE registro_diario SET agua = %s WHERE id = %s"
            valores = (novo_agua, id_registro)

        elif escolha == '2':
            nova_energia = float(input("Digite o novo valor de Energia consumida (kWh): "))
            sql = "UPDATE registro_diario SET energia = %s WHERE id = %s"
            valores = (nova_energia, id_registro)

        elif escolha == '3':
            novos_residuos_nao = float(input("Digite o novo valor de Resíduos não recicláveis (kg): "))
            sql = "UPDATE registro_diario SET residuos_nao_reciclaveis = %s WHERE id = %s"
            valores = (novos_residuos_nao, id_registro)

        elif escolha == '4':
            novos_residuos_reciclaveis = float(input("Digite o novo valor de Resíduos recicláveis (kg): "))
            sql = "UPDATE registro_diario SET residuos_reciclaveis = %s WHERE id = %s"
            valores = (novos_residuos_reciclaveis, id_registro)

        elif escolha == '5':
            novo_agua = float(input("Novo valor de água (litros): "))
            nova_energia = float(input("Novo valor de energia (kWh): "))
            novos_residuos_nao = float(input("Novo valor de resíduos não recicláveis (kg): "))
            novos_residuos_reciclaveis = float(input("Novo valor de resíduos recicláveis (kg): "))
            sql = """
                UPDATE registro_diario
                SET agua = %s, energia = %s, residuos_nao_reciclaveis = %s, residuos_reciclaveis = %s
                WHERE id = %s
            """
            valores = (novo_agua, nova_energia, novos_residuos_nao, novos_residuos_reciclaveis, id_registro)

        else:
            print("Opção inválida.")
            cursor.close()
            conexao.close()
            exit()

        cursor.execute(sql, valores)
        conexao.commit()
        print("\nRegistro alterado com sucesso!")

        cursor.close()
        conexao.close()


    elif opcao == '3':
        id_registro = input("Digite o ID do registro que deseja excluir: ")

        conexao = mysql.connector.connect(
            host='localhost',
            user='root',
            password='310107',
            database='sustentabilidade'
        )
        cursor = conexao.cursor()

        sql = "DELETE FROM registro_diario WHERE id = %s"
        valores = (id_registro,)

        cursor.execute(sql, valores)
        conexao.commit()
        print("\nRegistro excluído com sucesso!")

        cursor.close()
        conexao.close()

    elif opcao == '4':
        listar_registros()

    elif opcao == '5':
        print("Saindo...")
        break

    else:
        print("Opção inválida! Tente novamente.")