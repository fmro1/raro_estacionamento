# Gerenciador simples de estacionamento

Aplicativo de teste para gerenciar um estacionamento.

![Screenshot_1648075725](https://user-images.githubusercontent.com/31592577/159809616-efc6e9f6-e16b-46ee-b2c8-c370a41aebbb.png)
![Screenshot_1648075740](https://user-images.githubusercontent.com/31592577/159809684-aeb06d79-587a-4a97-8f03-a77c71c50940.png)
![Screenshot_1648075666](https://user-images.githubusercontent.com/31592577/159809717-93a3a975-56f0-4ee7-9300-cda0378ea037.png)
![Screenshot_1648075685](https://user-images.githubusercontent.com/31592577/159809714-c5f772a9-b4eb-4b8c-a8d0-9bd352a088d3.png)

## Projeto desenvolvido em flutter com utilização de banco de dados do Firebase.

A tela incial possui 4 botoes principais com funcionalidades distintas: 
 - Entrada - adicionar um veiculo que chegou;
 - Saída - Remover algum veículo de uma vaga;
 - Hoje - Mostra todas as movimentações que aconteceram no dia pelo relógio interno do aparelho;
 - Histórico - Mostra o historico de todas as movimentações desde o inicio.

Tomei como base um estacionamento de 100 vagas, e dividi o banco em Histórico e Vagas.

Tento separar o código em modelos, controladores e parte visual. Fiz meu primeiro contato com o pacote GetIt, achei interessante seu funcionamento e fácil de usar. Fiz a utilização do provider como gerenciador de estado, pois estou mais habituado com seu funcionamento.

Tive dificuldade para testar as streams e as conexoes com o firebase database, para testar eu utilizei diretamente os dados do firebase alterando as tabelas.
Os meus testes unitários e de widgets estão focados em verificar se a interface de usuario não fica bloqueada por recebimento de dados diferentes do esperado.


Versão do flutter: 2.13.0