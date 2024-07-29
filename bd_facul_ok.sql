-- Tabela para armazenar informações sobre os clientes
CREATE TABLE clientes (
    cliente_id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone VARCHAR(15),
    endereco TEXT
);

-- Tabela para armazenar informações sobre os funcionários
CREATE TABLE funcionarios (
    funcionario_id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cargo VARCHAR(50),
    salario NUMERIC(10, 2) NOT NULL,
    telefone VARCHAR(15)
);

-- Tabela para armazenar os serviços oferecidos
CREATE TABLE servicos (
    servico_id SERIAL PRIMARY KEY,
    descricao TEXT NOT NULL,
    preco NUMERIC(10, 2) NOT NULL
);

-- Tabela para registrar as ordens de serviço
CREATE TABLE ordens_servico (
    ordem_id SERIAL PRIMARY KEY,
    cliente_id INT REFERENCES clientes(cliente_id),
    funcionario_id INT REFERENCES funcionarios(funcionario_id),
    servico_id INT REFERENCES servicos(servico_id),
    data_inicio DATE NOT NULL,
    data_conclusao DATE,
    status VARCHAR(50)
);

-- Tabela para armazenar os pagamentos
CREATE TABLE pagamentos (
    pagamento_id SERIAL PRIMARY KEY,
    ordem_id INT REFERENCES ordens_servico(ordem_id),
    valor NUMERIC(10, 2) NOT NULL,
    data_pagamento DATE NOT NULL
);

-- Inserção de dados exemplo

-- Inserir clientes
INSERT INTO clientes (nome, email, telefone, endereco) VALUES 
('Osama', 'osama@email.com', '1764-5678', 'Rua X, 125'),
('LULA', 'lula@email.com', '2345-6767', 'Rua W, 486');

-- Inserir funcionários
INSERT INTO funcionarios (nome, cargo, salario, telefone) VALUES 
('Marcos Monteiro', 'Técnico', 2500.00, '3456-7890'),
('Leonardo Lopes', 'Analista', 3000.00, '4567-8901');

-- Inserir serviços
INSERT INTO servicos (descricao, preco) VALUES 
('Formatação de Computador', 250.00),
('Manutenção de Rede', 600.00);

-- Inserir ordens de serviço
INSERT INTO ordens_servico (cliente_id, funcionario_id, servico_id, data_inicio, data_conclusao, status) VALUES 
(1, 1, 1, '2024-07-01', '2024-07-30', 'Concluída'),
(2, 2, 2, '2024-07-10', NULL, 'Em andamento');

-- Inserir pagamentos
INSERT INTO pagamentos (ordem_id, valor, data_pagamento) VALUES 
(1, 250.00, '2024-07-29');

-- Consultas exemplo
-- Listar todos os clientes
SELECT * FROM clientes;

-- Listar todos os serviços com preços
SELECT * FROM servicos;

-- Listar ordens de serviço com detalhes dos clientes e funcionários
SELECT 
    os.ordem_id,
    c.nome AS cliente_nome,
    f.nome AS funcionario_nome,
    s.descricao AS servico_descricao,
    os.data_inicio,
    os.data_conclusao,
    os.status
FROM ordens_servico os
JOIN clientes c ON os.cliente_id = c.cliente_id
JOIN funcionarios f ON os.funcionario_id = f.funcionario_id
JOIN servicos s ON os.servico_id = s.servico_id;

-- Listar pagamentos realizados
SELECT 
    p.pagamento_id,
    os.ordem_id,
    p.valor,
    p.data_pagamento
FROM pagamentos p
JOIN ordens_servico os ON p.ordem_id = os.ordem_id;