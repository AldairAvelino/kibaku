--SCRIPT DAS TABELAS

--TABELA DE COR 	
create table if not exists kibaku_bd.tb_cor(
id_cor int(10) unsigned not null auto_increment,
no_cor varchar(50) not NULL,
descricao varchar(150) null,
created_at timestamp NULL default NULL,
updated_at timestamp NULL DEFAULT NULL,
primary key(id_cor)
)
engine = InnoDB
default character set = utf8mb4
collate = utf8mb4_unicode_ci;

--TABELA DE RACA
create table if not exists kibaku_bd.tb_raca(
id_raca int(10) unsigned not null auto_increment,
no_raca varchar(50) not NULL,
descricao varchar(150) null,
created_at timestamp NULL default NULL,
updated_at timestamp NULL DEFAULT NULL,
primary key(id_raca)
)
engine = InnoDB
default character set = utf8mb4
collate = utf8mb4_unicode_ci;

-- TABELA DE VETERINARIA
create table if not exists kibaku_bd.tb_veterinaria(
id_veterinaria int(10) unsigned not null auto_increment,
no_veterinaria varchar(100) not NULL,
descricao varchar(150) null,
tipo enum('nacional', 'estrangeira'),
deslocacao enum('sim', 'nao'),
created_at timestamp NULL default NULL,
updated_at timestamp NULL DEFAULT NULL,
primary key(id_veterinaria)
)
engine = InnoDB
default character set = utf8mb4
collate = utf8mb4_unicode_ci;

--TABELA DE TIPO MEDICACAO
create table if not exists kibaku_bd.tb_tipo_medicacao(
id_tipo_medicacao int(10) unsigned not null auto_increment,
descricao varchar(150) not null,
no_tipo_medicacao varchar(150) not null,
created_at timestamp NULL default NULL,
updated_at timestamp NULL DEFAULT NULL,
primary key(id_tipo_medicacao)
)
engine = InnoDB
default character set = utf8mb4
collate = utf8mb4_unicode_ci;

--TABELA DE CATEGORIA
create table if not exists kibaku_bd.tb_categoria(
id_categoria int(10) unsigned not null auto_increment,
no_categoria varchar(100) null,
descricao varchar(150) null,
created_at timestamp NULL default NULL,
updated_at timestamp NULL DEFAULT NULL,
primary key(id_categoria)
)
engine = InnoDB
default character set = utf8mb4
collate = utf8mb4_unicode_ci;

--TABELA DE TIPO PRODUTO
create table if not exists kibaku_bd.tb_tipo_produto(
id_tipo_produto int(10) unsigned not null auto_increment,
no_tipo_produto varchar(100) null,
descricao varchar(150) null,
sigla varchar(5) null,
created_at timestamp NULL default NULL,
updated_at timestamp NULL DEFAULT NULL,
primary key(id_tipo_produto)
)
engine = InnoDB
default character set = utf8mb4
collate = utf8mb4_unicode_ci;

--TABELA DE PETSHOP
create table if not exists kibaku_bd.tb_petshop(
id_petshop int(10) unsigned not null auto_increment,
no_petshop varchar(100) not null,
descricao varchar(150) null,
logo blob not null,
created_at timestamp NULL default NULL,
updated_at timestamp NULL DEFAULT NULL,
primary key(id_petshop)
)
engine = InnoDB
default character set = utf8mb4
collate = utf8mb4_unicode_ci;

--TABELA DE SERVICO
create table if not exists kibaku_bd.tb_servico(
id_servico int(10) unsigned not null auto_increment,
no_servico varchar(100) not null,
descricao varchar(150) null,
imagem blob null,
created_at timestamp NULL default NULL,
updated_at timestamp NULL DEFAULT NULL,
primary key(id_servico)
)
engine = InnoDB
default character set = utf8mb4
collate = utf8mb4_unicode_ci;

--TABELA DE PERMISSAO
create table if not exists kibaku_bd.tb_permissao(
id_permissao int(10) unsigned not null auto_increment,
no_permissao varchar(150) not null,
label varchar(45) null,
descricao varchar(250) null,
created_at timestamp NULL default NULL,
updated_at timestamp NULL DEFAULT NULL,
primary key(id_permissao)
)
engine = InnoDB
default character set = utf8mb4
collate = utf8mb4_unicode_ci;

--TABELA DE PAIS
create table if not exists kibaku_bd.tb_pais(
id_pais int(10) unsigned not null auto_increment,
no_pais varchar(50) not null,
sigla varchar(5) not null,
preposicao varchar(3) not null,
bandeira blob null,
codigo varchar(5) null,
created_at timestamp NULL default NULL,
updated_at timestamp NULL DEFAULT NULL,
primary key(id_pais)
)
engine = InnoDB
default character set = utf8mb4
collate = utf8mb4_unicode_ci;

--TABELA DE PERFIL
create table if not exists kibaku_bd.tb_perfil(
id_perfil int(10) unsigned not null auto_increment,
no_perfil enum('petshop', 'veterinario', 'adestrador', 'criador', 'admin') not null,
descricao varchar(150) null,
label varchar(45) null,
created_at timestamp NULL default NULL,
updated_at timestamp NULL DEFAULT NULL,
primary key(id_perfil)
)
engine = InnoDB
default character set = utf8mb4
collate = utf8mb4_unicode_ci;

--TAbela de Provincia
create table if not exists kibaku_bd.tb_provincia(
id_provincia int(10) unsigned not null auto_increment,
id_pais int(10) unsigned not null,
no_provincia varchar(50) not null,
sigla varchar(4) not null,
preposicao varchar(3) not null default 'de',
created_at timestamp NULL default NULL,
updated_at timestamp NULL DEFAULT NULL,
primary key(id_provincia),
constraint fk_provincia_pais
foreign key(id_pais)
references kibaku_bd.tb_pais(id_pais)
on delete cascade
on update cascade
)
engine = InnoDB
default character set = utf8mb4
collate = utf8mb4_unicode_ci;


-- TABELA PESSOA
create table if not exists kibaku_bd.tb_pessoa(
id_pessoa int(10) unsigned not null auto_increment,
nacionalidade int(10) unsigned not null,
naturalidade int(10) unsigned not null,
no_pessoa varchar(100) not null,
genero enum('masculino, femenino, outro'),
bi varchar(20) null,
nif varchar(20) null,
tipo_pessoa enum('singular', 'coletiva', 'estrangeira') default 'singular',
estado_civil enum('solteiro', 'casado', 'divorciado', 'viúvo'),
created_at timestamp NULL default NULL,
updated_at timestamp NULL DEFAULT NULL,
unique index pessoa_bi_unique (bi asc),
unique index pessoa_nif_unique (nif asc), 
primary key(id_pessoa),
constraint fk_nacionalidade_pessoa  
foreign key(nacionalidade) 
references kibaku_bd.tb_pais(id_pais)
 on delete cascade
 on update cascade,
CONSTRAINT fk_naturalidade_pessoa
FOREIGN KEY (`naturalidade`)
REFERENCES `kibaku_bd`.`tb_provincia` (`id_provincia`)
ON DELETE CASCADE
ON UPDATE CASCADE
)
engine = InnoDB
default character set = utf8mb4
collate = utf8mb4_unicode_ci;

-- TABELA USUÁRIO
create table if not exists kibaku_bd.tb_usuario(
id_usuario int(10) unsigned not null auto_increment,
id_pessoa int(10) unsigned not null,
conta varchar(150) not null,
email varchar(250) not null,
email_verified_at timestamp NULL DEFAULT NULL,
senha varchar(250) not null,
estado enum('activo', 'inactivo'),
remember_token varchar(150) null,
avatar blob null,
created_at timestamp NULL default NULL,
updated_at timestamp NULL DEFAULT NULL,
unique index usuario_conta_unique (conta asc),
unique index usuario_email_unique (email asc), 
primary key(id_usuario),
constraint fk_usuario_pessoa  foreign key(id_pessoa) references kibaku_bd.tb_pessoa(id_pessoa) on delete cascade on update cascade

)
engine = InnoDB
default character set = utf8mb4
collate = utf8mb4_unicode_ci;

-- TABELA PERFIL USUÁRIO
create table if not exists kibaku_bd.tb_perfil_usuario(
id_perfil_usuario int(10) unsigned not null auto_increment,
id_perfil int(10) unsigned not null,
id_usuario int(10) unsigned not null, 
primary key(`id_perfil_usuario`),
CONSTRAINT `fk_perfil_usuario_perfil` 
FOREIGN KEY (`id_perfil`) 
REFERENCES `kibaku_bd`.`tb_perfil`(`id_perfil`)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT `fk_perfil_usuario_usuario`
FOREIGN KEY (`id_usuario`)
REFERENCES `kibaku_bd`.`tb_usuario`(`id_usuario`)
ON DELETE CASCADE
ON UPDATE CASCADE
)
engine = InnoDB
default character set = utf8mb4
collate = utf8mb4_unicode_ci;

-- TABELA PERFIL PERMISSÃO
create table if not exists kibaku_bd.tb_perfil_permissao(
id_perfil_permissao int(10) unsigned not null auto_increment,
id_perfil int(10) unsigned not null,
id_permissao int(10) unsigned not null, 
primary key(`id_perfil_permissao`),
CONSTRAINT `fk_perfil_permissao_perfil1` 
FOREIGN KEY (`id_perfil`) 
REFERENCES `kibaku_bd`.`tb_perfil`(`id_perfil`)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT `fk_perfil_permissao_permissao`
FOREIGN KEY (`id_permissao`)
REFERENCES `kibaku_bd`.`tb_permissao`(`id_permissao`)
ON DELETE CASCADE
ON UPDATE CASCADE
)
engine = InnoDB
default character set = utf8mb4
collate = utf8mb4_unicode_ci;

-- TABELA PERMISSÃO USUÁRIO
create table if not exists kibaku_bd.tb_permissao_usuario(
id_permissao_usuario int(10) unsigned not null auto_increment,
id_permissao int(10) unsigned not null,
id_usuario int(10) unsigned not null, 
primary key(`id_permissao_usuario`),
CONSTRAINT `fk_permissao_usuario_permissao` 
FOREIGN KEY (`id_permissao`) 
REFERENCES `kibaku_bd`.`tb_permissao`(`id_permissao`)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT `fk_permissao_usuario_usuario`
FOREIGN KEY (`id_usuario`)
REFERENCES `kibaku_bd`.`tb_usuario`(`id_usuario`)
ON DELETE CASCADE
ON UPDATE CASCADE
)
engine = InnoDB
default character set = utf8mb4
collate = utf8mb4_unicode_ci;

-- TABELA CONTACTO PESSOA
create table if not exists kibaku_bd.tb_contacto_pessoa(
id_contacto_pessoa int(10) unsigned not null auto_increment,
id_pais int(10) unsigned not null,
descricao varchar(150) not null, 
tipo_contacto enum('pessoal', 'empresa', 'colectivo') not null,
no_contacto varchar(150),
created_at timestamp NULL default NULL,
updated_at timestamp NULL DEFAULT NULL,
primary key(`id_contacto_pessoa`),
CONSTRAINT `fk_tb_contacto_pessoa_pais` 
FOREIGN KEY (`id_pais`) 
REFERENCES `kibaku_bd`.`tb_pais`(`id_pais`)
ON DELETE CASCADE
ON UPDATE CASCADE
)
engine = InnoDB
default character set = utf8mb4
collate = utf8mb4_unicode_ci;

-- TABELA MUNICÍPIO
create table if not exists kibaku_bd.tb_municipio(
id_municipio int(10) unsigned not null auto_increment,
id_provincia int(10) unsigned not null,
no_municipio varchar(50) not null,
sigla varchar(4) null,
preposicao varchar(3) not null,
created_at timestamp NULL default NULL,
updated_at timestamp NULL DEFAULT NULL,
primary key(`id_municipio`),
CONSTRAINT `fk_municipio_provincia` 
FOREIGN KEY (`id_provincia`) 
REFERENCES `kibaku_bd`.`tb_provincia`(`id_provincia`)
ON DELETE CASCADE
ON UPDATE CASCADE
)
engine = InnoDB
default character set = utf8mb4
collate = utf8mb4_unicode_ci;

--TABELA COMUMA
create table if not exists kibaku_bd.tb_comuna(
id_comuna int(10) unsigned not null auto_increment,
id_municipio int(10) unsigned not null,
no_comuna varchar(150) not null,
sigla varchar(4) null,
preposicao varchar(3) not null,
created_at timestamp NULL default NULL,
updated_at timestamp NULL DEFAULT NULL,
primary key(`id_comuna`),
CONSTRAINT `fk_comuna_municipio` 
FOREIGN KEY (`id_municipio`) 
REFERENCES `kibaku_bd`.`tb_municipio`(`id_municipio`)
ON DELETE CASCADE
ON UPDATE CASCADE
)
engine = InnoDB
default character set = utf8mb4
collate = utf8mb4_unicode_ci;

-- TABELA BAIRRO
create table if not exists kibaku_bd.tb_bairro(
id_bairro int(10) unsigned not null auto_increment,
id_comuna int(10) unsigned not null,
no_bairro varchar(150) not null,
sigla varchar(4) null,
preposicao varchar(3) not null,
created_at timestamp NULL default NULL,
updated_at timestamp NULL DEFAULT NULL,
primary key(`id_bairro`),
CONSTRAINT `fk_bairro_comuna` 
FOREIGN KEY (`id_comuna`) 
REFERENCES `kibaku_bd`.`tb_comuna`(`id_comuna`)
ON DELETE CASCADE
ON UPDATE CASCADE
)
engine = InnoDB
default character set = utf8mb4
collate = utf8mb4_unicode_ci;

-- TABELA MORADA PESSOA
create table if not exists kibaku_bd.tb_morada_pessoa(
id_morada_pessoa int(10) unsigned not null auto_increment,
id_pessoa int(10) unsigned not null,
id_bairro int(10) unsigned not null,
id_comuna int(10) unsigned not null,
rua varchar(150) not null,
edificio varchar(50) null,
num_casa varchar(50) null,
travessa varchar(150) null,
created_at timestamp NULL default NULL,
updated_at timestamp NULL DEFAULT NULL,
primary key(`id_morada_pessoa`),
CONSTRAINT `fk_morada_pessoa_pessoa` 
FOREIGN KEY (`id_pessoa`) 
REFERENCES `kibaku_bd`.`tb_pessoa`(`id_pessoa`)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT `fk_morada_pessoa_bairro` 
FOREIGN KEY (`id_bairro`) 
REFERENCES `kibaku_bd`.`tb_bairro`(`id_bairro`)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT `fk_morada_pessoa_comuna` 
FOREIGN KEY (`id_comuna`) 
REFERENCES `kibaku_bd`.`tb_comuna`(`id_comuna`)
ON DELETE CASCADE
ON UPDATE CASCADE
)
engine = InnoDB
default character set = utf8mb4
collate = utf8mb4_unicode_ci;

-- TABELA ANIMAL
create table if not exists kibaku_bd.tb_animal(
id_animal int(10) unsigned not null auto_increment,
data_nascimento date not null,
id_raca int(10) unsigned not null,
no_animal varchar(150) not null,
imagem blob null,
created_at timestamp NULL default NULL,
updated_at timestamp NULL DEFAULT NULL,
primary key(`id_animal`),
CONSTRAINT `fk_animal_raca` 
FOREIGN KEY (`id_raca`) 
REFERENCES `kibaku_bd`.`tb_raca`(`id_raca`)
ON DELETE CASCADE
ON UPDATE CASCADE
)
engine = InnoDB
default character set = utf8mb4
collate = utf8mb4_unicode_ci;

-- TABELA ANIMAL COR
create table if not exists kibaku_bd.tb_animal_cor(
id_animal_cor int(10) unsigned not null auto_increment,
id_animal int(10) unsigned not null,
id_cor int(10) unsigned not null,
primary key(`id_animal_cor`),
CONSTRAINT `fk_animal_cor_animal` 
FOREIGN KEY (`id_animal`) 
REFERENCES `kibaku_bd`.`tb_animal`(`id_animal`)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT `fk_animal_cor_cor` 
FOREIGN KEY (`id_cor`) 
REFERENCES `kibaku_bd`.`tb_cor`(`id_cor`)
ON DELETE CASCADE
ON UPDATE CASCADE
)
engine = InnoDB
default character set = utf8mb4
collate = utf8mb4_unicode_ci;

-- TABELA DONO ANIMAL
create table if not exists kibaku_bd.tb_dono_animal(
id_dono_animal int(10) unsigned not null auto_increment,
id_animal int(10) unsigned not null,
id_pessoa int(10) unsigned not null,
principal varchar(150) null,
created_at timestamp NULL default NULL,
updated_at timestamp NULL DEFAULT NULL,
primary key(`id_dono_animal`),
CONSTRAINT `fk_dono_animal_animal` 
FOREIGN KEY (`id_animal`) 
REFERENCES `kibaku_bd`.`tb_animal`(`id_animal`)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT `fk_dono_animal_pessoa` 
FOREIGN KEY (`id_pessoa`) 
REFERENCES `kibaku_bd`.`tb_pessoa`(`id_pessoa`)
ON DELETE CASCADE
ON UPDATE CASCADE
)
engine = InnoDB
default character set = utf8mb4
collate = utf8mb4_unicode_ci;

-- TABELA CONSULTA
create table if not exists kibaku_bd.tb_consulta(
id_consulta int(10) unsigned not null auto_increment,
id_animal int(10) unsigned not null,
id_veterinaria int(10) unsigned not null,
descricao varchar(1000) null,
valor float(10,2) null,
created_at timestamp NULL default NULL,
updated_at timestamp NULL DEFAULT NULL,
primary key(`id_consulta`),
CONSTRAINT `fk_consulta_animal` 
FOREIGN KEY (`id_animal`) 
REFERENCES `kibaku_bd`.`tb_animal`(`id_animal`)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT `fk_consulta_veterinaria` 
FOREIGN KEY (`id_veterinaria`) 
REFERENCES `kibaku_bd`.`tb_veterinaria`(`id_veterinaria`)
ON DELETE CASCADE
ON UPDATE CASCADE
)
engine = InnoDB
default character set = utf8mb4
collate = utf8mb4_unicode_ci;

-- TABELA MEDICAÇÃO
create table if not exists kibaku_bd.tb_medicacao(
id_medicacao int(10) unsigned not null auto_increment,
id_tipo_medicacao int(10) unsigned not null,
id_animal int(10) unsigned not null,
grama float(10,2) not null,
data_medicacao date not null,
peso float(10,2) not null,
data_validade date not null,
origem int(10) unsigned not null,
created_at timestamp NULL default NULL,
updated_at timestamp NULL DEFAULT NULL,
primary key(`id_medicacao`),
CONSTRAINT `fk_medicacao_tipo_medicacao` 
FOREIGN KEY (`id_tipo_medicacao`) 
REFERENCES `kibaku_bd`.`tb_tipo_medicacao`(`id_tipo_medicacao`)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT `fk_medicacao_animal` 
FOREIGN KEY (`id_animal`) 
REFERENCES `kibaku_bd`.`tb_animal`(`id_animal`)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT `fk_medicacao_pais` 
FOREIGN KEY (`origem`) 
REFERENCES `kibaku_bd`.`tb_pais`(`id_pais`)
ON DELETE CASCADE
ON UPDATE CASCADE
)
engine = InnoDB
default character set = utf8mb4
collate = utf8mb4_unicode_ci;

--TABELA MORADA ANIMAL
create table if not exists kibaku_bd.tb_morada_animal(
id_morada_animal int(10) unsigned not null auto_increment,
id_animal int(10) unsigned not null,
id_bairro int(10) unsigned not null,
id_municipio int(10) unsigned not null,
id_comuna int(10) unsigned not null,
rua varchar(150) not null,
edificio varchar(50) null,
num_casa varchar(50) null,
travessa varchar(150) null,
created_at timestamp NULL default NULL,
updated_at timestamp NULL DEFAULT NULL,
primary key(`id_morada_animal`),
CONSTRAINT `fk_morada_animal_animal` 
FOREIGN KEY (`id_animal`) 
REFERENCES `kibaku_bd`.`tb_animal`(`id_animal`)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT `fk_morada_animal_bairro` 
FOREIGN KEY (`id_bairro`) 
REFERENCES `kibaku_bd`.`tb_bairro`(`id_bairro`)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT `fk_morada_animal_municipio` 
FOREIGN KEY (`id_municipio`) 
REFERENCES `kibaku_bd`.`tb_municipio`(`id_municipio`)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT `fk_morada_animal_comuna` 
FOREIGN KEY (`id_comuna`) 
REFERENCES `kibaku_bd`.`tb_comuna`(`id_comuna`)
ON DELETE CASCADE
ON UPDATE CASCADE
)
engine = InnoDB
default character set = utf8mb4
collate = utf8mb4_unicode_ci;

-- TABELA ADESTRADOR
create table if not exists kibaku_bd.tb_adestrador(
id_adestrador int(10) unsigned not null auto_increment,
id_pessoa int(10) unsigned not null,
descricao varchar(150) null,
created_at timestamp NULL default NULL,
updated_at timestamp NULL DEFAULT NULL,
primary key(`id_adestrador`),
CONSTRAINT `fk_adestrador_pessoa` 
FOREIGN KEY (`id_pessoa`) 
REFERENCES `kibaku_bd`.`tb_pessoa`(`id_pessoa`)
ON DELETE CASCADE
ON UPDATE CASCADE
)
engine = InnoDB
default character set = utf8mb4
collate = utf8mb4_unicode_ci;

-- TABELA CLIENTE
create table if not exists kibaku_bd.tb_cliente(
id_cliente int(10) unsigned not null auto_increment,
id_adestrador int(10) unsigned not null,
id_dono_animal int(10) unsigned not null,
created_at timestamp NULL default NULL,
updated_at timestamp NULL DEFAULT NULL,
primary key(`id_cliente`),
CONSTRAINT `fk_cliente_adestrador` 
FOREIGN KEY (`id_adestrador`) 
REFERENCES `kibaku_bd`.`tb_adestrador`(`id_adestrador`)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT `fk_cliente_dono_animal` 
FOREIGN KEY (`id_dono_animal`) 
REFERENCES `kibaku_bd`.`tb_dono_animal`(`id_dono_animal`)
ON DELETE CASCADE
ON UPDATE CASCADE
)
engine = InnoDB
default character set = utf8mb4
collate = utf8mb4_unicode_ci;

-- TABELA VETERINARIO
create table if not exists kibaku_bd.tb_veterinario(
id_veterinario int(10) unsigned not null auto_increment,
id_pessoa int(10) unsigned not null,
id_especialidade int(10) unsigned not null,
created_at timestamp NULL default NULL,
updated_at timestamp NULL DEFAULT NULL,
primary key(`id_veterinario`),
CONSTRAINT `fk_veterinario_pessoa` 
FOREIGN KEY (`id_pessoa`) 
REFERENCES `kibaku_bd`.`tb_pessoa`(`id_pessoa`)
ON DELETE CASCADE
ON UPDATE CASCADE
)
engine = InnoDB
default character set = utf8mb4
collate = utf8mb4_unicode_ci;

-- TABELA CONTACTO VETERINARIA
create table if not exists kibaku_bd.tb_contacto_veterinaria(
id_contacto_veterinaria int(10) unsigned not null auto_increment,
id_veterinaria int(10) unsigned not null,
id_pais int(10) unsigned not null,
tipo_contacto enum('pessoal', 'empresa', 'estrangeiro'),
descricao varchar(150),
created_at timestamp NULL default NULL,
updated_at timestamp NULL DEFAULT NULL,
primary key(`id_contacto_veterinaria`),
CONSTRAINT `fk_contacto_veterinaria_veterinaria` 
FOREIGN KEY (`id_veterinaria`) 
REFERENCES `kibaku_bd`.`tb_veterinaria`(`id_veterinaria`)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT `fk_contacto_veterinaria_pais` 
FOREIGN KEY (`id_pais`) 
REFERENCES `kibaku_bd`.`tb_pais`(`id_pais`)
ON DELETE CASCADE
ON UPDATE CASCADE
)
engine = InnoDB
default character set = utf8mb4
collate = utf8mb4_unicode_ci;

-- TABELA AVALIACAO VETERINARIO
create table if not exists kibaku_bd.tb_avaliacao_veterinario(
id_avaliacao_veterinario int(10) unsigned not null auto_increment,
id_veterinario int(10) unsigned not null,
id_cliente int(10) unsigned not null,
valor int(5) unsigned not null,
created_at timestamp NULL default NULL,
updated_at timestamp NULL DEFAULT NULL,
primary key(`id_avaliacao_veterinario`),
CONSTRAINT `fk_avaliacao_veterinario_veterinario` 
FOREIGN KEY (`id_veterinario`) 
REFERENCES `kibaku_bd`.`tb_veterinario`(`id_veterinario`)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT `fk_avaliacao_veterinario_cliente` 
FOREIGN KEY (`id_cliente`) 
REFERENCES `kibaku_bd`.`tb_cliente`(`id_cliente`)
ON DELETE CASCADE
ON UPDATE CASCADE
)
engine = InnoDB
default character set = utf8mb4
collate = utf8mb4_unicode_ci;

-- TABELA SERVICO VETERINARIA
create table if not exists kibaku_bd.tb_servico_veterinaria(
id_servico_veterinaria int(10) unsigned not null auto_increment,
id_veterinaria int(10) unsigned not null,
id_servico int(10) unsigned not null,
descricao varchar(150) null,
created_at timestamp NULL default NULL,
updated_at timestamp NULL DEFAULT NULL,
primary key(`id_servico_veterinaria`),
CONSTRAINT `fk_servico_veterinaria_veterinaria` 
FOREIGN KEY (`id_veterinaria`) 
REFERENCES `kibaku_bd`.`tb_veterinaria`(`id_veterinaria`)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT `fk_servico_veterinaria_servico` 
FOREIGN KEY (`id_servico`) 
REFERENCES `kibaku_bd`.`tb_servico`(`id_servico`)
ON DELETE CASCADE
ON UPDATE CASCADE
)
engine = InnoDB
default character set = utf8mb4
collate = utf8mb4_unicode_ci;

-- TABELA PRODUTO
create table if not exists kibaku_bd.tb_produto(
id_produto int(10) unsigned not null auto_increment,
id_tipo_produto int(10) unsigned not null,
no_produto varchar(100) not null,
descricao varchar(150) null,
estado enum('activo', 'inactivo', 'cancelado'),
created_at timestamp NULL default NULL,
updated_at timestamp NULL DEFAULT NULL,
primary key(`id_produto`),
CONSTRAINT `fk_produto_tipo_produto` 
FOREIGN KEY (`id_tipo_produto`) 
REFERENCES `kibaku_bd`.`tb_tipo_produto`(`id_tipo_produto`)
ON DELETE CASCADE
ON UPDATE CASCADE
)
engine = InnoDB
default character set = utf8mb4
collate = utf8mb4_unicode_ci;

-- TABELA SERVICO CLIENTE VETERINARIO
create table if not exists kibaku_bd.tb_servico_cliente_veterinario(
id_servico_cliente_veterinario int(10) unsigned not null auto_increment,
id_cliente int(10) unsigned not null,
id_veterinario int(10) unsigned not null,
id_servico int(10) unsigned not null,
tipo_servico varchar(50) not null,
valor_pagar float(10,2) not null,
data_servico date not null,
situacao enum('ativo', 'inativo'),
preposicao_valor varchar(3) not null,
created_at timestamp NULL default NULL,
updated_at timestamp NULL DEFAULT NULL,
primary key(`id_servico_cliente_veterinario`),
CONSTRAINT `fk_servico_cliente_veterinario_cliente` 
FOREIGN KEY (`id_cliente`) 
REFERENCES `kibaku_bd`.`tb_cliente`(`id_cliente`)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT `fk_servico_cliente_veterinario_veterinario` 
FOREIGN KEY (`id_veterinario`) 
REFERENCES `kibaku_bd`.`tb_veterinario`(`id_veterinario`)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT `fk_servico_cliente_veterinario_servico` 
FOREIGN KEY (`id_servico`) 
REFERENCES `kibaku_bd`.`tb_servico`(`id_servico`)
ON DELETE CASCADE
ON UPDATE CASCADE
)
engine = InnoDB
default character set = utf8mb4
collate = utf8mb4_unicode_ci;

-- TABELA SOLICITACAO PRODUTO
create table if not exists kibaku_bd.tb_solicitacao_produto(
id_solicitacao_produto int(10) unsigned not null auto_increment,
id_cliente int(10) unsigned not null,
data_solicitacao_produto date not null,
descricao varchar(150) null,
estado enum('solicitado', 'cancelado', 'reservado'),
motivo varchar(150) null,
created_at timestamp NULL default NULL,
updated_at timestamp NULL DEFAULT NULL,
primary key(`id_solicitacao_produto`),
CONSTRAINT `fk_solicitacao_produto_cliente` 
FOREIGN KEY (`id_cliente`) 
REFERENCES `kibaku_bd`.`tb_cliente`(`id_cliente`)
ON DELETE CASCADE
ON UPDATE CASCADE
)
engine = InnoDB
default character set = utf8mb4
collate = utf8mb4_unicode_ci;

-- TABELA CONSULTA SERVICO VETERINARIA
create table if not exists kibaku_bd.tb_consulta_servico_veterinaria(
id_consulta_servico_veterinaria int(10) unsigned not null auto_increment,
id_servico_veterinaria int(10) unsigned not null,
id_consulta int(10) unsigned not null,
created_at timestamp NULL default NULL,
updated_at timestamp NULL DEFAULT NULL,
primary key(`id_consulta_servico_veterinaria`),
CONSTRAINT `fk_consulta_servico_veterinaria_servico_veterinaria` 
FOREIGN KEY (`id_servico_veterinaria`) 
REFERENCES `kibaku_bd`.`tb_servico_veterinaria`(`id_servico_veterinaria`)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT `fk_consulta_servico_veterinaria_consulta` 
FOREIGN KEY (`id_consulta`) 
REFERENCES `kibaku_bd`.`tb_consulta`(`id_consulta`)
ON DELETE CASCADE
ON UPDATE CASCADE
)
engine = InnoDB
default character set = utf8mb4
collate = utf8mb4_unicode_ci;

-- TABELA VETERINARIO ESPECIALIDADE
create table if not exists kibaku_bd.tb_veterinario_especialidade(
id_veterinario_especialidade int(10) unsigned not null auto_increment,
id_veterinario int(10) unsigned not null,
id_especialidade int(10) unsigned not null,
created_at timestamp NULL default NULL,
updated_at timestamp NULL DEFAULT NULL,
primary key(`id_veterinario_especialidade`),
CONSTRAINT `fk_veterinario_especialidade_veterinario` 
FOREIGN KEY (`id_veterinario`) 
REFERENCES `kibaku_bd`.`tb_veterinario`(`id_veterinario`)
ON DELETE CASCADE
ON UPDATE CASCADE
)
engine = InnoDB
default character set = utf8mb4
collate = utf8mb4_unicode_ci;

-- TABELA CATEGORIA PRODUTO
create table if not exists kibaku_bd.tb_categoria_produto(
id_categoria_produto int(10) unsigned not null auto_increment,
id_produto int(10) unsigned not null,
id_categoria int(10) unsigned not null,
created_at timestamp NULL default NULL,
updated_at timestamp NULL DEFAULT NULL,
primary key(`id_categoria_produto`),
CONSTRAINT `fk_categoria_produto_produto` 
FOREIGN KEY (`id_produto`) 
REFERENCES `kibaku_bd`.`tb_produto`(`id_produto`)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT `fk_categoria_produto_categoria` 
FOREIGN KEY (`id_categoria`) 
REFERENCES `kibaku_bd`.`tb_categoria`(`id_categoria`)
ON DELETE CASCADE
ON UPDATE CASCADE
)
engine = InnoDB
default character set = utf8mb4
collate = utf8mb4_unicode_ci;

-- TABELA PAGAMENTO SOLICITACAO PRODUTO
create table if not exists kibaku_bd.tb_pagamento_solicitacao_produto(
id_pagamento_solicitacao_produto int(10) unsigned not null auto_increment,
id_solicitacao_produto int(10) unsigned not null,
data_pagamento_solicitacao_produto date not null,
valor float(10,2) null,
created_at timestamp NULL default NULL,
updated_at timestamp NULL DEFAULT NULL,
primary key(`id_pagamento_solicitacao_produto`),
CONSTRAINT `fk_pagamento_solicitacao_produto_solicitacao_produto` 
FOREIGN KEY (`id_solicitacao_produto`) 
REFERENCES `kibaku_bd`.`tb_solicitacao_produto`(`id_solicitacao_produto`)
ON DELETE CASCADE
ON UPDATE CASCADE
)
engine = InnoDB
default character set = utf8mb4
collate = utf8mb4_unicode_ci;

-- TABELA SOLICITACAO PRODUTO ITEM
create table if not exists kibaku_bd.tb_solicitacao_produto_item(
id_solicitacao_produto_item int(10) unsigned not null auto_increment,
id_produto int(10) unsigned not null,
quantidade int null,
created_at timestamp NULL default NULL,
updated_at timestamp NULL DEFAULT NULL,
primary key(`id_solicitacao_produto_item`),
CONSTRAINT `fk_solicitacao_produto_item_produto` 
FOREIGN KEY (`id_produto`) 
REFERENCES `kibaku_bd`.`tb_produto`(`id_produto`)
ON DELETE CASCADE
ON UPDATE CASCADE
)
engine = InnoDB
default character set = utf8mb4
collate = utf8mb4_unicode_ci;

-- TABELA PRECO SERVICO VETERINARIA
create table if not exists kibaku_bd.tb_preco_servico_veterinaria(
id_preco_servico_veterinaria int(10) unsigned not null auto_increment,
id_servico_veterinaria int(10) unsigned not null,
valor float(10,2) null,
descricao varchar(150) null,
created_at timestamp NULL default NULL,
updated_at timestamp NULL DEFAULT NULL,
primary key(`id_preco_servico_veterinaria`),
CONSTRAINT `fk_preco_servico_veterinaria_servico_veterinaria` 
FOREIGN KEY (`id_servico_veterinaria`) 
REFERENCES `kibaku_bd`.`tb_servico_veterinaria`(`id_servico_veterinaria`)
ON DELETE CASCADE
ON UPDATE CASCADE
)
engine = InnoDB
default character set = utf8mb4
collate = utf8mb4_unicode_ci;

-- TABELA HORARIO ADESTRADOR
create table if not exists kibaku_bd.tb_horario_adestrador(
id_horario_adestrador int(10) unsigned not null auto_increment,
id_adestrador int(10) unsigned not null,
dia_semana varchar(10) not null,
hora_inicio varchar(10) not null,
hora_fim varchar(10) not null,
mes varchar(20) not null,
created_at timestamp NULL default NULL,
updated_at timestamp NULL DEFAULT NULL,
primary key(`id_horario_adestrador`),
CONSTRAINT `fk_horario_adestrador_adestrador` 
FOREIGN KEY (`id_adestrador`) 
REFERENCES `kibaku_bd`.`tb_adestrador`(`id_adestrador`)
ON DELETE CASCADE
ON UPDATE CASCADE
)
engine = InnoDB
default character set = utf8mb4
collate = utf8mb4_unicode_ci;

-- TABELA HORARIO CLIENTE
create table if not exists kibaku_bd.tb_horario_cliente(
id_horario_cliente int(10) unsigned not null auto_increment,
id_horario_adestrador int(10) unsigned not null,
id_cliente int(10) unsigned not null,
estado enum('com tempo', 'sem tempo', 'quase sem tempo', 'arrumar tempo') not null,
created_at timestamp NULL default NULL,
updated_at timestamp NULL DEFAULT NULL,
primary key(`id_horario_cliente`),
CONSTRAINT `fk_horario_cliente_horario_adestrador` 
FOREIGN KEY (`id_horario_adestrador`) 
REFERENCES `kibaku_bd`.`tb_horario_adestrador`(`id_horario_adestrador`)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT `fk_horario_cliente_cliente` 
FOREIGN KEY (`id_cliente`) 
REFERENCES `kibaku_bd`.`tb_cliente`(`id_cliente`)
ON DELETE CASCADE
ON UPDATE CASCADE
)
engine = InnoDB
default character set = utf8mb4
collate = utf8mb4_unicode_ci;

-- TABELA LOCALIZACAO PETSHOP
create table if not exists kibaku_bd.tb_localizacao_veterinaria(
id_localizacao_veterinaria int(10) unsigned not null auto_increment,
id_veterinaria int(10) unsigned not null,
id_bairro int(10) unsigned not null,
id_municipio int(10) unsigned null,
id_comuna int(10) unsigned null,
rua varchar(150) not null,
edificio varchar(50) null,
num_casa varchar(50) null,
travessa varchar(150) null,
created_at timestamp NULL default NULL,
updated_at timestamp NULL DEFAULT NULL,
primary key(`id_localizacao_veterinaria`),
CONSTRAINT `fk_localizacao_veterinaria_veterinaria` 
FOREIGN KEY (`id_veterinaria`) 
REFERENCES `kibaku_bd`.`tb_veterinaria`(`id_veterinaria`)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT `fk_localizacao_veterinaria_bairro` 
FOREIGN KEY (`id_bairro`) 
REFERENCES `kibaku_bd`.`tb_bairro`(`id_bairro`)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT `fk_localizacao_veterinaria_municipio` 
FOREIGN KEY (`id_municipio`) 
REFERENCES `kibaku_bd`.`tb_municipio`(`id_municipio`)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT `fk_localizacao_veterinaria_comuna` 
FOREIGN KEY (`id_comuna`) 
REFERENCES `kibaku_bd`.`tb_comuna`(`id_comuna`)
ON DELETE CASCADE
ON UPDATE CASCADE
)
engine = InnoDB
default character set = utf8mb4
collate = utf8mb4_unicode_ci;

-- TABELA CONTACTO PETSHOP
create table if not exists kibaku_bd.tb_contacto_petshop(
id_contacto_petshop int(10) unsigned not null auto_increment,
id_pais int(10) unsigned not null,
tipo_contacto enum('pessoal', 'empresa', 'estrangeiro') not null,
descricao varchar(150) null,
id_petshop int(10) unsigned null,
created_at timestamp NULL default NULL,
updated_at timestamp NULL DEFAULT NULL,
primary key(`id_contacto_petshop`),
CONSTRAINT `fk_contacto_petshop_pais` 
FOREIGN KEY (`id_pais`) 
REFERENCES `kibaku_bd`.`tb_pais`(`id_pais`)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT `fk_contacto_petshop_petshop` 
FOREIGN KEY (`id_petshop`) 
REFERENCES `kibaku_bd`.`tb_petshop`(`id_petshop`)
ON DELETE CASCADE
ON UPDATE CASCADE
)
engine = InnoDB
default character set = utf8mb4
collate = utf8mb4_unicode_ci;

-- TABELA LOCALIZACAO PETSHOP
create table if not exists kibaku_bd.tb_localizacao_petshop(
id_localizacao_petshop int(10) unsigned not null auto_increment,
id_petshop int(10) unsigned not null,
id_pais int(10) unsigned not null,
id_bairro int(10) unsigned not null,
id_municipio int(10) unsigned not null,
id_comuna int(10) unsigned not null,
rua varchar(150) not null,
edificio varchar(50) null,
num_casa varchar(50) null,
travessa varchar(150) null,
created_at timestamp NULL default NULL,
updated_at timestamp NULL DEFAULT NULL,
primary key(`id_localizacao_petshop`),
CONSTRAINT `fk_localizacao_petshop_petshop` 
FOREIGN KEY (`id_petshop`) 
REFERENCES `kibaku_bd`.`tb_petshop`(`id_petshop`)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT `fk_localizacao_petshop_pais` 
FOREIGN KEY (`id_pais`) 
REFERENCES `kibaku_bd`.`tb_pais`(`id_pais`)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT `fk_localizacao_petshop_bairro` 
FOREIGN KEY (`id_bairro`) 
REFERENCES `kibaku_bd`.`tb_bairro`(`id_bairro`)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT `fk_localizacao_petshop_municipio` 
FOREIGN KEY (`id_municipio`) 
REFERENCES `kibaku_bd`.`tb_municipio`(`id_municipio`)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT `fk_localizacao_petshop_comuna` 
FOREIGN KEY (`id_comuna`) 
REFERENCES `kibaku_bd`.`tb_comuna`(`id_comuna`)
ON DELETE CASCADE
ON UPDATE CASCADE
)
engine = InnoDB
default character set = utf8mb4
collate = utf8mb4_unicode_ci;

-- TABELA PRODUTO PETSHOP
create table if not exists kibaku_bd.tb_produto_petshop(
id_produto_petshop int(10) unsigned not null auto_increment,
id_produto int(10) unsigned not null,
id_petshop int(10) unsigned not null,
id_categoria int(10) unsigned not null,
imagem blob null,
created_at timestamp NULL default NULL,
updated_at timestamp NULL DEFAULT NULL,
primary key(`id_produto_petshop`),
CONSTRAINT `fk_produto_petshop_produto` 
FOREIGN KEY (`id_produto`) 
REFERENCES `kibaku_bd`.`tb_produto`(`id_produto`)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT `fk_produto_petshop_petshop` 
FOREIGN KEY (`id_petshop`) 
REFERENCES `kibaku_bd`.`tb_petshop`(`id_petshop`)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT `fk_produto_petshop_categoria` 
FOREIGN KEY (`id_categoria`) 
REFERENCES `kibaku_bd`.`tb_categoria`(`id_categoria`)
ON DELETE CASCADE
ON UPDATE CASCADE
)
engine = InnoDB
default character set = utf8mb4
collate = utf8mb4_unicode_ci;

-- TABELA SERVICO PETSHOP
create table if not exists kibaku_bd.tb_servicos_petshop(
id_servicos_petshop int(10) unsigned not null auto_increment,
id_servico int(10) unsigned not null,
id_petshop int(10) unsigned not null,
id_servico_preco int not null,
created_at timestamp NULL default NULL,
updated_at timestamp NULL DEFAULT NULL,
primary key(`id_servicos_petshop`),
CONSTRAINT `fk_servicos_petshop_petshop` 
FOREIGN KEY (`id_petshop`) 
REFERENCES `kibaku_bd`.`tb_petshop`(`id_petshop`)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT `fk_servico_petshop_servico` 
FOREIGN KEY (`id_servico`) 
REFERENCES `kibaku_bd`.`tb_servico`(`id_servico`)
ON DELETE CASCADE
ON UPDATE CASCADE
)
engine = InnoDB
default character set = utf8mb4
collate = utf8mb4_unicode_ci;

-- TABELA AVALIACAO PETSHOP
create table if not exists kibaku_bd.tb_avaliacao_petshop(
id_avaliacao_petshop int(10) unsigned not null auto_increment,
id_petshop int(10) unsigned not null,
id_cliente int(10) unsigned not null,
valor int(5) unsigned not null,
created_at timestamp NULL default NULL,
updated_at timestamp NULL DEFAULT NULL,
primary key(`id_avaliacao_petshop`),
CONSTRAINT `fk_avaliacao_petshop_petshop` 
FOREIGN KEY (`id_petshop`) 
REFERENCES `kibaku_bd`.`tb_petshop`(`id_petshop`)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT `fk_avaliacao_petshop_cliente` 
FOREIGN KEY (`id_cliente`) 
REFERENCES `kibaku_bd`.`tb_cliente`(`id_cliente`)
ON DELETE CASCADE
ON UPDATE CASCADE
)
engine = InnoDB
default character set = utf8mb4
collate = utf8mb4_unicode_ci;

-- TABELA VALOR PRODUTO PETSHOP
create table if not exists kibaku_bd.tb_valor_produto_petshop(
id_valor_produto_petshop int(10) unsigned not null auto_increment,
id_produto_petshop int(10) unsigned not null,
grama float(10,2) null,
peso float(10,2) null,
descricao varchar(150) null,
quantidade int unsigned not null,
data_validade date not null,
preco float(10,2) null,
created_at timestamp NULL default NULL,
updated_at timestamp NULL DEFAULT NULL,
primary key(`id_valor_produto_petshop`),
CONSTRAINT `fk_valor_produto_petshop_produto_petshop` 
FOREIGN KEY (`id_produto_petshop`) 
REFERENCES `kibaku_bd`.`tb_produto_petshop`(`id_produto_petshop`)
ON DELETE CASCADE
ON UPDATE CASCADE
)
engine = InnoDB
default character set = utf8mb4
collate = utf8mb4_unicode_ci;

-- TABELA PAPEL USUÁRIO
create table if not exists kibaku_bd.tb_papel(
id_papel int(10) unsigned not null auto_increment,
no_papel varchar(50) null,
descricao varchar(150) null,
created_at timestamp NULL default NULL,
updated_at timestamp NULL DEFAULT NULL,
primary key(`id_papel`)
)
engine = InnoDB
default character set = utf8mb4
collate = utf8mb4_unicode_ci;
