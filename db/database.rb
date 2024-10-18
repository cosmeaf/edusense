require 'sequel'

# DB = Sequel.connect(
#   adapter: 'postgres',
#   host: 'localhost',
#   database: 'edusense_db',
#   user: 'postgres_user',
#   password: 'edusenseDBpwd'
# )
#DB = Sequel.connect(ENV['DATABASE_URL'] || 'postgres://postgres_user:edusenseDBpwd@localhost:5432/edusense_db')
DB = Sequel.connect(ENV['DATABASE_URL'] || 'postgres://postgres_user:edusenseDBpwd@172.16.0.10:5432/edusense_db')

puts "Running..."


#DB.run(%(
#  CREATE TEMP TABLE user_name_groups AS
#  SELECT MIN(id) as group_id, user_name
#  FROM lessons
#  GROUP BY user_name
#))

#query = %(
#  SELECT g1.user_name AS name1, g2.user_name AS name2, similarity(g1.user_name, g2.user_name) AS sim
#  FROM user_name_groups g1, user_name_groups g2
#  WHERE g1.group_id < g2.group_id AND similarity(g1.user_name, g2.user_name) > 0.5
#  ORDER BY sim DESC
#)

# Executar a query e imprimir os resultados
#DB[query].each do |row|
#  puts "#{row[:name1]}\\t#{row[:name2]}\\t#{row[:sim]}"
#end

# Limpar a tabela temporária após o uso
#DB.run("DROP TABLE IF EXISTS user_name_groups;")


name_fixes = [["MARCELLY HUASTEIN FERREIRA DE ANDRADE", "Marcelly Huastein Ferreira de Andrade"],
["RODRIGO ARAUJO E SILVA", "Rodrigo Araujo e Silva"],
["DALVA MARIA DA COSTA", "Dalva Maria Da Costa"],
["FELIPE AFONSO DA SILVA", "Felipe Afonso da Silva"],
["JULIANO ANDRADE PIRES", "Juliano Andrade Pires"],
["LUCAS ALBUQUERQUE SANTOS COSTA", "Lucas Albuquerque Santos Costa"],
["Jamille De Oliveira Tito", "Jamille de Oliveira Tito"],
["JULIANO ALVES MARES", "Juliano Alves Mares"],
["WENRY MARTINS SABINO", "Wenry Martins Sabino"],
["Jairo Lucas Dos Santos", "Jairo Lucas dos Santos"],
["RAFAEL TOLEDO SILVA", "Rafael Toledo Silva"],
["EDGAR DE SOUSA RODRIGUES", "Edgar De Sousa Rodrigues"],
["GILSON RODRIGUES LISBOA", "Gilson Rodrigues Lisboa"],
["Bernardo Carvalho Guerra Martins Da Costa", "Bernardo Carvalho Guerra Martins da Costa"],
["Gabriel Vitor de Oliveira Reis", "Gabriel Vitor De Oliveira Reis"],
["MARCONE AVELINO BORGES ALVES", "Marcone Avelino Borges Alves"],
["LUCAS RODRIGUES DE FARIA COSTA", "Lucas Rodrigues De Faria Costa"],
["PAULO HENRIQUE CARDOSO JUNIOR", "Paulo Henrique Cardoso Junior"],
["PAULO CESAR COSTA", "Paulo Cesar Costa"],
["LEONARDO FERRAZ RODRIGUES PEREIRA", "Leonardo Ferraz Rodrigues Pereira"],
["ISABELLE AMARAL QUEIROZ DE NOVAIS", "Isabelle Amaral Queiroz De Novais"],
["Jefte Ebiasafe Alves De Souza", "Jefte Ebiasafe Alves de Souza"],
["DAVID DE ANDRADE", "David de Andrade"],
["JOAO VITOR DA SILVA MORATO", "Joao Vitor da Silva Morato"],
["LIVIA COSTA DAVID", "Livia Costa David"],
["CARLOS EDUARDO CABRAL CARDOSO", "Carlos Eduardo Cabral Cardoso"],
["MARCOS PAULO SARAIVA SILVA", "Marcos Paulo Saraiva Silva"],
["ADRIANA CAMARGOS MOURA", "Adriana Camargos Moura"],
["BRUNO LUIS MORAIS PEREIRA", "Bruno Luis Morais Pereira"],
["Rafael Lucas Martins Almeida Dos Reis", "Rafael Lucas Martins Almeida dos Reis"],
["LORRAYNE GABRIELE CARDOSO", "Lorrayne Gabriele Cardoso"],
["NARA MENDES SANTOS", "Nara Mendes Santos"],
["KELI CRISTINA SILVA MARTINS", "Keli Cristina Silva Martins"],
["GERALDO FERREIRA SANTOS JUNIOR", "Geraldo Ferreira Santos Junior"],
["Lucas Vinicius De Oliveira Siqueira", "Lucas Vinicius de Oliveira Siqueira"],
["NICOLAS SILVA SANTOS", "Nicolas Silva Santos"],
["JENIFER SABINO REIS SILVA", "Jenifer Sabino Reis Silva"],
["GUSTAVO HENRIQUE DE PAIVA", "Gustavo Henrique de Paiva"],
["PAULO HENRIQUE LOPES SILVA", "Paulo Henrique Lopes Silva"],
["elcio Lage Machado", "Elcio Lage Machado"],
["FREDERICO CRISTIMANS MOREIRA", "Frederico Cristimans Moreira"],
["DIEGO VINICIUS DE SOUSA AZEVEDO", "Diego Vinicius de Sousa Azevedo"],
["RICARDO RODRIGUES NAVARRO", "Ricardo Rodrigues Navarro"],
["MAICON RODRIGUES DOS SANTOS", "Maicon Rodrigues dos Santos"],
["BRENO PEREIRA DOS SANTOS BISPO", "Breno Pereira dos Santos Bispo"],
["Linete Aparecida Tavares Da Costa", "Linete Aparecida Tavares da Costa"],
["FELIPPE VIEIRA NASCIMENTO SILVA", "Felippe Vieira Nascimento Silva"],
["PEDRO IGOR LOPES DA SILVA SOARES", "Pedro Igor Lopes da Silva Soares"],
["Jose Vitor Gomes dos santos Nascimento", "Jose Vitor Gomes Dos Santos Nascimento"],
["ALEXANDRE LIMA", "Alexandre Lima"],
["GUSTAVO HENRIQUE BRAGA SILVA", "Gustavo Henrique Braga Silva"],
["RICARDO JUNIO DOS SANTOS", "Ricardo Junio dos Santos"],
["GUSTAVO MACIEL CAETANO", "Gustavo Maciel Caetano"],
["Luis Felipe de Paula Duarte", "Luis Felipe De Paula Duarte"],
["LEONARDO FERNANDES GARBAZZA", "Leonardo Fernandes Garbazza"],
["ARTHUR FERREIRA CAMPOS MENEZES", "Arthur Ferreira Campos Menezes"],
["Lucas Goncalves Dos Santos", "Lucas Goncalves dos Santos"],
["Jeter Junior De Andrade", "Jeter Junior de Andrade"],
["WALLISSON FELIPE GONTIJO SOUSA PEREIRA", "Wallisson Felipe Gontijo Sousa Pereira"],
["FERNANDO KELVIN COSTA SANTOS", "Fernando Kelvin Costa Santos"],
["ANDRÉ LUÍS MARÇAL LONGUINHO SILVA", "André Luís Marçal Longuinho Silva"],
["LEANDRO VINICIUS RODRIGUES", "Leandro Vinicius Rodrigues"],
["Lucas Rodrigues da Cunha", "Lucas Rodrigues Da Cunha"],
["JULIANA RIBEIRO", "Juliana Ribeiro"],
["ELIAS ANTONIO COSTA LOPES", "Elias Antonio Costa Lopes"],
["Rafael Da Silva Rocha", "Rafael da Silva Rocha"],
["LUCAS SOARES TRINDADE", "Lucas Soares Trindade"],
["Giovanna Danielle Fran?a Fernandes de Sousa", "Giovanna Danielle França Fernandes de Sousa"],
["Anna Rita Tomich Magalhaes Felippe", "Anna Rita Tomich Magalhães Felippe"],
["ALEXANDRE CABRAL DO ESPIRITO SANTO", "Alexandre Cabral do Espírito Santo"],
["Henrique Queiroz Can?ado Silveira", "Henrique Queiroz Cancado Silveira"],
["Flavio Geraldo Rosa Martins", "Flávio Geraldo Rosa Martins"],
["Vinicius Goncalves Fisicaro", "Vinicius Gonçalves Fisicaro"],
["ANA VITORIA CARDOSO DE MELO", "Ana Vitória Cardoso de Melo"],
["Idalina de Cassia Gregório", "Idalina de Cassia Gregorio"],
["Ricardo Junio Araujo Gomes", "Ricardo Junio Araújo Gomes"],
["Daniel Lúcio Braga Cardoso", "Daniel Lucio Braga Cardoso"],
["Júlia Araujo De Figueiredo", "Julia Araujo De Figueiredo"],
["LUCAS ARAUJO PINTO RESENDE", "Lucas Araújo Pinto Resende"],
["Ryan Pablo Ara?jo de Souza", "Ryan Pablo Araújo de Souza"],
["NATALIA APARECIDA DA SILVA", "Natália Aparecida da Silva"],
["Robson Cornelio Kawanishi", "Robson Cornélio Kawanishi"],
["Alexandre Goncalves Dias", "Alexandre Gonçalves Dias"],
["Willian Patricio Silva", "Willian Patrício Silva"],
["CHARLES VINICIUS CAMPOS", "Charles Vinícius Campos"],
["Fabricio Saez Milanio", "Fabrício Saez Milanio"],
["Ana Paula Lopes Cruz", "Ana Paula Lopez da Cruz"],
["Mateus Ara?jo Macedo", "Mateus Araújo Macedo"],
["Luiz Ot?vio Santos", "Luiz Otávio Santos"],
["Mateus Ara?jo Macedo", "Mateus Araujo Macedo"],
["Luiz Ot?vio Santos", "Luiz Otavio Santos"],
["Mateus Araujo Macedo", "Mateus Araújo Macedo"],
["Luiz Otávio Santos", "Luiz Otavio Santos"],
["JOAO PAULO FERRY", "João Paulo Ferry"],
["Eduarda Silva", "Eduarda Araújo Silva"],
["Julio Cesar De Souza Oliveira", "Júlio César De Souza Oliveira"],
["Gabriel Souza", "Gabriel Wilson Souza"],
["Hiago Ambrosio", "Hiago Espindola Ambrosio"],
["Davi Andrade", "Davi Monteiro Andrade"],
["ANDRE LUIS REBOUCAS GUIMARAES", "André Luis Rebouças Guimarães"],
["Andreia P Santos", "Andreia Priscila dos Santos"],
["Luke", "Luke Lage"],
["Valter Oliveira", "Valter Rodrigues de Oliveira"]]

#name_fixes.each do |names|
#  previous_name, new_name = names
#  puts "Updating `#{previous_name}` to `#{new_name}`"
#  DB.run("UPDATE lessons SET user_name = '#{new_name}' WHERE user_name ILIKE '#{previous_name}%'")
#end

